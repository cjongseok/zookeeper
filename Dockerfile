FROM cjongseok/oracle-jdk:1.8.0_77

ENV ZK_VERSION=3.4.6
ENV ZK_HOME=/opt/zookeeper-${ZK_VERSION}
ENV ZK_CONF_FILE=${ZK_HOME}/conf/zoo.cfg
ENV JAVA_HOME=/usr/java/jdk1.8.0_77
ENV ZOO_LOG_DIR=${ZK_HOME}/logs

RUN set -ex \
        && cd /opt \
        && curl -LO --silent http://apache.mirrors.pair.com/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz \
        && tar -xzf zookeeper-${ZK_VERSION}.tar.gz \
        && mkdir -p ${ZK_HOME}/data \
        && sed -i '125itail -f $_ZOO_DAEMON_OUT' ${ZK_HOME}/bin/zkServer.sh

# 2181: client port
# 2888: peer communication
# 3888: leader selection
EXPOSE 2181 2888 3888

COPY config/zoo.cfg ${ZK_CONF_FILE}
COPY start /opt/start
CMD ["/opt/start"]

#ENTRYPOINT ["/opt/zookeeper-3.4.6/bin/zkServer.sh"]
#ENTRYPOINT ["/opt/zookeeper-${ZK_VERSION}/bin/zkServer.sh"]
#ENTRYPOINT ["${ZK_HOME}/bin/zkServer.sh"]

