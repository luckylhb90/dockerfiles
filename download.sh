#!/bin/bash

# dirname $0，取得当前执行的脚本文件的父目录
# cd `dirname $0`，进入这个目录(切换当前工作目录)
# pwd，显示当前工作目录(cd执行后的)
basepath=$(cd `dirname $0`; pwd)
pkg=$basepath/pkg

cd $basepath

if [ ! -f "$pkg/swoole.tar.gz" ];then
    wget -c https://github.com/swoole/swoole-src/archive/v4.3.0.tar.gz -O $basepath/pkg/swoole.tar.gz
else
    echo "swoole.tar.gz 文件已存在"
fi

# 构建 docker php 镜像
cd files/php
docker build -t hopher/php:7.2-fpm .

