# traefik 反向代理及负载均衡

## 主页

https://traefik.cn/
https://github.com/containous/traefik
https://hub.docker.com/_/traefik

## 获取

go build 可以生成一个文件
但 make 要用 docker

## https

https://www.zhangyong.name/page/1/traefik-shi-xian-https/
https://www.copperion.com/2019/raspberry-nextcloud-with-docker/

## 视频

https://github.com/heyMP/docker-traefic-test
https://github.com/justmeandopensource/kubernetes

How to use Traefik (Part 1) - Introduction to Traefik
https://www.youtube.com/watch?v=CCfUrWAuxck

## file 代理

https://docs.traefik.io/v2.0/providers/file/

[中文](https://docs.traefik.cn/toml#file-backend)

目标: 能下载文件

## docker

TODO: ? 我的 es-head 怎么访问?
TODO: ? 怎么编辑,现在都没有看到编辑的地方,更没有建全

https://www.katacoda.com/courses/traefik/deploy-load-balancer

https://hub.docker.com/_/traefik

```yaml
## traefik.yml

# Docker configuration backend
providers:
  docker:
    defaultRule: "Host(`{{ trimPrefix `/` .Name }}.docker.localhost`)"

# API and dashboard configuration, 非安全
api:
  insecure: true

```
```bash
docker run -d -p 8080:8080 -p 80:80 \
-v $PWD/traefik.yml:/etc/traefik/traefik.yml \
-v /var/run/docker.sock:/var/run/docker.sock \
traefik:v2.0

docker run -d --name test containous/whoami
```

## [性能 vs nginx](https://docs.traefik.cn/benchmarks)

同时并发是 nginx 85%

Traefik is obviously slower than Nginx, but not so much: Traefik can serve 28392 requests/sec and Nginx 33591 requests/sec which gives a ratio of 85%. Not bad for young project :) !

Some areas of possible improvements:

Use GO_REUSEPORT listener

Run a separate server instance per CPU core with GOMAXPROCS=1 (it appears during benchmarks that there is a lot more context switches with traefik than with nginx)

