docker && ejabberd
========

## 两种语言 两种技术

  golang && docker

  erlang && ejabberd

## golang

### 能干又要求低的经济实用男
  C级别的内存需求 几k - 几十k

### 高并发且靠谱的 goroutine
  并发能力不是可用就行的
  goroutine
  ruby和纤程 线程
### 为啥不直接用c?
  一份代码,到处执行

### 腹黑的大括号

### 成长的烦恼--GC

http://studygolang.com/articles/7516

### 还可以开发 android/ios

http://www.jianshu.com/p/403aa507935b

### 其它

  有一些源是从google的库上来的

### 其它参考

http://www.infoq.com/cn/articles/build-a-container-golang

## docker

### 容器 vs 虚拟机

  容器: 帮我们管理文件(程序)的瓶子
  虚拟机: 一个能在上面运行程序的程序

  docker本质上是把要运行的文件做一个映射,到某一目录下. 如: /bin/bash -> /docker/A/bin/bash
  虚拟机是一个虚拟机器的程序,在上面可以运行新的程序

  docker 能在"宿主机"上找到对应的文件
  虚拟机会把文件都打成包

  docker 几乎没有性能消耗
  虚拟机 更好的隔离,内存/CPU控制

  docker用于打包部署,或隔离运行
  虚拟机用来把大机器拆成小机器

  docker 只有linux 和 与"宿主机"一样的内核版本
  虚拟机可以用于装别的系统如windows上装linux

### 为什么要用容器

  打包部署
  隔离运行

### 安装及本地化

  linux才是的原版
  mac/windows都是装在虚拟机上 docker-machine

#### ubuntu

  请安装1.6.0以上版本的Docker。
  您可以通过阿里云的镜像仓库下载： mirrors.aliyun.com/help/docker-engine

  curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
  配置Docker加速器

  您可以使用如下的脚本将mirror的配置添加到docker daemon的启动参数中。

  echo "DOCKER_OPTS=\"\$DOCKER_OPTS --registry-mirror=https://j90112tg.mirror.aliyuncs.com\"" | sudo tee -a /etc/default/docker
  sudo service docker restart


#### mac

  安装或升级Docker

  推荐您安装Docker Toolbox。
  Toolbox的介绍和帮助： mirrors.aliyun.com/help/docker-toolbox
  Mac系统的安装文件目录： mirrors.aliyun.com/docker-toolbox/mac

  快速开始

  # 创建一台安装有Docker环境的Linux虚拟机，指定机器名称为default，同时配置Docker加速器地址。
  docker-machine create --engine-registry-mirror=https://j90112tg.mirror.aliyuncs.com -d virtualbox default

  # 查看机器的环境配置，并配置到本地。然后通过Docker客户端访问Docker服务。
  docker-machine env default
  eval "$(docker-machine env default)"
  docker info

#### windows

  推荐您安装Docker Toolbox。
  Toolbox的介绍和帮助： mirrors.aliyun.com/help/docker-toolbox
  Windows系统的安装文件目录： mirrors.aliyun.com/docker-toolbox/windows

  #### 创建一台安装有Docker环境的Linux虚拟机，指定机器名称为default，同时配置Docker加速器地址。
  docker-machine create --engine-registry-mirror=https://j90112tg.mirror.aliyuncs.com -d virtualbox default

  #### 查看机器的环境配置，并配置到本地。然后通过Docker客户端访问Docker服务。
  docker-machine env default
  eval "$(docker-machine env default)"
  docker info


####  aliyun / daoclound

  boot2docker.iso


### 简单使用

  Docker Quickstart Terminal

  docker pull

  交互方式 进入容器
  docker run -it daocloud.io/java:8 /bin/bash

  后台运行
  docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d daocloud.io/postgres

### 建立自己的容器

#### Dockerfile
```
FROM daocloud.io/postgres:9.4
RUN localedef -i de_DE -c -f UTF-8 -A /usr/share/locale/locale.alias de_DE.UTF-8
ENV LANG de_DE.utf8
```
docker build -t new_container .

#### -it && commit

  docker commit cdc905a55f8e daocloud.io/java:9

  docker images

  docker rmi 2e80a8e2b20a

## erlang

  是一门老语言

  erlang 1987
  java 1991

  函数式/动态语言

  高并发/多核/小

  一言不合开新"进程" 这是erlang自己的进程

  分布式语言 天生就是分布式系统 通过端口,可以指定某个节点上的某个进程运行

  erlang gc
  http://www.cnblogs.com/me-sa/archive/2011/11/13/erlang0014.html
  安进程回收

## ejabberd

    高并发xmpp

    安装

    mod

    ejabberdctl debug

    manesa

    vhost

    node

referrent:
  Go语言并发与并行学习笔记(一)
  http://eleme.io/blog/2014/goroutine-1/


  http://zhang.hu/go-vs-erlang/
  http://studygolang.com/articles/5892
  http://www.cnblogs.com/lidaobing/archive/2011/10/07/difference-between-goroutine-and-erlang-process.html

