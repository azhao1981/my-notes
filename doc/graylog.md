# gray log

## docker

[docker-compose 的中文文档](https://deepzz.com/post/docker-compose-file.html)

一点都不好用

### install

mongo

elasticsearch

docker pull graylog2/server

docker run --link graylog-mongo:mongo \
           --link graylog-elasticsearch:elasticsearch \
           -p 9000:9000 \
           -p 12201:12201/udp \
           -e GRAYLOG_WEB_ENDPOINT_URI="http://192.168.56.101:9000/api" \
           -e GRAYLOG_PASSWORD_SECRET=somepasswordpepper \
           -e GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918 \
           -d graylog2/server

--link 参数让 Graylog 容器能够用主机名 mongo 和 elasticsearch 访问 MongoDB 和 Elasticsearch 的服务。

-p 9000:9000 映射 Graylog 的 Web 服务端口 9000。

-p 12201:12201/udp 映射 Graylog 接收日志数据的 UDP 端口 12201。

GRAYLOG_WEB_ENDPOINT_URI 指定 Graylog 的 Web 访问 URI，请注意这里需要使用 Docker Host 的外部 IP（在实验环境中为 192.168.56.101）。

GRAYLOG_ROOT_PASSWORD_SHA2 指定 Graylog 管理员用户密码的哈希值，在这个例子中密码为 admin。可以通过如下命令生成自己的密码哈希，比如：

DEFAULT_JAVA_OPTS JVM options
GRAYLOG_SERVER_JAVA_OPTS

GRAYLOG_SERVER_JAVA_OPTS: '-Xms3500m -Xmx3500m -XX:NewRatio=1 -XX:MaxMetaspaceSize=256m -server -XX:+ResizeTLAB -XX:+UseConcMarkSweepGC -XX:+CMSConcurrentMTEnabled -XX:+CMSClassUnloadingEnabled -XX:+UseParNewGC -XX:-OmitStackTraceInFastThrow'

GRAYLOG_SERVER_JAVA_OPTS "-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:NewRatio=1 -XX:MaxMetaspaceSize=256m -server -XX:+ResizeTLAB -XX:+UseConcMarkSweepGC -XX:+CMSConcurrentMTEnabled -XX:+CMSClassUnloadingEnabled -XX:+UseParNewGC -XX:-OmitStackTraceInFastThrow **-Xms6g -Xmx6g**"


echo -n yourpassword | shasum -a 256
容器启动后，在 Web 浏览器中访问 http://[Docker Host IP]:9000

用户名/密码 = admin/admin

[部署 Graylog 日志系统 - 每天5分钟玩转 Docker 容器技术](https://www.ibm.com/developerworks/community/blogs/132cfa78-44b0-4376-85d0-d3096cd30d3f/entry/%E9%83%A8%E7%BD%B2_Graylog_%E6%97%A5%E5%BF%97%E7%B3%BB%E7%BB%9F_%E6%AF%8F%E5%A4%A95%E5%88%86%E9%92%9F%E7%8E%A9%E8%BD%AC_Docker_%E5%AE%B9%E5%99%A8%E6%8A%80%E6%9C%AF_92?lang=en)

### docker

```
$ mkdir -p ./graylog/config
$ cd ./graylog/config
$ wget https://raw.githubusercontent.com/Graylog2/graylog-docker/2.3/config/graylog.conf
$ wget https://raw.githubusercontent.com/Graylog2/graylog-docker/2.3/config/log4j2.xml

--net=host
net: "host"

链接到在docker-compose.yml外部启动的容器，甚至在Compose之外，特别是对于提供共享或公共服务的容器。 external_links在指定容器名称和链接别名（CONTAINER：ALIAS）时遵循类似于links的语义。

external_links:
 - redis_1
 - project_db_1:mysql
 - project_db_1:postgresql

extra_hosts
Add hostname mappings. Use the same values as the docker client --add-host parameter.

extra_hosts:
 - "somehost:162.242.195.82"
 - "otherhost:50.31.209.229"
An entry with the ip address and hostname is created in /etc/hosts inside containers for this service, e.g:

162.242.195.82  somehost
50.31.209.229   otherhost
```

### 官方文档


https://hub.docker.com/r/graylog2/server/
http://docs.graylog.org/en/2.3/pages/installation/docker.html

$ docker run --name some-mongo -d mongo:2

$ docker run --name some-elasticsearch -d elasticsearch:2 elasticsearch -Des.cluster.name="graylog"

$ docker run --link some-mongo:mongo --link some-elasticsearch:elasticsearch -p 9000:9000 -e GRAYLOG_WEB_ENDPOINT_URI="http://127.0.0.1:9000/api" -d graylog2/server

-e GRAYLOG_PASSWORD_SECRET=somepasswordpepper
  -e GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
  -e GRAYLOG_WEB_ENDPOINT_URI="http://127.0.0.1:9000/api"
In this case you can login to Graylog with the user and password admin. Generate your own password with this command:

  $ echo -n yourpassword | shasum -a 256
This all can be put in a docker-compose file, like:

version: '2'
services:
  some-mongo:
    image: "mongo:3"
  some-elasticsearch:
    image: "elasticsearch:2"
    command: "elasticsearch -Des.cluster.name='graylog'"
  graylog:
    image: graylog2/server:2.1.1-1
    environment:
      GRAYLOG_PASSWORD_SECRET: somepasswordpepper
      GRAYLOG_ROOT_PASSWORD_SHA2: 8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
      GRAYLOG_WEB_ENDPOINT_URI: http://127.0.0.1:9000/api
    links:
      - some-mongo:mongo
      - some-elasticsearch:elasticsearch
    ports:
      - "9000:9000"
After starting the three containers with docker-compose up open your browser with the URL http://127.0.0.1:9000 and login with admin:admin


## 操作

graylog
+ 提取raw  system/inputs -> inputs -> im_production -> manage extractors -> get started
eaad73c1-db2c-11e8-9090-00163e0d067a
graylog_19426
params=(.*) time

+ 提取json 先把 raw replace 成 json, 再拆分json
