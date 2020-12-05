ejabberd tips
------



### roster

大量的roster会造成 cpu使用率暴涨

### room 

ej 的 room 好像也有坑


### mnesia

mnesia:table_info(roster, attributes).
mnesia:table_info(roster, memory).
mnesia:read(roster, memory).
roster 统计
erlang mnesia 数据库实现SQL查询
http://blog.csdn.net/mycwq/article/details/12158967
mnesia:clear_table(last_activity).


http://koteancno.iteye.com/category/190792
http://koteancno.iteye.com/blog/1300196
http://www.cnblogs.com/me-sa/archive/2012/11/22/erlang_vm_monitor_text_mode.html
```erlang
spawn(
  fun() ->
    etop:start([{output, text}, {interval, 1}, {lines, 20}, {sort, memory}])
  end
  ).

  /usr/lib/erlang/lib/observer-1.3.1.2/priv/bin/etop -name ejabberd@node00  \
    -node ejabberd@node00 -setcookie .erlang.cookie \
    -lines 5 -sort memory -interval 10 -accumulate true -tracing on   
```

### 踢人
ejabberdctl kick_user agent_26205_4429 im03.udesk.cn

### ETOP
```shell
#!/bin/bash
EJABBERD_DIR=/srv/ejabberd-16.01
# ETOP_DIR=/usr/lib/erlang/lib/observer-1.3.1.2
ETOP_DIR=/usr/local/lib/erlang/lib/observer-2.1.1
# ETOP_DIR=/srv/otp_src_18.2.1/lib/observer
COOKIE=`cat $EJABBERD_DIR/.erlang.cookie`
ETOP=$ETOP_DIR/priv/bin/etop
ETOPPATH=$ETOP_DIR/ebin/

$ETOP -pa $ETOPPATH \
    -setcookie $COOKIE \
    -tracing off \
    -sort reductions -lines 50
    -node ejabberd@ejabberd

    runtime | reductions | memory | msg_q
```

### odbc
...
{mod_offline_odbc,  []},
{mod_last_odbc,     []},
{mod_roster_odbc,   []},
{mod_shared_roster_odbc,[]},
{mod_vcard_odbc,    []},
{mod_muc_odbc, [
  ...]},
{mod_pubsub_odbc, [
  ...]},
...
