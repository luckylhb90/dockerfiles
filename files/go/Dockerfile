FROM golang:latest
LABEL maintainer="565983236@qq.com"

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 更新安装源 -- 阿里云
RUN cat > /etc/apt/sources.list <<EOF
deb http://mirrors.ustc.edu.cn/debian stretch main contrib non-free
deb http://mirrors.ustc.edu.cn/debian stretch-updates main contrib non-free
deb http://mirrors.ustc.edu.cn/debian-security stretch/updates main contrib non-free
EOF


