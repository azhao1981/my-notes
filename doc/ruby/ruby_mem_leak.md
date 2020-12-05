# ruby_mem_leak

## 工具 LIST

### list

#### 生产记录内容变化 gem [oink](https://github.com/noahd1/oink)

```ruby
# Gemfile
gem 'oink'
```

```bash
  bundle exec oink --threshold=1 log/oink.log

# rails c
  Oink::Instrumentation::SystemCall.execute("ps -o vsz= -p #{$$}").stdout.to_i
```

#### 用来看进程大小 [get_process_mem](https://github.com/schneems/get_process_mem)

```ruby
mem = GetProcessMem.new
puts mem.inspect
mem.bytes
```

#### [memory_profiler](https://github.com/SamSaffron/memory_profiler)

#### [derailed_benchmarks](https://github.com/schneems/derailed_benchmarks)

#### [helper](https://github.com/kaspernj/memory_leak_helper)

#### [discourse](https://github.com/discourse/discourse/blob/master/lib/memory_diagnostics.rb)

#### 用于debug的虚机 [valgrind](http://valgrind.org/)

#### http://tmm1.net/ruby21-objspace/

```ruby
require 'objspace'
ObjectSpace.trace_object_allocations_start
```

### TODO

+ 只部署一台
+ 压测 staging
+ 加 discourse 那个工具
+ 换成unicorn


bundle exec pumactl -S /srv/www/udesk_ichat/shared/tmp/pids/puma.state -F /srv/www/udesk_ichat/shared/puma.rb restart

./wrk -t2 -c10 -d30s "http://ichat.udeskmonkey.com/app/status"

http://ichat.udeskmonkey.com/app/status/memory_stats

http://ichat.udeskmonkey.com/app/status/memory_stats?diff=1
http://ichat.udeskmonkey.com/app/status/memory_stats?snapshot=1
  /srv/www/udesk_ichat/releases/20170727074712/tmp/mem_snapshots/3411.snapshot
http://ichat.udeskmonkey.com/app/status/dump_heap

discourse-heap-067872.json


- 去掉 coverband 不是这个问题

### 有问题的gem

+ 确认有问题,直接loop就能看到内存上涨

  [ruby-pinyin]((https://github.com/janx/ruby-pinyin))


https://github.com/ruby-concurrency/concurrent-ruby

## 参考与操作

### unicorn



### debugging


https://bearmetal.eu/theden/how-do-i-know-whether-my-rails-app-is-thread-safe-or-not/

https://samsaffron.com/archive/2015/03/31/debugging-memory-leaks-in-ruby

  discourse 的一个工具

https://bearmetal.eu/theden/how-do-i-know-whether-my-rails-app-is-thread-safe-or-not/  

https://blog.codeship.com/debugging-a-memory-leak-on-heroku/

  [重启]https://github.com/schneems/puma_worker_killer#only-turn-on-rolling-restarts

https://github.com/ruby-prof/ruby-prof
  https://gxnotes.com/article/109600.html

https://github.com/archan937/ruby-mass
  http://www.developerq.com/article/1499323174

### puma 的配置及 线程

https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server
  

### 确认内存问题 [Pinyin](https://github.com/janx/ruby-pinyin)

  [已经发现](https://github.com/janx/ruby-pinyin/issues/25)

  但跟要不需要,直接写一个loop 来跑一下,就能看到

  确认是 ruby-pinyin 的问题

  15:10 部署, 1小时后再查看

  换用 gem 'chinese_pinyin'

### Oink

https://github.com/noahd1/oink

bundle exec oink --threshold=1 log/oink.log
---- MEMORY THRESHOLD ----
THRESHOLD: 1 MB

-- SUMMARY --
Worst Requests:
1. Jul 25 19:23:08, 66560 KB, server/users#create
2. Jul 25 15:09:05, 2052 KB, server/users#create
3. Jul 25 15:10:10, 2052 KB, server/users#create
4. Jul 25 16:19:41, 2048 KB, server/users#create
5. Jul 25 16:47:58, 2048 KB, server/users#create
6. Jul 25 16:51:33, 2048 KB, server/users#create
7. Jul 25 17:01:40, 2048 KB, server/users#create
8. Jul 25 17:01:48, 2048 KB, server/users#create
9. Jul 25 18:15:48, 2048 KB, status#index
10. Jul 25 18:15:48, 2048 KB, client/sessions#create

Worst Actions:
16, server/users#create
1, status#index
1, client/sessions#create

Aggregated Totals:
Action                	Max	Mean	Min	Total	Number of requests
server/users#create   	66560	5888	1536	94216	16
status#index          	2048	2048	2048	2048	1
client/sessions#create	2048	2048	2048	2048	1


## TODO

[] https://robots.thoughtbot.com/a-crash-course-in-analyzing-memory-usage-in-ruby