#!/bin/bash

#
# docker 构建脚本
#

# dirname $0，取得当前执行的脚本文件的父目录
# cd `dirname $0`，进入这个目录(切换当前工作目录)
# pwd，显示当前工作目录(cd执行后的)
basepath=$(cd `dirname $0`; pwd)
php_pkg=$basepath/files/php/pkg

cd $basepath

if [ ! -f "$php_pkg/swoole.tar.gz" ];then
    wget -c https://github.com/swoole/swoole-src/archive/v4.3.0.tar.gz -O $php_pkg/swoole.tar.gz
else
    echo "swoole.tar.gz 文件已存在"
fi

# 查找镜像是否存在 hopher/php:7.2-fpm
if `docker images | awk '{print $1":"$2}' | grep -q "hopher/php:7.2-fpm"`; then 
    echo "hopher/php:7.2-fpm 镜像已存在";
else 
    # 构建 docker php 镜像
    cd files/php
    docker build -t hopher/php:7.2-fpm .    
fi

# 运行 php 容器
docker run -itd --name myphp -v ${HOME}/src:/var/www/html hopher/php:7.2-fpm /bin/bash

