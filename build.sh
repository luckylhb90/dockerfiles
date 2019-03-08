#!/bin/bash

#
# docker 构建脚本
#

# dirname $0，取得当前执行的脚本文件的父目录
# cd `dirname $0`，进入这个目录(切换当前工作目录)
# pwd，显示当前工作目录(cd执行后的)
basepath=$(cd `dirname $0`; pwd)
php_pkg=$basepath/files/php/pkg

##
# 查找 && 构建 docker 镜像
#
# @$1 镜像名
# @$2 dockerfile 上下文路径，默认(当前目录): .
# @return 1 成功 | 0 失败
#
function buildDockerImage() {
    if [ $# -ne 2 ]; then
        echo 'Please input 镜像名 上下文路径'
        exit 0
    fi

    if `docker images | awk '{print $1":"$2}' | grep -q "$1"`; then 
        echo -e "\033[0;32m$1 image exist...\033[0m"
    else
        # 构建 docker php 镜像
        cd $2
        docker build -t $1 .
    fi
    return 1
}

##
# 查找容器
#
# @$1 容器名
# @return 1 已存在 | 0 不存在
#
function searchContainer() {    
    if `docker ps -a | grep -q $1`; then
        echo -e "\033[0;32m$1 container exist...\033[0m"
        return 0        
    fi
    return 1
}
#echo $1
# if `docker ps -a | grep $1`; then
#    echo -e "\033[0;32m$1 container exist...\033[0m"
#    return 0
# fi
#return 1

##############################
# php 环境
##############################
php_image_name="hopher/php:7.2-fpm"
php_container_name="myphp"

if [ ! -f "$php_pkg/swoole.tar.gz" ];then
    wget -c https://github.com/swoole/swoole-src/archive/v4.3.0.tar.gz -O $php_pkg/swoole.tar.gz
else
    echo "swoole.tar.gz 文件已存在"
fi

buildDockerImage $php_image_name "./files/php"
searchContainer $php_container_name
# 容器不存在 - $? 获取 searchContainer
if [ $? -ne 0 ]; then
    # 运行 php 容器
    # running php container
    docker run -itd --name $php_container_name \
    -v ${HOME}/src:/var/www/html \
    -p 9000:9000 \
    $php_image_name /bin/bash
fi

##############################
# golang 环境
##############################
golang_image_name="hopher/golang:latest"
golang_container_name="mygolang"

buildDockerImage $golang_image_name "./files/go"
searchContainer $golang_container_name

# 容器不存在 - $? 获取 searchContainer
if [ $? -ne 0 ]; then
    # 这里根据自己机器，
    # 创建下面目录
    # - /go/bin (编译后生成的可执行文件), 
    # - /go/pkg (编译时生成的中间文件)
    if [ ! -d "$HOME/go/bin" ];then
        echo "Create Dir $HOME/go/bin"
        mkdir -p "$HOME/go/bin"
    fi

    if [ ! -d "$HOME/go/pkg" ];then
        echo "Create Dir $HOME/go/pkg"
        mkdir -p "$HOME/go/pkg"
    fi

    # 运行 golang 容器 - running golang container
    docker run -itd --name $golang_container_name \
    -v ${HOME}/src:/go/src \
    -v ${HOME}/go/bin:/go/bin \
    -v ${HOME}/go/pkg:/go/pkg \
    -p 1313:1313 \
    $golang_image_name /bin/bash
fi

##############################
# nginx 环境
##############################

# TODO...


##############################
# mysql 环境
##############################

# TODO...