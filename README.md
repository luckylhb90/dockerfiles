# Dockerfiles

用 Docker 容器服务的方式搭建 nginx/php/mysql/redis/go/node 环境，易于维护、升级。

相关软件版本：
- PHP 7.2
- Golang 1.12
- MySQL 5.7
- Nginx 1.15
- Redis 3.2
- Node 11.12

PHP 扩展
- swoole v4.3.0
- Composer version 1.8.4

## 使用

### 1.下载

下载 zip 压缩包 && 解压

```
wget -c https://github.com/hopher/dockerfiles/archive/master.zip -O dockerfiles.zip
unzip dockerfiles.zip
mkdir -p ${HOME}/src
```

其中, `~/src` 为 volumes 名称，可根据自己需要更改 `docker-compose.yml` 中 volumes 对应值

### 2.docker-compose 构建项目

进入 docker-compose.yml 所在目录：
执行命令：
```
docker-compose up
```  

如果没问题，下次启动时可以以守护模式启用，所有容器将后台运行：  
```
docker-compose up -d
``` 

使用 docker-compose 基本上就这么简单，Docker 就跑起来了，用 stop，start 关闭开启容器服务。  
更多的是在于编写 dockerfile 和 docker-compose.yml 文件。 

可以这样关闭容器并删除服务：
```
docker-compose down
```

### 3. 测试

将项目源码放到 `~/src` 目录下, 并运行

```
cd src
echo "<?php phpinfo();" > index.php
```

打开 url 访问 `http://localhost/index.php`


### 4.帮助

执行命令：
```
docker-compose --help
```  
**参数说明**

- `-p` 指定项目名称，默认为当前目录名, 也可以直接在`docker-compose.yml`中设置`image`, `container_name` 这2个属性

### 5.目录结构

```
dockerfiles
    |-- services            # docker 相关服务
    |-- docker-compose.yml  # docker-compose.yml 定义
    |-- deprecated.sh       # 已弃用 shell 脚本, 勿使用
    |-- mirrors             # source.list 镜像源地址
~/src                       # 工作源码存放目录
```

## 常用`shell`组合

```
# 删除所有容器
docker stop `docker ps -q -a` | xargs docker rm

# 删除所有标签为none的镜像
docker images|grep \<none\>|awk '{print $3}'|xargs docker rmi

# 查找容器IP地址
docker inspect 容器名或ID | grep "IPAddress"
```

## 各系统软件源

### Ubuntu

| 系统代号 | 版本  |
| -------- | ----- |
| precise  | 12.04 |
| trusty   | 14.04 |
| vivid    | 15.04 |
| xenial   | 16.04 |
| zesty    | 17.04 |

### Debian

| 系统代号 | 版本 |
| -------- | ---- |
| squeeze  | 6.x  |
| wheezy   | 7.x  |
| jessie   | 8.x  |
| stretch  | 9.x  |
| buster   | 10.x |

> **NOTE**:  
> 查询自己的Linux版本 `cat /etc/issue`

## 番外篇

### links


> **Warning**: The `--link` flag is a legacy feature of Docker. It may eventually be removed. Unless you absolutely need to continue using it, we recommend that you use [user-defined networks](https://docs.docker.com/engine/userguide/networking//#user-defined-networks) to facilitate communication between two containers instead of using `--link`. One feature that user-defined networks do not support that you can do with `--link` is sharing environmental variables between containers. However, you can use other mechanisms such as volumes to share environment variables between containers in a more controlled way.
>
> @https://docs.docker.com/compose/compose-file/

##  参考资料
- [[官方文档] Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
- [[官方文档] Compose file version 3 reference](https://docs.docker.com/compose/compose-file/)
- [[官方文档] Use volumes](https://docs.docker.com/storage/volumes/)
- [[镜像] mysql 镜像说明](https://hub.docker.com/_/mysql/)
- [[镜像] php 镜像说明](https://hub.docker.com/_/php/)
- [[镜像站] 阿里云开源镜像站](https://opsx.alibaba.com/mirror)
- [[镜像站] 腾讯开源镜像站](https://mirrors.cloud.tencent.com/index.html)
- [[镜像站] 网易开源镜像站](http://mirrors.163.com/)
- [[镜像站] 清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn/help/debian/)