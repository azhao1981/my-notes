nginx
=========

### unit

http://unit.nginx.org/configuration/

### 中文

http://www.nginx.cn/doc/

### upstream

http://wangwei007.blog.51cto.com/68019/1103727

分配权种

### ssl
http://seanlook.com/2015/05/28/nginx-ssl/
https://blog.phusion.nl/2016/07/27/using-ssl-with-passenger-in-development-on-macos

## ln

```bash
sudo /srv/nginx
cd /srv/nginx
sudo ln -nfs /etc/nginx conf
sudo ln -nfs /var/log/nginx log
```

## ip 过滤
```bash
deny 114.253.39.254;

set_real_ip_from 100.109.0.0/16;
deny 114.253.39.254;
```

## 编译安装

```bash
wget http://liquidtelecom.dl.sourceforge.net/project/pcre/pcre/8.38/pcre-8.38.tar.bz2
bzip2 -d pcre-8.38.tar.bz2
tar xvf pcre-8.38.tar
cd pcre-8.38
./configure
make
make install

https://www.nginx.com/resources/wiki/start/topics/tutorials/installoptions/#
wget http://nginx.org/download/nginx-1.17.3.tar.gz
tar xzvf nginx-1.17.3.tar.gz && cd nginx-1.17.3
./configure --prefix=/srv/nginx \
  --with-cc-opt="-Wno-deprecated-declarations"  \
  --with-http_ssl_module \
  --with-pcre=/srv/pcre-8.38


make && make install
```

```
adduser webuser
passwd -d webuser
chmod +w  /etc/sudoers
production
echo "webuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
production
echo "webuser ALL=(ALL:ALL) ALL " >> /etc/sudoers
chmod 0440 /etc/sudoers
没成功
mkdir /home/webuser/.ssh \
&& touch /home/webuser/.ssh/authorized_keys \
&& chown -R webuser:webuser /home/webuser/.ssh
chmod 0700 /home/webuser/.ssh
chmod 0600 /home/webuser/.ssh/authorized_keys
```

websocket的反向代理

http://blog.fens.me/nodejs-websocket-nginx/
http://stackoverflow.com/questions/12102110/nginx-to-reverse-proxy-websockets-and-enable-ssl-wss
git clone https://github.com/yaoweibin/nginx_tcp_proxy_module.git


https://www.nginx.com/resources/admin-guide/tcp-load-balancing/
./configure --prefix=/srv/nginx-wss \
  --with-cc-opt="-Wno-deprecated-declarations"  \
  --with-http_ssl_module \
  --with-pcre=/srv/pcre-8.38 \
  --with-stream_ssl_module \
  --with-stream
https://knowledge.geotrust.com/support/knowledge-base/index?page=content&id=SO25680
1. SSL certificate ssl_certificate.crt  end entity certificate, public key certificate, digital certificate or identity certificate
2. Intermediate CA certificate (i.e. IntermediateCA.crt, also known as chained certificate or signer/issuer of the ssl certificate).
3. cat ssl_certificate.crt IntermediateCA.crt >> udesk.cn.crt
4. privateKey.pem
5. nginx:


```

user  webuser;
worker_processes  2;

error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                     '$status $body_bytes_sent "$http_referer" '
                     '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    gzip  on;
    map $http_upgrade $connection_upgrade {
        default upgrade;
        ''      close;
    }


    server {
        listen       80;
        server_name  localhost;

        charset utf-8;

        access_log  logs/host.access.log  main;

        location / {
            root   html;
            index  index.html index.htm;
        }

        location ^~ /admin {
          proxy_pass http://localhost:5880/admin;
          proxy_set_header X-Real-IP $remote_addr;
    	    proxy_set_header Host $host;
    	    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    	    proxy_http_version 1.1;
        }
        location ^~ /http-bind {
          proxy_pass http://localhost:5880/http-bind;
          proxy_set_header X-Real-IP $remote_addr;
    	    proxy_set_header Host $host;
    	    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    	    proxy_http_version 1.1;
        }
        location ^~ /websocket {
          proxy_pass http://localhost:5880/websocket;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header Host $host;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
        }



        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
}

```


后台全站HTTPS设置.md

# 生成证书

## 单独证书
> 参考: https://www.digitalocean.com/community/tutorials/how-to-create-an-ssl-certificate-on-nginx-for-ubuntu-14-04

```bash
sudo mkdir /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./nginx.key -out ./nginx.crt
```

## 根证书 + 服务器证书
> 参考: http://blog.creke.net/762.html

```bash
# 生成CA证书
sudo openssl genrsa -des3 -out ca.key 2048
sudo openssl req -new -x509 -days 7305 -key ca.key -out ca.crt

# 用CA签名前的准备
sudo mkdir -p demoCA/newcerts
sudo touch demoCA/index.txt
sudo touch demoCA/serial
sudo echo 01 > demoCA/serial

# 生成服务器证书(ud.com为例)
# 注意第三步 Common Name 填写 *.ud.com
sudo openssl genrsa -des3 -out udesk10.com.pem 1024
sudo openssl rsa -in udesk10.com.pem -out udesk10.com.key
sudo openssl req -new -key udesk10.com.pem -out udesk10.com.csr

# Sign
sudo openssl ca -policy policy_anything -days 1460 -cert ca.crt -keyfile ca.key -in udesk10.com.csr -out udesk10.com.crt

# 创建证书链
sudo su -c "cat udesk10.com.crt ca.crt > udesk10.com.chained.crt"

# copy到目录
sudo mkdir /etc/nginx/ssl
sudo cp udesk10.com.chained.crt /etc/nginx/ssl/nginx.crt
sudo cp udesk10.com.key /etc/nginx/ssl/nginx.key
```

## Chrome设置

设置 -> 管理证书 -> 授权中心 -> 导入(ca.crt)

# 配置 Nginx

## 配置虚拟主机

```
server {
  listen 80;
  listen 443 ssl;

  server_name *.ud.com;

  ssl on;
  ssl_certificate /etc/nginx/ssl/nginx.crt;
  ssl_certificate_key /etc/nginx/ssl/nginx.key;
  ...
}
```

## 优化

在 http 中加入

```
# 1m可以存放4000个session
ssl_session_cache shared:SSL:10m;
ssl_session_timeout 10m;
```

在配置https的虚拟主机server{}中加入：

```
keepalive_timeout 70;
```

## 忽略日志

https://blog.51cto.com/yanconggod/2052023

## rails

发现一个 Rails 422 错误，检查以后发现是由于用户使用 HTTP 协议，而 Rails 要求 HTTPS 协议。

于是认为是错误的请求返回了 422 错误。

开发者自己测试会发现明明是好的，可用户就是不对。

Nginx 配置 Upstream 要确保传递:

```bash
proxy_set_header  X-Forwarded-Proto $scheme;
```
否则 force_ssl 会误判

