#!/bin/bash
SCRIPT_DIR=$(dirname $(readlink -e $0))

# $1: desired hostname
script_name=$0
unset desired_hostname

function func_usage(){
    echo "$script_name <hostname>"
    echo ""
    echo "It runs zookeeper container with specified hostname"
    echo ""
    echo "PREREQUISITE"
    echo " docker and docker-compose"
    exit
}

function func_init(){

    # check dep
    if [ -z $(which docker-compose) ]; then
        func_usage
    fi

    # setup hostname
#    sudo hostname $desired_hostname

    # setup Zookeeper consul service name

}

function func_parse_args(){
    local argp=0
    local argv=("$@")
    local argn=${#argv[@]}
    local unset remained_args_num

    if [ $argn -eq 0 ]; then
        func_usage
    fi

    for ((; argp<argn; argp++)); do
        ((remained_args_num=argn-argp))
        if [ $remained_args_num -eq 1 ]; then
            desired_hostname=${argv[argp]}
        else
            func_usage
        fi
    done
}

function func_run(){
    sudo docker-compose up -d
}

argv=($@)
func_parse_args ${argv[@]}
func_init
func_run

