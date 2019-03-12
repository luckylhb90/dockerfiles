FROM php:7.2-fpm
LABEL maintainer="hopher <565983236@qq.com>"

# 设置服务根目录
ENV SERVICE_PATH ./services/php

# 设置时区
ENV TIMEZONE Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# 设置安装源镜像
ENV MIRROR_SOURCE=tencent
COPY ./mirrors/$MIRROR_SOURCE/debian/stretch.list /etc/apt/sources.list
COPY ./mirrors/$MIRROR_SOURCE/debian/buster.list /etc/apt/sources.list.d/buster.list


# 安装 Composer
COPY $SERVICE_PATH/pkg/composer.phar /usr/local/bin/composer

# 更新安装依赖包和PHP核心拓展
# 
# –no-install-recommends 参数来避免安装非必须的文件，从而减小镜像的体积
RUN apt-get clean all && apt-get update && apt-get install -y \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
        && docker-php-ext-install zip \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install opcache \
        && docker-php-ext-install mysqli \
        && rm -r /var/lib/apt/lists/*

# 安装 Swoole 扩展
# see: https://github.com/swoole/swoole-src
COPY $SERVICE_PATH/pkg/swoole.tar.gz /usr/local/src/swoole.tar.gz
RUN cd /usr/local/src \
    && tar -zxvf swoole.tar.gz \
    && cd swoole-src-4.3.0 \
    && phpize \
    && ./configure \
    && make && make install \
    && echo "extension=swoole.so" > /usr/local/etc/php/conf.d/swoole.ini \
    && cd ../ && rm -rf swoole*