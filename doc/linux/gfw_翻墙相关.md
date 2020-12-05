# 科学上网法

## 教程资料

🍅冲出你的窗口，Git镜像、Clone 及AWS下载加速、FREE SS/SSR/VMESS、WireGuard配置分享、IPFS、暗网等其他资源存储库
| <https://github.com/hoodiearon/w3-goto-world>

[自由上网方法](https://github.com/Alvin9999/new-pac/wiki)

[免费ss账号 免费shadowsocks账号 免费v2ray账号 (长期更新)](https://github.com/max2max/freess)

## wss + v2ray

### 免费证书

<https://letsencrypt.org/zh-cn/getting-started/>

<https://certbot.eff.org/>

### mktcp

vmess+kcp+wechat-video #527 看人家的配置
https://github.com/v2ray/discussion/issues/527

### [Docker + Trojan + Caddy 部署](https://muguang.me/it/2757.html)

https://www.v2rayssr.com/trojan-1.html

这个可以,但是太慢了,因为本地直接出国很慢

```bash
git clone git@github.com:FaithPatrick/trojan-caddy-docker-compose.git trojan && cd trojan
vim ./caddy/Caddyfile
sed -i "s/www\.yourdomain\.com/yes\.gezhishirt\.club/g" ./caddy/Caddyfile

vim ./trojan/config/config.json
sed -i "s/your_password/84ac7e65-4618-8a77-2a9f0ad3df8c/g" ./trojan/config/config.json
sed -i "s/your_domain_name/yes\.gezhishirt\.club/g" ./trojan/config/config.json

docker-compose build
docker-compose up -d
```

Trojan+Chrome插件SwitchyOmega

<https://github.com/FelisCatus/SwitchyOmega/releases>

### v2ray ws-tls

https://www.johnrosen1.com/v2ray-cdn/

v2ray ws 配置 config.json

```json
{
  "inbounds": [
    {
      "port": 10000,
      "listen":"127.0.0.1",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "xxxx",
            "alterId": 64
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
        "path": "/ray"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
```

https://github.com/pengchujin/v2rayDocker

https://gist.github.com/dcb9/1e0f0346400e42fb4d03ead124da1658


https://github.com/yulahuyed/v2ray-ws-tls
v2ray-openshift-all-in-one <https://hub.docker.com/r/b1nitp7iw/v2ray-ws-tls/>

```bash
docker pull b1nitp7iw/v2ray-ws-tls
```

https://ntgeralt.blogspot.com/2019/07/20190708-docker-v2ray-ws-tls.html

```bash
docker run -d --name v2ray --restart always -p 443:443 -p 80:80 -v $HOME/.caddy:/root/.caddy pengchujin/v2ray_ws:0.08 yourdomain.com testv2ray 608c5d42-fbb4-49b0-be72-53c65ba82401 && sleep 3s && sudo docker logs v2ray
```

mac 客户端
<https://github.com/trojan-gfw/trojan/releases/download/v1.14.1/trojan-1.14.1-macos.zip>

https://github.com/shadowsocks/ShadowsocksX-NG

[科学/自由上网，免费ss/ssr/v2ray/goflyway账号，搭建教程|手动,仅 CentOS](https://github.com/Alvin9999/)
https://trojan-tutor.github.io/2019/04/10/p41.html

[android](https://github.com/2dust/v2rayNG)

## ansible + ss docker

https://hub.docker.com/r/mritd/shadowsocks

使用docker快速部署Shadowsocks 原

https://my.oschina.net/u/1012033/blog/3001164

关于协议:

https://github.com/shadowsocks/shadowsocks-windows/issues/1243

## 服务器中转

阿里的服务器再到国外会更稳定:

```bash
sudo iptables -t nat -A PREROUTING -p tcp -i eth1 --dport xxx -j DNAT --to xxx:8088
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
sudo iptables -L -n
sudo iptables -L -n -t nat
```

101.201.41.249

## Host

<https://github.com/googlehosts/hosts>

## v2ray

### 客户端: V2RayX

kcp就是 UDP

#### 先装 v2ray-core

```bash
brew tap v2ray/v2ray
brew install v2ray-core
brew upgrade v2ray-core

vim /usr/local/etc/v2ray/config.json

brew services run v2ray-core
brew services start v2ray-core

https://github.com/netchx/Netch/blob/master/docs/README.zh-CN.md
```

#### 图形界面 [V2RayX](https://github.com/W-MS/V2RayX-macOS)

+ 迅雷下载:
<https://github.com/W-MS/V2RayX-macOS/releases/download/untagged-14f62df2dd3e1a70d01a/V2RayX-121-0627.zip>
+ 配置服务器:
 地址+port+id
 加密: 自动
 协议: tcp
+ [其它客户端V2rayU](https://github.com/yanue/V2rayU)

### 服务器

[使用 Docker 简单部署 v2ray](https://www.iszy.cc/2019/02/18/docker-v2ray/)
[官网](https://www.v2ray.com/) |
[github](https://github.com/v2ray) |
[白话教程](https://guide.v2fly.org/) |
[使用V2Ray实现科学爱国](https://www.codercto.com/a/22204.html)

#### docker

```bash
apt update
wget -qO- https://get.docker.com/ | sudo sh
curl -L https://github.com/docker/compose/releases/download/1.23.2/run.sh > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo mkdir -p docker/v2ray
sudo docker pull v2ray/official
```

+ 配置可以参考: <https://wild-flame.github.io/guides/docs/mac-os-x-setup-guide/V2ray>
+ [online](https://www.uuidgenerator.net/)
+ `cat /proc/sys/kernel/random/uuid`
+ tip: 可以用512这样的 udp 端口,这个是邮件端口 <https://tool.oschina.net/commons?type=7>

```json
{
  "inbounds": [
    {
      "port": 512,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "`cat /proc/sys/kernel/random/uuid`",
            "alterId": 64
          }
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
```

```json
// mxkcp 加在服务器 inbound 和客户端 outbound 里
{
  "streamSettings": {
    "network": "kcp",
    "kcpSettings": {
      "mtu": 1350,
      "tti": 20,
      "uplinkCapacity": 6,
      "downlinkCapacity": 1000,
      "congestion": false,
      "readBufferSize": 1,
      "writeBufferSize": 1,
      "header": { "type": "none" }
    }
  },

  "protocol": "vmess",
  "settings": {
    "vnext": [
      {
        "address": "xxx",
        "port": 14037,
        "users": [
          {
            "id": "xxxx",
            "alterId": 64,
            "security": "auto",
            "level": 1
          }
        ],
        "remark": "sz-tx1"
      }
    ]
  }
}
```

```yaml
version: "3"
services:
  v2ray:
    image: v2ray/official:latest
    container_name: v2ray
    restart: always
    command: v2ray -config=/etc/v2ray/config.json
    network_mode: "host"
    volumes:
      - ./v2ray:/etc/v2ray
```

```bash
docker-compose up -d
docker-compose down
```

#### 安装 v2

```bash
ssh linode "apt update && apt install curl zip -y"
ssh linode "bash <(curl -L -s https://install.direct/go.sh)"
scp ./config.tcp.json linode:/etc/v2ray/config.json
ssh linode "service v2ray restart"

wget https://raw.githubusercontent.com/flyzy2005/ss-fly/master/ss-fly.sh && chmod +x ss-fly.sh && ./ss-fly.sh -bbr

cat /etc/v2ray/config.json
vim /etc/v2ray/config.json
service v2ray start
service v2ray start|stop|status|reload|restart|force-reload
brew tap v2ray/v2ray
```

## 混淆

安装 https://vinga.tech/v2ray

https://www.bookstack.cn/read/HyperApp-guide/zh-proxy-V2ray+Websocket.md
https://toutyrater.github.io/basic/Shadowsocks.html

https://la4ji.blogspot.com/2018/07/v2ray.html
https://toutyrater.github.io/basic/vmess.html

## digitalocean

https://www.17ce.com/ 找一下真实 ip

```bash
151.101.25.194 cloud-cdn-digitalocean-com.global.ssl.fastly.net
# 这个快一些
151.101.1.194 cloud-cdn-digitalocean-com.global.ssl.fastly.net
```
151.101.9.194
151.101.229.194

ss://chacha20:xxx@157.230.141.96:8088

国外17ce
https://check-host.net/check-dns?host=cloud-cdn-digitalocean-com.global.ssl.fastly.net

##   DNS

**如果你上了 SS 也不能上google,但别的有的还是可以,说明 DNS 被劫持了**

处理: 把 第一个DNS 设置为: 8.8.8.8

##  ssh

可以用,但请快速关闭

ssh -D localhost:1088 -f -C -q -N monkeyss

https://www.jianshu.com/p/274b691f672d

因此勾选上使用SOCKS v5代理DNS更加安全

ssh -D port -f -C -q -N user@IP [-p port]

ssh ud-es6-tunnel -C -f -N -g

ssh ud-es6-tunnel -C -f -N -g

##  goAgent

ChromeGo，Chrome一键翻墙包
https://github.com/bannedbook/fanqiang/wiki/GoAgent-v3.2.3---%E8%87%AA%E5%BB%BA%E7%BF%BB%E5%A2%99%E6%9C%8D%E5%8A%A1%E5%99%A8

如何开启IPv6
https://github.com/bannedbook/fanqiang/wiki/Chrome%E4%B8%80%E9%94%AE%E7%BF%BB%E5%A2%99%E5%8C%85

转   GoAgent使用教程：翻墙并没有那么难
https://www.ctolib.com/topics-7486.html

##  nginx

https://webcache.googleusercontent.com/search?q=cache:Yq_szBV0xtQJ:https://10beasts.net/best-vpn-china/+&cd=1&hl=zh-CN&ct=clnk&gl=in&lr=lang_zh-CN%7Clang_zh-TW

http://wdg.me
http://dg.me

46.101.186.87 wdg.me
46.101.186.87 dg.me

server {
  listen 80;
  server_name dg.me;

  location / {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host www.google.com;
    proxy_set_header X-NginX-Proxy true;

    add_header Access-Control-Allow-Methods "POST, GET, OPTIONS";
    add_header Access-Control-Allow-Headers "x-requested-with,content-type";

    proxy_pass https://www.google.com/;
    proxy_redirect off;

    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
  }
}

## 自建

[安装教程](https://github.com/nodejh/nodejh.github.io/issues/30)

```bash
apt update
apt install python-pip build-essential -y

wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar zxf LATEST.tar.gz
cd libsodium*
./configure
make &&  make install

echo '
/lib
/usr/lib64
/usr/local/lib
' >> /etc/ld.so.conf
ldconfig

pip install -U setuptools
pip install shadowsocks

go get -u -v github.com/shadowsocks/go-shadowsocks2

go-shadowsocks2 -s 'ss://AEAD_CHACHA20_POLY1305:azhao2020@:8488' -verbose
go-shadowsocks2 -s 'ss://AEAD_AES_256_GCM:azhao2020@:8488' -verbose


echo '{
    "server":"0.0.0.0",
    "server_port":9900,
    "local_address": "127.0.0.1",
    "local_port":1086,
    "password":"xxxx",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}' >  /etc/shadowsocks.json

ssserver -c /etc/shadowsocks.json -d start

echo 'alias sss="ssserver -c /etc/shadowsocks.json start"' >> ~/.bashrc

```

https://floperry.github.io/2019/02/24/2018-06-25-Ubuntu-18.04-下解决-shadowsocks-服务报错问题/
EVP_CIPHER_CTX_cleanup
因此，可以通过将 EVP_CIPHER_CTX_cleanup() 函数替换为 EVP_CIPHER_CTX_reset() 函数来解决该问题。具体解决方法如下：

```bash
# 1. 查看:
grep EVP_CIPHER_CTX_cleanup /usr/local/lib/python2.7/dist-packages/shadowsocks/crypto/openssl.py
# 2. 验证
sed 's/EVP_CIPHER_CTX_cleanup/EVP_CIPHER_CTX_reset/g' /usr/local/lib/python2.7/dist-packages/shadowsocks/crypto/openssl.py | grep EVP_CIPHER_CTX_reset
# 3. 替换
sed -i 's/EVP_CIPHER_CTX_cleanup/EVP_CIPHER_CTX_reset/g' /usr/local/lib/python2.7/dist-packages/shadowsocks/crypto/openssl.py
```


## 蓝灯

https://github.com/getlantern/forum

易用的翻墙工具
https://github.com/XX-net/XX-Net

Brook is a cross-platform(Linux/MacOS/Windows/Android/iOS) proxy software
https://github.com/txthinking/brook

## 代理规则 :

http://www.duoluodeyu.com/1337.html

user-rule.txt
与GFWlist同，即adblockplus过滤规则 https://adblockplus.org/en/filter-cheatsheet

1. 通配符支持，如 *.example.com/* 实际书写时可省略* 如.example.com/ 意即*.example.com/*
2. 正则表达式支持，以\开始和结束， 如 \[\w]+:\/\/example.com\
3. 例外规则 @@，如 @@*.example.com/* 满足@@后规则的地址不使用代理
4. 匹配地址开始和结尾 |，如 |http://example.com、example.com|分别表示以http://example.com开始和以example.com结束的地址
5. || 标记，如 ||example.com *://*.example.com/*
6. 注释 ! 如 ! Comment

例如你要添加www.ip138.com、ip.cn两个网站到自定义代理规则，编辑user-rule.txt文件，在文件最后加入：
!测试user-rule生效
||ip138.com
||ip.cn

备注：user-rule.txt一行只能有一条代理规则。

user-rule.txt 规则生效 执行下面重要的一步：更新本地的PAC

TIPS: 如果发现哪个网站载入很慢,样式有问题,很可能cdn被墙,用chrome 打开,看newwork里红色的请求,把地址加到 user-rule.txt中

如:
https://atom.io/packages/remote-atom
包含
https://github-atom-io-herokuapp-com.global.ssl.fastly.net/assets/application-ba07c5c2889a34307a4b7d49410451d9.css
加
||fastly.net
然后 更新本地的PAC
