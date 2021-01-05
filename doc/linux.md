# linux

## 查看/升级内核

[参考](https://blog.csdn.net/u011304615/article/details/70919711)

```bash
sudo dpkg --get-selections |grep linux-image
uname -r
uname -a
uname -r
cat /proc/version

apt-get update
apt-cache search linux-image
    linux-image-3.13.0-117-generic - Linux kernel image for version 3.13.0 on 64 bit x86 SMP
    linux-image-3.13.0-32-generic - Linux kernel image for version 3.13.0 on 64 bit x86 SMP
apt-get install linux-image-3.13.0-117-generic
# 安装完后会提示能找到哪些老版本
# 需要删除老的,不然重启还是会用最老的(新版本并不会)
apt-get remove linux-image-3.2.0-67-generic

reboot #OK
uname -r
3.13.0-117-generic
```

### ip

https://blog.csdn.net/orangleliu/article/details/51994513
curl ipinfo.io 不准,上海腾讯云认为北京

下面都比较准
curl cip.cc
curl myip.ipip.net
curl http://members.3322.org/dyndns/getip

这个可能已经不能用了
curl https://ip.cn

## service

cat /etc/systemd/system/redis.service
[Service]
User=redis
Group=redis

Ubuntu service管理
https://pdf-lib.org/Home/Details/4863
systemctl --all | grep nginx
systemctl enable nginx.service (.service可省略如下)
systemctl enable nginx
systemctl disable nginx.service
systemctl disable nginx

## window10

### 命令行

https://hyper.is/#installation

win10终端(WSL)优化 : 高颜值 windows命令行工具 Hyper全面介绍

https://cibifang.com/win10%E7%BB%88%E7%AB%AF%E4%BC%98%E5%8C%96-%E9%AB%98%E9%A2%9C%E5%80%BCwindows%E5%91%BD%E4%BB%A4%E8%A1%8C%E5%B7%A5%E5%85%B7hyper%E5%85%A8%E9%9D%A2%E4%BB%8B%E7%BB%8D/#_windows_Hyper_tips
使用vscode,然后用terminal运行bash就可以了

### [将Win10子系统(Ubuntu)从C盘迁移走](https://blog.czlz.net/2017/11/21/Ubuntu-on-Windows/)

1、以管理员身份运行cmd终端。输入如下命令：

lxrun /uninstall /full

  完全卸载掉Linux子系统。后面再进行安装。如果你已经在子系统中装了很多软件,也可以跳过此步。将子系统一起转移。
  2、临时建一个管理员账号，并用这个管理员账号进行登录。（我用要用这个账号进行资料转移，转移完成后就可以删除掉。）
  3、在文件夹选项->查看选项卡中，取消掉“隐藏受保护的操作系统文件（推荐）”并选择“显示隐藏的文件、文件夹和驱动器”。
  4、在目标磁盘建立一个文件夹，用于存放转移过来的系统，例如：
D:\Users\czlz\AppData\
  你可以自选位置，反正我是放在这里。
  5、将C盘目标用户的Local文件夹拷贝至第四步建立的目录下。比如我要转移的用户是czlz的数据。那么我的数据目录就是：
C:\Users\czlz\AppData\Local
  6、转移完成后，将原来的Local目录删除或改名（PS:怕操作失败,目前测试是不会失败）。然后打开以管理员身份运行cmd终端。到当前目标用户数据目录下输如下命令：
mklink /j C:\Users\czlz\AppData\Local D:\Users\czlz\AppData\Local
为 C:\Users\czlz\AppData\Local <<===>> D:\Users\czlz\AppData\Local 创建的联接
这样就成功的创建了一个连接。
  7、现在注销当前的临时用户，用原来的用户登录。看看有没有报错什么。然后再用管理员身份运行cmd终端执行如下命令(PS：如果第一步没删除的话这步操作不需要做。)：
lxrun /install


## kworker bioset 问题

[块层介绍 第一篇: bio层](https://blog.csdn.net/juS3Ve/article/details/79224066)
[Linux内核块设备层介绍之bio层 ](https://kuaibao.qq.com/s/20180711B1INT700?refer=spider)

https://bbs.archlinux.org/viewtopic.php?id=235015
https://wiki.archlinux.org/index.php/Mac#kworker_using_high_CPU
https://askubuntu.com/questions/1044872/ubuntu-16-04-kworker-using-high-cpu-constantly
https://www.linuxquestions.org/questions/linux-software-2/high-cpu-usage-by-kworker-4175563563/

https://askubuntu.com/questions/33640/kworker-what-is-it-and-why-is-it-hogging-so-much-cpu
What is kworker? kworker means a Linux kernel process doing "work" (processing system calls). You can have several of them in your process list: kworker/0:1 is the one on your first CPU core, kworker/1:1 the one on your second etc..
Why does kworker hog your CPU? To find out why a kworker is wasting your CPU, you can create CPU backtraces: watch your processor load (with top or something) and in moments of high load through kworker, execute echo l > /proc/sysrq-trigger to create a backtrace. (On Ubuntu, this needs you to login with sudo -s). Do this several times, then watch the backtraces at the end of dmesg output. See what happens frequently in the CPU backtraces, it hopefully points you to the source of your problem.

"kworker" is a placeholder process for kernel worker threads,
which perform most of the actual processing for the kernel,
especially(特别) in cases where there are interrupts, timers, I/O, etc.
These typically correspond to the vast majority(绝大部分) of any allocated "system" time to running processes.

## 查看时间

```bash
linux:
date -d @`date -u +%s`
date -d @`redis-cli LASTSAVE`
mac:
date -r `date -u +%s`
```

## 释放机器缓存

free -m
sync
echo 3 > /proc/sys/vm/drop_caches
那些机器空闲内存很小,但是应用占用很少

## 一个奇怪负载问题

https://blog.csdn.net/arkblue/article/details/46862751
https://blog.csdn.net/u011183653/article/details/19489603
http://www.fblinux.com/?p=281

## grep 正则

netstat -na| grep -E '7001|7002' |wc -l
netstat -na| grep -E '6001|6002' |wc -l

grep -E -i -w 'vivek|raj' /etc/passwd 忽略大小写

https://linux.cn/article-6941-1.html

## 一个奇怪网络问题解决

tmp-ybren-proxy
root
Udesk2018

ssh root@106.14.94.55
10.29.27.185

`echo 1 > /proc/sys/net/ipv4/ip_forward`

sudo iptables -t nat -A PREROUTING -p tcp -i eth1 --dport 80 -j DNAT --to 120.26.50.234:80

curl -XPOST 'http://wx.ybren.com/index.php/Home/WxCallback/GetUdeskMessage?timestamp=20180104115148&sign=9e37bd188c42cfc5a7dd3d7efb0dc37f' -vv

sudo vim /etc/hosts

106.14.94.55 wx.ybren.com

 /proc/sys/net/ipv4/tcp_timestamps 已恢复为 1
 
 http://perthcharles.github.io/2015/08/27/timestamp-intro/

 http://noops.me/?p=269

## 文字处理shell

https://github.com/learnbyexample/Command-line-text-processing

## inside 有中文翻译

https://github.com/0xAX/linux-insides

## bash

https://github.com/Idnan/bash-guide

## docker ali
vim /etc/apt/sources.list
deb http://mirrors.aliyun.com/ubuntu/ precise main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ precise-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ precise-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ precise-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ precise-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ precise main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ precise-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ precise-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ precise-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ precise-backports main restricted universe multiverse
apt-get update

## crotab

01 0    * * *   root    /srv/script/logstar.sh >/dev/null 2>&1

## 按日期排序 

ls -t
ls -tr
ls -halt | grep 'Jul 21'

https://github.com/ivanilves/xiringuito



## grep Binary

grep 文件报错 “Binary file ... matches

strings vers.log.2010-03-09 | grep -i ‘mezimedia’
或者 grep -a -i ‘mezimedia’ vers.log.2010-03-09
           
http://shanchao7932297.blog.163.com/blog/static/136362420113634354832/

https://github.com/sharkdp/shell-functools

https://github.com/wangyu-/udp2raw-tunnel

## dns

https://blog.csdn.net/u012732259/article/details/76502231

sudo vim /etc/resolvconf/resolv.conf.d/base
nameserver 8.8.8.8
nameserver 8.8.4.4

sudo resolvconf -u

### Ubuntu16.04 编译安装ffmpeg支持amrnb

参考文档:https://gist.github.com/teocci/f7a438013a0197a91446ee86de41faee

```bash 
cd ~
git clone https://git.ffmpeg.org/ffmpeg.git
cd ffmpeg
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --pkg-config-flags="--static" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="$HOME/bin" --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-version3
PATH="$HOME/bin:$PATH" make
make install
hash -r
sudo cp ~/bin/ffmpeg ~/bin/ffprobe /usr/bin/
```

### 证书问题

不行

这对我有用：
>使用Chrome，通过HTTPS在您的服务器上打开一个页面，然后继续通过红色警告页面(假设您还没有这样做)。
>打开Chrome设置>显示高级设置> HTTPS / SSL>管理证书。
>单击“授权”选项卡，向下滚动，找到您授予证书的“组织名称”下的证书。
>选择它，点击编辑(注意：在最近的Chrome版本中，该按钮现在是“高级”而不是“编辑”)，选中所有框，然后单击确定。您可能必须重新启动Chrome。

你应该得到你的网页上漂亮的绿色锁现在。

编辑：我在一台新机器上再次尝试，并且证书没有出现在管理证书窗口只是通过从红色不受信任的证书页面继续。我不得不做以下事情：

>在包含不受信任的证书(https：//以红色划线)的页面上，点击锁>证书信息。
>单击详细信息选项卡>出口。选择PKCS#7，单证书作为文件格式。
>然后按照我原来的说明进入管理证书页面。单击“授权”选项卡>导入并选择导出证书的文件，并确保选择PKCS#7，单个证书作为文件类型。
>如果提示存储，请选择受信任的根证书颁发机构
>选中所有复选框，然后单击确定。重新启动Chrome。