#!/bin/bash

# dirname $0，取得当前执行的脚本文件的父目录
# cd `dirname $0`，进入这个目录(切换当前工作目录)
# pwd，显示当前工作目录(cd执行后的)
basepath=$(cd `dirname $0`; pwd)

wget -c https://github.com/swoole/swoole-src/archive/v4.3.0.tar.gz -O $basepath/pkg/swoole.tar.gz