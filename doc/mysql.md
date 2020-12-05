# MYSQL

## 高阶使用

http://chars.tech/2017/05/29/mysql-advanced-study/

[滴滴MySQL架构及自动化运维工作](http://wubx.net/didi-db-platform/?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io)
    - [DBproxy](https://tech.meituan.com/dbproxy-pr.html)
    - [GTID](http://dbaplus.cn/news-11-857-1.html)
    - rsyslog+ kafka zk(日志收集分析报警)

## 大表迁移 [github/gh-ost](doc/gh-ost.md)

## 集群

1. proxySQL
2. maxscale
3. 阿里云的RDS apsaradb DRDS/PetaData
4. 腾讯云的DCDB FOR TDSQL
5. UCloud最近推出的UDDB。
6. vitess

+ ali新型数据库:
DRDS 分布式数据库服务 概览 最低8核16G 18,172.00/年 含首页 99 3.450/小时
阿里云自研的下一代关系型云数据库，100% 兼容 MySQL 存储容量最高可达100 TB，性能最高提升至MySQL 的 6 倍，单库最多可扩展到 16 个节点
https://help.aliyun.com/document_detail/58764.html?spm=5176.polardb.103.3.6d644135uVyGGu

+ POLARDB
2c4G 560/M
5,712.00 /Y

+ HybridDB for MySQL
CStore/TokuDB
高性能分析引擎/高性能事务引擎
8核CPU，32GB内存，512GB硬盘（SSD) OLAP增强 4,394.00/M

闲鱼使用了https://mp.weixin.qq.com/s?__biz=MzU4MDUxOTI5NA==&mid=2247484101&idx=1&sn=2ff09963e0afb1a605334eefa54b3377&chksm=fd54d6d4ca235fc2eb0373b85dfa9c9f6dd587f0e5c729c0a31f58a8b6553a0d5e365794f635&scene=21#wechat_redirect

在MySQL和PostgreSQL之外，为什么阿里要研发HybridDB数据库？
https://yq.aliyun.com/articles/66125
  实现OLAP、进行在线大规模并行处理
  基于数据库Greenplum的开源版本，并且吸收PostgreSQL精髓

  OLAP意思是On-Line Analytical Processing联机分析处理 针对于数据的分析汇总操作
    如我们的业务系统中每天都需要出销售日报，这个操作需要对当天所有数据进行汇总，并需要进行计算，以得到全天收入、产品销售排名、分时段的销售量，甚至与过去30天及去年当天进行对比，这样的操作都属于OLAP。

### mysql8

[一张图搞定Docker 安装 MySQL8.0](https://juejin.im/post/5e0d7bd5e51d4541625a4bde)

```bash
docker run -p 3307:3306 --name mysql8.0 -e MYSQL_ROOT_PASSWORD=xxx -d daocloud.io/mysql:8.0
docker rm mysql8.0
docker run -it --rm mysql8 daocloud.io/mysql:8.0 bash
```

error: "exec: \"docker-entrypoint.sh\": executable file not found in $PATH"

无效: <https://github.com/docker-library/postgres/issues/296>

重新打 image,也无效:

error: OCI runtime create failed: container_linux.go:345: starting container process caused "exec: \"/bin/sh\": stat /bin/sh: no such file or directory": unknown

最终认为是这个 image 有问题,删除重下

https://hub.docker.com/_/mysql

其它操作

```bash
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
# 客户端
docker run -it --network some-network --rm mysql mysql -hsome-mysql -uexample-user -p
docker run -it --rm mysql mysql -hsome.mysql.host -usome-mysql-user -p
docker exec -it some-mysql bash
# log
docker logs some-mysql
# config
docker run --name some-mysql -v /my/custom:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
```

```yaml
  mysql:
    restart: always
    image: daocloud.io/mysql:8.0
    command: --default-authentication-plugin=mysql_native_password
    expose:
      - 3306
    ports:
      - 3306:3306
    volumes:
      - ./mysql:/var/lib/mysql
      - ./tools/:/srv/tools
    environment:
      - MYSQL_ROOT_PASSWORD=xxx
```

### sql 优化工具

https://github.com/XiaoMi/soar

对比
https://github.com/XiaoMi/soar/blob/master/doc/comparison.md

### rename db

好像新版本不能,只能迁移表

https://stackoverflow.com/questions/67093/how-do-i-quickly-rename-a-mysql-database-change-schema-name

### 权限

```sql
grant all privileges on *.* to 'root'@'%' identified by 'udesk654321';
```

### vchar大小写

utf8_bin 将字符串中的每一个字符用二进制数据存储，区分大小写。
utf8_genera_ci 不区分大小写，ci为 case insensitive 的缩写，即大小写不敏感。
utf8_general_cs 区分大小写，cs为 case sensitive 的缩写，即大小写敏感。

###  版本

```bash
mysqld --version
```

```sql
select version();
select @@version;
```

### 关于空间释放

https://blog.csdn.net/seven_3306/article/details/30254299

### 性能 PostgreSQL Partial Index

https://huoding.com/2016/04/28/510

mysql 只有前缀索引

### 触发器

https://www.cnblogs.com/geaozhang/p/6819648.html

### mysql-create-index-if-not-exists
https://dba.stackexchange.com/questions/24531/mysql-create-index-if-not-exists

### binlog

[订阅工具](https://github.com/alibaba/canal)

[docker binlog](https://blog.csdn.net/harris135/article/details/79712750)

mac binlog, 都不行,还是用 linux
https://blog.csdn.net/zhengyong15984285623/article/details/73335646

```bash
mysql --help --verbose | grep my.cnf

vim /usr/local/etc/my.cnf
# log_bin
log-bin = mysql-bin #开启binlog
binlog-format = ROW #选择row模式
server_id = 1 #配置mysql replication需要定义，不能喝canal的slaveId重复

sudo kill -9 xxxx
brew services start mysql
show variables like 'log_bin';
show variables like 'binlog%';
```

https://www.jianshu.com/p/396162ddd1d7

show variables like 'log_bin';
log_bin=D:/phpStudy/MySQL/bin-log/bin-log.log
show binary logs; =>可以查看自己binlog的名称
show binlog events; =>可以查看已生成的binlog

三个参数来指定，
第一个参数是打开binlog日志
第二个参数是binlog日志的基本文件名，后面会追加标识来表示每一个文件
第三个参数指定的是binlog文件的索引文件，这个文件管理了所有的binlog文件的目录

当然也有一种简单的配置，一个参数就可以搞定
log-bin=/var/lib/mysql/mysql-bin

https://blog.csdn.net/king_kgh/article/details/74800513
log_bin=ON
log_bin_basename=/var/lib/mysql/mysql-bin
log_bin_index=/var/lib/mysql/mysql-bin.index

log_bin     = /var/log/mysql/mysql-bin.log

### mac版本切换

https://www.jianshu.com/p/f1a5a680b464

/usr/local/Cellar/mysql/5.7.15 (13,510 files, 440.8MB)
  Poured from bottle on 2016-09-28 at 11:37:45
/usr/local/Cellar/mysql/8.0.11 (254 files, 232.6MB) *
  Poured from bottle on 2018-08-21 at 15:04:53

mv /usr/local/var/mysql /usr/local/var/mysql_57

brew unlink mysql

这个符号链接 指的是诸如
/usr/local/bin/mysql -> ../Cellar/mysql/5.7.10/bin/mysql

和之类的
/usr/local/lib/libmysqlclient.20.dylib -> ../Cellar/mysql/5.7.10/lib/libmysqlclient.20.dylib
东西。


brew install mysql56
brew unlink mysql && brew link mysql56

brew search mysql

ll /usr/local/opt/| grep mysql
lrwxr-xr-x  1 weizhao  staff    22B  8 21 17:26 mysql -> ../Cellar/mysql/8.0.11
lrwxr-xr-x  1 weizhao  staff    26B  8 21 19:29 mysql@5.7 -> ../Cellar/mysql@5.7/5.7.22
lrwxr-xr-x  1 weizhao  staff    22B  8 21 17:26 mysql@8.0 -> ../Cellar/mysql/8.0.11

/usr/local/Cellar/mysql/5.7.15 (13,510 files, 440.8MB)
/usr/local/Cellar/mysql/8.0.11 (254 files, 232.6MB)

tail -n40 /usr/local/var/mysql/weizhaodeMacBook-Pro.err
/usr/local/Cellar/mysql/5.7.15/bin/mysql.server start

sudo dpkg -l | grep mysql

### 优化

[找到 mysql 数据库中的不良索引](https://xiezhenye.com/2015/01/%E6%89%BE%E5%88%B0-mysql-%E6%95%B0%E6%8D%AE%E5%BA%93%E4%B8%AD%E7%9A%84%E4%B8%8D%E8%89%AF%E7%B4%A2%E5%BC%95.html)

```sql

带id的索引
select c.*, pk from 
   (select table_schema, table_name, index_name, concat('|', group_concat(column_name order by seq_in_index separator '|'), '|') cols
     from INFORMATION_SCHEMA.STATISTICS
     where index_name != 'PRIMARY' and table_schema != 'mysql'
 group by table_schema, table_name, index_name) c,
   (select table_schema, table_name, concat('|', group_concat(column_name order by seq_in_index separator '|'), '|') pk
     from INFORMATION_SCHEMA.STATISTICS
     where index_name = 'PRIMARY' and table_schema != 'mysql'
 group by table_schema, table_name) p
 where c.table_name = p.table_name and c.table_schema = p.table_schema and c.cols like concat('%', pk, '%');

重复前缀
select c1.table_schema, c1.table_name, c1.index_name,c1.cols,c2.index_name, c2.cols from
   (select table_schema, table_name, index_name, concat('|', group_concat(column_name order by seq_in_index separator '|'), '|') cols 
     from INFORMATION_SCHEMA.STATISTICS 
     where table_schema != 'mysql' and index_name!='PRIMARY'
 group by table_schema,table_name,index_name) c1,   
   (select table_schema, table_name,index_name, concat('|', group_concat(column_name order by seq_in_index separator '|'), '|') cols 
     from INFORMATION_SCHEMA.STATISTICS 
     where table_schema != 'mysql' and index_name != 'PRIMARY'
 group by table_schema, table_name, index_name) c2 
 where c1.table_name = c2.table_name and c1.table_schema = c2.table_schema and c1.cols like concat(c2.cols, '%') and c1.index_name != c2.index_name;


低分

 select p.table_schema, p.table_name, c.index_name, c.car, p.car total from
   (select table_schema, table_name, index_name, max(cardinality) car
     from INFORMATION_SCHEMA.STATISTICS
 where index_name != 'PRIMARY'
 group by table_schema, table_name,index_name) c,
   (select table_schema, table_name, max(cardinality) car
     from INFORMATION_SCHEMA.STATISTICS
 where index_name = 'PRIMARY' and table_schema != 'mysql'
 group by table_schema,table_name) p
 where c.table_name = p.table_name and c.table_schema = p.table_schema and p.car > 0 and c.car / p.car < 0.1;

 select table_schema, table_name, group_concat(column_name order by seq_in_index separator ',') cols, max(seq_in_index) len
    from INFORMATION_SCHEMA.STATISTICS
    where index_name = 'PRIMARY' and table_schema != 'mysql'
    group by table_schema, table_name having len>1;

```
[[译] MYSQL索引最佳实践](https://segmentfault.com/a/1190000007494097)

### [vitess](https://github.com/vitessio/vitess)

[深入理解开源数据库中间件 Vitess](https://blog.csdn.net/defonds/article/details/47813071)

### 导出导入库

```bash
mysqldump -uroot -ppassword dbName > dbName.sql

mysql -uroot -ppassword dbName < ./dbName.sql
```

### 导入异构表

导入字段不一样的数据库,使用中间数据库,把数据改成新结构,然后导入

### 导出表

[Mysqldump参数大全](https://segmentfault.com/a/1190000000621104)

https://www.cnblogs.com/emanlee/p/4233602.html

`mysql> select count(1) from table  into outfile '/tmp/test.xls';`

```sql
mysql> pager cat > /tmp/test.txt ;
-- PAGER set to 'cat > /tmp/test.txt'
-- 之后的所有查询结果都自动写入/tmp/test.txt'，并前后覆盖
mysql> select * from table;
-- 30 rows in set (0.59 sec)
-- 在框口不再显示查询结果
```

`mysql -h 127.0.0.1 -u root -p XXXX -P 3306 -e "select * from table"  > /tmp/test/txt`

## 删除后需要释放空间

删除后需要释放空间 optimize table #{table_name}
  http://www.cnblogs.com/shawnloong/archive/2013/02/07/2908911.html

## 参考

[GitHub's Online Schema Migrations for MySQL]( https://github.com/github/gh-ost)

http://www.cnblogs.com/hustcat/archive/2009/10/28/1591648.html 理解MySQL——索引与优化

http://www.cnblogs.com/billyxp/p/3548540.html myslq char varchar text 之分

http://stackoverflow.com/questions/2023481/mysql-large-varchar-vs-text

```ruby
def up
  change_column :im_sessions, :src_url, :string, limit: 2000
end
def down
  change_column :im_sessions, :src_url, :string
end
```

http://blog.csdn.net/voidccc/article/details/40077329 Innodb index

apt-get install libmysqlclient-dev
You can see a log of iCloud Drive transactions being made


CREATE TABLE #{backup_table} AS SELECT * FROM im_users;"
TRUNCATE table im_users

memory:

http://www.robbyonrails.com/articles/2013/11/24/reducing-mysqls-memory-usage-on-os-x-mavericks

mkdir -p /usr/local/etc

vim /usr/local/etc/my.cnf

```yaml
[mysqld]
 max_connections       = 10

 key_buffer_size       = 16K
 max_allowed_packet    = 1M
 table_open_cache      = 4
 sort_buffer_size      = 64K
 read_buffer_size      = 256K
 read_rnd_buffer_size  = 256K
 net_buffer_length     = 2K
 thread_stack          = 128K
 ```

mysql.server stop

最后80M左右

my.cnf 中没有这个设置
通过下面的值进行计算

key_buffer_size + (read_buffer_size + sort_buffer_size) * max_connections = K bytes

key_buffer_size = 8G
sort_buffer_size = 1M
read_buffer_size = 1M
read_rnd_buffer_size = 2M
myisam_sort_buffer_size = 2M
join_buffer_size = 2M

## Innodb

innodb_buffer_pool_size = 16G
innodb_additional_mem_pool_size = 2G
innodb_log_file_size = 1G
innodb_log_buffer_size = 8M
innodb_flush_log_at_trx_commit = 1
innodb_lock_wait_timeout = 30
innodb_file_format=barracuda

<https://www.pureweber.com/article/myisam-vs-innodb/>

## 数据库表大小

```sql
use information_schema;
SELECT TABLE_NAME,DATA_LENGTH+INDEX_LENGTH,TABLE_ROWS FROM TABLES WHERE TABLE_SCHEMA='db_name';

 AND TABLE_NAME='表名'
```

## 同步索引

mysql indexes concurrently

搜索一下,看下怎么实现

http://semaphoreci.com/blog/2017/06/21/faster-rails-indexing-large-database-tables.html

错,这个不是mysql,是pg
CREATE INDEX CONCURRENTLY idx_builds_branch ON builds USING btree (branch_id);
def change
  add_index :builds, :build_metric_id, :algorithm => :concurrently
end

## 清库 shell

```bash

#!/bin/bash

HOST="$1"
MUSER="$2"
MPASS="$3"
MDB="$4"

# Detect paths
MYSQL=$(which mysql)
AWK=$(which awk)
GREP=$(which grep)

if [ $# -ne 4 ]
then
	echo "Usage: $0 {MySQL-Host} {MySQL-User-Name} {MySQL-User-Password} {MySQL-Database-Name}"
	echo "Drops all tables from a MySQL"
	exit 1
fi

TABLES=$($MYSQL -h $HOST -u $MUSER -p$MPASS $MDB -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables' )

for t in $TABLES
do
	echo "Deleting $t table from $MDB database..."
	$MYSQL -h $HOST -u $MUSER -p$MPASS $MDB -e "drop table $t"
done
```

5.6 有分析工具
我们的没有开
https://dev.mysql.com/doc/refman/5.6/en/performance-schema-quick-start.html

## 删除

## index of group by

<https://stackoverflow.com/questions/7475332/mysql-index-for-group-by-order-by>

结论: group by 内容好像不是必须索引的
但是一个很难的问题是,所以有 id 都会取得最小一个, 不管你是正排还是反排

## 锁查询和解锁

<https://blog.csdn.net/qq_37581708/article/details/73926072>

1.查看下在锁的事务

SELECT * FROM INFORMATION_SCHEMA.INNODB_TRX;

TIP: 时间长的一样是有问题的

2.杀死进程id（就是上面命令的trx_mysql_thread_id列）

kill 线程ID

这个可以查看正在用的锁和表
show OPEN TABLES where In_use > 0;

MySQL如何定位未提交事务执行的SQL语句?

https://www.jianshu.com/p/be4965ed802e

select * from information_schema.`PROCESSLIST` where ID = thread_id;

select * from performance_schema.events_statements_current;

## tools

[tools比较,旧的](http://developer.51cto.com/art/201309/410323_all.htm)

mysqlsla 作者已经停止维护转[percona-toolkit]

hackmysql.com 推出的一款日志分析工具(该网站还维护了 mysqlreport，mysqlidxchk 等比较实用的mysql 工具)

mysql-explain-slow-log

mysql-log-filter

myprofi

[101个MySQL的调优技巧](http://database.51cto.com/art/201308/408375.htm)

## percona-toolkit

[官方](https://www.percona.com/software/database-tools/percona-toolkit)

[安装](http://arthur376.blog.51cto.com/2918801/1893250)

[percona-toolkit工具的使用](http://www.cnblogs.com/chenpingzhao/p/4850420.html)

[linux下percona-toolkit工具包的安装和使用（超详细版）](http://www.cnblogs.com/zishengY/p/6852280.html)

PerconaToolKit是Percona为MySQL分支版本Percona开发的一套工具集，将过去那些常用的繁重的需要手工执行的操作总结起来，便组织成了一套工具。这些工具很多功能都是同时适用于MySQL(官方)和MySQL(Percona版)的。其包含功能如：
分析索引使用情况
检查分析重复索引\
获取用来分析事故现场的信息
统计分析查询性能问题
汇总服务配置状态等信息
实现不加锁修改表结构 … 等等
整个工具集中共有32个命令，涉及到了MySQL操作的方方面面。这里只做了简单介绍，更多功能需要自己去主动挖掘。

```bash
sudo wget https://www.percona.com/downloads/percona-toolkit/3.0.4/binary/tarball/percona-toolkit-3.0.4_x86_64.tar.gz

sudo tar xf percona-toolkit-3.0.4_x86_64.tar.gz

sudo perl Makefile.PL
sudo make
sudo make install

pt-mysql-summary --user=root --password='root'

sudo pt-index-usage --user=root --password='root' # 没有效果,不会用

mysql -uroot -proot
```

## 其它技巧

[MySQL使用pt-online-change-schema工具在线修改1.6亿级数据表结构](http://www.cnblogs.com/zishengY/p/6852333.html)

## innodb/MyIsam

[MySQL--引擎介绍MyISAM VS InnoDB](http://blog.51cto.com/13126942/2043972)

https://codeday.me/bug/20170702/31853.html
https://my.oschina.net/junn/blog/183341
https://www.pureweber.com/article/myisam-vs-innodb/

## BLOB 类型

[MySQL数据类型之BLOB与TEXT及其最大存储限制](http://blog.csdn.net/q3dxdx/article/details/51014357)

[MySQL 数据类型](http://www.runoob.com/mysql/mysql-data-types.html)

[rails blob](https://ihower.tw/rails/migrations-cn.html)

## TiDB

[TiDB 的正确使用姿势](https://segmentfault.com/a/1190000008643974)

如果整篇文章你只想记住一句话，那就是数据条数少于 5000w 的场景下通常用不到 TiDB，TiDB 是为大规模的数据场景设计的。如果还想记住一句话，那就是单机 MySQL 能满足的场景也用不到 TiDB。

