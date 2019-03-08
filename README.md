# Dockerfiles

用 Docker 容器服务的方式搭建 nginx/php/mysql/redis/go 环境，易于维护、升级。

相关软件版本：
- PHP 7.2
- Golang latest
- MySQL 5.7
- Nginx latest
- Redis 3.2

PHP 扩展
- swoole

## 使用

### 1.下载
直接 clone：
```
git clone https://github.com/hopher/dockerfiles.git
```
或者下载 zip 压缩包也可以。

### 2.下载需要的扩展包
先下载好要使用的扩展包，如果编译出错要多次构建容器就可以省掉下载时间。
```
cd dockerfiles
chmod +x download.sh
./download.sh
```

### 4.docker-compose 构建项目
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

### 5.帮助

执行命令：
```
docker-compose --help
```  
**参数说明**

- `-p` 指定项目名称，默认为当前目录名, 也可以直接在`docker-compose.yml`中设置`image`, `container_name` 这2个属性

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


### 阿里源

修改 `/etc/apt/sources.list` 为以下内容

```
deb http://mirrors.aliyun.com/debian stretch main contrib non-free
deb-src http://mirrors.aliyun.com/debian stretch main contrib non-free
deb http://mirrors.aliyun.com/debian stretch-updates main contrib non-free
deb-src http://mirrors.aliyun.com/debian stretch-updates main contrib non-free
deb http://mirrors.aliyun.com/debian-security stretch/updates main contrib non-free
deb-src http://mirrors.aliyun.com/debian-security stretch/updates main contrib non-free
```

> **NOTE**:  
> 查询自己的Linux版本 `cat /etc/issue`


##  参考资料
- [[官方] Compose file version 3 reference](https://docs.docker.com/compose/compose-file/)
- [清华大学开源软件镜像站-Debian 镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/debian/)