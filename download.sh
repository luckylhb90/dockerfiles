#!/bin/bash

##
# 安装包下载脚本
#

# dirname $0，取得当前执行的脚本文件的父目录
# cd `dirname $0`，进入这个目录(切换当前工作目录)
# pwd，显示当前工作目录(cd执行后的)
basepath=$(cd `dirname $0`; pwd)

################ php ################

# 下载 php 扩展包
php_pkg=$basepath/files/php/pkg

if [ ! -f "$php_pkg/swoole.tar.gz" ];then
    wget -c https://github.com/swoole/swoole-src/archive/v4.3.0.tar.gz -O $php_pkg/swoole.tar.gz
fi

################ mysql ################

# mysql 配置文件
cp $basepath/files/mysql/mysqld.cnf ~/mysql/etc/mysqld.cnf