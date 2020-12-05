#!/bin/bash
# vim /etc/crontab
# 59 23 * * * root /srv/script/logstar.sh 2>&1
# bzip2 -d file          # unzip
# targets="file1 file2"  # config
date=`date +%Y-%m-%d`
targets="//srv/ejabberd-16.01/logs/message.log"
for target in $targets
do
    file=`basename $target`
    basedir=`dirname $target`
    cd $basedir
    echo $basedir/$file
    cat $file >> $file.$date
    cat /dev/null > $file
    echo $file.$date
    bzip2 -z $file.$date
    chown webuser:webuser $file.$date.bz2
done
