FROM node:11.12
LABEL maintainer="hopher <565983236@qq.com>"

# 设置时区
ENV TIMEZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# 设置安装源镜像
ENV MIRROR_SOURCE=tencent
COPY ./mirrors/$MIRROR_SOURCE/debian/stretch.list /etc/apt/sources.list

# 创建应用目录 && 替换淘宝npm镜像
# 安装 gitbook 命令行工具
RUN mkdir /app \
    && npm config set registry https://registry.npm.taobao.org/ \
    && npm install gitbook-cli -g