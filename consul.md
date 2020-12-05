consul
-----

https://www.consul.io/intro/getting-started/services.html

  echo '{"service": {"name": "web", "tags": ["rails"], "port": 80}}' > web.json

  consul agent -dev -config-dir ~/dev/etc/consul.d


  dig @127.0.0.1 -p 8600 web.service.consul
  dig @127.0.0.1 -p 8600 web.service.consul SRV
  dig @127.0.0.1 -p 8600 rails.web.service.consul

  curl http://localhost:8500/v1/catalog/service/web


consul agent -dev


https://blog.coding.net/blog/intro-consul

consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -node weiz -dc sz-1

-advertise=127.0.0.1
-bind=127.0.0.1

-dc 数据中心
-node 节点

consul members

查看节点:

curl 127.0.0.1:8500/v1/catalog/nodes | json

使用DNS协议查看节点信息:

dig @127.0.0.1 -p 8600 Litao-MacBook-Pro.node.consul

注册两个 Mysql 服务的实例, 数据中心在 sz-1, 端口都是 3306. 具体为以下命令:

curl -X PUT -d '{"Datacenter": "sz-1", "Node": "mysql-1", "Address": "mysql-1.node.consul","Service": {"Service": "mysql", "tags": ["master","v1"], "Port": 3306}}' http://127.0.0.1:8500/v1/catalog/register

curl -X PUT -d '{"Datacenter": "sz-1", "Node": "mysql-2", "Address": "mysql-2.node.consul","Service": {"Service": "mysql", "tags": ["slave","v1"],"Port": 3306}}' http://127.0.0.1:8500/v1/catalog/register


http://chattool.sinaapp.com/?p=1965

http://txt.fliglio.com/2014/05/encapsulated-services-with-consul-and-confd/
 http://172.20.20.12:8500/ui


