# api网关

## nginx mruby

[mRuby 使用 ngx_mruby 打造简易 WAF](https://ruby-china.org/topics/29834)

## OpenResty


## kong

### docker 安装 
Cassandra or PostgreSQL
  
docker run -d --name kong-database \
                -p 9042:9042 \
                cassandra:3
docker run -d --name kong-database \
                -p 5432:5432 \
                -e "POSTGRES_USER=kong" \
                -e "POSTGRES_DB=kong" \
                postgres:9.4
db migrate
docker run --rm \
    --link kong-database:kong-database \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    kong kong migrations up

    CREATE DATABASE "kong"  WITH ENCODING 'UTF8';
    docker run --rm \
        -e "KONG_DATABASE=postgres" \
        -e "KONG_PG_HOST=10.24.193.252" \
        -e "KONG_PG_USER=postgres" \
        -e "KONG_PG_PASSWORD=" \
        -e "KONG_PG_DATABASE=kong" \
        kong kong migrations up
    
$ docker run -d --name kong \
    --link kong-database:kong-database \
    -e "KONG_DATABASE=cassandra" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    -e "KONG_PG_HOST=kong-database" \
    -p 8000:8000 \
    -p 8443:8443 \
    -p 8001:8001 \
    -p 8444:8444 \
    kong

postgres ''
独立
docker run -d --name kong \
-e "KONG_CUSTOM_PLUGINS=helloworld" \


docker run -d --name kong \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=10.24.193.252" \
    -e "KONG_PG_USER=postgres" \
    -e "KONG_PG_PASSWORD=" \
    -e "KONG_PG_DATABASE=kong" \
    -e "KONG_ADMIN_LISTEN=0.0.0.0:8001" \
    -e "KONG_LOG_LEVEL=info" \
    -v "/srv/kong/nettools:/nettools" \
    -p 8000:8000 \
    -p 8443:8443 \
    -p 8001:8001 \
    -p 7946:7946 \
    -p 7946:7946/udp \
    kong

docker pull cassandra
docker pull kong

docker inspect <container ID>

### 使用

#### 添加规则

docker 安装必须使用

```bash
curl -i -X POST \
  --url http://192.168.0.7:8001/apis/ \
  --data 'name=example-api' \
  --data 'hosts=example.com' \
  --data 'upstream_url=http://example.com'

docker exec -it kong curl -i -X POST \
  --url http://localhost:8001/apis/ \
  --data 'name=example-api' \
  --data 'hosts=example.com' \
  --data 'upstream_url=http://example.com'

curl -i -X GET \
  --url http://localhost:8000/ \
  --header 'Host: example.com'
```

## GUI

https://github.com/Kong/kong/issues/391 


https://github.com/rsdevigo/jungle 无docker

https://github.com/vikingco/django-kong-admin 最后更新两年前

https://github.com/PGBI/kong-dashboard 14天前更,有docker
ali neucloud/kong-dashboard  不需要,直接用原版,阿里也很快

docker run --rm --link kong:kong -p 8080:8080 pgbi/kong-dashboard bash

docker run --rm --link kong:kong -p 8080:8080 pgbi/kong-dashboard start \
  --kong-url http://192.168.0.7:8001 \
  --basic-auth admin=Udesk123

这个活跃度也不错,有docker
https://github.com/pantsel/konga

docker pull pantsel/konga

```bash
# As stated before, in case of 'postgres','sqlserver'  or 'mysql' adapters,
# the app must be started in development mode the first time in order to be able to apply migrations.
# You can do that by bashing into Konga's container and running 'node app.js --dev'.
# You may also need to add an extra link that points to your database container.
docker run -p 1337:1337 
             --link kong:kong \
             -e "DB_ADAPTER=the-name-of-the-adapter" \ // 'mongo','postgres','sqlserver'  or 'mysql'
             -e "DB_HOST=your-db-hostname" \
             -e "DB_PORT=your-db-port" \ // Defaults to the default db port
             -e "DB_USER=your-db-user" \ // Omit if not relevant
             -e "DB_PASSWORD=your-db-password" \ // Omit if not relevant
             -e "DB_DATABASE=your-db-name" \ // Defaults to 'konga_database'
             -e "NODE_ENV=production" \ // or 'development' | defaults to 'development'
             --name konga \
             pantsel/konga
# dev
-e "KONG_PG_HOST=10.24.193.252" \
docker run -p 1337:1337 \
             --link kong:kong \
             -e "DB_ADAPTER=postgres" \
             -e "DB_HOST=10.24.193.252" \
             -e "DB_USER=postgres" \
             -e "DB_PASSWORD=" \
             -e "DB_DATABASE=konga_database" \
             -e "NODE_ENV=development" \
             --name konga \
             pantsel/konga
             
```

#### todo

/usr/local/kong

## 使用

https://www.jianshu.com/p/5400bf1aceda

[基本使用](https://yq.aliyun.com/articles/63180)

## 参考

[kong](https://getkong.org/) Kong：Kong 是一个可扩展的开放源码API Layer(也称为API网关或API中间件)。Kong 在任何RESTful API的前面运行，通过插件扩展，它提供了超越核心平台的额外功能和服务。 [github](https://github.com/Kong/kong)

[docker](https://github.com/Kong/docker-kong)

[tyk](https://github.com/TykTechnologies/tyk)  golang Tyk：Tyk是一个开放源码的API网关，它是快速、可扩展和现代的。Tyk提供了一个API管理平台，其中包括API网关、API分析、开发人员门户和API管理面板。Try 是一个基于Go实现的网关服务。

[orange](http://orange.sumory.com/) Orange：和Kong类似也是基于OpenResty的一个API网关程序，是由国人开发的. 中文友好
v0.6.4 2017.05.16

[apiumbrella](https://apiumbrella.io/) [github](https://github.com/NREL/api-umbrella) nginx_lua

### 下面的nodejs和java先不考虑

[apiaxle](https://github.com/apiaxle/apiaxle) nodejs

[zuul](https://github.com/Netflix/zuul) Netflix zuul：Zuul是一种提供动态路由、监视、弹性、安全性等功能的边缘服务。Zuul是Netflix出品的一个基于JVM路由和服务端的负载均衡器。

[微服务 Open Source API Gateway](http://www.do1618.com/archives/783)
