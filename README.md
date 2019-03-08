# Dockerfiles

用 Docker 容器服务的方式搭建 nginx/php/mysql/redis/go 环境，易于维护、升级。

> **NOTE**:  
> 个人开发环境，还是使用老式的 bind mount, 将host机器的目录mount到container中。  
> 因为开发中，需要在指定目录中编码，所以不适合使用volume(卷)

## 使用

执行命令：
```
cd dockerfiles
chmod +x build.sh
./build.sh
```


## Docker-compose 

> **NOTE**: 暂未使用

参数说明
```
docker-compose --help
```
- `-p` 指定项目名称，默认为当前目录名


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
- [[官方] docker-compose命令行说明](https://docs.docker.com/compose/reference/overview/)
- [清华大学开源软件镜像站-Debian 镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/debian/)