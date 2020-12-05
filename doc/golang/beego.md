beego
-----

admin
	
grace
	"github.com/astaxie/beego/grace"
	http://grisha.org/blog/2014/06/03/graceful-restart-in-golang/

	https://github.com/fvbock/endless 是这编文章作者提供的,也可以直接用beego

	Fork a new process which inherits the listening socket.
	Fork新的进程继承监听的socket
	The child performs initialization and starts accepting connections on the socket.
	招待初始化并处理新的socket连接
	Immediately after, child sends a signal to the parent causing the parent to stop accepting connecitons and terminate.
	子进程给父进程发信号,父进程停止新进连接并关闭


	"github.com/astaxie/beego/logs"
	"github.com/astaxie/beego/toolbox"
	"github.com/astaxie/beego/utils"

cache 
	memcache
	redis
	ssdb

config
	xml
	yaml

context
	输入输出

httplib

log

migration


orm

plugin

	apiauth
	auth
	cors

session

swagger
	Swagger™ is a project used to describe and document RESTful APIs.


utils
	captcha  模板
	pagination
	testdata
validation

/
	admin
	app
	beego
	config
	controller
	doc
	filter
	flash
	hooks
	mime
	namespace
	parser
	router
	saticfile
	template
	tree


mgweb

	config
	controller
	models
	routers
	views

	models/controller可以利用一下

pool

	https://github.com/golang/go/issues/4805
	https://golang.org/src/database/sql/doc.txt

From http://golang.org/src/pkg/database/sql/doc.txt:

* Handle concurrency well.  Users shouldn't need to care about the
   database's per-connection thread safety issues (or lack thereof),
   and shouldn't have to maintain their own free pools of connections.
   The 'db' package should deal with that bookkeeping as needed.  Given
   an *sql.DB, it should be possible to share that instance between
   multiple goroutines, without any extra synchronization.
   正确处理并发. 用户不需要关心每个连接的线程安全问题. 也不必要维护他可用的连接池.
   db package 会以按需记账方式处理.给定一个 *sql.DB 他可以在多个 goroutines中互用.而不需要额外的同步.

I think the current approach fails to achieve this because there is no control over the
dynamics of the pool. For example the pool size can grow without bound if there are
enough goroutines trying to use the DB connection. This is a problem if your database
has limits on the number of connections per user, as you end up with errors when trying
to use a *sql.DB.
我想当前方式达不到个目标,因为没有动态池处理的控制.

The current workaround is to maintain your own fixed-size pool of *sql.DB's and ensure
each one is only used by one goroutine at a time, which seems counter to the package
design goals.

There should be a way to configure maxIdleConns, as well as a way to set the maximum
number of connections.



https://codereview.appspot.com/6855102/#ps2001

https://github.com/golang/go/commit/41c5d8d85f6c031c591c26404a5009a333d5d974
SetMaxOpenConns

用这个来处理,看那个项目有没有处理了
	http://go-database-sql.org/connection-pool.html
	In Go 1.2.1 or newer, you can use db.SetMaxOpenConns(N) to limit the number of total open connections to the database. Unfortunately, a deadlock bug (fix) prevents db.SetMaxOpenConns(N) from safely being used in 1.2.



http://www.cnblogs.com/howDo/archive/2013/06/01/GoLang-Control.html
https://golang.org/doc/effective_go.html

:= 推导赋值
http://blog.ixcv.com/posts/1380.html




