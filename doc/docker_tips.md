# docker tips

##  书
docker101
https://www.aquasec.com/wiki/display/containers/Docker+101

##  清理空间

https://docs.docker.com/config/pruning/

DockerSlim (docker-slim): Don't change anything in your Docker container image and minify it by up to 30x (and for compiled languages even more) making it secure too! (free and open source) https://dockersl.im
https://github.com/docker-slim/docker-slim

## 其它选择

[Podman 的使用体验和 Docker 类似，不同的是 Podman 没有 daemon](https://github.com/containers/libpod)
https://alternativeto.net/software/docker/
https://containerjournal.com/topics/container-ecosystems/5-container-alternatives-to-docker/
Docker、Containerd、RunC...：你应该知道的所有
https://www.infoq.cn/article/2017/02/Docker-Containerd-RunC

https://www.aquasec.com/wiki/display/containers/Docker+Alternatives+-+Rkt%2C+LXD%2C+OpenVZ%2C+Linux+VServer%2C+Windows+Containers

Docker 数据管理
https://cloud.tencent.com/developer/article/1047243
在生产环境使用 Docker
https://cloud.tencent.com/developer/article/1047256

## gosu

[docker与gosu](https://blog.csdn.net/boling_cavalry/article/details/93380447)

## 在生产环境中运行容器的“六要、六不要和六管理”

<https://www.anquanke.com/post/id/186294>

## 远程库列表

```bash
https://stackoverflow.com/questions/31251356/how-to-get-a-list-of-images-on-docker-registry-v2
https://docs.docker.com/registry/spec/api/#introduction

curl -X GET https://myregistry:5000/v2/_catalog
> {"repositories":["redis","ubuntu"]}
List all tags for a repository:

curl -X GET https://myregistry:5000/v2/ubuntu/tags/list
> {"name":"ubuntu","tags":["14.04"]}
```
##  不错的管理工具

https://github.com/jesseduffield/lazydocker

## 再见 Docker：我删除了使用六年的 Docker

https://www.infoq.cn/article/OLMbGbRDw-IKekPDqkDc
Podman: <https://podman.io/>
Buildah
Skopeo

## 连接宿主机

mac:

<https://docs.docker.com/docker-for-mac/networking/#i-cannot-ping-my-containers>
<https://stackoverflow.com/questions/31324981/how-to-access-host-port-from-docker-container/31328031#31328031>
<https://github.com/docker/for-mac/issues/1898>

host.docker.internal

Docker for Mac v 17.12 to v 18.02
Same as above but use docker.for.mac.host.internal instead.

Docker for Mac v 17.06 to v 17.11
Same as above but use docker.for.mac.localhost instead

## image is referenced in one or more repositories
https://www.cnblogs.com/youreyebows/p/8064280.html

先删除 tag
docker rmi 192.168.0.1/you/tom:1.0.8

## volumes
[Docker学习笔记（6）——Docker Volume](https://www.jianshu.com/p/ef0f24fd0674)
## webapp

[react+docker](https://medium.com/yld-engineering-blog/deploy-your-create-react-app-with-docker-and-ngnix-653e94ffb537)

<https://medium.com/@hendrikwallbaum/dockerizing-spas-9f72b7867e41>

