# SSL

## 主要:

https://github.com/Neilpang/acme.sh/wiki/%E8%AF%B4%E6%98%8E

[使用 acme.sh 给 Nginx 安装 Let’ s Encrypt 提供的免费 SSL 证书](https://ruby-china.org/topics/31983)

## 优化

### 问题

1、慢，HTTPS未经任何优化的情况下要比HTTP慢几百毫秒以上，特别在移动端可能要慢500毫秒以上，关于HTTPS慢和如何优化已经是一个非常系统和复杂的话题，由于时间的关系，本次分享就不做介绍了。但有一点可以肯定的是，HTTPS的访问速度在经过优化之后是不会比HTTP慢；
2、贵，特别在计算性能和服务器成本方面。HTTPS为什么会增加服务器的成本？相信大家也都清楚HTTPS要额外计算，要频繁地做加密和解密操作，几乎每一个字节都需要做加解密，这就产生了服务器成本，但也有两点大家可能并不清楚：
HTTPS有哪些主要的计算环节，是不是每个计算环节计算量都一样？
知道这些计算环节对CPU的影响，我们如何优化这些计算环节？

[腾讯优化](http://mp.weixin.qq.com/s?__biz=MjM5MDE0Mjc4MA==&mid=2650995461&idx=1&sn=ff45463bbf862517761c17887ef3fd2d&chksm=bdbf03568ac88a40072d5f4e6706ad102cd33abe68db4eb88a85d2180f65fab5a59ea8debe06&scene=21#wechat_redirect)

## 免费证书: certbot

<https://letsencrypt.org/zh-cn/getting-started/>

<https://certbot.eff.org/>

```bash
sudo apt-get update
sudo apt-get install software-properties-common -y
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install certbot python-certbot-nginx -y
sudo certbot --nginx
sudo certbot certonly --nginx
```

## ssl配置

[分享一个 HTTPS A+ 的 nginx 配置](https://www.textarea.com/zhicheng/fenxiang-yige-https-a-di-nginx-peizhi-320/)

`openssl dhparam -out dhparam.pem 4096`

```config
## nginx/conf/site.conf
server {
    ssl_dhparam /srv/nginx/conf/dhparam.pem;

    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_stapling on;
    ssl_ciphers "ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA";
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;

    #HSTS 配置，这个对评分影响也比较大，但如果开启这个，需要全站开启 HTTPS
    add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
}
```

评分:
https://ssllabs.com/ssltest/analyze.html?d=mast.azhao.im
