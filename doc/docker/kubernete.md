# kubernetes

## 资源

[主页](http://kubernetes.io/)

[github](https://github.com/kubernetes/kubernetes)

[kubernetes最近好文章](https://stackshare.io/posts/kubernetes-roundup-1)
    - https://www.oschina.net/p/kaniko
    - [3小时学习k8部署微服务](https://medium.freecodecamp.org/learn-kubernetes-in-under-3-hours-a-detailed-guide-to-orchestrating-containers-114ff420e882)
    - [安全最佳实践](https://github.com/freach/kubernetes-security-best-practice?ref=stackshare)
    - [tcp debug](https://blog.hasura.io/debugging-tcp-socket-leak-in-a-kubernetes-cluster-99171d3e654b?ref=stackshare)
    - [Jenkins X + k8s](https://jenkins.io/blog/2018/03/19/introducing-jenkins-x/?ref=stackshare)
    - [kubernetes-state-of-stateful-apps](https://www.cockroachlabs.com/blog/kubernetes-state-of-stateful-apps/?ref=stackshare)
    - [kubernetes-101](https://medium.com/google-cloud/kubernetes-101-pods-nodes-containers-and-clusters-c1509e409e16)
    - https://blog.hasura.io/draft-vs-gitkube-vs-helm-vs-ksonnet-vs-metaparticle-vs-skaffold-f5aa9561f948
    - [一个严重bug](https://zhuanlan.zhihu.com/p/37217575)

[阿里的 k8s 集群/容器服务](https://cs.console.aliyun.com/#/k8s/cluster/list)

## 安装 centos8+k8 1.18

使用kubeadm在Centos8上部署kubernetes1.18
https://www.kubernetes.org.cn/7189.html

kubernetes部署（kubeadm国内镜像源）  
https://my.oschina.net/Kanonpy/blog/3006129

Centos搭建Docker和Kubernetes
https://juejin.im/post/5e7f7ba96fb9a03c947cb935

看起来像官方
https://kubernetes.io/zh/docs/home/
https://kubernetes.io/zh/docs/setup/learning-environment/minikube/

 kubeadm init --kubernetes-version=1.18.0  \
--apiserver-advertise-address=192.168.56.101   \
--image-repository registry.aliyuncs.com/google_containers  \
--service-cidr=10.10.0.0/16 --pod-network-cidr=10.122.0.0/16

设置 kubectl客户端

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get node
现在只有一个master001,还是notready
master001.k8.local   NotReady   master   16h   v1.18.5

kubectl get pod --all-namespaces
kube-system   coredns-7ff77c879f-wlzdh                     0/1     Pending   0          16h
kube-system   coredns-7ff77c879f-xvpt7                     0/1     Pending   0          16h
kube-system   etcd-master001.k8.local                      1/1     Running   0          16h
kube-system   kube-apiserver-master001.k8.local            1/1     Running   0          16h
kube-system   kube-controller-manager-master001.k8.local   1/1     Running   0          16h
kube-system   kube-proxy-49qt5                             1/1     Running   0          16h
kube-system   kube-scheduler-master001.k8.local            1/1     Running   0          16h

### 添加网络

[配置网络](https://www.funtl.com/zh/service-mesh-kubernetes/%E9%85%8D%E7%BD%AE%E7%BD%91%E7%BB%9C.html)

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
但发现
kubectl get pod --all-namespaces
还是pending
kube-system   calico-kube-controllers-58b656d69f-knlcg     0/1     Pending                 0          22m
kube-system   calico-node-csbfl                            0/1     Init:ImagePullBackOff   0          22m

kubectl describe pod calico-node-csbfl --namespace=kube-system
Events:
  Type     Reason     Age                  From                         Message
  ----     ------     ----                 ----                         -------
  Normal   Scheduled  <unknown>            default-scheduler            Successfully assigned kube-system/calico-node-csbfl to master001.k8.local
  Warning  Failed     2m33s                kubelet, master001.k8.local  Failed to pull image "calico/cni:v3.15.0": rpc error: code = Unknown desc = context canceled
  Warning  Failed     2m33s                kubelet, master001.k8.local  Error: ErrImagePull
  Normal   BackOff    2m32s                kubelet, master001.k8.local  Back-off pulling image "calico/cni:v3.15.0"
  Warning  Failed     2m32s                kubelet, master001.k8.local  Error: ImagePullBackOff
  Normal   Pulling    2m18s (x2 over 22m)  kubelet, master001.k8.local  Pulling image "calico/cni:v3.15.0"

kubectl logs -n kube-system calico-node-csbfl

应该是拉不下这个镜像

calico/cni:v3.15.0
registry.aliyuncs.com/google_containers/kube-scheduler
sudo docker pull registry.aliyuncs.com/google_containers/calico/cni:v3.15.0

registry.cn-hangzhou.aliyuncs.com/k8s-calico/cni
v3.13.0

calico/cni:v3.15.0
docker pull calico/pod2daemon-flexvol:v3.15.0
docker pull calico/node:v3.15.0
docker pull calico/kube-controllers:v3.15.0

docker save -o ca.pod2daemon.tar calico/pod2daemon-flexvol:v3.15.0
docker save -o ca.node.tar calico/node:v3.15.0
docker save -o ca.kctrl.tar calico/kube-controllers:v3.15.0

sudo usermod -aG docker centos

--apiserver-advertise-address=192.168.56.101
--service-cidr=10.10.0.0/16 --pod-network-cidr=10.122.0.0/16

2020-06-30 08:35:10.970 [INFO][1] main.go 109: Ensuring Calico datastore is initialized
2020-06-30 08:35:12.016 [ERROR][1] client.go 261: Error getting cluster information config ClusterInformation="default" error=Get https://10.10.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default: dial tcp 10.10.0.1:443: connect: no route to host
2020-06-30 08:35:12.016 [FATAL][1] main.go 114: Failed to initialize Calico datastore error=Get https://10.10.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default: dial tcp 10.10.0.1:443: connect: no route to host

https://k8smeetup.github.io/docs/admin/kubeadm/
--pod-network-cidr
对于某些网络解决方案，Kubernetes master 也可以为每个节点分配网络范围（CIDR），这包括一些云提供商和 flannel。通过 --pod-network-cidr 参数指定的子网范围将被分解并发送给每个 node。这个范围应该使用最小的 /16，以让 controller-manager 能够给集群中的每个 node 分配 /24 的子网。如果您是通过 这个 manifest 文件 来使用 flannel，那么您应该使用 --pod-network-cidr=10.244.0.0/16。大部分基于 CNI 的网络解决方案都不需要这个参数。

--service-cidr (默认 ‘10.96.0.0/12’)
您可以通过使用 --service-cidr 参数来覆盖 Kubernetes 用来分配 pod IP 地址的子网。如果您这么做了，那么您还需要更新 /etc/systemd/system/kubelet.service.d/10-kubeadm.conf 文件来反映这个修改，否则 DNS 将无法正常工作。

对 kubeadm 进行故障排查
https://kubernetes.io/zh/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/

kubeadm init --kubernetes-version=1.18.0  \
--apiserver-advertise-address=192.168.56.101   \
--image-repository registry.aliyuncs.com/google_containers  \
--service-cidr=10.10.0.0/16 --pod-network-cidr=10.122.0.0/16

禁用SELinux
修改/etc/selinux/config，设置SELINUX=disabled，重启机器。

Pod 异常排错
https://feisky.gitbooks.io/kubernetes/troubleshooting/pod.html

增加一个pod

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.56.101:6443 --token 0lcoqi.pbcumaztdifxatg3 \
    --discovery-token-ca-cert-hash sha256:49cb79baffc0b1f80a1313622cfc0eea3e8d7526d3ca63df1b036ab3cf879cb5

## helm charts

Helm User Guide - Helm 用户指南
https://whmzsu.github.io/helm-doc-zh-cn/?q=
Helm教程
https://www.cnblogs.com/lyc94620/p/10945430.html
https://github.com/helm/charts

## k3s

https://k3s.io/
https://www.rancher.cn/rancher-k3s/
https://www.kubernetes.org.cn/5069.html

你的第一次轻量级K8S体验 —— 记一次Rancher 2.2 + K3S集成部署过程
https://blog.ilemonrain.com/docker/rancher-with-k3s.html

### unistall

```bash
curl -sfL https://get.k3s.io > uninstall.sh

k3s-killall.sh
k3s-uninstall.sh

echo "Stopping firewall and allowing everyone..."
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -L -n
sudo iptables -L -n -t nat
```

### 装 rancher

```bash
docker pull rancher/rancher:stable

docker run -d -v /data/docker/rancher-server/var/lib/rancher/:/var/lib/rancher/ --restart=unless-stopped --name rancher-server -p 80:80 -p 443:443 rancher/rancher:stable

docker run -d -v /data/docker/rancher-server/var/lib/rancher/:/var/lib/rancher/ --restart=unless-stopped --name rancher-server -p 9080:9080 -p 9443:9443 rancher/rancher:stable

docker exec -it 31aa94998b75 bash
sed -i "s/80/9080/g" /usr/bin/entrypoint.sh
sed -i "s/443/9443/g" /usr/bin/entrypoint.sh
```

touch docker-compose.yml
mkdir -p data tools

```yaml
version: "3.1"
services:
  rancher:
    restart: always
    image: rancher/rancher:stable
    ports:
      - 9080:80
      - 9443:443
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - ./tools/:/srv/tools
      - ./data/:/var/lib/rancher
```

### pause 镜像被墙无法下载

<https://hub.docker.com/r/rancher/pause-amd64/tags>

只有742kB?

```bash
docker pull registry.cn-beijing.aliyuncs.com/ilemonrain/pause-amd64:3.1
docker tag registry.cn-beijing.aliyuncs.com/ilemonrain/pause-amd64:3.1 k8s.gcr.io/pause:3.1
```

+ 不能下载 比较久,但最终还是能下

[k3s 安装小记](http://zxc0328.github.io/2019/06/04/k3s-setup/)

[K3s:轻量的Kubernetes](https://segmentfault.com/a/1190000018797879)

```bash
## 下载镜像，避免无网络或访问不了gcr.io
wget https://github.com/rancher/k3s/releases/download/v0.3.0/k3s-airgap-images-amd64.tar
sudo mkdir -p /var/lib/rancher/k3s/agent/images/
sudo cp k3s-airgap-images-amd64.tar  /var/lib/rancher/k3s/agent/images/
```

### /etc/systemd/system/k3s.service

vim /etc/systemd/system/multi-user.target.wants/k3s.service

```bash
ExecStart=/usr/local/bin/k3s \
    server \
# new
ExecStart=/usr/local/bin/k3s server --docker --no-deploy traefik

systemctl daemon-reload
service k3s restart
service k3s status

k3s kubectl get node
```

### Step 5: 导入K3S集群到 Rancher

<work/udesk.md#hids rancher>

`curl --insecure -sfL *** |  kubectl apply -f -`

```bash
# curl --insecure -sfL https://xxx:9443/v3/import/xxx.yaml | kubectl apply -f -

clusterrole.rbac.authorization.k8s.io/proxy-clusterrole-kubeapiserver created
clusterrolebinding.rbac.authorization.k8s.io/proxy-role-binding-kubernetes-master created
namespace/cattle-system created
serviceaccount/cattle created
clusterrolebinding.rbac.authorization.k8s.io/cattle-admin-binding created
secret/cattle-credentials-8721c00 created
clusterrole.rbac.authorization.k8s.io/cattle-admin created
deployment.extensions/cattle-cluster-agent created
daemonset.extensions/cattle-node-agent created
```

time="2019-10-15T08:07:47Z" level=info msg="Connecting to wss://hids.udesk.cn:9443/v3/connect with token wgvgpz6fwr2ndd6kfjbdss44jcm25k8m4pxs5vp4dg5n8wzs6hpxt9"
time="2019-10-15T08:07:47Z" level=info msg="Connecting to proxy" url="wss://hids.udesk.cn:9443/v3/connect"

https://gist.github.com/janeczku/e20e6298462918b0570dda8c66c47f62
https://gist.github.com/superseb/89972344508e99b9336ad7eff78cb928

### 其它引用

[K8S 的轻量版 K3S 安装教程](https://github.com/eyasliu/blog/issues/26)

kubernetes（8）：rancher 的 k3s 使用启动测试，边缘计算，物联网使用
https://blog.csdn.net/freewebsys/article/details/88263731

不到1分钟，从零完成k3s Kubeconfig配置！
https://juejin.im/post/5d65e668e51d453bc470df00

组件:
https://traefik.cn/
https://mritd.me/2018/05/24/kubernetes-traefik-service-exposure/
https://my.oschina.net/guol/blog/2209678
/var/lib/rancher/k3s/agent/kubelet/pods/acd768d8-3c45-11e9-8998-265efbe5077e/volumes/kubernetes.io~configmap/config/traefik.toml

## mac

最新的edge 版本内置支持了,但是需要清除原来所有的配置的文件

[下载地址](https://store.docker.com/editions/community/docker-ce-desktop-mac)

[中国主页](http://www.docker-cn.com/)

### 被墙的问题

[相关issues](https://github.com/docker/for-mac/issues/2474)

[相关解决方案](https://github.com/denverdino/k8s-for-docker-desktop) |
[另外参考:手工在Docker for mac上安装Kubernetes](https://www.cnblogs.com/andrewwang/p/8603589.html)

+ 加镜像

<https://registry.docker-cn.com>
<https://j90112tg.mirror.aliyuncs.com>

+ `git clone https://github.com/denverdino/k8s-for-docker-desktop` 执行 `./load_images.sh`
+ 执行后可能需要 在docker.app 里重置一下 kubernetes
+ 可选,一般用 docker.app 不需要做这步 `kubectl config use-context docker-for-desktop`
+ 验证安装
  + `kubectl cluster-info` 两个地址都是 https,但https是没有证书的
  + kubectl get nodes
+ Deploy Kubernetes dashboard
  + install `kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml`
  + or `kubectl create -f kubernetes-dashboard.yaml`
  + Start proxy for API server `kubectl proxy`
  + http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default
  + 配置 可以跳过
+ TODO:
  + kubectl cluster-info 两个地址的证书的问题
  + 配置访问权限问题

+ 官方demo  <http://www.kingscow.com/archives/tag/k8s> <https://cloud.tencent.com/developer/article/1007305>
  + docker stack deploy –compose-file stack.yml demo
  + docker stack --namespace my-app deploy –compose-file stack.yml demo
  + docker stack remove demo
  + kubectl get pods
  + kubectl get deployments
  + kubectl get services
  + kubectl get services -n my-app

+ 安装一个 es-ik 压压惊
  + cd ~/udesk/docker/es5.6.4 && docker build -t elasticsearch-ik:5.6.4-alpine .
  + cd ~/udesk/docker
  + brew install kompose or

```shell
curl -L https://github.com/kubernetes/kompose/releases/download/v1.13.0/kompose-darwin-amd64 -o kompose
chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose
```

+ kompose convert -f docker-compose.yaml 这个不知道跑哪个? 有两套,一套 deployment.yaml 一套 service.yaml
+ kompose -f ./docker-compose.yml up
+ docker stack --namespace base deploy –compose-file ~/udesk/docker/docker-compose.yml elastic

```shell
kompose -f ./docker-compose.yml up
WARN Volume mount on the host "/Users/weizhao/udesk/docker/esdata" isn't supported - ignoring path on the host
WARN Volume mount on the host "/Users/weizhao/udesk/docker/es5.6.4/config/elasticsearch.yml" isn't supported - ignoring path on the host
INFO We are going to create Kubernetes Deployments, Services and PersistentVolumeClaims for your Dockerized application. If you need different kind of resources, use the 'kompose convert' and 'kubectl create -f' commands instead.
```

一些用法
`kubectl get all --all-namespaces`

[Kubernetes in Docker for Mac Beta小記](http://sakananote2.blogspot.jp/2018/01/kubernetes-in-docker-for-mac-beta.html)

https://rominirani.com/tutorial-getting-started-with-kubernetes-with-docker-on-mac-7f58467203fd
新特性初探：Docker for Mac喜迎Kubernetes支持能力
 http://dockone.io/article/3038

基于 Docker for MAC 的 Kubernetes 本地环境搭建与应用部署
 https://juejin.im/post/5a5cbad5518825734216e14f
Docker for Mac 添加 Kubernetes dashboard
 https://my.oschina.net/u/2306127/blog/1606599
Ubuntu上运行MiniKube，快速开始攻略
https://my.oschina.net/u/2306127/blog/1621468

## 部署

<https://kubernetes.feisky.xyz/zh/deploy/>

<https://kubernetes.feisky.xyz/zh/deploy/single.html>

[使用Ansible脚本安装K8S集群，介绍组件交互原理，方便直接，不受国内网络环境影响](https://github.com/gjmzj/kubeasz)

https://github.com/hasura/gitkube

## minikube 本地体验版

删除,这个有效
https://github.com/kubernetes/minikube/issues/1043 
Hopefully, this is all of it but converted to macOS tools

minikube stop; minikube delete &&
docker stop $(docker ps -aq) &&
rm -rf ~/.kube ~/.minikube &&
sudo rm -rf /usr/local/bin/localkube /usr/local/bin/minikube &&
launchctl stop '*kubelet*.mount' &&
launchctl stop localkube.service &&
launchctl disable localkube.service &&
sudo rm -rf /etc/kubernetes/ &&
docker system prune -af --volumes

LINUX:
To completely nuke it, this worked for me on Linux:
minikube stop; minikube delete
docker stop (docker ps -aq)
rm -r ~/.kube ~/.minikube
sudo rm /usr/local/bin/localkube /usr/local/bin/minikube
systemctl stop '*kubelet*.mount'
sudo rm -rf /etc/kubernetes/
docker system prune -af --volumes

[参考](http://johng.cn/minikube-installation/)

<https://ehlxr.me/2018/01/12/kubernetes-minikube-installation/>

```shell
brew cask install minikube -v
minikube -h

sudo minikube start

卡在这里
E0508 12:05:53.326075   81098 start.go:281] Error restarting cluster:  restarting kube-proxy: waiting for kube-proxy to be up for configmap update: timed out waiting for the condition

# 会打印出管理后台地址
sudo minikube dashboard --url

# 或者用下面写法，会自动打开默认浏览器，但我的一直失败，没有打开默认浏览器，没关系，执行后自己打开也行
sudo minikube dashboard
```

## 中文资料

[社区](http://dockone.io/topic/Kubernetes)
    http://dockone.io/article/5297

[开发实践](https://www.kubernetes.org.cn/practice)

https://12factor.net/zh_cn/

[8 月最新基于 kubernetes 的应用编排实践](https://cloud.tencent.com/developer/article/1005788)

[k8](https://github.com/hasura/gitkube)

Monitoring, visualisation & management for Docker & Kubernetes
https://github.com/weaveworks/scope

### Helm编排

[Docker —— 从入门到实践](https://yeasy.gitbooks.io/docker_practice/content/kubernetes/)

+ 启动 etcd  https://github.com/coreos/etcd 
  + https://skyao.gitbooks.io/learning-etcd3/content/documentation/op-guide/configuration.html
  + docker run --net=host -d gcr.io/google_containers/etcd:2.0.9 /usr/local/bin/etcd --addr=127.0.0.1:4001 --bind-addr=0.0.0.0:4001 --data-dir=/var/etcd/data
  + docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/etcd-amd64:3.2.18
  + docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/etcd-amd64:3.2.18 etcd:3.2.18
  + docker run --net=host -d etcd:3.2.18 /usr/local/bin/etcd --addr=127.0.0.1:4001 --bind-addr=0.0.0.0:4001 --data-dir=/var/etcd/data
  + docker run --net=host etcd:3.2.18 /usr/local/bin/etcd --data-dir=/var/etcd/data
  + --addr= 已经不支持了 [参考](https://blog.csdn.net/fly2leo/article/details/78326594)
  + docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/etcd-amd64:2.0.9
    + 
+ https://gcpug-tw.gitbooks.io/kuberbetes-in-action/content/install-from-docker-compose.html

[Kubernetes系统架构简介](http://www.infoq.com/cn/articles/Kubernetes-system-architecture-introduction)

[国内服务器安装kubernetes一路坑](http://dockone.io/question/1225)

[Kubernetes监控之InfluxDB](http://dockone.io/article/1878)

[k8s开源书](https://github.com/feiskyer/kubernetes-handbook)

https://github.com/ksonnet/kubecfg

[DockOne微信分享（一二〇）：基于Kubernetes的私有容器云建设实践](http://dockone.io/article/2351)

https://kubernetes.io/docs/tools/kompose/user-guide/

k8s use docker-compose
https://github.com/vyshane/docker-compose-kubernetes

[kubernetes-101/done](https://medium.com/google-cloud/kubernetes-101-pods-nodes-containers-and-clusters-c1509e409e16)
    https://blog.hasura.io/draft-vs-gitkube-vs-helm-vs-ksonnet-vs-metaparticle-vs-skaffold-f5aa9561f948
