# Dockerfiles

Using docker container build  nginx/php/mysql/redis/go/node/postgres/phpmyadmin service,which is easy to maintain and upgrade.

- [中文说明](./README.cn.md)

**Mirror version**

Common storage: (network segment name: common)
- MySQL 5.7
- Redis 3.2
- Postgres 10

Other：
- PHP 7.1/7.2/7.3
    - extension: swoole v4.3.0
    - extension: Composer version 1.8.4
- Golang 1.12
- Nginx 1.15
- Node 11.12
- tomcat 8-jre8


## Custom a project combination && Config

Common storage (MySQL, Redis, Postgres), using the network segment: common

You can customize the build project combination by copying && modifying .env file

default is php combination

```
COMPOSE_FILE=docker-compose.yml:docker-compose-php.yml:docker-compose-nginx.yml
```

You can change COMPOSE_FILE to 

```
COMPOSE_FILE=docker-compose.yml:docker-compose-go.yml
```

which mean only need `mysql + redis + postgres + golang`

Example: 
```
cp .env.example .env
vi .env
```

Or DIY yourself, modify the networks property in the docker-compose-*.yml file, configure the relevant communication network segment

Example: 

```
services:
  node:
    ... // 省略
    networks:
      - app
      - common
networks:
  common: # 公用网络
    external: true
    name: common # `docker network ls` 查询 && 根据实际填写
  app:
    name: nodejs
```


## Usage

### 1. Download

Download zip archive && unzip

```
wget -c https://github.com/hopher/dockerfiles/archive/master.zip -O dockerfiles.zip
unzip dockerfiles.zip
mkdir -p ${HOME}/app
```

Where ~/app is the volume name, you can change the corresponding value of volumes in docker-compose.yml according to your needs.

### 2. docker-compose Build project


Go to the directory where docker-compose.yml is located And Execute the command:

```
cp .env.example .env
docker-compose up
```

If there is no problem, it can be enabled in daemon mode the next time it is started, and all containers will run in the background:

```
docker-compose up -d
``` 

Using docker-compose is basically as simple as this, Docker runs up, and stops the container service with stop, start.
More is to write the dockerfile and docker-compose.yml files.

You can close the container and delete the service like this:

```
docker-compose down
```

### 3. Test

Put the project source code in the `~/app` directory and run it

```
cd src
echo "<?php phpinfo();" > index.php
```

Open url: `http://localhost/index.php`

### 4. Common command

- Help
    ```
    docker-compose --help
    ```
- List network
    ```
    docker network ls
    ```
- Specify the configuration file at runtime
    ```
    docker-compose -p java -f docker-compose-tomcat.yml up -d
    ```
    **Parameters**:
    - `-p` project name
    - `-f` Configuration file
    - `-d` Run in Background

- Common `shell` command

    ```
    # Delete all containers
    docker stop `docker ps -q -a` | xargs docker rm

    # Delete all images with the tag as none
    docker images|grep \<none\>|awk '{print $3}'|xargs docker rmi

    # Find the container IP address
    docker inspect 容器名或ID | grep "IPAddress"

    # Create a network segment
    docker network create mynet
    docker run -d --net mynet --name container1 my_image
    docker run -it --net mynet --name container1 another_image
    ```

> more help `docker-compose -h|--help`      

### 5. Directory Structure

```
dockerfiles
    |-- services                    # docker service file, like nginx, mysql, php
    |-- docker-compose.yml          # compose file 
    |-- docker-compose-tomcat.yml   # tomcat compose file 
    |-- mirrors                     # mirrors source.list
~/app                               # app source codes
```


## Version 3 (docker-composer) Parameter description is no longer supported

**depends_on**

> The author interprets: Better improved by configuring the `networks` parameter

- `depends_on` does not wait for `db` and `redis` to be “ready” before starting `web` - only until they have been started. If you need to wait for a service to be ready, see [Controlling startup order](https://docs.docker.com/compose/startup-order/) for more on this problem and strategies for solving it.
- Version 3 no longer supports the `condition` form of `depends_on`.
- The `depends_on` option is ignored when [deploying a stack in swarm mode](https://docs.docker.com/engine/reference/commandline/stack_deploy/) with a version 3 Compose file.

> @https://docs.docker.com/compose/compose-file/

**links**

**Warning**: The `--link` flag is a legacy feature of Docker. It may eventually be removed. Unless you absolutely need to continue using it, we recommend that you use [user-defined networks](https://docs.docker.com/engine/userguide/networking//#user-defined-networks) to facilitate communication between two containers instead of using `--link`. One feature that user-defined networks do not support that you can do with `--link` is sharing environmental variables between containers. However, you can use other mechanisms such as volumes to share environment variables between containers in a more controlled way.


## System software source

### Ubuntu

| System code | Version  |
| -------- | ----- |
| precise  | 12.04 |
| trusty   | 14.04 |
| vivid    | 15.04 |
| xenial   | 16.04 |
| zesty    | 17.04 |

### Debian

| System code | Version |
| -------- | ---- |
| squeeze  | 6.x  |
| wheezy   | 7.x  |
| jessie   | 8.x  |
| stretch  | 9.x  |
| buster   | 10.x |

> **NOTE**:  
> Search Your Linux Version `cat /etc/issue`

## git ssh key config

For your host machine which run git, all the contents of `git config --list` is stored in files:

- If use `git config --system` to configure them, they are stored in `/etc/gitconfig`
- If use `git config --global` to configure them, they are stored in `~/.gitconfig`

> @https://stackoverflow.com/questions/52819584/copying-local-git-config-into-docker-container
> @https://github.com/tomwillfixit/atomci/blob/master/docker-compose.yml

Example: 

```
volumes:
    # Git and ssh config
    - ~/.ssh:/root/.ssh:ro # Change - ssh key needed to push to github
    - ~/.gitconfig:/root/.gitconfig:ro  # Change - git config needed for user details
    #- /tmp/ssh_auth_sock:/tmp/ssh_auth_sock #Static - needed to push to github without prompt
```

## Development Plan

- [] add .env config

## Feedback && Contribution

[Feedback](https://github.com/hopher/dockerfiles/issues/new), Thank you.


**Team up together, contribute**

First `fork`, according to the format:

`services/services_name/version/Dockerfile`

Example: 
```
services/php/v7.1/Dockerfile
```

Last `Pull Request`

## Contributions

... Looking forward to your name ...

##  Reference material
- [[Official document] Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
- [[Official document] Compose file version 3 reference](https://docs.docker.com/compose/compose-file/)
- [[Official document] Use volumes](https://docs.docker.com/storage/volumes/)
- [[Official document] env-file](https://docs.docker.com/compose/env-file/)
- [[Mirror Site] mysql](https://hub.docker.com/_/mysql/)
- [[Mirror Site] php](https://hub.docker.com/_/php/)
- [[Mirror Site] Alibaba](https://opsx.alibaba.com/mirror)
- [[Mirror Site] Tencent](https://mirrors.cloud.tencent.com/index.html)
- [[Mirror Site] 163](http://mirrors.163.com/)
- [[Mirror Site] Tuna](https://mirrors.tuna.tsinghua.edu.cn/help/debian/)