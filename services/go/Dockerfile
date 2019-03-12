FROM golang:1.12
LABEL maintainer="hopher <565983236@qq.com>"

# 设置服务根目录
ENV SERVICE_PATH ./services/go

# 设置时区
ENV TIMEZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# 设置安装源镜像
ENV MIRROR_SOURCE=tencent
COPY ./mirrors/$MIRROR_SOURCE/debian/stretch.list /etc/apt/sources.list