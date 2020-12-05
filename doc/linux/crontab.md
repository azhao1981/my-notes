crontab
-----

### 有记录跑没有执行成功问题
大多是环境变量及配置文件
http://www.pooy.net/ubuntu-open-crontab-logging-and-resolution-no-mta-installed-discarding-output-problem.html
修改rsyslog文件，将/etc/rsyslog.d/50-default.conf 文件中的#cron.*前的#删掉；
重启rsyslog服务service rsyslog restart；
重启cron服务service cron restart；

more /var/log/cron.log；

就可以查看运行时的日志文件，如果在日志文件中出现：No MTA installed, discarding output

那么就是说，crontab执行脚本时是不会直接错误的信息输出，而是会以邮件的形式发送到你的邮箱里，这时候就需要邮件服务器了，如果你没有安装邮件服务器，它就会报这个错。如果是测试，可以用下面的办法来解决：

在每条定时脚本后面加入：

>/dev/null 2>&1
就可以解决No MTA installed, discarding output的问题。

http://www.cnblogs.com/hancf/archive/2013/06/06/3122777.html