# nmap

nmap 一直是黑帽很重要的收集工具

## 安装使用

https://nmap.org/download.html

```bash
bzip2 -cd nmap-7.80.tar.bz2 | tar xvf -
cd nmap-7.80
./configure
make
su root
make install
```

### 使用

Nmap使用教程（初级篇）
https://www.cnblogs.com/H4ck3R-XiX/p/12231851.html

Nmap使用教程（进阶篇）
https://www.cnblogs.com/H4ck3R-XiX/p/12234762.html

## nmap vs masscan

[中文输出文档](https://nmap.org/man/zh/man-output.html)

nmap -T4 -A -Pn -v  47.99.95.96 -p 5221 -OX myscan.xml

/usr/local/bin/xml2json -t xml2json -o myscan.json myscan.xml

真是不是很好用

py2 https://github.com/hay/xml2json.git
py3 https://github.com/eliask/xml2json

[nmap命令-----基础用法](https://www.cnblogs.com/nmap/p/6232207.html)

[Nmap端口扫描工具](https://www.jianshu.com/p/20a3d4b25242)

Security For Embedeed Systems - One Bin to Rule Them All.
https://github.com/isdrupter/busybotnet
nmap 一些东西,但没有 clamav chkrootkit

+ masscan 扫描出错, 应该开了 80,443,6001,6002
  + nmap 可以很快确认没有问题,但扫描结果要很长时间
  + nmap 可以,那 masscan 应该是也是可以的,只是参数问题
    + 错, masscan 很多的参数都没实现

# nmap

## 概述

https://nmap.org/man/zh/

发现 nmap 有很多功能.可以搞出很多事情来.

https://github.com/ernw/nmap-parse-output
https://github.com/jgamblin/nmaptable
https://github.com/scipag/vulscan
https://github.com/SpiderLabs/Nmap-Tools
https://github.com/honze-net/nmap-bootstrap-xsl
https://github.com/vulnersCom/nmap-vulners
https://github.com/cldrn/nmap-nse-scripts

## 参数

[扫描方式](https://nmap.org/man/zh/man-port-scanning-techniques.html)

-sS (TCP SYN扫描) 半开放扫描
  发送一个SYN报文，等待响应
    SYN/ACK 表示端口在监听 (开放)
    RST(复位) 表示没有监听者
    数次重发后仍没响应，该端口就被标记为被过滤
    ICMP不可到达错误 (类型3，代码1，2，3，9，10，或者13)，该端口也被标记为被过滤
  SYN扫描可用时，它通常是更好的选择
-sT (TCP connect()扫描)
  connect() 系统调用
  管理员在日志里看到来自同一系统的 一堆连接尝试，她应该知道她的系统被扫描了
-sU (UDP扫描)
  DNS，SNMP，和DHCP (注册的端口是53，161/162，和67/68)是最常见的三个
  可以和TCP扫描如 SYN扫描 (-sS)结合使用来同时检查两种协议
  UDP扫描发送空的(没有数据)UDP报头到每个目标端口
    返回ICMP端口不可到达错误(类型3，代码3) 该端口是closed(关闭的)
    其它ICMP不可到达错误(类型3， 代码1，2，9，10，或者13)表明该端口是filtered(被过滤的)
    偶尔地，某服务会响应一个UDP报文，证明该端口是open(开放的)
    如果几次重试后还没有响应，该端口就被认为是 open|filtered(开放|被过滤的)
    可以用版本扫描(-sV)帮助区分真正的开放端口和被过滤的端口。
-sA (TCP ACK扫描)
  它不能确定open(开放的)或者 open|filtered(开放或者过滤的))端口。
  它用于发现防火墙规则，确定它们是有状态的还是无状态的，哪些端口是被过滤的。

  ACK扫描探测报文只设置ACK标志位(除非您使用 --scanflags)。当扫描未被过滤的系统时， open(开放的)和closed(关闭的) 端口 都会返回RST报文。
  Nmap把它们标记为 unfiltered(未被过滤的)，意思是 ACK报文不能到达，但至于它们是open(开放的)或者 closed(关闭的) 无法确定。
  不响应的端口或者发送特定的ICMP错误消息(类型3，代号1，2，3，9，10， 或者13)的端口，标记为 filtered(被过滤的)。
-sW (TCP windows 扫描)
  除了利用特定系统的实现细节来区分开放端口和关闭端口，当收到RST时不总是打印unfiltered,窗口扫描和ACK扫描完全一样。
  它通过检查返回的RST报文的TCP窗口域做到这一点。
  在某些系统上，开放端口用正数表示窗口大小(甚至对于RST报文) 而关闭端口的窗口大小为0。
  因此，当收到RST时，窗口扫描不总是把端口标记为 unfiltered， 而是根据TCP窗口值是正数还是0，分别把端口标记为open或者 closed

  该扫描依赖于互联网上少数系统的实现细节， 因此您不能永远相信它。
  不支持它的系统会通常返回所有端口closed。
  当然，一台机器没有开放端口也是有可能的。
  如果大部分被扫描的端口是 closed，而一些常见的端口 (如 22， 25，53) 是 filtered，该系统就非常可疑了。
  偶尔地，系统甚至会显示恰恰相反的行为。 如果您的扫描显示1000个开放的端口和3个关闭的或者被过滤的端口， 那么那3个很可能也是开放的端口。
-sM (TCP Maimon扫描)
  Maimon扫描是用它的发现者Uriel Maimon命名的。他在 Phrack Magazine issue #49 (November 1996)中描述了这一技术。
  这项技术和Null，FIN，以及Xmas扫描完全一样，除了探测报文是FIN/ACK。
  根据RFC 793 (TCP)，无论端口开放或者关闭，都应该对这样的探测响应RST报文。
  然而，Uriel注意到如果端口开放，许多基于BSD的系统只是丢弃该探测报文。
-sO (IP协议扫描)
  IP 协议扫描可以让您确定目标机支持哪些IP协议 (TCP，ICMP，IGMP，等等)。
  从技术上说，这不是端口扫描 ，既然它遍历的是IP协议号而不是TCP或者UDP端口号。 
  但是它仍使用 -p选项选择要扫描的协议号， 用正常的端口表格式报告结果，甚至用和真正的端口扫描一样的扫描引擎。
  因此它和端口扫描非常接近，也被放在这里讨论。

  协议扫描以和UDP扫描类似的方式工作。它不是在UDP报文的端口域上循环， 而是在IP协议域的8位上循环，发送IP报文头。 报文头通常是空的，不包含数据，甚至不包含所申明的协议的正确报文头 TCP，UDP，和ICMP是三个例外。它们三个会使用正常的协议头，因为否则某些系 统拒绝发送，而且Nmap有函数创建它们。协议扫描不是注意ICMP端口不可到达消息， 而是ICMP 协议不可到达消息。如果Nmap从目标主机收到 任何协议的任何响应，Nmap就把那个协议标记为open。 ICMP协议不可到达 错误(类型 3，代号 2) 导致协议被标记为 closed。其它ICMP不可到达协议(类型 3，代号 1，3，9，10，或者13) 导致协议被标记为 filtered (虽然同时他们证明ICMP是 open )。如果重试之后仍没有收到响应， 该协议就被标记为open|filtered

## 使用

```bash
sudo /srv/ipscan/masscan -n -v -Pn --banners --top-ports 1000 149.129.160.28 -oJ /srv/www/udesk_greatwall/releases/20191206012841/data/ips/reports/149.129.160.28.json

sudo /srv/ipscan/masscan -n -v -Pn --banners -p80,443,6001,6002 149.129.160.28 -oJ /srv/www/udesk_greatwall/releases/20191206012841/data/ips/reports/149.129.160.28.json

./masscan -n -Pn --banners --top-ports 1000 149.129.160.28

sudo /srv/ipscan/masscan -n -Pn -sS -p 80,443,6001,6002 149.129.160.28 -oJ 149.129.160.28.json
sudo /srv/ipscan/masscan -sO -Pn -n  -v -p 80,443,6001,6002 -v 149.129.160.28

nmap -T4 -A -Pn -v 149.129.160.28 -p 80,443,6001,6002 -oN myscan.nmap
sudo nmap -sS -p 80,443,6001,6002 -v 149.129.160.28
sudo nmap -sA -p 80,443,6001,6002 -v 149.129.160.28

# ST 不需要 root
nmap -sT -p 80,443,6001,6002 -v 149.129.160.28

nmap -sW -p 80,443,6001,6002 -v 149.129.160.28
nmap -sM -p 80,443,6001,6002 -v 149.129.160.28

# 这个能扫不少东西,时间也比较长
nmap -A -T4 www.udesk.cn
```

[中文使用手册](https://nmap.org/man/zh/)

https://github.com/shmilylty/Nmap-Reference-Guide

https://github.com/Rvn0xsy/nse_vuln

https://github.com/sophsec/ruby-nmap

这是商业的在线扫描工具
https://securitytrails.com/blog/top-15-nmap-commands-to-scan-remote-hosts#one-basic-nmap-scan-against-ip-or-host

全自动扫描(中文)
https://github.com/RASSec/pentestER-Fully-automatic-scanner

https://pentest-tools.com/network-vulnerability-scanning/tcp-port-scanner-online-nmap

  nmap -sT -sV -Pn -v xxx.xxx.xxx.xxx
  nmap -sS -p 1-65535 -v 192.168.1.254
  参数：
  -sS/sT/sA/sW/sM: TCP SYN/Connect()/ACK/Window/Maimon scans
  -sS    TCP SYN扫描
  -P     指定端口扫描
  -V     详细信息

### nmap-hackers 邮件组

https://nmap.org/mailman/listinfo/announce