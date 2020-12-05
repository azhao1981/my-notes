运维
=======

工具
-------

精通DevOps必备的50款顶级工具
<https://mp.weixin.qq.com/s/H4vR7RAZ3brPKxmEyZvKOQ>

报警
----

[DevOps实战：Graphite监控上手指南](http://www.infoq.com/cn/articles/graphite-intro)

http://www.franklinangulo.com/blog/2014/5/11/graphite-usage-statistics-on-an-elk-stack


statsd + mongo
    https://github.com/dynmeth/mongo-statsd-backend
    https://github.com/etsy/statsd

    [StatsD！次世代系统监控的核心](https://segmentfault.com/a/1190000004148785)
    zabbix nagios

    可视化
        [Grafana](https://github.com/grafana/grafana)
        Signal FX

[开发工具 InfluxDB + Grafana 快速搭建自己的 NewRelic ，分析应用运行情况](https://ruby-china.org/topics/23470)

http://www.hostedgraphite.com
it@udesk.cn
Udeskpublic0

各位是我们statsd第一阶段灰度用户
hostedgraphite：Grafana 配置自己的dashboard
statsd：echo "foo:100|c" | nc -u -w0 127.0.0.1 8125，UDP直接发送消息到本地，目前p2已部署


https://www.elastic.co/guide/en/logstash/current/plugins-outputs-graphite.html


[docker]
https://hub.docker.com/r/hopsoft/graphite-statsd/


以下两个差不多

https://github.com/hopsoft/docker-graphite-statsd

https://github.com/kamon-io/docker-grafana-graphite

    git clone https://github.com/kamon-io/docker-grafana-graphite.git

To start a container with this image you just need to run the following command:

$ make up
To stop the container

$ make down
To run container's shell

$ make shell
To view the container log

$ make tail


http://localhost:8080
admin
admin


### redis server 监控
https://blog.serverdensity.com/monitor-redis/

http://big-elephants.com/2013-09/building-a-message-queue-using-redis-in-go/


redis-cli > INFO
redis-cli > INFO clients

http://redisdoc.com/server/info.html

很不错的文章:

[细说Redis监控和告警](https://zhuoroger.github.io/2016/08/20/redis-monitor-and-alarm/)

https://www.percona.com/blog/2010/02/28/why-you-should-ignore-mysqls-key-cache-hit-ratio/

https://www.percona.com/docs/wiki/tcprstat_start.html

[Redis 高可用架构最佳实践](https://dbarobin.com/2017/05/27/ha-of-redis/?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io)


### 大数据存贮
[360海量数据存储 zeppelin设计与实现](https://mp.weixin.qq.com/s/nHcX7hB5yzlgAk2ujhVKSQ)


### CDN

[域名劫持资源重加载方案](https://techblog.toutiao.com/2017/05/09/cdn/)


### 日志

[logrotate](http://www.jianshu.com/p/ea7c2363639c)

[基于ELK+Filebeat搭建日志中心](https://github.com/jasonGeng88/blog/blob/master/201703/elk.md)
- <https://cloud.tencent.com/developer/article/1006051>
- [filebeat](https://kibana.logstash.es/content/beats/file.html)
- [Filebeat中文指南](https://www.cnblogs.com/kerwinC/p/6227768.html)
- [Logstash最佳实践](https://doc.yonyoucloud.com/doc/logstash-best-practice-cn/index.html)
- https://github.com/elastic/logstash
- [Kibana：分析及可视化日志文件 ](http://hao.jobbole.com/kibana/)
- `brew install filebeat`
- 

```bash
https://github.com/jasonGeng88/blog/blob/master/201703/elk.md
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-darwin-x86_64.tar.gz
tar -xvf filebeat-6.2.4-linux-x86_64.tar.gz
# 3.新建配置文件filebeat.yml
filebeat:
  prospectors:
    - paths:
        - /tmp/test.log #日志文件地址
      input_type: log #从文件中读取
      tail_files: true #以文件末尾开始读取数据
output:
  logstash:
      hosts: ["{$LOGSTASH_IP}:5044"] #填写logstash的访问IP
      
# 4.运行filebeat  
./filebeat-5.2.2-linux-x86_64/filebeat -e -c filebeat.yml
```

日志收集处理框架
    像 scribe 是 facebook 出品， http://dongxicheng.org/search-engine/scribe-intro/
    flume 是 apache 基金会项目， 基于Flume的美团日志收集系统(一)架构和设计
https://tech.meituan.com/mt-log-system-arch.html

[容器监控方案 cAdvisor + Elasticsearch](https://github.com/jasonGeng88/blog/blob/master/201705/cadvisor.md)


<https://www.elastic.co/products/beats/filebeat>

### 15个极好的Linux find命令示例

https://www.oschina.net/translate/15-practical-unix-linux-find-command-examples-part-2?print

### Inode 使用率高的问题

[ref](http://frankch.blog.51cto.com/10836181/1771924)

查看每个硬盘分区的inode总数和已经使用的数量，可以使用df命令，具体命令如下：

`df -i`

如果要查看每个inode节点的大小，可以用如下命令：

```bash
sudo dumpe2fs -h /dev/hda | grep "Inode size"
df -i
for i in /*; do echo $i; find  $i -atime -1 | wc -l; done
for i in /*; do echo $i; find $i | wc -l; done
for i in /usr/*; do echo $i; find $i | wc -l; done
for i in /usr/src/*; do echo $i; find $i | wc -l; done
```

### 系统自动更新内核

[更新](http://www.linuxdiyf.com/linux/29788.html)

https://github.com/oguzhaninan/Stacer

