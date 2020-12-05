# shell

## 变量

[玩转Bash变量](https://segmentfault.com/a/1190000002539169)

## bash慢 原因: xxvm init - 太慢

+ 打点 `/etc/profile ~/.bashrc ~/dofiles/index`
  + date 打ms `gdate +"x: %Y-%m-%d %H:%M:%S.%N"`

<http://mattgreensmith.net/2014/12/25/speed-up-rbenv-init-via-background-rehashing/>
+ time eval "$(rbenv init -)"
+ time eval "$(rbenv init --no-rehash -)"

## bash

https://github.com/dylanaraps/pure-bash-bible

## ip

curl ipinfo.io/ip
wget -qO- http://ipecho.net/plain ; echo

## 日期

DATE=$(date --date=' 1 days ago' '+%Y-%d-%m')

[参考](https://stackoverflow.com/questions/22043088/how-to-get-yesterday-and-day-before-yesterday-in-linux)

## Bash guide

[guide](https://github.com/Idnan/bash-guide)


## miller

http://johnkerl.org/miller/doc/10-min.html

## awk 

https://www.linuxidc.com/Linux/2017-02/140316.htm

```bash
awk '
> BEGIN{FS=":";print "----header----"}   #打印内容字符串要用双引号，单引号有语法错误
> /mail/{print $1}
> END{print "----footer----"}
> ' /etc/passwd

----header----
mail
----footer----
```

## 命令是否存在

if ! [ -x "$(command -v curl)" ]; then
  echo 'Error: curl is not installed. sudo apt-get install curl ' >&2
  exit 1
fi

## 某端口联接ip排名

netstat -na| grep -v 7001 | grep -v 7002 |grep ESTABLISHED |  awk '{split($5,a,":" ); print a[1]}' | sort|uniq -c|sort -nr

netstat -nap|grep -v LISTEN |  awk '{split($5,a,":" ); print a[1]}' | sort|uniq -c|sort -nr

## [2>&1 的含义](http://blog.csdn.net/ithomer/article/details/9288353)

## 颜色

```bash
echo -e "Default \033[0;32mGreen"
```

[有效引用](https://billie66.github.io/TLCL/book/chap14.html) |
[详见](https://misc.flogisoft.com/bash/tip_colors_and_formatting)

## 当前路径

```bash
## 在执行脚本中可以用
cd `dirname $0`
dir=`pwd`
```

```bash
cat shell/a.sh
#!/bin/bash
echo '$0: '$0
echo "pwd: "`pwd`
echo "============================="
echo "scriptPath1: "$(cd `dirname $0`; pwd)
echo "scriptPath2: "$(pwd)
echo "scriptPath3: "$(dirname $(readlink -f $0))
echo "scriptPath4: "$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
echo -n "scriptPath5: " && dirname $(readlink -f ${BASH_SOURCE[0]})
Jun@VAIO 192.168.1.216 23:53:17 ~ >
bash shell/a.sh
$0: shell/a.sh
pwd: /home/Jun
=============================
scriptPath1: /home/Jun/shell
scriptPath2: /home/Jun
scriptPath3: /home/Jun/shell
scriptPath4: /home/Jun/shell
scriptPath5: /home/Jun/shell
Jun@VAIO 192.168.1.216 23:54:54 ~ >
```

## color

http://misc.flogisoft.com/bash/tip_colors_and_formatting

## bash with args

```bash
reset_remote_branch(){
  name=$1
  cd ~/xxx/$name
  echo "reset $name"
  set -x \
    && git fetch --all \
    && git checkout develop && git reset --hard origin/develop \
    && git checkout master && git reset --hard origin/master \
    && git checkout week && git reset --hard origin/week
}
proj="xxx_proj"
im="xxx_im"
reset_remote_branch $proj
reset_remote_branch $im
```

## sshd

```yaml
sshd_config
  PasswordAuthentication no
```

## IM redis 分析

awk '{split($5,a,":" ); print a[1]}'
head memory.1129.csv | awk '{split($1,a,"," ); print a[3]}'

git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/" | awk '{split($1,a,"_" ); print a[2]}'

数据分类,key特征,平均大小,总大小
IPIP,im_redis:IPIP,152,445.2M
im临时数据,im_redis:sets,165,215M
im临时数据客户,im_redis:sets:*customer:,165,124M

grep -v 'im_redis:IPIP' memory.1129.csv > im_redis_noip.csv

cat im_redis_noip.csv |wc -l
1368816

grep 'im_redis:sets' im_redis_noip.csv|wc -l
1054586

grep 'im_redis:sets' im_redis_noip.csv| grep customer |wc -l
790216

## 使用im的公司排序

```
tower 上redis 问题查看
netstat -na| grep -v 7001 | grep -v 7002 |grep 6379| grep ESTABLISHED | \
 awk '{split($5,a,":" ); print a[1]}' | sort|uniq -c|sort -nr

'{split($5,a,":" ); print a[1]}' # 把 $5 用 : 拆分放在a中. 取第一个
'{split($4,a,":" ); print a[2]}' # 把 $5 用 : 拆分放在a中. 取第一个
netstat -nap| grep 6379 | awk '{split($5,a,":" ); print a[1]}' | sort|uniq -c|sort -nr
grep /api/v2/im/agent.json log/production.log | awk '{print $5}' |sort|uniq -c|sort -nr

args tips

((!$#)) && echo 请指定文件, command ignored! && exit 1

for in
for branch in $MERGE_BRANCHS
do
    echo "$DEPLOY_BRANCH merge $branch"
done
```

## vim 自动加可执行

```bash
vim ~/.vimrc
au BufWritePost * if getline(1) =~ "^#!" | silent !chmod a+x <afile>
```

```bash
#!/bin/bash
echo "Enter your name: "
read A
if [ "$A" = "GS" ];then
        echo "yes"
elif [ "$A" = "UC" ];then
        echo "no"
else
        echo  "your are wrong"
fi
```

## file
```bash
if [ -d "$DIRECTORY" ]; then  
    # Here if $DIRECTORY exists  
fi

if [ ! -f "$file" ]; then
  touch "$file"
fi
```

## replace

tomorrow="${today//Suzi/Sara}"
全部
echo "${tomorrow//Marry/Jesica}" > /tmp/lovers.txt

一个
echo "${tomorrow/Marry/Jesica}" > /tmp/lovers.txt

## 参数是否是空

```bash
#!/bin/sh

a=xx

if [ ! -n "$a" ]; then
  echo "IS NULL"
else
  echo "NOT NULL"
fi
```

