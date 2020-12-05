Elixir lang
-----

### install

brew install elixir

brew upgrade elixir

elixir -v

### sublime

[elixir playground](http://elixirplayground.com/)

elixirSublime 不要装这个SB插件,会把 shift + 左键 改了

### phoenix_live_view

https://github.com/phoenixframework/phoenix_live_view

### ejabberd

[编译](https://docs.ejabberd.im/developer/extending-ejabberd/elixir/)

https://blog.process-one.net/elixir-sips-ejabberd-with-elixir-part-1/

https://blog.process-one.net/ejabberd-joins-the-elixir-revolution/

### 教程

https://www.amberbit.com/blog/2017/7/27/how-learning-elixir-made-me-better-ruby-developer/

[OOP](http://mikepackdev.com/blog_posts/45-object-orientation-in-ruby-and-elixir)

https://robots.thoughtbot.com/elixir-for-rubyists

https://startlearningelixir.com/elixir-for-rubyists

https://github.com/elixir-lang-china/elixir_guide_cn/

https://github.com/elixir-lang-china/elixir_style_guide

[book](https://github.com/elixir-lang-china/etudes-for-elixir)  企业级应用

http://fredwu.me/post/147855522498/i-accidentally-some-machine-learning-my-story-of 学习路径,不错

### tools

[emacs](https://github.com/tonini/alchemist.el)

https://github.com/slashmili/alchemist.vim/wiki

### phoenix

http://www.phoenixframework.org

#### install

  http://www.phoenixframework.org/docs/installation

  mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

  Plug, Cowboy, and Ecto


#### quick start

  pg

  mix phoenix.new -v

  mix phoenix.new hello_phoenix

  We are all set! Run your Phoenix application:

      $ cd hello_phoenix
      $ mix phoenix.server

  You can also run your app inside IEx (Interactive Elixir) as:

      $ iex -S mix phoenix.server

  Before moving on, configure your database in config/dev.exs and run:

      $ mix ecto.create

  http://www.phoenixframework.org/docs/using-mysql

  mix phoenix.new hello_phoenix --database mysql

  mix ecto.create # db create
  mix ecto.migrate

  mix phoenix.server

### channel 

[vs rails cable](https://dockyard.com/blog/2016/08/09/phoenix-channels-vs-rails-action-cable)

http://www.phoenixframework.org/docs/channels

https://www.mongodb.com/blog/post/pubsub-with-mongodb

http://redisbook.readthedocs.io/en/latest/feature/pubsub.html

[Phoenix官方教程 (九) Channel](https://my.oschina.net/ljzn/blog/734329)


[通道.md](https://github.com/mydearxym/phoenix-doc-in-chinese/blob/master/G_%E9%80%9A%E9%81%93.md)


[Phoenix Channel 入门](http://elixir-cn.com/posts/23)

https://www.viget.com/articles/websockets-with-elixir-how-to-sync-multiple-clients

```elixir
mix phoenix.gen.channel Room
* creating web/channels/room_channel.ex
* creating test/channels/room_channel_test.exs

Add the channel to your `web/channels/user_socket.ex` handler, for example:

    channel "room:lobby", HelloPhoenix.RoomChannel

```

https://rails.guide/book/action_cable_overview.html

redis pub sub

http://blog.sina.com.cn/s/blog_6262a50e0100yi05.html

http://blog.leanote.com/post/yoanaky/Redis%E5%81%9Apub-sub%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%BB%8B%E7%BB%8D

golang  p/s

https://gist.github.com/jweir/4528042

https://github.com/go-redis/redis

https://hackernoon.com/communicating-go-applications-through-redis-pub-sub-messaging-paradigm-df7317897b13
