#!/bin/bash

sudo wget http://liquidtelecom.dl.sourceforge.net/project/pcre/pcre/8.38/pcre-8.38.tar.bz2
sudo bzip2 -d pcre-8.38.tar.bz2
sudo tar xvf pcre-8.38.tar
cd pcre-8.38

sudo ./configure
sudo make
sudo make install

sudo wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz
sudo tar zxvf pcre-8.38.tar.gz
cd pcre-8.38
sudo ./configure
sudo make
sudo make install

https://www.nginx.com/resources/wiki/start/topics/tutorials/installoptions/#
sudo wget http://nginx.org/download/nginx-1.9.15.tar.gz
sudo tar xzvf nginx-1.9.15.tar.gz && cd nginx-1.9.15

sudo wget http://nginx.org/download/nginx-1.13.4.tar.gz
sudo tar xzvf nginx-1.13.4.tar.gz && cd nginx-1.13.4

https://www.nginx.com/resources/admin-guide/tcp-load-balancing/
sudo ./configure --prefix=/srv/nginx-wss \
  --with-cc-opt="-Wno-deprecated-declarations"  \
  --with-http_ssl_module \
  --with-pcre=/srv/pcre-8.38 \
  --with-stream_ssl_module \
  --with-stream
sudo make
sudo make install

sudo yum install -y openssl openssl-devel
sudo apt install -y libssl-dev

worker_processes  1;

events {
    worker_connections  1024;
}

stream{
  upstream visitor {
        server localhost:6001;
    }
  server {
    listen 6002 ssl;

    ssl_certificate /srv/nginx-wss/conf/udesk.cn.crt;
    ssl_certificate_key /srv/nginx-wss/conf/privateKey.pem;
    ssl_protocols  SSLv3 TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers    HIGH:!aNULL:!MD5;
    proxy_pass visitor;
  }
}

worker_processes  1;

events {
    worker_connections  1024;
}

stream{
  upstream visitor {
        server localhost:6001;
    }
  server {
    listen 6002 ssl;

    ssl_certificate /srv/nginx-wss/conf/udeskdog.com.chained.crt;
    ssl_certificate_key /srv/nginx-wss/conf/udeskdog.com.key;
    ssl_protocols  SSLv3 TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers    HIGH:!aNULL:!MD5;
    proxy_pass visitor;
  }
}


sudo /srv/nginx-wss/sbin/nginx -t
sudo /srv/nginx-wss/sbin/nginx

后台全站HTTPS设置.md

# 生成证书

## 单独证书
> 参考: https://www.digitalocean.com/community/tutorials/how-to-create-an-ssl-certificate-on-nginx-for-ubuntu-14-04

```bash
sudo mkdir /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
```

## 根证书 + 服务器证书
> 参考: http://blog.creke.net/762.html

```bash
# 生成CA证书
openssl genrsa -des3 -out ca.key 2048
openssl req -new -x509 -days 7305 -key ca.key -out ca.crt

# 用CA签名前的准备
mkdir -p demoCA/newcerts
touch demoCA/index.txt
touch demoCA/serial
echo 01 > demoCA/serial

# 生成服务器证书(ud.com为例)
# 注意第三步 Common Name 填写 *.ud.com
openssl genrsa -des3 -out ud.com.pem 1024
openssl rsa -in ud.com.pem -out ud.com.key
openssl req -new -key ud.com.pem -out ud.com.csr

# Sign
openssl ca -policy policy_anything -days 1460 -cert ca.crt -keyfile ca.key -in ud.com.csr -out ud.com.crt

# 创建证书链
cat ud.com.crt ca.crt > ud.com.chained.crt

# copy到目录
sudo mkdir /etc/nginx/ssl
sudo cp ud.com.chained.crt /etc/nginx/ssl/nginx.crt
sudo cp ud.com.key /etc/nginx/ssl/nginx.key
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


新证书方法:

http://confluence.flyudesk.com/pages/viewpage.action?pageId=11796893

1. 目标

测试环境下使用的 SSL 证书应满足一下条件：

目标	原因
采用 CA 签名的服务器证书	开发人员只需要在自己的浏览器（或系统中）导入 CA 证书，每次服务器证书变动不需要重新导入
服务器证书支持多域名（SAN）	所有测试服务器使用相同的 SSL 证书，简化证书管理

2. 生成过程

2.1 修改本地 openssl 配置

以 Ubuntu 系统为例，修改 /etc/ssl/openssl.cnf 文件：

替换 [ req ] 段为
distinguished_name = req_distinguished_name
req_extensions = v3_req

在 [ v3_req ] 段添加
subjectAltName = @alt_names

在文件最后新建段，添加所有需要签名的测试服务器域名，注意 *.domain.com 和 domain.com 要分开处理，udesk.dev 为本地开发环境域名（也可加入 ud.com、udesk.local 等）
[ alt_names ]
DNS.1 = *.udesk.dev
DNS.2 = udesk10.com
DNS.3 = *.udesk10.com
DNS.4 = udesk11.com
DNS.5 = *.udesk11.com
DNS.6 = udesk20.com
DNS.7 = *.udesk20.com
DNS.8 = udeskcat.com
DNS.9 = *.udeskcat.com
DNS.10 = udeskdog.com
DNS.11 = *.udeskdog.com
DNS.12 = udeskmonkey.com
DNS.13 = *.udeskmonkey.com
DNS.14 = udesktiger.com
DNS.15 = *.udesktiger.com
DNS.16 = tiyanudesk.com
DNS.17 = *.tiyanudesk.com
DNS.18 = tryudesk.com
DNS.19 = *.tryudesk.com
2.2 创建相关目录
选择任意目录作为 SSL 证书生成的根目录，然后执行
$ mkdir -p demoCA/newcerts
$ touch demoCA/index.txt
$ touch demoCA/serial
$ echo 01 > demoCA/serial

2.3 生成 CA 证书
生成证书时按提示填写即可，CN可以为空
$ openssl genrsa -des3 -out ca.key 2048
$ openssl req -new -x509 -days 7305 -key ca.key -out ca.crt

2.4 生成服务器证书
生成证书时按提示填写，CN填写 udesk.dev（本地开发环境域名）

$ openssl genrsa -des3 -out udesk.pem 2048
$ openssl rsa -in udesk.pem -out udesk.key
$ openssl req -new -key udesk.pem -out udesk.csr -config /etc/ssl/openssl.cnf

2.5 签名服务器证书
$ openssl ca -policy policy_anything -days 1460 -cert ca.crt -keyfile ca.key -in udesk.csr -out udesk.crt -extensions v3_req -extfile /etc/ssl/openssl.cnf

最终生成
证书：udesk.crt
密钥：udesk.key
