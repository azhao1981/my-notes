etcd
-------

[ETCD](https://github.com/coreos/etcd)

### 概念

+ **ETCD** A highly-available key value store for shared configuration and service discovery.
    高可用的配置共享和服务发现 k-v 存贮
+ **服务发现** 想要了解集群中是否有进程在监听udp或tcp端口，并且通过名字就可以查找和连接
+ **Raft算法** [中文](http://www.infoq.com/cn/articles/raft-paper) [中文2](https://github.com/maemual/raft-zh_cn) [中文3](http://blog.csdn.net/cszhouwei/article/details/38374603)

### 特点:
+ 简单：基于HTTP+JSON的API让你用curl就可以轻松使用。
+ 安全：可选SSL客户认证机制。
+ 快速：每个实例每秒支持一千次写操作。
+ 可信：使用Raft算法充分实现了分布式。

### 引用: 

[etcd：从应用场景到实现原理的全方位解读](http://www.infoq.com/cn/articles/etcd-interpretation-application-scenario-implement-principle)

[goreman](https://github.com/mattn/goreman)
[foremen](https://github.com/ddollar/foreman)
[introducing-foreman](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html)
