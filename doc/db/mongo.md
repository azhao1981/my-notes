mongo.md
----

### 文档

[中文](http://www.runoob.com/mongodb/mongodb-tutorial.html)

### ubuntu 安装

[doc](https://docs.mongodb.com/v3.2/tutorial/install-mongodb-on-ubuntu/)

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

# Ubuntu 12.04
echo "deb http://repo.mongodb.org/apt/ubuntu precise/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Ubuntu 14.04
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Ubuntu 16.04
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt-get update

sudo apt-get install mongodb-org
# or
sudo apt-get install -y mongodb-org=3.2.10 \
  mongodb-org-server=3.2.10 \
  mongodb-org-shell=3.2.10 \
  mongodb-org-mongos=3.2.10 \
  mongodb-org-tools=3.2.10

```

### 性能及监控分析

[MongoDB运行状态、性能监控，分析](https://blog.csdn.net/liubo2012/article/details/8203751) | 
[mongodb之查看状态的命令详解](http://blog.51cto.com/yucanghai/1705237) |
[MongoDB 连接数高产生原因及解决](https://blog.csdn.net/hjxhjh/article/details/12611195) |
<https://docs.mongodb.com/manual/reference/command/nav-diagnostic/> |

#### mongostat

mongostat -u admin -p xxx --port 27017 --authenticationDatabase=admin

inserts/s   每秒插入次数
query/s     每秒查询次数
update/s    每秒更新次数
  10条简单的查询可能比一条复杂的查询速度还快, 所以数值的大小，意义并不大
getmore/s   查询时游标(cursor)的getmore操作
command/s   每秒的命令数，在主从系统中，会显示两个值 （例如：80|0），分别代表 本地|复制 命令的个数
flushs/s 每秒执行fsync将数据写入硬盘的次数。
  一般都是0，或者1，通过计算两个1之间的间隔时间，可以大致了解多长时间flush一次。flush开销是很大的，如果频繁的flush，可能就要找找原因了。
mapped/s 所有的被mmap的数据量，单位是MB（这是 在mongostat 最后一次调用的总数据）
vsize 虚拟内存使用量，单位MB （这是 在mongostat 最后一次调用的总数据）
res 物理内存使用量，单位MB （这是 在mongostat 最后一次调用的总数据）
  这个和你用top看到的一样，mapped, vsize一般不会有大的变动， res会慢慢的上升，如果res经常突然下降，去查查是否有别的程序狂吃内存。
faults/s 每秒访问失败数(只有Linux有)，数据被交换出物理内存，放到swap。
   注：不要超过100，否则就是机器内存太小，造成频繁swap写入。此时要升级内存或者扩展，大压力下这个数值往往不为0。如果经常不为0，那就该加内存了。
locked % 被锁的时间百分比，尽量控制在50%以下吧
   注：MongoDB就一把读写锁，这里指的是写锁所住的时间百分比。这个数值过大(经常超过10%)，那就是出状况了。
idx miss % 访问加载 btree 节点时需要页面故障的尝试的索引百分比。
   注：这是一个采样值。如果太高的话就要考虑索引是不是少了，非常重要的参数, 正常情况下，所有的查询都应该通过索引，也就是idx miss为0。如果这里数值较大，是不是缺少索引。
qr  客户端等待从 MongoDB 实例读取数据的队列长度。
qw  客户端等待向 MongoDB 实例写入数据的队列长度。
ar  执行读取操作的活动客户端的数目。
aw  执行写入操作的活动客户端的数目。
   注：如果这两个数值很大，那么就是DB被堵住了，DB的处理速度不及请求速度。看看是否有开销很大的慢查询。如果查询一切正常，确实是负载很大，就需要加机器了。
conn   打开连接的总数。
   注： MongoDB为每一个连接创建一个线程，线程的创建和释放也是有开销的。尽量不要让这个数值很大。
#### profiler

db.setProfilingLevel(2);
db.getProfilingLevel();

0 – 不开启
1 – 记录慢命令 (默认为>100ms)
2 – 记录所有命令
db.setProfilingLevel( level , slowms ) 
　　db.setProfilingLevel( 1 , 100 );
查看Profile日志
db.system.profile.find().sort({$natural:-1})
ts：时间戳
info：具体的操作
millis：操作所花时间，毫秒
注意，造成满查询可能是索引的问题，也可能是数据不在内存造成因此磁盘读入造成。

#### db.stat()
#### db.serverStatus()
#### db.currentOp()

#### connPoolStats
但好像没有用 好像必须是分片状态的机器才能用
http://www.cnblogs.com/abclife/p/5425413.html

#### 连接数

- connPoolTimeout设置

（该参数不在官方没有）
效果

mongos> db.runCommand({ setParameter : 1, connPoolTimeout : 900 })
{ "was" : 1800, "ok" : 1 }
初步测试，效果不明显。

releaseConnections
计划添加个命令releaseConnections，从mongod运行，减少复制集连接数。

### docker 安装

[docker国内安装](/doc/docker_cn.md)

快速安装 ali docker for ubuntu

```shell
curl -sSL https://git.io/vyg91 | bash
```

安装 mongo
```shell
mkdir -p mongo/db mongo/log

docker pull mongo:3.2.10
```

[ali docker](https://dev.aliyun.com/)

试`docker run -p 27017:27017 -v $PWD/db:/data/db -d mongo:3.2.10`

这个居然不是后台运行,改使用下面的脚本`run.sh`来运行

```bash

#!/bin/bash
cd `dirname $0`
DIR=`pwd`
mkdir -p $DIR/db $DIR/log

NAME=mongo

docker stop $NAME
docker rm $NAME

# 正常开两个地址端口,注意10.1.251.27换成自己的内网地址
# 忘记密码请去掉 --auth 重启再进入
 nohup docker run \
  -p 10.1.251.27:27017:27017 \
  -p 127.0.0.1:27017:27017 \
  -v $PWD/db:/data/db \
  --name $NAME \
  mongo:3.2.10 --auth > log/mongo.log &

sleep 2
docker ps
```

命令行访问

```
docker exec -it mongo mongo -u admin -p xxx test
```

--auth 在没有系统管理账号时不会生效,忘记密码请去掉 --auth 重启再进入

注: `2.*` 版本客户端不能进入`3.*` 的服务器

[参考](https://yeasy.gitbooks.io/docker_practice/content/appendix_repo/mongodb.html)


### 管理员维护

#### IOPS计算

使用如下脚本可以看到机器的IOPS
```shell
#!/bin/bash
uplrio=0
uplwio=0
updrio=0
updwio=0

# 卷名,cat /proc/diskstats 查看服务器卷名, vda1为阿里云ecs默认名
DriverName=vda1

while true ; do
        lrio=$(grep $DriverName /proc/diskstats | awk '{print $4}')
        lwio=$(grep $DriverName /proc/diskstats | awk '{print $8}')
        llrio=$(echo $lrio - $uplrio | bc)
        llwio=$(echo $lwio - $uplwio | bc)
        iops=$(echo "$llrio + $llwio " | bc)
        echo "iops:$iops Data_Read $llrio Data_Write $llwio "
        uplrio=$lrio
        uplwio=$lwio
        sleep 1
done

# 参考 http://blog.itpub.net/22664653/viewspace-757531/
```
#### 当前操作/连接

http://xiayuanfeng.iteye.com/blog/987555

```json
db.currentOp();
db.$cmd.sys.inprog.find()
// <= v1.2
> db.killOp()
> // 等同于: db.$cmd.sys.killop.findOne()
{"info" : "no op in progress/not locked"}
// v>= 1.3
> db.killOp(1234/*opid*/)> 
// 等同于: db.$cmd.sys.killop.findOne({op:1234})
```

http://tech.lezi.com/archives/290
https://www.jianshu.com/p/da43f0234d47

https://www.cnblogs.com/xiaoit/p/4597100.html
db.currentOp()
2：查看当前有多少个连接？
db.serverStatus().connections

"opid" : 6222,#进程号
"active" : true,#是否活动状态
"secs_running" : 3,#操作运行了多少秒
"microsecs_running" : NumberLong(3662328),
"op" : "getmore",#操作类型，包括(insert/query/update/remove/getmore/command)
"ns" : "local.oplog.rs",#命名空间
"query" : {},#如果op是查询操作，这里将显示查询内容；也有说这里显示具体的操作语句的

"client" : "192.168.91.132:45745",#连接的客户端信息
"desc" : "conn5",#数据库的连接信息
"threadId" : "0x7f1370cb4700",#线程ID
"connectionId" : 5,#数据库的连接ID
"waitingForLock" : false,#是否等待获取锁
"numYields" : 0,
"lockStats" : {
"timeLockedMicros" : {#持有的锁时间微秒
"r" : NumberLong(141),#整个MongoDB实例的全局读锁
"w" : NumberLong(0)},#整个MongoDB实例的全局写锁
"timeAcquiringMicros" : {#为了获得锁，等待的微秒时间
"r" : NumberLong(16),#整个MongoDB实例的全局读锁
"w" : NumberLong(0)}#整个MongoDB实例的全局写锁

#### proxy (重要)

mongo的连接数一个会占1m,然后不会太多,需要一个proxy做中转
https://github.com/facebookgo/dvara
http://blog.parse.com/learn/engineering/dvara/


https://github.com/dataux/dataux
  cloud.google.com/go/storage https://github.com/GoogleCloudPlatform/google-cloud-go

  google.golang.org/api/option https://github.com/google/google-api-go-client
  g clone https://github.com/google/google-api-go-client src/google.golang.org/api

  <!--git clone --depth 1 https://github.com/google/go-genproto.git src/google.golang.org/genproto-->

  src/k8s.io/client-go && git checkout -b v1.4.0 v1.4.0

  golang.org/x/oauth2

  golang 处理包: http://golangtc.com/t/56f3c175b09ecc66b9000181

  golang 跨编译 http://blog.jyootai.com/blog/2015/05/08/golang-cross-platform-compile.html

#### 数据迁移及导出

[mongo到es/mgo官方](https://github.com/mongodb-labs/mongo-connector)
[mongo到es/es出口](https://github.com/richardwilly98/elasticsearch-river-mongodb)
[介绍](https://segmentfault.com/a/1190000003773614)

[高可用的MongoDB集群](http://www.jianshu.com/p/2825a66d6aed)

#### 单表备份及恢复

mongoexport -d udesk_vistor_test -c vistor_trace -o ./trace.json

mongoimport -d udesk_vistor -c vistor_trace --type json --file ./trace.json

[参考](http://www.bkjia.com/sjkqy/901460.html)

+ 单个collection备份：

mongoexport -h dbhost -d dbname -c collectionname -f collectionKey -o dbdirectory

  -h: MongoDB所在服务器地址

  -d: 需要恢复的数据库实例

  -c: 需要恢复的集合

  -f: 需要导出的字段(省略为所有字段)

  -o: 表示导出的文件名

+ 单个collection恢复：

  mongoimport -d dbhost -c collectionname –type csv –headerline –file

  -type: 指明要导入的文件格式

  -headerline: 批明不导入第一行，因为第一行是列名

  -file: 指明要导入的文件路径

#### 压缩
  [单表 compact](https://docs.mongodb.com/manual/reference/command/compact/)
  [中文](http://blog.nosqlfan.com/html/3282.html)
  > db.yourCollection.runCommand("compact");
  > db.runCommand({ compact online casino  : "yourCollection" });
  + Compact操作进行中，会blocks掉所有在当前Collection上的操作，所以Compact操作最好在业务低估的时候进行。
  + 你可以在一个Replica Sets的secondary上进行数据压缩，不过在压缩过程中，这个节点会变成不能服务的recovery模式。
  + 运行Compact操作后，当前Collection的Padding Factor会变成1，后续如果有使数据变长的更新操作，可能会在一段时间内比较慢。
  + Capped Collection是不能进行Compact操作的，原因嘛，因为Capped Collection本身就没有碎片存在。
  [整体](http://blog.nosqlfan.com/html/1062.html)
  [中文](http://blog.nosqlfan.com/html/1062.html)
  db.repairDatabase()

#### 自动分片

按时间分片

组合键分片

一旦以某个键建立了分片，暂时没有再修改为按其它键分片的办法(2.0)

Generally, having a large number of collections has no significant(重大的) performance penalty(惩罚) and results in(结果是) very good performance. Distinct collections are very important for high-throughput batch processing.


#### 集合数限制
https://docs.mongodb.com/manual/core/data-model-operations/#collection-contains-large-number-of-small-documents

3.x 应该是自动2G以上
–nssize 只设置新创建的 .ns 文件的大小，如果想改变已经存在的数据库的命名空间，在使用这个参数启动后，还需要运行 db.repairDatabase() 命令来调整尺寸。
12000(c+i) = 24,000(namespace) = 16M
3,400,000 = 2G

[引用](https://blog.oldj.net/2011/08/14/notes-on-mongodb/)

#### Auto-Sharding
[58](http://www.infoq.com/cn/articles/app-practice-of-mongodb-in-58-ten-billion-scale-data)
首先是在Sharding Key选择上，如果选择了单一的Sharding Key，会造成分片不均衡，一些分片数据比较多，一些分片数据较少，无法充分利用每个分片集群的能力。为了弥补单一Sharding Key的缺点，引入复合Sharing Key，然而复合Sharding Key会造成性能的消耗；

第二count值计算不准确的问题，数据Chunk在分片之间迁移时，特定数据可能会被计算2次，造成count值计算偏大的问题；

第三Balancer的稳定性&智能性问题，Sharing的迁移发生时间不确定，一旦发生数据迁移会造成整个系统的吞吐量急剧下降。为了应对Sharding迁移的不确定性，我们可以强制指定Sharding迁移的时间点，具体迁移时间点依据业务访问的低峰期。比如IM系统，我们的流量低峰期是在凌晨1点到6点，那么我们可以在这段时间内开启Sharding迁移功能，允许数据的迁移，其他的时间不进行数据的迁移，从而做到对Sharding迁移的完全掌控，避免掉未知时间Sharding迁移带来的一些风险。

我们的MongoDB集群线上环境全部禁用了Auto-Sharding功能

#### 监控

http://munin-monitoring.org/


#### Replica
Could not reach any servers in [(u'205d29c30140', 27017)]. Replica set is configured with internal hostnames or IPs?

https://github.com/mongodb-labs/mongo-connector/issues/391
https://docs.mongodb.com/manual/tutorial/change-hostnames-in-a-replica-set/

```javascript
cfg = rs.conf()
cfg.members[0].host = "localhost:27017"
rs.reconfig(cfg)
```

### 常用查询语句

#### 删除

```javascript
db.getCollection('vistor_trace').remove({"data": {$exists:true}})
```
### 概念

#### [索引实践](http://blog.nosqlfan.com/html/3656.html)

#### [最佳实践](https://www.oschina.net/translate/mongodb-best-practices)
1. 彻底的测试 模拟你的生产环境，包括流量来进行测试。假如你的测试环境不能达到生产环境的压力，你将无法发现性能瓶颈和架构缺陷。

2. RDBMS 并不一定能迁移到 NoSQL

3. 考虑你的数据的一致性和持久性需求 这一点很重要！MongoDB通过多实例备份来提解决数据持久性问题。不推荐生产环境中只使用一个MongoDB实例。

4. 始终启用备份 备份能保证你应用的高可用性。假如你的一个节点down了，第二节点可以迅速启用，你的应用不会中断。

5. 使用最新版本

6. 不要在32位的系统上跑MongoDB MongoDB在32位系统上有“2.5GB数据限制”。它的存储引擎使用内存映射来读取文件以获得更好的性能。这个功能依赖于内存寻址，而32位系统的内存不能超过4GB。

7. 默认开启日志 MongoDB支持数据库操作的提前日志（write-ahead journaling）。这个功能有助于灾难恢复。

8. 注意你数据文件的位置 你应该保证你的MongoDB的数据文件是存储在物理驱动器上，例如 /data/mongodb。当然你也可以使用虚拟的驱动器，但是必须非常小心。因为它有可能会影响到你的集群架构。我们建议你使用 Amazon EBS 来存放你的数据库文件。

9. 保证足够大的内存 为了保证整个集群的性能，你要确保整个所有MongoDB的工作实例（working set）包括索引可以完全装入内存。如果你发现“page faults”的概率在增加，很有可能mongoDB的数据量超出了你的内存。在这种情况下你有两种选择：加内存，或者创建分片集群（Sharding）。我们建议你先考虑加内存。

10. 保持 65% 以内的压力 如果你发现你的集群压力达到了65%，那么你应该考虑扩大你的集群了。通常，你应该保证数据库压力低于65%。

11. 特别小心分片集群 分片集群需要你充分理解你应用的数据访问方式。你应该充分了解MongoDB的分片工作方式，并且确认你确实需要这个功能。还有，选择一个分片钥匙（sharding key）是对于性能也是很重要的。

配置服务器对于一个集群的健康也是很重要的。在分片集群的环境中，你必须有三台配置服务器。永远不要删除配置服务器的数据，时常备份这些数据。这些配置服务器也需要64位的环境。还有，不要把三台配置服务器放在同一台机器上！

12. 使用 Mongo MMS 来图形化的监控你的数据库 如果你还没有使用 Mongo MMS的话，我强烈推荐这个工具。10gen 正在大力开发这个产品。它提供了一个非常友好的可视化的界面来监控你的MongoDB集群。

10. MongoDB 资源

技术总是在不断进步，你需要市场关注这些信息：
Documentation: http://www.mongodb.org/display/DOCS/Home
Google Group: http://groups.google.com/group/mongodb-user
Bugs: https://jira.mongodb.org
Blog: http://blog.mongodb.org/


#### 躲坑秘笈

[初创公司MongoDB最佳实践策略和躲坑秘笈](https://segmentfault.com/a/1190000007229895)

+ easy to understand/learn and use

+ 支持server-side script

+ spatial(空间) index ， GridFS 以及有限度的 MR 的支持

  [GridFS详细分析](http://blog.csdn.net/hengyunabc/article/details/7294099)

  [MongoDB GridFS](http://www.runoob.com/mongodb/mongodb-gridfs.html)

+ oplog = binlog

+ 复制集最多12节点

+ 查询先扫index再扫数据，如只要个别字段，又恰恰有index，可以直接返回省去扫数据

+ 复合索引次序问题，类似多个漏斗筛东西，将小漏斗放左侧，减少后续扫索引，插入数据时，也减少索引树的变化程度

+ 生产建议不要使用 sparse index(稀疏索引)，浪费空间 --有的时候还是有用的

  [DOC](https://docs.mongodb.com/manual/core/index-sparse/)

+ 对已有数据做创建索引操作，如果是复制集环境，建议离线来做
  [索引实践](http://blog.nosqlfan.com/html/3656.html)

+ 索引类型选择，string >> int ，尽可能减小 index 的 size， 尽可能将index都放入内存

+ document层面：尽量使用nested document，建模时尽可能反范式。一减少doc总量，同时减少查询IO

+ doc中field名字尽可能短，减小doc的size大小，

+ doc内有 text 内容不会做内容检索，建议使用bindata来存。

+ statement方面：用好explain很重要
```
db.order.find({"status": 1}).explain();
```

+ 系统层面，per connection的粒度来创建线程，所以也要关注链接数，和对应操作系统的stacksize。

+ 监控和排错监控, 推荐munin，或者官方的mms服务

+ 监控命令,mongostat和mongoshell中的db.stats。重点关注pagefault %和lock %，
  + page率高，那需要关注读场景的效率以及数据量和内存的情况。
  + lock率高，则要关注写场景。比如合并写，或者异步写的方式。

+ IO繁忙的时候，数据文件（xyz.n）预分配会堵塞其他操作，非常容易造成雪崩，所以可以pretouch的方式去创建数据文件。

+ 数据碎片化，建议离线repair database。

+ 通过profile，需要重点关注运行时full scan和update的场景，
  + 特别是update，如果大部分情况产生了moved，则需要通过填充占位数据的方式去避免。
  + 通过explain，需要关注covered indexes和index usage的情况，有针对性的创建或修改索引。

+ 3.x版本是MongoDB非常重要的里程碑，其中有些feature非常有价值。
  + 比如提供更高压缩率的压缩方式，zlib和snappy，能有30%～50%的提高，相当于用压榨cpu来换取内存中数据的使用率。
  + 此外，是复制集的改进，明显缩短选举的过程。
  + 同时对于心跳检测的过程复用复制的通道，而且可以单独控制选取的超时，这个有利于网络环境差时的选举过程。
  + 对index的改进主要时支持partial index，特别适合索引中目标数据的值在全部数据中占比很小的情况，能极大的减小index的size。
  + schema，所以3.x中支持schemavalidator可以加强schema校验拒绝无效数据。



### get start

#### 建立用户

管理员
```javascript
# mongo
use admin
db.system.users.find();

db.createUser(
  { user: "admin",
    pwd: "xxx",
    roles: [
      "root",
      "dbAdminAnyDatabase",
      "readWrite",
      "userAdminAnyDatabase",
      "readWriteAnyDatabase"
    ]
  },
  { w: "majority" , wtimeout: 5000 }
)
db.system.users.find();
# 提示没有权限
db.auth("admin","xxx")

# 删除用户
db.system.users.remove({"user": "admin"})
```

库权限用户
```
use test
db.createUser(
   {
     user: "test",
     pwd: "test1234",
     roles:
       [
         { role: "readWrite", db: "test" }
       ]
   }
)
db.system.users.find();
db.auth("test","test1234")
```

更新用户权限

```
use admin
db.system.users.find();

```

### 常见查询方法

```
# 查询最后一条
db.online.find({"company_code": "d66b21h"}).sort({'created_at': -1}).limit(1)

# 排名统计
# https://docs.mongodb.com/v3.2/reference/operator/aggregation/group/
db.online.aggregate(
   [
      {
        $group : {
           _id : "$company_code",
           count: { $sum: 1 }
        }
      },
      {
        $sort:{count: -1}
      }
   ]
)
```
参考:

[用户](https://docs.mongodb.com/v3.2/tutorial/manage-users-and-roles/#create-a-user-defined-role)

[角色](https://docs.mongodb.com/v3.2/reference/built-in-roles/#userAdminAnyDatabase)


注:3.2 没有 db.addUser了

### 初始化脚本

/mongo IP/DBName init.js

init.js文件内容可以这么写：

```javascript
db.dropDatabase(); //删除数据库达到清空数据的目的

db.message.ensureIndex({display_id:1}); //在当前数据库中的message集合的display_id字段上创建索引
```

### 权限控制相关

超级用户拥有最大权限， 存在 admin 数据库中，刚安装的 MongoDB 中 admin 数据库是空的；

数据库用户存储在单个数据库中，只能访问对应的数据库。另外，用户信息保存在 db.system.users 中。

数据库是由超级用户来创建的，一个数据库可以包含多个用户，一个用户只能在一个数据库下，不同数据库中的用户可以同名

如果在 admin 数据库中不存在用户，即使 mongod 启动时添加了 –auth 参数，此时不进行任何认证还是可以做任何操作

在 admin 数据库创建的用户具有超级权限，可以对 MongoDB 系统内的任何数据库的数据对象进行操作

特定数据库比如 test1 下的用户 test_user1，不能够访问其他数据库 test2，但是可以访问本数据库下其他用户创建的数据
不同数据库中同名的用户不能够登录其他数据库。比如数据库 test1 和 test2 都有用户 test_user，以 test_user 登录 test1 后,不能够登录到 test2 进行数据库操作

### tools

https://github.com/paralect/robomongo

### 引用

[8天学通MongoDB](http://www.cnblogs.com/huangxincheng/category/355399.html)

数据库，集合，文档

  collections -> tables

  documents -> row

```
db.person.insert({"name": "weizhao","age": 35});
db.person.find();
```

`>, >=, <, <=, !=, =`

$gt", "$gte", "$lt", "$lte", "$ne", "没有特殊关键字"

`db.person.find({"age":{$gt:32}});`

And，OR，In，NotIn

"无关键字“, "$or", "$in"，"$nin"

正则

`db.person.find({"name":/^w/, "name":/o$/});``

where

`db.person.find({$where:function(){ return this.name == 'weizhao'}});`

update:

```
var model=db.person.findOne({"name": "weizhao"});
model.age = 36
db.person.find()
db.person.update({"name": "weizhao"}, model)
db.person.update({"name": "weizhao"}, {"name": "weizhao", "age": 36})
db.person.find()
```

$inc修改器

   $inc也就是increase的缩写，在原有的基础上 自增$inc指定的值，如果“文档”中没有此key，则会创建key，下面的例子一看就懂。

   加数,或由 0 加

```
 db.person.update({"name": "weizhao"}, {$inc: {"worktime": 14}} )
```

$set修改器

 	非加光改

$upsert

`db.person.update({"name": "韦洢澄"}, {"name": "韦洢澄","age": 1},  true)`

注: 3.2 必须加 "name": "xxx"

批量更新

     在mongodb中如果匹配多条，默认的情况下只更新第一条，那么如果我们有需求必须批量更新，那么在mongodb中实现也是很简单

的，在update的第四个参数中设为true即可。例子就不举了。


四: Remove操作

`db.person.remove({"age": 1})``


$ count

$ distinct

`db.person.distinct("age")`

$ group

    在mongodb里面做group操作有点小复杂，不过大家对sql server里面的group比较熟悉的话还是一眼

能看的明白的，其实group操作本质上形成了一种“k-v”模型，就像C#中的Dictionary，好，有了这种思维，

我们来看看如何使用group。

    下面举的例子就是按照age进行group操作，value为对应age的姓名。下面对这些参数介绍一下：

       key：  这个就是分组的key，我们这里是对年龄分组。

       initial: 每组都分享一个”初始化函数“，特别注意：是每一组，比如这个的age=20的value的list分享一个

initial函数，age=22同样也分享一个initial函数。

       $reduce: 这个函数的第一个参数是当前的文档对象，第二个参数是上一次function操作的累计对象，第一次

为initial中的{”perosn“：[]}。有多少个文档， $reduce就会调用多少次。

```
db.person.group(
  {
  "key": {"age": true},
  "initial": {"person": []},
  "$reduce": function(cur, prev){
  	prev.person.push(cur.name);
  }
})
```

$ condition:  这个就是过滤条件。

finalize:这是个函数，每一组文档执行完后，多会触发此方法，那么在每组集合里面加上count也就是它的活了。

db.person.group(
{
	"key": {"age": true},
	"initial": {"person": []},
	"$reduce": function(cur, prev){
		prev.person.push(cur.name);
	},
	"finalize": function(out){
		out.count = out.person.length;
	},
	"condition": {"age": {$lt: 25}}

})

$ mapReduce
map：
	映射函数，里面会调用emit(key,value)，集合会按照你指定的key进行映射分组。
reduce：
	简化函数，会对map分组后的数据进行分组简化，注意：在reduce(key,value)中的key就是 emit中的key，vlaue为emit分组后的emit(value)的集合，这里也就是很多{"count":1}的数组。
mapReduce:
	这个就是最后执行的函数了，参数为map，reduce和一些可选参数

map
function(){
	emit(this.name, {count: 1});
}

reduce
function(key,value){
	var result = {count: 0};
	for (var i = 0; i < value.length; i++ ){
		result.count += value[i].count;
	}
	return result;
}

db.person.mapReduce(map,reduce, {"out": "collection"})

       result: "存放的集合名“；

       input:传入文档的个数。

       emit：此函数被调用的次数。

       reduce：此函数被调用的次数。

       output:最后返回文档的个数。

最后我们看一下“collecton”集合里面按姓名分组的情况。

db.collection.find()

$ 游标

```
var list=db.person.find();
for / next()
list.forEach(function(x){
	print(x.name);
})
var single=db.person.find().sort({"name",1}).skip(2).limit(2);
```

#### 没有 created_at updated_at 如何过滤什么时间后创建

(Time.now - 30.days).to_i.to_s(16)
0000000000000000

58e714621a81b295d00c8174
593f98c8
58e71462

str = "58b3fc900000000000000000";
oid = new ObjectId(str);
db.getCollection('company').count({status: true, _id: {$gt: oid}});

#### 主从

http://gong1208.iteye.com/blog/1558355

#### 一些坑:

https://ruby-china.org/topics/20128

锁的问题

http://www.jianshu.com/p/13c6a6cf903d

补充:

1. 过高的内存占用   116G数据   占用32G内存跑满

2. 在内存不足的时候如不使用安全模式,大量导入数据时会随机丢数据

3. skip 太慢

因为文档型数据的长度是不定的，所以其实并没有字节偏移量这种方便的东西。当你 skip(N) 的时候，这其实是一个 O(N) 的计算。可能一百以内感觉还不明显，成千上万以后延迟就已经肉眼可见了。

因此最好用 last_id 之类的来分页。

没有事务

虽然官方给出了一个名为 两步提交（two phase commit） 的替代方案，但比较麻烦。有事务需求的时候建议还是用支持原生事务的数据库替代。

[map-reduce](http://www.cnblogs.com/shanpow/p/4169773.html)

[内存](http://huoding.com/2011/08/19/107)

http://blog.codingnow.com/2014/03/mmzb_mongodb.html

https://github.com/ma6174/blog/issues/3

http://www.edwardesire.com/2016/03/28/a-mountain-to-climb-mongodb-index-query/

越过大山和mongoDB查询操作的坑

https://www.v2ex.com/t/104230

著名的`带条件的count()`慢到爆浆？

由于JS引擎的原因，精度有问题

https://github.com/Tokutek/mongo

http://www.infoq.com/cn/news/2014/11/tokutek-tokudb-7-5-tokumx-2-0

[多表查询](http://qianxunniao.iteye.com/blog/1776313)

[connection-string/主从](https://docs.mongodb.com/manual/reference/connection-string/)

[索引](http://www.mongoing.com/archives/2797)

http://www.yl-blog.com/article/482.html

http://eksliang.iteye.com/blog/2178555

https://www.oschina.net/translate/mongodb-indexing-tip-3-too-many-fields-to-index-use

[学习汇总](http://www.liyuduo.com/?p=577)


[sql2nosql](https://prestodb.io/docs/current/)


[linux top命令中的cache & buffers](https://blog.csdn.net/Cooling88/article/details/50969013)

理解下mongo服务器上的 cache/buffer