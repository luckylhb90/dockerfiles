FROM mysql:5.7
LABEL maintainer="565983236@qq.com"

# 设置时区
ENV TIMEZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# 更新安装源镜像
COPY ./mirrors/tencent/debian/stretch.list /etc/apt/sources.list