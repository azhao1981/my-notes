linux
----
### 查看版本

`cat /etc/issue`

### 交换分区

```bash
dd if=/dev/zero of=/tmp/swap bs=1MB count=8192

swap:
1、使用命令：dd if=/dev/zero of=/tmp/swap bs=1MB count=1024增加1G的swap空间。
2、使用 mkswap /tmp/swap 命令制作一个swap文件。
3、使用 swapon /tmp/swap 命令启动swap分区。
注意：此操作只对当前有效，重启服务器后失效。如果想持续保持。可以将其写入/etc/fstab文件中。
vim /etc/fstab
/tmp/swap                                       swap    defaults        0 0

##
sudo dd if=/dev/zero of=/tmp/swap bs=1MB count=2048
sudo dd if=/dev/zero of=/tmp/swap bs=1MB count=4096
sudo dd if=/dev/zero of=/tmp/swap bs=1MB count=8192
sudo mkswap /tmp/swap
sudo swapon /tmp/swap
sudo chmod 0600 /tmp/swap
```