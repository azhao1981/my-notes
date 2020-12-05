erlang
=====

## try

http://www.tryerlang.org/
https://github.com/killme2008/erlwsh

## 语法

### split

把 customer_1_2_azhao 切成 cusotmer, 1, 2, azhao

posfix
1> list_to_binary("hello world").
<<"hello world">>

HostsList = [<<"udeskte3">>, <<"imdev.udeske3.com">>,<<"udeskt1">>,<<"imdev.udeske3.com">>].

binary:split(<<"customer_1_2_azhao">>,[<<"_">>],[global]).

[UserType, UserId, CompanyId, Prefix] = binary:split(<<"customer_1_2_azhao">>,[<<"_">>],[global]).
binary:at(binary:split(<<"customer_1_2_azhao">>,[<<"_">>],[global]), 3).

[_,_,_,Prefix] = binary:split(<<"customer_1_2_azhao">>,[<<"_">>],[global]).
AtstList= binary:split(<<"customer_1_2_azhao">>,[<<"_">>],[global]).
iolist_size(AtstList).
[_,_,_,Prefix2] = binary:split(<<"customer_1_2">>,[<<"_">>],[global]).

Array = array:from_list(["a", "b", "c"]),
array:size(Array).

iolist_size([1, 2 | <<3, 4>>]). 这个会取得字节数
lists:flatlength([3,4,45,5]) 这个取数据个数


http://erlang.org/doc/man/binary.html#split-2

split(Subject, Pattern, Options) -> Parts

binary:split

1> binary:split(<<1,255,4,0,0,0,2,3>>, [<<0,0,0>>,<<2>>],[]).
[<<1,255,4>>, <<2,3>>]
2> binary:split(<<0,1,0,0,4,255,255,9>>, [<<0,0>>, <<255,255>>],[global]).
[<<0,1>>,<<4>>,<<9>>]

## erlang to elixir
https://github.com/dazuma/erl2ex
## 数组

其实，tuple就是数组（当然是常数组）。

size(Tuple)
%% 取数组大小

append_element(Tuple1, Term) -> Tuple2
%% 添加一个元素

element(N, Tuple) -> Term
%% 取数组的第N个元素

make_tuple(N, InitialValue) -> Tuple
%% 创建一个数组元素值均为InitialValue的数组（该数组包含N个元素）。

setelement(Index, Tuple1, Value) -> Tuple2
%% 修改下标为Index的数组元素的值。

list_to_tuple(List) -> Tuple
%% 链表转数组

tuple_to_list(Tuple) -> List
%% 数组转链表

可以看出，Tuple数组相关的功能还是比较全的。

## emqttd 推送

https://github.com/emqtt/emqttd
https://github.com/erlio/vernemq

golang

https://github.com/drone/mq
https://github.com/surgemq/surgemq  网站都打不开了

## socket.io

https://github.com/omarkj/socketio-erlang
https://github.com/sinnus/socket.io-cowboy
https://github.com/yrashk/socket.io-erlang

## unit test

http://erlang.org/doc/apps/eunit/chapter.html
https://github.com/zkessin/testing-erlang-book
https://github.com/basho/rebar
http://stackoverflow.com/questions/6449681/best-practices-conventions-for-writing-erlang-unit-tests-using-eunit

## tips

```erlang
io:fwrite("hello, world\n").
lists:foldl()
foldl(Function, InitialAcc :: A, Array :: array(Type)) -> B
Function =
    fun((Index :: array_indx(), Value :: Type, Acc :: A) -> B)
Fold the elements of the array using the given function and initial accumulator value. The elements are visited in order from the lowest index to the highest. If Function is not a function, the call fails with reason badarg.

case:
case Condition of
     Result 1 ->
           Action 1;      
     Result 2 ->
           Action 2;
     Result 3 ->
           Action 3
end

erlang:iolist_to_binary([<<"foo">>, <<"bar">>,<<"ok">>]).


PacketS = <<"<message from='agent_2_1@im03.tryudesk.com/217367430861347726128075512219489684885722420486696854608' to='customer_236_1@im03.tryudesk.com' type='chat'><received xmlns='urn:xmpp:receipts' id='UDESK_1_msg1463476286450'/></message>">>.

Packet = xml_stream:parse_element(PacketS).
```

## moduls

http://mbooks.me/LYEFGG/modules.html

## ejabberd

Erlang 状态监控
http://wudaijun.com/2016/05/erlang-debug-online/  不错

Recon-Erlang线上系统诊断工具

http://blog.yufeng.info/archives/3080

Erlang ‘One Weird Trick’ Goodiebag

http://blog.equanimity.nl/blog/2015/03/15/erlang-one-weird-trick-goodiebag/

erlang 故障排查工具
http://www.cnblogs.com/lulu/p/4149204.html
monitor

https://www.ejabberd.im/mod_monitor_web

网络监控

erlang性能分析及进程监控工具
http://blog.sina.com.cn/s/blog_a78beb1f0102vgss.html
[Erlang 0092] Erlang 命令行监控工具
http://www.cnblogs.com/me-sa/archive/2012/11/22/erlang_vm_monitor_text_mode.html

ETOP:
shell/etop
http://erlang.org/doc/man/etop.html

以下失败
import(etop,start)
-import(etop,[start/0]).

```
ETOP_DIR=/srv/otp_src_18.2.1/lib/observer
/usr/lib/erlang/lib/observer-1.3.1.2
/usr/local/lib/erlang/lib/observer-2.1.1/priv/bin/

erl -sname etop  -setcookie  JHWKZOZFBUYXNYPMXOSA -hidden -s etop -s erlang halt -output text ejabberd@node00
erlang:get_cookie().
 ./etop -node 'ejabberd@localhost'  -setcookie  JHWKZOZFBUYXNYPMXOSA -lines 5 -sort memory -interval 50 -accumulate true -tracing on
```

 ```
 #!/bin/sh

 NAME="etop@testrsa.igrslabdns.com"
 echo erl -sname $NAME -hidden -s etop -s erlang halt -output text $@
 erl -name $NAME -hidden -s etop -s erlang halt -output text $@
 ```
 ~                                             

http://dev.groupdock.com/2010/10/05/monitoring-ejabberd-with-munin.html

https://github.com/processone/grapherl

```
ejabberdctl debug

ejabberdctl debug
>i().

```

https://www.ejabberd.im/tricks

erl -sname node1 -remsh ejabberd@localhost

erlang:get_cookie().
LGYFBKOXQEEOENCNEHYC
erl -setcookie KDETQBSASTSJCDRLAUUN -sname node1 -remsh ejabberd@localhost -run i -run init stop -noshell
erl -noshell -s program main -s init stop


ejabberd_config:load_file("/home/ejabberd/ejabberd.cfg").
c(mod_version).  # compile
l(mod_version).  # reload

erlang:system_info(process_limit).
processes:max(N). % set processes limits.

MonitorRef = erlang:monitor(Pid).
{MonitorRef,Pid} = spawn_monitor(...). %% spawn and monitor, atomic.
demonitor(MonitorRef). %% remove monitor



`exec $ERL $NAME ejabberdetop$SUFFIX -hidden -s etop -s erlang halt -output
text -tracing off -node $ERLANG_NODE`
