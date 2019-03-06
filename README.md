# Dockerfiles

用 Docker 容器服务的方式搭建 nginx/php/mysql/redis/go 环境，易于维护、升级。

> **NOTE**:  
> 个人开发环境，还是使用老式的 bind mount, 将host机器的目录mount到container中。  
> 因为开发中，需要在指定目录中编码，所以不适合使用volume

## 使用

执行命令：
```
cd files
docker-compose -p hopher up
```


## Docker-compose 参数说明

```
docker-compose --help
```

- `-p` 指定项目名称，默认为当前目录名


##  参考资料

- [[官方] docker-compose命令行说明](https://docs.docker.com/compose/reference/overview/)