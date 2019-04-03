FROM node:11.12
LABEL maintainer="hopher <565983236@qq.com>"

# 设置时区
ENV TIMEZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# 设置安装源镜像
ENV MIRROR_SOURCE=tencent
COPY ./mirrors/$MIRROR_SOURCE/debian/stretch.list /etc/apt/sources.list

# 创建应用目录 && 替换淘宝npm镜像
RUN mkdir -p /app \
    && npm config set registry https://registry.npm.taobao.org/

ARG INSTALL_GITBOOK=false
# 安装 gitbook-cli && gitbook v3.2.3
# Fixes https://github.com/GitbookIO/gitbook/issues/1309
RUN if [ ${INSTALL_GITBOOK} = true ]; then \
    npm install gitbook-cli -g \
    && gitbook fetch 3.2.3 \
    && npm cache clear --force \
    && rm -rf /tmp/* \
    && sed -i 's/confirm: true/confirm: false/g' \
    /root/.gitbook/versions/3.2.3/lib/output/website/copyPluginAssets.js \
;fi

# 安装 docsify轻量级文档系统
# ![github地址](https://github.com/docsifyjs/docsify)
# ![英文文档](https://docsify.js.org/#/?id=docsify)
# ![中文文档](https://docsify.js.org/#/zh-cn/quickstart)
ARG INSTALL_DOCSIFY=false
RUN if [ ${INSTALL_DOCSIFY} = true ]; then \
    npm i docsify-cli -g \
;fi
