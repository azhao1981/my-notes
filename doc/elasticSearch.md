# elasticSearch

## 引用

[ELASTICSEARCH Elasticsearch 文本和数字查询](https://wenchao.ren/archives/349)

[精确值查找](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_finding_exact_values.html)

[查询语句查询](http://cwiki.apachecn.org/pages/viewpage.action?pageId=4883355)

[elasticsearch数字加字母的字段值怎样进行模糊查询](https://elasticsearch.cn/question/440)

```json
{
    "query": {
        "wildcard": {
            "field": "*009*"
        }
    }
}
```


[23 个很有用的 ElasticSearch 查询示例 ](https://coyee.com/article/10764-23-useful-elasticsearch-example-queries)
version 5.4

## 命令

curl http://10.12.154.132:9200/_cat/indices
curl 127.1:9200/_cat/indices
curl 127.1:9200/_cat/aliases
curl -XGET "http://127.0.0.1:9200/knowledge_attachments/_mapping?pretty"
curl -XGET "http://10.12.154.132:9200/knowledge_attachments/_mapping?pretty"
curl -XGET "http://10.12.154.132:9200/useful_expressions/_mapping?pretty"
curl -XGET "http://10.12.154.132:9200/useful_expressions/useful_expression/1"
curl -XGET "http://10.12.154.132:9200/knowledge_questions/knowledge_question/1"

### delete

curl -XDELETE http://localhost:9200/_all
curl -XDELETE http://localhost:9200/*
curl -XDELETE http://localhost:9200/twitter,my_index
curl -XDELETE http://127.0.0.1:9200/wazuh-alerts-3.x-2019.07.23,wazuh-alerts-3.x-2019.07.21
curl -XDELETE http://127.0.0.1:9200/wazuh-alerts-3.x-2019.07.22,wazuh-alerts-3.x-2019.07.24
curl -XDELETE http://127.0.0.1:9200/wazuh-alerts-3.x-2019.07.25,wazuh-alerts-3.x-2019.07.26
curl -XDELETE http://127.0.0.1:9200/wazuh-alerts-3.x-2019.08.12,wazuh-alerts-3.x-2019.08.13
curl -XDELETE http://127.0.0.1:9200/wazuh-alerts-3.x-2019.08.14,wazuh-alerts-3.x-2019.08.15
curl -XDELETE http://127.0.0.1:9200/wazuh-alerts-3.x-2019.08.16,wazuh-alerts-3.x-2019.08.17
curl -XDELETE http://127.0.0.1:9200/wazuh-alerts-3.x-2019.08.18,wazuh-alerts-3.x-2019.08.19
curl -XDELETE http://127.0.0.1:9200/wazuh-alerts-3.x-2019.08.20,wazuh-alerts-3.x-2019.08.21
curl -XDELETE http://127.0.0.1:9200/wazuh-alerts-3.x-2019.08.22,wazuh-alerts-3.x-2019.08.23,wazuh-alerts-3.x-2019.08.24,wazuh-alerts-3.x-2019.08.25,wazuh-alerts-3.x-2019.08.26


## [Elasticsearch 趋势科技实战分享笔记 https://mp.weixin.qq.com/s/YocdEQ3cVcPoXRc4tUOxOA
https://es.xiaoleilu.com/070_Index_Mgmt/31_Metadata_source.html

====

```ruby
Customer.__elasticsearch__.client.get index: 'customers', id: c.id
ImSubSession.__elasticsearch__.client.get index: 'im_sub_sessions', id: i.id

```

## 常见用法

[ignore_above](http://cwiki.apachecn.org/pages/viewpage.action?pageId=10028661)
[不分词](https://elasticsearch.cn/question/1913)
1.x 2.x版本设置 no not_analyzed即可。
5.xstring 分为两种类型 keyword,text。 如果不想分词，用 keyword 即可。

====

[中文文档](http://www.apache.wiki/pages/viewpage.action?pageId=4260364)

[阿里docker](https://dev.aliyun.com/detail.html?spm=5176.1972343.2.2.z0jcdt&repoId=1209)

```bash
docker pull elasticsearch:5.4.1-alpine

docker run -d -v "$PWD/config":/usr/share/elasticsearch/config elasticsearch

docker run -d \
  -v "$PWD/data":/usr/share/elasticsearch/data \
  -p 9220:9200 \
  elasticsearch:5.4.0-alpine

docker exec -it \
  -v "$PWD/data":/usr/share/elasticsearch/data \
  -p 9220:9200 \
  elasticsearch:5.4.0-alpine bash
```

GC 
=======

[成为JavaGC专家（2）—如何监控Java垃圾回收机制](http://www.importnew.com/2057.html)
[深入理解java垃圾回收机制----](http://www.cnblogs.com/sunniest/p/4575144.html)
[Java 垃圾收集机制](http://wiki.jikexueyuan.com/project/java-vm/garbage-collection-mechanism.html)

ik
=====

```bash
docker pull registry.cn-hangzhou.aliyuncs.com/calculusma/elasticsearch_ik

elasticsearch 2.4 + ik
```

```bash
brew cask install java
brew info elasticsearch
brew install elasticsearch
brew install maven
/usr/local/Cellar/maven/3.3.9/libexec/conf/settings.xml
```

```xml
<mirrors>
  <id>nexus-aliyun</id>
  <mirrorOf>*</mirrorOf>
  <name>Nexus aliyun</name>
  <url>http://maven.aliyun.com/nexus/content/groups/public</url>
</mirrors>
```

```bash
git checkout v1.9.5 tags/v1.9.5
mvn package
```

https://github.com/medcl/elasticsearch-analysis-ik

http://log.medcl.net/?s=elastic

https://github.com/feiin/elasticsearch-ik-docker

docker pull registry.cn-hangzhou.aliyuncs.com/nodesolar/elasticsearch-ik-docker

http://siye1982.github.io/2015/09/17/es-optimize/

http://openskill.cn/article/454

这个也提到 G1
https://discuss.elastic.co/t/es-filling-up-the-old-gc-pool/20788

https://github.com/firehol/netdata


要获得群集中所有索引的简明列表，请调用

curl http://localhost:9200/_aliases
curl http://localhost:9200/_aliases?pretty=1

https://github.com/jettro/elasticsearch-gui

bin/elasticsearch-plugin install jettro/elasticsearch-gui

https://github.com/appbaseio/dejavu#docker-installation

