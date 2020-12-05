ssh
-----

### 配置 config

 文件: .ssh/config


 https://superuser.com/questions/247564/is-there-a-way-for-one-ssh-config-file-to-include-another-one

#### key

生成私钥：`ssh-keygen -t rsa -b 4096 -f ${private}.key`

生成公钥：`openssl rsa -in ${private}.key -pubout -outform PEM -out ${public}.key.pub`

转换格式：`openssl pkcs8 -topk8 -inform PEM -in jwtRS256.key -outform pem -nocrypt -out pkcs8.pem`

[引用](https://blog.csdn.net/li396864285/article/details/79865806)

#### 缓存

```bash
Host *
    ForwardAgent yes
    ControlMaster auto
    ControlPath ~/.ssh/cm_socket/%r@%h:%p
    ControlPersist yes
    ServerAliveInterval 10
```

#### ssh自动添加hostkey到know_hosts

https://www.cnblogs.com/yuxc/archive/2013/02/28/2936616.html

/etc/ssh/ssh_config
StrictHostKeyChecking no

#### 通用配置

```
Host ud*
  User webuser
  ServerAliveInterval 10
  identityfile ~/.ssh/id_rsa

Host udhz-*
  ProxyCommand ssh bastion@xxxx -o ServerAliveInterval=30 -i ~/.ssh/id_rsa -W %h:%p

Host udhz-p001 udhz-p1
  HostName 10.1.251.1
```

```bash
#!/bin/bash
((!$#)) && echo 请指定机器名 , command ignored! && exit 1

HostName="udhz-$1"
echo "Connecting to $HostName"
ssh $HostName
```

### 使用管道访问阿里云 rds

设 rds的主机虽 xxx.mysql.rds.aliyuncs.com

只有主机A可以访问

```bash
## .ssh/config 管道主机配置
Host debugdb
  User webusr
  HostName 101.201.50.233
  LocalForward 3301 xxx.mysql.rds.aliyuncs.com:3306
## 连接命令,会在本地开 3301 端口
ssh debugdb -C -f -N -g

## 本地配置 host
127.0.0.1 xxx.mysql.rds.aliyuncs.com

## mysql 连接
mysql -h xxx.mysql.rds.aliyuncs.com -P3301 -uUSER_NAME -pPASSPWD DB_NAME

```

推荐工具:

[mycli](https://github.com/dbcli/mycli)

[pgcli](https://github.com/dbcli/pgcli)

[bdash](https://github.com/bdash-app/bdash)

  这个好像还不太好用


### 管道

端口转发(服务器本地到本地)
```
ssh -C -f -N -g root@localhost -L 42557:127.0.0.1:27017
```

远程转发到本地
```
host  linode
  user root
  hostname 106.187.101.89
  RemoteForward 52698 localhost:52698
  RemoteForward 53698 localhost:53698
  identityfile ~/.ssh/id_rsa
  ServerAliveInterval 10
```

```shell
# 在服务器上
rmate xx.rb
```

### 常见错误

#### 服务器权限错误
http://www.daveperrett.com/articles/2010/09/14/ssh-authentication-refused/
> chmod g-w /home/webuser
> chmod 700 /home/webuser/.ssh
> chmod 600 /home/webuser/.ssh/authorized_keys

Sep 14 01:26:31 new-server sshd[22107]: Authentication refused: bad ownership or modes for directory /home/dave/.ssh
Sep 14 01:26:46 new-server sshd[22108]: Connection closed by 98.76.54.32

重要的一个文件
/var/log/auth.log

### 建用户
adduser webuser
passwd -d webuser
passwd webuser
chmod +w  /etc/sudoers

staging
echo "webuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
production
echo "webuser ALL=(ALL:ALL) ALL " >> /etc/sudoers
chmod 0440 /etc/sudoers

mkdir /home/webuser/.ssh \
&& touch /home/webuser/.ssh/authorized_keys \
&& chown -R webuser:webuser /home/webuser/.ssh
chmod 0700 /home/webuser/.ssh
chmod 0600 /home/webuser/.ssh/authorized_keys

