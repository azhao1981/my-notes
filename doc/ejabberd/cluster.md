Clustering
-----
在线确认
http://stackoverflow.com/questions/17424254/ejabberd-online-status-when-user-loses-connection

生产双活:
1. 先把 现有ejabberd 升级为node
/etc/hosts
127.0.0.1 ejabberd
127.0.0.1 ejabberd2
10.24.202.252 ejabberd2
10.24.202.252 ejabberd2
10.24.192.139 ejabberd
2. ejabberd2 备份启动
3. ./bin/ejabberdctl join_cluster 'ejabberd@ejabberd1'
ejabberdctl leave_cluster 'ejabberd@ejabberd2'
4369
4. LVS双机配置


sudo iptables -t nat -A PREROUTING -p tcp -i eth1 --dport 5222 -j DNAT --to 10.24.193.252:5222

1. 配置几个module : router/ local router/ session manager/ s2s manager
2. ~ejabberd/.erlang.cookie
3. ejabberdctl join_cluster 'ejabberd@ejabberd01' / ejabberdctl leave_cluster 'ejabberd@ejabberd02'

client -> LVS-> ejabberd node 1/2 -> db
ejabberd node1 -> ejabberd udtim
ejabberd node2 -> ejabberd udmonkey

check_list
1. 不同机器agent/customer是不是可以聊天
2. 在一个机器上是不是可以取得所有的在线用户
3. 插件的表现

apt-get update && apt-get build-dep erlang -y
测试环境返回java7
ln -nfs /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java /etc/alternatives/java
cp -r /srv/www/xxx/current/modules/mod_offline_receipt  ./
cp -r /srv/www/xxx/current/modules/mod_post_log/ ./

配置影响
bin/ejabberdctl:ERLANG_NODE=ejabberd@node01
conf/inetrc:{host,{127,0,0,1}, ["localhost","node01"]}.
conf/ejabberdctl.cfg:#ERLANG_NODE=ejabberd@node01

执行:
把两台机器加到/etc/hosts中
10.46.161.47 node01
10.25.92.172 node02
./bin/ejabberdctl join_cluster 'ejabberd@node01'

在try上进行登录,看能不能在monkey上看到结果

mysql proxy

mysql-proxy ，mysql官方的代理，使用起来并不友好，需要进行lua定制，而且本人对其稳定性和性能存疑。 Aug 19, 2014
Cobar ，阿里的东西，品质没的说，但对于我们项目，有点杀鸡用牛刀的感觉，另外我们都不会java。
Atlas ，360出品的基于mysql-proxy的增强版，几乎用c重写了核心框架，性能和稳定性都没话说。

https://github.com/siddontang/mixer

好像这两个都是一个人
https://github.com/flike/kingshard/blob/master/README_ZH.md
https://github.com/Qihoo360/Atlas/

https://github.com/Qihoo360/Atlas/wiki/Atlas的架构
https://github.com/Qihoo360/Atlas/wiki/Atlas的安装
rpm –i Atlas-2.2.1.el6.x86_64.rpm
sudo dpkg -i Atlas-2.2.1.el6.x86_64.rpm
cd /usr/local/mysql-proxy/
ln -nfs /usr/local/mysql-proxy/ /srv/mysql-proxy
没有ubuntu 的....

减少pool
node00:
127.0.0.1 node00
10.46.161.47 node01

node01:

10.24.193.252 node00
127.0.0.1 node01

./bin/ejabberdctl join_cluster 'ejabberd@node00'

cluster 状态


可视算法
http://algo-visualizer.jasonpark.me/#path=backtracking/n_queens/n_queens
## Purpose

The purpose of ejabberd clustering is to be able to use several servers for a single or small group of large domains, for fault-tolerance and scalability.
ejabberd集群的目的是:可以用一个或一组子域名机器来实现容灾和扩展.

Note that you do not necessarily need clustering if you want to run two large domains independantly. You may simply want to run two different independant servers.
如果你想用于两个独立域名,用不同机器就可以了.

However, to build reliable service and support large user base, clustering is a must have feature.
无论如何,要让系统更可靠,容纳更多人,cluster是必须的.

## How it Works
A XMPP domain is served by one or more ejabberd nodes. These nodes can be run on different machines that are connected via a network. They all must have the ability to connect to port 4369 of all another nodes, and must have the same magic cookie (see Erlang/OTP documentation, in other words the file ~ejabberd/.erlang.cookie must be the same on all nodes). This is needed because all nodes exchange information about connected users, s2s connections, registered services, etc…

一个XMPP域名可以用于一个或多个ejabberd节点.这些节点部署在联通的网络中.他们之间使用4369端口通讯,并用相同的Erlang magic cookie(见Erlang/OTP文档.换句话说,所有节点的~ejabberd.erlang.cookie这个文件必须一样.).这样才能保证不同节点交换在线用户,s2s连接,已注册服务等.

Each ejabberd node has the following modules:
每个ejabberd节点必须包含下面的modules:
router
local router
session manager
s2s manager.

Router
This module is the main router of XMPP packets on each node. It routes them based on their destination’s domains. It uses a global routing table. The domain of the packet’s destination is searched in the routing table, and if it is found, the packet is routed to the appropriate process. If not, it is sent to the s2s manager.
此module是每个节点上的XMPP包主路由.他会根据目标域名分发.使用一个全局路由表.系统根据XMPP包的目标域名在路由表中检索,如果找到,就把包分发到对应进程中.如果找不到,就发给s2s manager进程.

Local Router
This module routes packets which have a destination domain equal to one of this server’s host names. If the destination JID has a non-empty user part, it is routed to the session manager, otherwise it is processed depending on its content.
此module 分发那些目标域名(可多个)是本地机器的消息包,如果jid是用户部分非空,就发给session manager进程,不然会根据内容来处理.

Session Manager
This module routes packets to local users. It looks up to which user resource a packet must be sent via a presence table. Then the packet is either routed to the appropriate c2s process, or stored in offline storage, or bounced back.
此module把包发给当前用户.他会根据在线列表来把投送包发送给相应resource的用户.然后包会分发给相应的c2s进程,或离线存贮进程.或是返回.

s2s Manager
This module routes packets to other XMPP servers. First, it checks if an opened s2s connection from the domain of the packet’s source to the domain of the packet’s destination exists. If that is the case, the s2s manager routes the packet to the process serving this connection, otherwise a new connection is opened.
此module与其它的xmpp服务器通讯.首先,他检查包来源域名与目标域名的s2s连接是否存在.如果已经存在,就直接通过这个连接投送,不然会启用新的连接.

## Before you get started
Before you start implementing clustering, there are a few things you need to take into account:
在你实现集群前,先必须考虑下面的问题:

Cluster should be set up in a single data center: The clustering in ejabberd Community Edition relies on low latency networking. While it may work across regions, it is recommended that you run an ejabberd cluster in a single Amazon region.
Clustering relies on Erlang features and Mnesia shared schemas. Before getting started, it is best to get familiar with the Erlang environment as this guide will heavily reference Erlang terms.
集群必须建立独立数据中心:集群必须建立在可信认和低风险的网络中.虽然他是可以跨区使用,但还是建议部署在相同的亚马逊区域内.
集群依赖于Erlang特性和Mnesia 同享模式.开始前,最好先熟悉一下erlang环境,本指引会较深涉及erlang一些概念.


## Clustering Setup
Adding a node to a cluster
Suppose you have already configured ejabberd on one node named ejabberd01. Let’s create an additional node (ejabberd02) and connect them together.
添加一个节点到集群中
假设你已经有一个节点叫ejabberd01,这里会添加一个ejabberd02到现在的节点中.

Copy the /home/ejabberd/.erlang.cookie file from ejabberd01 to ejabberd02.
从ejabberd01拷贝文件/home/ejabberd/.erlang.cookie到ejabberd02

Alternatively you could pass the -setcookie <value> option to all erl commands below.
或者你可以每次都用 -setcookie <value> 来执行下面的erl命令

Make sure your new ejabberd node is properly configured. Usually, you want to have the same ejabberd.yml config file on the new node that on the other cluster nodes.
确认你的新ejabberd正确的设置.一般你的ejabberd.yml配置文件必须是一样的.

Adding a node to the cluster is done by starting a new ejabberd node within the same network, and running a command from a cluster node. On the ejabberd02 node for example, as ejabberd is already started, run the following command as the ejabberd daemon user, using the ejabberdctl script:
在同一网络中打开节点并执行一个命令就可以把节点加到集群中了.
比如在ejabberd02上,用ejabberd启用用户执行下面的脚本:

1
$ ejabberdctl join_cluster 'ejabberd@ejabberd01'
SELECT CODE
This enables ejabberd’s internal replications to be launched across all nodes so new nodes can start receiving messages from other nodes and be registered in the routing tables.
此命令启用ejabberd的内部应答,这样集群所有节点会把新节点加入到路由表中,这样新节点就可以接收消息了.

Removing a node from the cluster
To remove a node from the cluster, it just needs to be shut down. There is no specific delay for the cluster to figure out that the node is gone, the node is immediately removed from other router entries. All clients directly connected to the stopped node are disconnected, and should reconnect to other nodes.
删除节点
把节点关上就可以删除节点.如果没有特别指定延迟删除时间,那么其它的节点会立刻生效.所有连这个节点的客户端都会断开,并去连其它的节点.

If the cluster is used behind a load balancer and the node has been removed from the load balancer, no new clients should be connecting to that node but established connections should be kept, thus allowing to remove a node smoothly, by stopping it after most clients disconnected by themselves. If the node is started again, it’s immediately attached back to the cluster until it has been explicitly removed permanently from the cluster.
如果集群是在负载均衡下使用或是说被负载均衡移除.那么不能建立新的连接但是会老连接会保持.这样等老用户都下了,就可以平滑地删除节点了.
当节点再次打开,他马上会补加入到集群当中,除非已经明确地从集群中永久地删除他.

To permanently remove a running node from the cluster, the following command must be run as the ejabberd daemon user, from one node of the cluster:
 要明确删除一个节点,需要在一个集群结点上执行:

1
$ ejabberdctl leave_cluster 'ejabberd@ejabberd02'
SELECT CODE
The removed node must be running while calling leave_cluster to make it permanently removed. It’s then immediately stopped.
执行命令的时候这个节点必须还在运行.之后它马上会停止.


13 Distributed Erlang
13 分布式Erlang框架

13.1  Distributed Erlang System
13.1 分布式Erlang系统

A distributed Erlang system consists of a number of Erlang runtime systems communicating with each other. Each such runtime system is called a node. Message passing between processes at different nodes, as well as links and monitors, are transparent when pids are used. Registered names, however, are local to each node. This means that the node must be specified as well when sending messages, and so on, using registered names.
分布式Erlang系统由相互通讯的Erlang runtime组成.每个runtime也被称为node(节点). 当使用pids来交互时,不同节点进程(如links和monitors)的消息传递是透明的.
注册的名字被定位到每个节点上.这意味着,当发送消息时,节点必须明确指定,如使用被注册过的名称.

The distribution mechanism is implemented using TCP/IP sockets. How to implement an alternative carrier is described in the ERTS User's Guide.
这种分布式机制使用TCP/IP实现.详见<<ERTS用户手册>>
http://erlang.org/doc/apps/erts/alt_dist.html

13.2  Nodes

A node is an executing Erlang runtime system that has been given a name, using the command-line flag -name (long names) or -sname (short names).
一个节点是一个正在运行的Erlang程序,用命令-name或-sname来标记.

The format of the node name is an atom name@host. name is the name given by the user. host is the full host name if long names are used, or the first part of the host name if short names are used. node() returns the name of the node.
节点名称格式如name@host.name是用户定义的程序名称.host是机器名(ping host可以ping到).如果用-name是使用全称,如果使用-sname则指第一部分.
在代码中使用node().返回这个节点的名称.

Example:

% erl -name dilbert
(dilbert@uab.ericsson.se)1> node().
'dilbert@uab.ericsson.se'

% erl -sname dilbert
(dilbert@uab)1> node().
dilbert@uab
Note
A node with a long node name cannot communicate with a node with a short node name.

13.3  Node Connections

The nodes in a distributed Erlang system are loosely connected. The first time the name of another node is used, for example, if spawn(Node,M,F,A) or net_adm:ping(Node) is called, a connection attempt to that node is made.

Connections are by default transitive. If a node A connects to node B, and node B has a connection to node C, then node A also tries to connect to node C. This feature can be turned off by using the command-line flag -connect_all false, see the erl(1) manual page in ERTS.

If a node goes down, all connections to that node are removed. Calling erlang:disconnect_node(Node) forces disconnection of a node.

The list of (visible) nodes currently connected to is returned by nodes().

13.4  epmd

The Erlang Port Mapper Daemon epmd is automatically started at every host where an Erlang node is started. It is responsible for mapping the symbolic node names to machine addresses. See the epmd(1) manual page in ERTS.

13.5  Hidden Nodes

In a distributed Erlang system, it is sometimes useful to connect to a node without also connecting to all other nodes. An example is some kind of O&M functionality used to inspect the status of a system, without disturbing it. For this purpose, a hidden node can be used.

A hidden node is a node started with the command-line flag -hidden. Connections between hidden nodes and other nodes are not transitive, they must be set up explicitly. Also, hidden nodes does not show up in the list of nodes returned by nodes(). Instead, nodes(hidden) or nodes(connected) must be used. This means, for example, that the hidden node is not added to the set of nodes that global is keeping track of.

This feature was added in Erlang 5.0/OTP R7.

13.6  C Nodes

A C node is a C program written to act as a hidden node in a distributed Erlang system. The library Erl_Interface contains functions for this purpose. For more information about C nodes, see the Erl_Interface application and Interoperability Tutorial..

13.7  Security

Authentication determines which nodes are allowed to communicate with each other. In a network of different Erlang nodes, it is built into the system at the lowest possible level. Each node has its own magic cookie, which is an Erlang atom.

When a node tries to connect to another node, the magic cookies are compared. If they do not match, the connected node rejects the connection.

At start-up, a node has a random atom assigned as its magic cookie and the cookie of other nodes is assumed to be nocookie. The first action of the Erlang network authentication server (auth) is then to read a file named $HOME/.erlang.cookie. If the file does not exist, it is created. The UNIX permissions mode of the file is set to octal 400 (read-only by user) and its contents are a random string. An atom Cookie is created from the contents of the file and the cookie of the local node is set to this using erlang:set_cookie(node(), Cookie). This also makes the local node assume that all other nodes have the same cookie Cookie.

Thus, groups of users with identical cookie files get Erlang nodes that can communicate freely and without interference from the magic cookie system. Users who want to run nodes on separate file systems must make certain that their cookie files are identical on the different file systems.

For a node Node1 with magic cookie Cookie to be able to connect to, or accept a connection from, another node Node2 with a different cookie DiffCookie, the function erlang:set_cookie(Node2, DiffCookie) must first be called at Node1. Distributed systems with multiple user IDs can be handled in this way.

The default when a connection is established between two nodes, is to immediately connect all other visible nodes as well. This way, there is always a fully connected network. If there are nodes with different cookies, this method can be inappropriate and the command-line flag -connect_all false must be set, see the erl(1) manual page in ERTS.

The magic cookie of the local node is retrieved by calling erlang:get_cookie().

13.8  Distribution BIFs

Some useful BIFs for distributed programming (for more information, see the erlang(3) manual page in ERTS:

BIF	Description
erlang:disconnect_node(Node)	Forces the disconnection of a node.
erlang:get_cookie()	Returns the magic cookie of the current node.
is_alive()	Returns true if the runtime system is a node and can connect to other nodes, false otherwise.
monitor_node(Node, true|false)	Monitors the status of Node. A message{nodedown, Node} is received if the connection to it is lost.
node()	Returns the name of the current node. Allowed in guards.
node(Arg)	Returns the node where Arg, a pid, reference, or port, is located.
nodes()	Returns a list of all visible nodes this node is connected to.
nodes(Arg)	Depending on Arg, this function can return a list not only of visible nodes, but also hidden nodes and previously known nodes, and so on.
erlang:set_cookie(Node, Cookie)	Sets the magic cookie used when connecting to Node. If Node is the current node, Cookie is used when connecting to all new nodes.
spawn[_link|_opt](Node, Fun)	Creates a process at a remote node.
spawn[_link|opt](Node, Module, FunctionName, Args)	Creates a process at a remote node.
Table 13.1:   Distribution BIFs
13.9  Distribution Command-Line Flags

Examples of command-line flags used for distributed programming (for more information, see the erl(1) manual page in ERTS:

Command-Line Flag	Description
-connect_all false	Only explicit connection set-ups are used.
-hidden	Makes a node into a hidden node.
-name Name	Makes a runtime system into a node, using long node names.
-setcookie Cookie	Same as calling erlang:set_cookie(node(), Cookie).
-sname Name	Makes a runtime system into a node, using short node names.
Table 13.2:   Distribution Command-Line Flags
13.10  Distribution Modules

Examples of modules useful for distributed programming:

In the Kernel application:

Module	Description
global	A global name registration facility.
global_group	Grouping nodes to global name registration groups.
net_adm	Various Erlang net administration routines.
net_kernel	Erlang networking kernel.
Table 13.3:   Kernel Modules Useful For Distribution.
In the STDLIB application:

Module	Description
slave	Start and control of slave nodes.
Table 13.4:   STDLIB Modules Useful For Distribution.


XEP-0198

http://xmpp.org/extensions/xep-0198.html

This specification defines an XMPP protocol extension for active management of an XML stream between two XMPP entities, including features for stanza acknowledgements and stream resumption.

1. Introduction

XMPP Core [1] defines the fundamental streaming XML technology used by XMPP (i.e., stream establishment and termination including authentication and encryption). However, the core XMPP specification does not provide tools for actively managing a live XML stream.

The basic concept behind stream management is that the initiating entity (either a client or a server) and the receiving entity (a server) can exchange "commands" for active management of the stream. The following stream management features are of particular interest because they are expected to improve network reliability and the end-user experience:

Stanza Acknowledgements -- the ability to know if a stanza or series of stanzas has been received by one's peer.
Stanze 确认 -- 可以知道某个包是不是已经被对方接收
Stream Resumption -- the ability to quickly resume a stream that has been terminated.
stream恢复 -- 可以快速地回复一个不小心掉线的stream
Stream management implements these features using short XML elements at the root stream level. These elements are not "stanzas" in the XMPP sense (i.e., not <iq/>, <message/>, or <presence/> stanzas as defined in RFC 6120) and are not counted or acked in stream management, since they exist for the purpose of managing stanzas themselves.


Stream management is used at the level of an XML stream. To check TCP connectivity underneath a given stream, it is RECOMMENDED to use whitespace keepalives (see RFC 6120), XMPP Ping (XEP-0199) [2], or TCP keepalives. By contrast with stream management, Advanced Message Processing (XEP-0079) [3] and Message Delivery Receipts (XEP-0184) [4] define acks that are sent end-to-end over multiple streams; these facilities are useful in special scenarios but are unnecessary for checking of a direct stream between two XMPP entities.

Note: Stream Management can be used for server-to-server streams as well as for client-to-server streams. However, for convenience this specification discusses client-to-server streams only. The same principles apply to server-to-server streams. (In this document, examples prepended by "C:" are sent by a client and examples prepended by "S:" are sent by a server.)

2. Stream Feature

The server returns a stream header to the client along with stream features, where the features include an <sm/> element qualified by the 'urn:xmpp:sm:3' namespace (see Namespace Versioning regarding the possibility of incrementing the version number).

Note: The client cannot negotiate stream management until it has authenticated with the server and has bound a resource; see below for specific restrictions.

Example 1. Server sends new stream header along with stream features

S: <stream:stream
       from='example.com'
       xmlns='jabber:client'
       xmlns:stream='http://etherx.jabber.org/streams'
       version='1.0'>

S: <stream:features>
     <bind xmlns='urn:ietf:params:xml:ns:xmpp-bind'/>
     <sm xmlns='urn:xmpp:sm:3'/>
   </stream:features>

3. Enabling Stream Management

To enable use of stream management, the client sends an <enable/> command to the server.

Example 2. Client enables stream management

C: <enable xmlns='urn:xmpp:sm:3'/>

If the client wants to be allowed to resume the stream, it includes a boolean 'resume' attribute, which defaults to false [5]. For information about resuming a previous session, see the Resumption section of this document.

The <enable/> element MAY include a 'max' attribute to specify the client's preferred maximum resumption time in seconds.

Upon receiving the enable request, the server MUST reply with an <enabled/> element or a <failed/> element qualified by the 'urn:xmpp:sm:3' namespace. The <failed/> element indicates that there was a problem establishing the stream management "session". The <enabled/> element indicates successful establishment of the stream management session.

Example 3. Server enables stream management

S: <enabled xmlns='urn:xmpp:sm:3'/>

The parties can then the use stream management features defined below.

If the server allows session resumption, it MUST include a 'resume' attribute set to a value of "true" or "1" [6].

Example 4. Server enables stream management with session resumption

S: <enabled xmlns='urn:xmpp:sm:3' id='some-long-sm-id' resume='true'/>

The <enabled/> element MAY include a 'max' attribute to specify the server's preferred maximum resumption time.

The <enabled/> element MAY include a 'location' attribute to specify the server's preferred IP address or hostname (optionally with a port) for reconnection, in the form specified in Section 4.9.3.19 of RFC 6120 (i.e., "domainpart:port", where IPv6 addresses are enclosed in square brackets "[...]" as described in RFC 5952 [7]); if reconnection to that location fails, the standard XMPP connection algorithm specified in RFC 6120 applies.

The client MUST NOT attempt to negotiate stream management until it is authenticated; i.e., it MUST NOT send an <enable/> element until after authentication (such as SASL, Non-SASL Authentication (XEP-0078) [8] or Server Dialback (XEP-0220) [9]) has been completed successfully.

For client-to-server connections, the client MUST NOT attempt to enable stream management until after it has completed Resource Binding unless it is resuming a previous session (see Resumption).

The server SHALL enforce this order and return a <failed/> element in response if the order is violated (see Error Handling).

Example 5. Server returns error if client attempts to enable stream management before resource binding

S: <failed xmlns='urn:xmpp:sm:3'>
     <unexpected-request xmlns='urn:ietf:params:xml:ns:xmpp-stanzas'/>
   </failed>

Note that a client SHALL only make at most one attempt to enable stream management. If a server receives a second <enable/> element it SHOULD respond with a stream error, thus terminating the client connection .

4. Acks

After enabling stream management, the client or server can send ack elements at any time over the stream. An ack element is one of the following:

The <a/> element is used to answer a request for acknowledgement or to send an unrequested ack.
The <r/> element is used to request acknowledgement of received stanzas.
The following attribute is defined:

The 'h' attribute identifies the last handled stanza (i.e., the last stanza that the server will acknowledge as having received).
An <a/> element MUST possess an 'h' attribute.

The <r/> element has no defined attributes.

Definition: Acknowledging a previously-received ack element indicates that the stanza(s) sent since then have been "handled" by the server. By "handled" we mean that the server has accepted responsibility for a stanza or stanzas (e.g., to process the stanza(s) directly, deliver the stanza(s) to a local entity such as another connected client on the same server, or route the stanza(s) to a remote entity at a different server); until a stanza has been affirmed as handled by the server, that stanza is the responsibility of the sender (e.g., to resend it or generate an error if it is never affirmed as handled by the server).

Receipt of an <r/> element does not imply that new stanzas have been transmitted by the peer; receipt of an <a/> element only indicates that new stanzas have been processed if the 'h' attribute has been incremented.

The value of 'h' starts at zero at the point stream management is enabled or requested to be enabled (see note below). The value of 'h' is then incremented to one for the first stanza handled and incremented by one again with each subsequent stanza handled. In the unlikely case that the number of stanzas handled during a stream management session exceeds the number of digits that can be represented by the unsignedInt datatype as specified in XML Schema Part 2 [10] (i.e., 232), the value of 'h' SHALL be reset from 232-1 back to zero (rather than being incremented to 232).

Note: There are two values of 'h' for any given stream: one maintained by the client to keep track of stanzas it has handled from the server, and one maintained by the server to keep track of stanzas it has handled from the client. The client initializes its value to zero when it sends <enable/> to the server, and the server initializes its value to zero when it sends <enabled/> to the client (it is expected that the server will respond immediately to <enable/> and set its counter to zero at that time). After this initialization, the client increments its value of 'h' for each stanza it handles from server, and the server increments its value of 'h' for each stanza it handles from the client.

The following annotated example shows a message sent by the client, a request for acknowledgement, and an ack of the stanza.

Example 6. Simple stanza acking

C: <enable xmlns='urn:xmpp:sm:3'/>

   <!-- Client sets outbound count to zero. -->

C: <message from='laurence@example.net/churchyard'
            to='juliet@example.com'
            xml:lang='en'>
     <body>
       I'll send a friar with speed, to Mantua,
       with my letters to thy lord.
     </body>
   </message>

   <!-- Note that client need not wait for a response. -->

S: <enabled xmlns='urn:xmpp:sm:3'/>

   <!--
        Server receives enable, and responds,
        setting both inbound and outbound counts
        to zero.

        In addition, client sets inbound count to zero.
   -->

C: <r xmlns='urn:xmpp:sm:3'/>

S: <a xmlns='urn:xmpp:sm:3' h='1'/>

When an <r/> element ("request") is received, the recipient MUST acknowledge it by sending an <a/> element to the sender containing a value of 'h' that is equal to the number of stanzas handled by the recipient of the <r/> element. The response SHOULD be sent as soon as possible after receiving the <r/> element, and MUST NOT be withheld for any condition other than a timeout. For example, a client with a slow connection might want to collect many stanzas over a period of time before acking, and a server might want to throttle incoming stanzas. The sender does not need to wait for an ack to continue sending stanzas.

Either party MAY send an <a/> element at any time (e.g., after it has received a certain number of stanzas, or after a certain period of time), even if it has not received an <r/> element from the other party.

When a party receives an <a/> element, it SHOULD keep a record of the 'h' value returned as the sequence number of the last handled outbound stanza for the current stream (and discard the previous value).

If a stream ends and it is not resumed within the time specified in the original <enabled/> element, the sequence number and any associated state MAY be discarded by both parties. Before the session state is discarded, implementations SHOULD take alternative action regarding any unhandled stanzas (i.e., stanzas sent after the most recent 'h' value received):

A server SHOULD treat unacknowledged stanzas in the same way that it would treat a stanza sent to an unavailable resource, by either returning an error to the sender, delivery to an alternate resource, or committing the stanza to offline storage. (Note that servers SHOULD add a delay element with the original (failed) delivery timestamp, as per Delayed Delivery (XEP-0203) [11]).
A user-oriented client SHOULD try to silently resend the stanzas upon reconnection or inform the user of the failure via appropriate user-interface elements.
Because unacknowledged stanzas might have been received by the other party, resending them might result in duplicates; there is no way to prevent such a result in this protocol, although use of the XMPP 'id' attribute on all stanzas can at least assist the intended recipients in weeding out duplicate stanzas.

5. Resumption

It can happen that an XML stream is terminated unexpectedly (e.g., because of network outages). In this case, it is desirable to quickly resume the former stream rather than complete the tedious process of stream establishment, roster retrieval, and presence broadcast.

In addition, this protocol exchanges the sequence numbers of the last received stanzas on the previous connection, allowing entities to establish definitively which stanzas require retransmission and which do not, eliminating duplication through replay.

To request that the stream will be resumable, when enabling stream management the client MUST add a 'resume' attribute to the <enable/> element with a value of "true" or "1" [12].

Example 7. Client enables stream management

C: <enable xmlns='urn:xmpp:sm:3' resume='true'/>

If the server will allow the stream to be resumed, it MUST include a 'resume' attribute set to "true" or "1" on the <enabled/> element and MUST include an 'id' attribute that specifies an identifier for the stream.

Example 8. Server allows stream resumption

S: <enabled xmlns='urn:xmpp:sm:3' id='some-long-sm-id' resume='true'/>

Definition: The 'id' attribute defines a unique identifier for purposes of stream management (an "SM-ID"). The SM-ID MUST be generated by the server. The client MUST consider the SM-ID to be opaque and therefore MUST NOT assign any semantic meaning to the SM-ID. The server MAY encode any information it deems useful into the SM-ID, such as the full JID <localpart@domain.tld/resource> of a connected client (e.g., the full JID plus a nonce value). Any characters allowed in an XML attribute are allowed. The SM-ID MUST NOT be reused for simultaneous or subsequent sessions (but the server need not ensure that SM-IDs are unique for all time, only for as long as the server is continuously running). The SM-ID SHOULD NOT be longer than 4000 bytes.

As noted, the <enabled/> element MAY include a 'location' attribute that specifies the server's preferred location for reconnecting (e.g., a particular connection manager that hold session state for the connected client).

Example 9. Server prefers reconnection at a particular location

S: <enabled xmlns='urn:xmpp:sm:3'
            id='some-long-sm-id'
            location='[2001:41D0:1:A49b::1]:9222'
            resume='true'/>

If the stream is terminated unexpectedly, the client would then open a TCP connection to the server. The order of events is as follows:

After disconnection, the client opens a new TCP connection to the server, preferring the address specified in the 'location' attribute (if any).
Client sends initial stream header.
Server sends response stream header.
Server sends stream features.
Client sends STARTTLS request.
Server informs client to proceed with the TLS negotiation.
The parties complete a TLS handshake. (Note: When performing session resumption and also utilizing TLS, it is RECOMMENDED to take advantage of TLS session resumption RFC 5077 [13] to further optimize the resumption of the XML stream.)
Client sends new initial stream header.
Server sends response stream header.
Server sends stream features, requiring SASL negotiation and offering appropriate SASL mechanisms. (Note: If the server considers the information provided during TLS session resumption to be sufficient authentication, it MAY offer the SASL EXTERNAL mechanism; for details, refer to draft-cridland-sasl-tls-sessions [14].)
The parties complete SASL negotiation.
Client sends new initial stream header.
Server sends response stream header.
Server sends stream features, offering the SM feature.
Client requests resumption of the former stream.
Note: The order of events might differ from those shown above, depending on when the server offers the SM feature, whether the client chooses STARTTLS, etc. Furthermore, in practice server-to-server streams often do not complete SASL negotiation or even TLS negotiation. The foregoing text does not modify any rules about the stream negotiation process specified in RFC 6120. However, since stream management applies to the exchange of stanzas (not any other XML elements), it makes sense for the server to offer the SM feature when it will be possible for the other party to start sending stanzas, not before. See also Recommended Order of Stream Feature Negotiation (XEP-0170) [15].

To request resumption of the former stream, the client sends a <resume/> element qualified by the 'urn:xmpp:sm:3' namespace. The <resume/> element MUST include a 'previd' attribute whose value is the SM-ID of the former stream and MUST include an 'h' attribute that identifies the sequence number of the last handled stanza sent over the former stream from the server to the client (in the unlikely case that the client never received any stanzas, it would set 'h' to zero).

Example 10. Stream resumption request

C: <resume xmlns='urn:xmpp:sm:3'
           h='some-sequence-number'
           previd='some-long-sm-id'/>

If the server can resume the former stream, it MUST return a <resumed/> element, which MUST include a 'previd' attribute set to the SM-ID of the former stream and MUST also include an 'h' attribute set to the sequence number of the last handled stanza sent over the former stream from the client to the server (in the unlikely case that the server never received any stanzas, it would set 'h' to zero).

Example 11. Stream resumed

S: <resumed xmlns='urn:xmpp:sm:3'
            h='another-sequence-number'
            previd='some-long-sm-id'/>

If the server does not support session resumption, it MUST return a <failed/> element, which SHOULD include an error condition of <feature-not-implemented/>. If the server does not recognize the 'previd' as an earlier session (e.g., because the former session has timed out), it MUST return a <failed/> element, which SHOULD include an error condition of <item-not-found/>. If the server recogizes the 'previd' as an earlier session that has timed out the server MAY also include a 'h' attribute indicating the number of stanzas received before the timeout. (Note: For this to work the server has to store the SM-ID/sequence number tuple past the time out of the actual session.)

Example 12. Stream timed out

S: <failed xml='urn:xmpp:sm:3'
           h='another-sequence-number'>
     <item-not-found xmlns='urn:ietf:params:xml:ns:xmpp-stanzas'/>
   </failed>

In both of these failure cases, the server SHOULD allow the client to bind a resource at this point rather than forcing the client to restart the stream negotiation process and re-authenticate.

If the former stream is resumed and the server still has the stream for the previously-identified session open at this time, the old stream SHOULD be terminated.

When a session is resumed, the parties proceed as follows:

The sequence values are carried over from the previous session and are not reset for the new stream.
Upon receiving a <resume/> or <resumed/> element the client and server use the 'h' attribute to retransmit any stanzas lost by the disconnection. In effect, it should handle the element's 'h' attribute as it would handle it on an <a/> element (i.e., marking stanzas in its outgoing queue as handled), except that after processing it MUST re-send to the peer any stanzas that are still marked as unhandled.
Both parties SHOULD retransmit any stanzas that were not handled during the previous session, based on the sequence number reported by the peer.
A reconnecting client SHOULD NOT request the roster, because any roster changes that occurred while the client was disconnected will be sent to the client after the stream management session resumes.
The client SHOULD NOT resend presence stanzas in an attempt to restore its former presence state, since this state will have been retained by the server.
Both parties SHOULD NOT try to re-establish state information (e.g., Service Discovery (XEP-0030) [16] information).
6. Error Handling

If an error occurs with regard to an <enable/> or <resume/> element, the server MUST return a <failed/> element. This element SHOULD contain an error condition, which MUST be one of the stanza error conditions defined in RFC 6120.

An example follows.

Example 13. Server returns error

S: <failed xmlns='urn:xmpp:sm:3'>
     <unexpected-request xmlns='urn:ietf:params:xml:ns:xmpp-stanzas'/>
   </failed>

Stream management errors SHOULD be considered recoverable; however, misuse of stream management MAY result in termination of the stream.

7. Stream Closure

A cleanly closed stream differs from an unfinished stream. If a client wishes to cleanly close its stream and end its session, it MUST send a </stream:stream> so that the server can send unavailable presence on the client's behalf.

If the stream is not cleanly closed then the server SHOULD consider the stream to be unfinished (even if the client closes its TCP connection to the server) and SHOULD maintain the session on behalf of the client for a limited amount of time. The client can send whatever presence it wishes before leaving the stream in an unfinished state.

8. Scenarios

The following scenarios illustrate several different uses of stream management. The examples are that of a client and a server, but stream management can also be used for server-to-server streams.

8.1 Basic Acking Scenario

The Stream Management protocol can be used to improve reliability using acks without the ability to resume a session. A basic implementation would do the following:

As a client, send <enable/> with no attributes, and ignore the attributes on the <enabled/> response.
As a server, ignore the attributes on the <enable/> element received, and respond via <enabled/> with no attributes.
When receiving an <r/> element, immediately respond via an <a/> element where the value of 'h' returned is the sequence number of the last handled stanza.
Keep an integer X for this stream session, initially set to zero. When about to send a stanza, first put the stanza (paired with the current value of X) in an "unacknowleged" queue. Then send the stanza over the wire with <r/> to request acknowledgement of that outbound stanza, and increment X by 1. When receiving an <a/> element with an 'h' attribute, all stanzas whose paired value (X at the time of queueing) is less than or equal to the value of 'h' can be removed from the unacknowledged queue.
This is enough of an implementation to minimally satisfy the peer, and allows basic tracking of each outbound stanza. If the stream connection is broken, the application has a queue of unacknowledged stanzas that it can choose to handle appropriately (e.g., warn a human user or silently send after reconnecting).

The following examples illustrate basic acking (here the client automatically acks each stanza it has received from the server, without first being prompted via an <r/> element).

First, after authentication and resource binding, the client enables stream management.

Example 14. Client enables stream management

C: <enable xmlns='urn:xmpp:sm:3'/>

The server then enables stream management.

Example 15. Server enables stream management

S: <enabled xmlns='urn:xmpp:sm:3'/>

The client then retrieves its roster and immediately sends an <r/> element to request acknowledgement.

Example 16. Client sends a stanza and requests acknowledgement

C: <iq id='ls72g593' type='get'>
     <query xmlns='jabber:iq:roster'/>
   </iq>

C: <r xmlns='urn:xmpp:sm:3'/>

The server handles the client stanza (here returning the roster) and sends an <a/> element to acknowledge handling of the stanza.

Example 17. Server handles client stanza and acknowledges handling of client stanza

S: <iq id='ls72g593' type='result'>
     <query xmlns='jabber:iq:roster'>
       <item jid='juliet@capulet.lit'/>
       <item jid='benvolio@montague.lit'/>
     </query>
   </iq>

S: <a xmlns='urn:xmpp:sm:3' h='1'/>

The client then chooses to acknowledge receipt of the server's stanza (although here it is under no obligation to do so, since the server has not requested an ack), sends initial presence, and immediately sends an <r/> element to request acknowledgement, incrementing by one its internal representation of how many stanzas have been handled by the server.

Example 18. Client acks handling of first server stanza, sends a stanza, and requests acknowledgement

C: <a xmlns='urn:xmpp:sm:3' h='1'/>

C: <presence/>

C: <r xmlns='urn:xmpp:sm:3'/>

The server immediately sends an <a/> element to acknowledge handling of the stanza and then broadcasts the user's presence (including to the client itself as shown below).

Example 19. Server acks handling of second client stanza and sends a stanza

S: <a xmlns='urn:xmpp:sm:3' h='2'/>

S: <presence from='romeo@montague.lit/orchard'
             to='romeo@montague.lit/orchard'/>

The client then acks the server's second stanza and sends an outbound message followed by an <r/> element.

Example 20. Client acks receipt of second server stanza, sends a stanza, and requests acknowledgement

C: <a xmlns='urn:xmpp:sm:3' h='2'/>

C: <message to='juliet@capulet.lit'>
     <body>ciao!</body>
   </message>

C: <r xmlns='urn:xmpp:sm:3'/>

The server immediately sends an <a/> element to acknowledge handling of the third client stanza and then routes the stanza to the remote contact (not shown here because the server does not send a stanza to the client).

Example 21. Server acknowledges handling of third client stanza

S: <a xmlns='urn:xmpp:sm:3' h='3'/>

And so on.

8.2 Efficient Acking Scenario

The basic acking scenario is wasteful because the client requested an ack for each stanza. A more efficient approach is to periodically request acks (e.g., every 5 stanzas). This is shown schematically in the following pseudo-XML.

Example 22. An efficient session

C: <enable/>
S: <enabled/>
C: <message/>
C: <message/>
C: <message/>
C: <message/>
C: <message/>
C: <r/>
S: <a h='5'/>
C: <message/>
C: <message/>
C: <message/>
C: <message/>
C: <message/>
C: <r/>
S: <a h='10'/>

In particular, on mobile networks, it is advisable to only request and/or send acknowledgements when an entity has other data to send, or in lieu of a whitespace keepalive or XMPP ping (XEP-0199).

9. Security Considerations

As noted, a server MUST NOT allow an client to resume a stream management session until after the client has authenticated (for some value of "authentication"); this helps to prevent session hijacking.

10. IANA Considerations

This XEP requires no interaction with the Internet Assigned Numbers Authority (IANA) [17].

11. XMPP Registrar Considerations

11.1 Protocol Namespaces

This specification defines the following XML namespace:

urn:xmpp:sm:3
The XMPP Registrar [18] includes the foregoing namespace in its registry at <http://xmpp.org/registrar/namespaces.html>, as described in Section 4 of XMPP Registrar Function (XEP-0053) [19].

11.2 Protocol Versioning

If the protocol defined in this specification undergoes a revision that is not fully backwards-compatible with an older version, the XMPP Registrar shall increment the protocol version number found at the end of the XML namespaces defined herein, as described in Section 4 of XEP-0053.

11.3 Stream Features

The XMPP Registrar includes 'urn:xmpp:sm:3' in its registry of stream features at <http://xmpp.org/registrar/stream-features.html>.

12. XML Schemas

<?xml version='1.0' encoding='UTF-8'?>

<xs:schema
    xmlns:xs='http://www.w3.org/2001/XMLSchema'
    targetNamespace='urn:xmpp:sm:3'
    xmlns='urn:xmpp:sm:3'
    elementFormDefault='qualified'>

  <xs:annotation>
    <xs:documentation>
      The protocol documented by this schema is defined in
      XEP-0198: http://www.xmpp.org/extensions/xep-0198.html
    </xs:documentation>
  </xs:annotation>

  <xs:import namespace='urn:ietf:params:xml:ns:xmpp-stanzas'
             schemaLocation='http://xmpp.org/schemas/stanzaerror.xsd'/>

  <xs:element name='a'>
    <xs:complexType>
      <xs:simpleContent>
        <xs:extension base='empty'>
          <xs:attribute name='h'
                        type='xs:integer'
                        use='required'/>
        </xs:extension>
      </xs:simpleContent>
    </xs:complexType>
  </xs:element>

  <xs:element name='enable'>
    <xs:complexType>
      <xs:simpleContent>
        <xs:extension base='empty'>
          <xs:attribute name='max'
                        type='xs:positiveInteger'
                        use='optional'/>
          <xs:attribute name='resume'
                        type='xs:boolean'
                        use='optional'
                        default='false'/>
        </xs:extension>
      </xs:simpleContent>
    </xs:complexType>
  </xs:element>

  <xs:element name='enabled'>
    <xs:complexType>
      <xs:simpleContent>
        <xs:extension base='empty'>
          <xs:attribute name='id'
                        type='xs:string'
                        use='optional'/>
          <xs:attribute name='location'
                        type='xs:string'
                        use='optional'/>
          <xs:attribute name='max'
                        type='xs:positiveInteger'
                        use='optional'/>
          <xs:attribute name='resume'
                        type='xs:boolean'
                        use='optional'
                        default='false'/>
        </xs:extension>
      </xs:simpleContent>
    </xs:complexType>
  </xs:element>

  <xs:element name='failed'>
    <xs:complexType>
      <xs:sequence xmlns:err='urn:ietf:params:xml:ns:xmpp-stanzas'
                   minOccurs='0'
                   maxOccurs='1'>
        <xs:group ref='err:stanzaErrorGroup'/>
      </xs:sequence>
      <xs:attribute name='h'
                    type='xs:unsignedInt'
                    use='optional'/>
    </xs:complexType>
  </xs:element>

  <xs:element name='r' type='empty'/>

  <xs:element name='resume' type='resumptionElementType'/>

  <xs:element name='resumed' type='resumptionElementType'/>

  <xs:element name='sm'>
    <xs:complexType>
      <xs:choice>
        <xs:element name='optional' type='empty'/>
        <xs:element name='required' type='empty'/>
      </xs:choice>
    </xs:complexType>
  </xs:element>

  <xs:complexType name='resumptionElementType'>
    <xs:simpleContent>
      <xs:extension base='empty'>
        <xs:attribute name='h'
                      type='xs:unsignedInt'
                      use='required'/>
        <xs:attribute name='previd'
                      type='xs:string'
                      use='required'/>
      </xs:extension>
    </xs:simpleContent>
  </xs:complexType>

  <xs:simpleType name='empty'>
    <xs:restriction base='xs:string'>
      <xs:enumeration value=''/>
    </xs:restriction>
  </xs:simpleType>

</xs:schema>

13. Acknowledgements

Thanks to Bruce Campbell, Jack Erwin, Philipp Hancke, Curtis King, Tobias Markmann, Alexey Melnikov, Pedro Melo, Robin Redeker, Mickaël Rémond, Florian Schmaus, and Tomasz Sterna for their feedback.
