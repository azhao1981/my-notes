crystal
-----

install && make :

  curl http://dist.crystal-lang.org/apt/setup.sh | sudo bash
  sudo apt-get install crystal

  brew install crystal-lang

  crystal init lib MyCoolLib
  --cross-compile
  --release
  crystal build your_program.cr --cross-compile --target "x86_64-unknown-linux-gnu"

amethyst:

  curl https://raw.githubusercontent.com/Sdogruyol/amethyst-bin/master/amethyst > ~/dotfiles/bin/amethyst \
  && chmod +x ~/dotfiles/bin/amethyst
  amethyst sample


做一个 websocket 服务为后端
react 为前端的应用框架
前端点一个按钮,后端直接通过 websocket 取得数据

  https://github.com/veelenga/awesome-crystal

常用

  https://github.com/crystal-lang
  https://github.com/crystal-lang/shards
  https://github.com/greyblake/crystal-icr  like Interactive console
  https://github.com/sdogruyol/kemal        Lightning Fast, Super Simple micro web framework
  https://github.com/generate-cr/generate
研究

  https://github.com/mperham/sidekiq.cr
  https://github.com/waterlink/active_record.cr
  https://github.com/stefanwille/crystal-redis
  https://github.com/ysbaddaden/minitest.cr.git Test Unit for the Crystal programming language
  https://github.com/ysbaddaden/artanis Sinatra-like DSL for the Crystal language (abusing macros)
  https://github.com/ysbaddaden/pool Generic (connection) pools for Crystal
  https://github.com/ysbaddaden/frost Full Featured Web Framework 开发版,还不能用
  https://github.com/juanedi/micrate migrate

有用

  https://github.com/akwiatkowski/crystal_api Simple PostgreSQL REST API in Crystal with devise-like auth.
  https://github.com/sdogruyol/ohm-crystal redis 存贮对象

  https://github.com/f/kamber Static site server (basically blogs) with Crystal Language
  https://github.com/lucaong/immutable Thread-safe, persistent, immutable collections
  https://github.com/sdogruyol/fast-http-server Super fast, zero configuration command line HTTP Server
  https://github.com/sdogruyol/cryload HTTP benchmarking tool written in Crystal
  https://github.com/f/guardian guardian files

  https://github.com/ysbaddaden/selenium-webdriver-crystal Selenium Webdriver client for the Crystal programming language
  https://github.com/ysbaddaden/prax.cr Rack proxy server for development (Crystal port) ``*.dev到开发``
  https://github.com/ysbaddaden/scrypt-crystal Crystal bindings for Colin Percival's scrypt key derivation function
  https://github.com/ysbaddaden/crystal-pg a postgres driver for crystal
  https://github.com/jtomschroeder/crystalline a collection of containers & algorithms

does not work yield

  https://github.com/0x73/hoop Building native OSX apps. do't work
  https://github.com/Codcore/amethyst Amethyst is a Rails inspired web-framework for Crystal language http://codcore.github.io/amethyst/

ruby:

  https://github.com/ysbaddaden/ruby-cookbook

js:

  https://github.com/ysbaddaden/minitest-js

try:

  https://github.com/Compass/compass
  为 crystal 提供 socket.io
  https://github.com/socketio/socket.io/
    http://www.infoq.com/cn/news/2015/01/socket-io-websocket
    http://blog.csdn.net/fjslovejhl/article/details/12558349 中文讲原理
