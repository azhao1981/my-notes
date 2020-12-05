# 心脏出血

## openssl version

```bash
# 目前有漏洞的版本有： 1.0.1-1.0.1f（包含1.0.1f）以及 1.0.2-beta。你可以使用如下的命令查看服务器上的当前版本：

openssl version

openssl s_client -connect 你的网站:443 -tlsextdebug 2>&1| grep 'TLS server extension "heartbeat" (id=15), len=1'

```

现在资源已经不可用
https://segmentfault.com/a/1190000000461002