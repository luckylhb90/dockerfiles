#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
docker cp $basepath/etc/php.ini /usr/local/etc/php/php.ini

## 重启 php 服务
cd $basepath/../../
docker-composer up -d php