## 下载需要的拓展包
先下载好要使用的拓展包，如果编译出错要多次构建容器就可以省掉下载时间。

##  编译镜像

创建名称为 hopher/phpfpm 镜像

```
docker build -t hopher/php:7.2-fpm .
```

## 运行容器

```
docker run -itd --name myphp -v ${HOME}/src:/var/www/html hopher/php:7.2-fpm /bin/bash
```