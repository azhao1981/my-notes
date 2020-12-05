# DOCKER

<!-- MarkdownTOC -->

- 概述
  - 为什么要用
  - 使用国内镜像安装docker
    - ubuntu
      - QuickStart: 一键安装
      - 在线安装
      - 可以开放权限给应用用户
      - docker-compose
    - mac
      - 最新版本\(推荐\)
      - 老点的版本,不知道从哪个版本起
    - windows
  - docker on rails
  - image to cn
- FAQ
  - 例子
- 参考
  - tips: build
  - 状态
  - 只显示名字
  - stats+名字
  - 长时间运行后 docker日志会变大
  - save and import
  - 有用的例子
  - ERROR: Kubernetes is starting 无用,重装,可以导出

<!-- /MarkdownTOC -->

## 概述

### 为什么要用

* 安装方便简单
* 没有权限烦恼
* 漏洞攻击影响小,保护宿主机

### 使用国内镜像安装docker

**QUICKTIP: 国内用户请放弃安装原版的docker**

#### ubuntu

##### QuickStart: 一键安装

```bash
curl -sSL https://raw.githubusercontent.com/azhao1981/my-notes/master/shell/install.docker.cn.daocloud.linux | bash
```

##### 在线安装

```bash
curl -sSL https://get.daocloud.io/docker | sh
```

配置Docker加速器(daocloud)

```bash
sudo su -
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["http://f1361db2.m.daocloud.io", "http://hub-mirror.c.163.com"]
}
EOF
systemctl daemon-reload
systemctl restart docker
```

##### 可以开放权限给应用用户

`sudo usermod -aG docker webuser`

##### docker-compose

在[github主页](https://github.com/docker/compose/releases) 看下最新版本地址

阿里的版本很旧, <https://get.daocloud.io/> daocloud 有最新版本

```bash
sudo su -
curl -L https://get.daocloud.io/docker/compose/releases/download/1.26.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

#### kali

[kali linux 更换镜像源](https://www.cnblogs.com/yyxianren/p/10916140.html)

[Installing Docker in Kali Linux](https://medium.com/@airman604/installing-docker-in-kali-linux-2017-1-fbaa4d1447fe)

<https://www.daocloud.io/mirror#accelerator-doc>

<http://get.daocloud.io/>

```bash
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get remove docker docker-engine docker.io
sudo apt-get install docker-ce
```

#### mac

##### 最新版本(推荐)

下载 https://mirrors.aliyun.com/docker-toolbox/mac/docker-for-mac/stable/

安装,最新的版本已经不需要装virtualbox了

https://cr.console.aliyun.com/?spm=5176.doc60750.2.3.P4b6B6#/accelerator

https://j90112tg.mirror.aliyuncs.com 加到 "registry-mirrors" 的数组里，点击 Apply & Restart按钮，

"registry-mirrors" : No certs for rnpwate.mirror.aliyuncs.com
  https://blog.csdn.net/jianglianye21/article/details/79389949
这个提示把 https改为http

EDGE版本内置k8s了,但是国内安装很慢

阿里后台: https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors

##### 老点的版本,不知道从哪个版本起

对于10.10.3以下的用户 推荐使用 Docker Toolbox

[Toolbox的介绍和帮助](http://mirrors.aliyun.com/help/docker-toolbox)

[Mac系统的安装文件目录](http://mirrors.aliyun.com/docker-toolbox/mac)

对于10.10.3以上的用户 推荐使用 Docker for Mac

[Mac系统的安装文件目录](http://mirrors.aliyun.com/docker-toolbox/mac/docker-for-mac/)

  # 创建一台安装有Docker环境的Linux虚拟机，指定机器名称为default，同时配置Docker加速器地址。
  ```
  docker-machine create --engine-registry-mirror=https://j90112tg.mirror.aliyuncs.com --virtualbox-memory 4096 -d virtualbox default
  docker-machine provision --engine-registry-mirror=https://j90112tg.mirror.aliyuncs.com -d virtualbox default
  ```

  # 查看机器的环境配置，并配置到本地。然后通过Docker客户端访问Docker服务。
  ```
  docker-machine env default
  eval "$(docker-machine env default)"
  docker info
  ```

#### windows

  [Docker for Windows](https://www.docker.com/products/docker#/windows) 在Windows上运行Docker。系统要求，Windows10x64位，支持Hyper-V
      -- FROM:[daocloud](https://get.daocloud.io/)

  [Toolbox的介绍和帮助](http://mirrors.aliyun.com/help/docker-toolbox)

  [Windows系统的安装文件目录](http://mirrors.aliyun.com/docker-toolbox/windows)

### docker on rails

https://evilmartians.com/chronicles/ruby-on-whales-docker-for-ruby-rails-development

https://www.firehydrant.io/blog/developing-a-ruby-on-rails-app-with-docker-compose/

https://docs.docker.com/compose/rails/

https://blog.codeship.com/running-rails-development-environment-docker/

http://jes.al/2016/09/setting-up-a-rails-development-environment-using-docker/

https://ruby-china.org/topics/32459

[Dockfile with ruby](https://github.com/erikh/box)

[docker上跑rails开发环境](https://blog.codeship.com/running-rails-development-environment-docker/)

[建立rails的docker开发环境](http://jes.al/2016/09/setting-up-a-rails-development-environment-using-docker/)

### image to cn

```yml
FROM erlang:latest
MAINTAINER azhao <azhao.1981@foxmail.com>
COPY cn.source.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install net-tools -y

# 中文支持
ENV LC_ALL=C.UTF-8 \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US.UTF-8
RUN apt-get install locales -y
RUN dpkg-reconfigure locales
RUN set -x \
  && locale-gen C.UTF-8 \
  && /usr/sbin/update-locale LANG=C.UTF-8 \
  && echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen \
  && locale-gen
RUN     /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR /srv

EXPOSE 4560 5222 5269 5280 5443
```

```ali.ubunut.16.04.apt.source.list
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
```

```ali.debian.jessie.apt.source.list
deb http://mirrors.cloud.aliyuncs.com/debian/ jessie main contrib non-free
deb-src http://mirrors.cloud.aliyuncs.com/debian/ jessie main contrib non-free
deb http://mirrors.cloud.aliyuncs.com/debian/ jessie-proposed-updates main non-free contrib
deb-src http://mirrors.cloud.aliyuncs.com/debian/ jessie-proposed-updates main non-free contrib
deb http://mirrors.cloud.aliyuncs.com/debian/ jessie-updates main contrib non-free
deb-src http://mirrors.cloud.aliyuncs.com/debian/ jessie-updates main contrib non-free
```

## FAQ

  1. ERROR: TERM environment variable not set.

  export TERM=dumb

### 例子

[mongo](/doc/db/mongo.md)

## 参考

[最完整的Docker聖經(文中书)](https://joshhu.gitbooks.io/docker_theory_install/content/)

[10张图带你深入理解Docker容器和镜像](http://dockone.io/article/783)

[alicloudhpc/toolkit 阿里云深度学习/这个太老了,删除](https://dev.aliyun.com/detail.html?spm=5176.100208.8.2.VSKcdu&repoId=2)

[docker入门到实践](https://www.gitbook.com/book/yeasy/docker_practice/details)

[mac下访问宿主机端口](https://github.com/docker/docker/issues/1143)

```shell
# 如何访问宿主机
# Docker auto updating /etc/hosts on every container with the host IP, e.g. 172.17.42.1 and calling it for example dockerhost would be a convenient fix.
# I guess for now we are stuck with
netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}'
# 就是写hosts 然后直接访问就好了
```
Docker容器访问宿主机网络
https://jingsam.github.io/2018/10/16/host-in-docker.html

发现宿主机的IP是172.17.0.1，那么将proxy_pass http://localhost:1234改为proxy_pass http://172.17.0.1:1234就可以解决502 Bad Gateway错误。

但是，在Windows和macOS平台下并没有docker0虚拟网卡，这时候可以使用host.docker.internal这个特殊的DNS名称来解析宿主机IP。


[连接/几个不同的容器组在一起](https://www.oschina.net/translate/dockerlinks)

--link name:alias

[图表君聊docker-Dockerfile](http://go.ctolib.com/topics/72.html)

[李华顺一些安装脚本](https://github.com/huacnlee/init.d)

[Docker學習筆記](https://www.gitbook.com/book/peihsinsu/docker-note-book/details)

### tips: build

```
docker build -t new_container .
```

[阿里云上部署和使用Docker Swarm集群](https://github.com/denverdino/aliyungo/wiki/Docker-Swarm-on-Aliyun)

Trusted Registry

[k8s开源书](https://github.com/feiskyer/kubernetes-handbook)

TIPS:

### 状态
  docker stats $(docker ps -q)

### 只显示名字
  sudo docker ps | awk '{if(NR>1) print $NF}'

### stats+名字

  sudo docker stats $(sudo docker ps --format '{{.Names}}')

  sudo docker stats --format "table {{.Name}}\t{{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"

[集成](https://github.com/drone/drone)

https://medium.com/statuscode/dockercheatsheet-9730ce03630d

### 长时间运行后 docker日志会变大

https://www.jianshu.com/p/caf6383d1d9b

docker volume ls -qf dangling=true | xargs -r docker volume rm

ll `find /var/lib/docker/containers/ -name *-json.log` -h

cat /dev/null > xxxx.log

https://www.cnblogs.com/jackluo/p/8116775.html

```bash
#!/bin/sh
echo "==================== start clean docker containers logs =========================="

logs=$(find /var/lib/docker/containers/ -name *-json.log)

for log in $logs
        do
                echo "clean logs : $log"
                cat /dev/null > $log
        done
echo "==================== end clean docker containers logs   =========================="
```

ali 工作台
https://cr.console.aliyun.com/?spm=5176.doc60750.2.3.P4b6B6#/accelerator

或是在docker-compose.yml 里加参数

```yaml
services:
  base:
    logging:
      options:
        max-size: "2048m"
        max-file: "10"
```

### save and import

postgres:latest
adminer
mobz/elasticsearch-head:5-alpine
elasticsearch-ik:5.6.4-alpine
graphiteapp/docker-graphite-statsd

docker save -o fedora-all.tar fedora
docker load --input fedora.tar

docker save -o adminer.tar adminer:latest
docker save -o postgres.tar postgres:latest
docker save -o mysql.tar mysql:5.7
docker save -o elasticsearch.5.6.4-alpine.tar elasticsearch:5.6.4-alpine
docker save -o elasticsearch-ik.5.6.4-alpine.tar elasticsearch-ik:5.6.4-alpine
docker save -o graphiteapp_docker-graphite-statsd.latest.tar graphiteapp/docker-graphite-statsd:latest
docker save -o mobz_elasticsearch-head.5-alpine.tar mobz/elasticsearch-head:5-alpine

docker load --input elasticsearch-ik.5.6.4-alpine.tar
docker load --input elasticsearch.5.6.4-alpine.tar
docker load --input graphiteapp_docker-graphite-statsd.latest.tar
docker load --input mobz_elasticsearch-head.5-alpine.tar
docker load --input mysql.tar
docker load --input postgres.tar

### 有用的例子

```bash
docker run \
  --rm \
  --detach \
  --env KEY=VALUE \
  --ip 10.10.9.75 \
  --publish 3000:3000 \
  --volume my_volume \
  --name my_container \
  --tty --interactive \
  --volume /my_volume \
  --workdir /app \
  IMAGE bash
```

### ERROR: Kubernetes is starting 无用,重装,可以导出

https://github.com/maguowei/k8s-docker-for-mac
