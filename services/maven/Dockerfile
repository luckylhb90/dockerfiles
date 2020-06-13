FROM maven:3.6.1-jdk-8-alpine
LABEL maintainer="hopher <565983236@qq.com>"
#配置linux服务器需要的环境
RUN apk add --no-cache git bash openssh-client tzdata
#指定到工作目录
WORKDIR /app
#配置环境
ENV TZ Asia/Shanghai
#定义工程远程地址
ARG GIT_URL
ENV GIT_URL $GIT_URL
#定义分支
ARG BRANCH
ENV BRANCH $BRANCH
#工程Java VM 启动参数
ARG VM_OPTIONS
ENV VM_OPTIONS $VM_OPTIONS
#需要启动的服务
ARG SERVER_NAME
ENV SERVER_NAME $SERVER_NAME
#迁移启动脚本至工作目录
ADD ${RUN_SHELL} /app
#开始运行启动脚本
CMD [ "bash", "run.sh" ]
# replace this with your application's default port
EXPOSE $SERVER_NAME
