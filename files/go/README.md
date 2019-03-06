## 介绍

开发环境，还是使用老式的 bind mount, 将host机器的目录mount到container中

因为开发中，需要在指定目录中编码，所以不适合使用volume

**示例**

`-v ${HOME}/src:/go/src` 为 bind mount

##  编译镜像

创建名称为 hopher/golang 镜像

```
docker build -t hopher/golang:latest .
```

## 运行容器

```
docker run -itd --name mygolang -v ${HOME}/src:/go/src hopher/golang /bin/bash
```


## 参考资料
- [Docker学习笔记（6）——Docker Volume](https://www.jianshu.com/p/ef0f24fd0674)