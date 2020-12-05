# tips

## 手册

### rails应用模板

[Rails 应用模板](https://ruby-china.github.io/rails-guides/rails_application_templates.html)

https://guides.rubyonrails.org/rails_application_templates.html

 thoughtbot.
https://github.com/thoughtbot/suspenders

https://github.com/railsapps/rails_apps_composer

### 验证码

https://github.com/ambethia/recaptcha

### JIT for 2.6

https://medium.com/@k0kubun/ruby-2-6-jit-progress-and-future-84e0a830ecbf

https://gist.github.com/k0kubun/7a1145f8391fbc3c076052d6f40d9e8e

RUBYOPT="--jit" rails s

https://www.youtube.com/watch?v=3fidwhVjuhs

### generaters

https://guides.rubyonrails.org/generators.html

### test

#### unit test

[rspec](https://blog.redpanthers.co/made-rspec-test-suite-run-2x-faster)

[build-your-own-rspec DSL](http://pdabrowski.com/blog/ruby-on-rails/testing/build-your-own-rspec/)

[speed](https://goiabada.blog/improving-spec-speed-in-a-huge-old-rails-app-8f3ab05a33f9)

[tips](https://blog.daftcode.pl/how-we-made-writing-tests-fun-and-easy-2d7e1fac6d16)

    https://www.monterail.com/blog/actionable-tips-to-improve-web-performance-with-rails

Ruby 10 个 Ruby 技巧提升你的代码
https://ruby-china.org/topics/24903

[debugging-why-your-specs-have-slowed-down](https://robots.thoughtbot.com/debugging-why-your-specs-have-slowed-down)

https://github.com/DatabaseCleaner/database_cleaner
https://github.com/jvillarejo/embedded

#### cops: 在 rspec 里不使用常量定义

https://rubocop-rspec.readthedocs.io/en/latest/cops_rspec/#rspecleakyconstantdeclaration

原因: https://fili.pp.ru/leaky-constants.html

#### already initialized constant
warning: already initialized constant RunnerTask::DEFAULT_BATCH_SIZE

这是因为比如在rails里已经require了lib/下的东西,如果再在别的代码里 require 'runner_task' 就会有问题

#### 2.6 jit

```bash
ruby --jit test.rb
ruby --jit-verbose=1 test.rb

RUBYOPT="--jit" rails server
RUBYOPT="--jit-verbose=1" rails server

RUBYOPT="--jit" sidekiq
```

#### version　比较

```ruby
Gem::Version.new(RUBY_VERSION) > Gem::Version.new('2.6.6.pre1')
```
很明显,Gem::Version更好些
https://code.dblock.org/2020/07/16/comparing-version-numbers-in-ruby.html
https://github.com/bkuhlmann/versionaire

#### rack-attack

[rack acttack](https://blog.bigbinary.com/2018/05/15/how-to-mitigate-ddos-using-rack-attack.html)

```ruby
Gemfile
gem 'rack-attack'
config/application.rb
module YourAppName
  class Application < Rails::Application
    config.middleware.use Rack::Attack
  end
end
config/initializers/rack_attack.rb
class Rack::Attack
  Rack::Attack.throttle("users/sign_up", limit: 3, period: 15.minutes) do |req|
     # Using “vanilla” devise inside a User model
    req.ip if req.path == "/users" && req.post?
  end
end if Rails.env.production?

```
#### factory_girl

[GETTING_STARTED](http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md)

[Rails 中使用 Factory Girl 生成测试数据](http://ju.outofmemory.cn/entry/98578)


[Taming Rails memory bloat](http://www.mikeperham.com/2018/04/25/taming-rails-memory-bloat/)

http://semaphoreci.com/blog/2017/08/03/tips-on-treating-flakiness-in-your-test-suite.html

https://evilmartians.com/chronicles/factories-or-fixtures

[BDD](https://semaphoreci.com/community/tutorials/setting-up-a-bdd-stack-on-a-rails-5-application)

[test prof](https://evilmartians.com/chronicles/testprof-2-factory-therapy-for-your-ruby-tests-rspec-minitest)

### book

[揭开rails面纱](https://launchschool.com/books/demystifying_rails/read/introduction)

[rails目录详解](https://github.com/jwipeout/rails-directory-structure-guide)

### 设计模式

[模板](https://medium.com/@joshsaintjacque/the-template-method-pattern-558f3e16879f)

[ruby_one_liners](https://github.com/learnbyexample/Command-line-text-processing/blob/master/ruby_one_liners.md)

[算法](https://blog.codeship.com/using-genetic-algorithms-in-ruby/)

[map-reduce](https://blog.dnsimple.com/2018/05/simple-async-map-reduce-queue-for-ruby/)

### 内存专题/调试

[ruby_mem_leak](/doc/ruby/ruby_mem_leak.md)

[visualizing-your-ruby-heap](http://tenderlovemaking.com/2017/09/27/visualizing-your-ruby-heap.html)

### cap puma 失败

Skipping task 'puma:start'. Capistrano tasks may only be invoked once

/home/webuser/.rbenv/versions/2.4.1/lib/ruby/2.4.0/rubygems.rb:270:in `find_spec_for_exe': can't find gem puma (>= 0.a) (Gem::GemNotFoundException)

这是因为 产生环境把 gem 都装在 shared 中, 必须要自己在 gem install puma 里装一下

### cap指定分支

<https://stackoverflow.com/questions/1524204/using-capistrano-to-deploy-from-different-git-branches>

```bash
BRANCH=your_branch cap deploy
```

### 入门教程

[learning-ruby-from-zero-to-hero](https://medium.freecodecamp.org/learning-ruby-from-zero-to-hero-90ad4eecc82d)

https://github.com/oracle/truffleruby

https://github.com/oracle/truffleruby/issues/1054

https://github.com/oracle/truffleruby/blob/master/doc/user/ruby-managers.md#installing-truffleruby-with-rvm-ruby-build-or-ruby-install

### 视频教程

[On Writing Software Well](https://www.youtube.com/channel/UCUkM9uMpWatT7gVWShgtKFw)

[rubykaigi2017](https://www.youtube.com/playlist?list=PLbFmgWm555yaJalSEHY17E96ChjY-kF2D#rubykaigi2017)
> https://schneems.com/2017/09/27/gaijin-guide-to-rubykaigi/

GORUCO 2017: How to Load 1m Lines of Ruby in 5s by Andrew Metcalf
没看懂
https://www.youtube.com/watch?v=lKMOETQAdzs

### freeze

`# frozen_string_literal: true`

### 配置管理

+ https://www.ruby-toolbox.com/categories/Configuration_Management
+ [Rails 最佳实践之配置管理](https://ruby-china.org/topics/32126)
+ https://github.com/railsconfig/config settings.yml
+ https://github.com/laserlemon/figaro  application.yml
+ https://github.com/rahmal/rconfig
+ https://github.com/bkeepers/dotenv .env
+ https://www.helplib.com/GitHub/article_80987

config/application.rb
config.autoload_paths += Dir["#{config.root}/app/utilities/"]
config.i18n.default_locale = "zh-CN"
config.active_job.queue_adapter = :sidekiq
config.time_zone = 'Beijing'
### key

[secret-key](https://medium.com/@mikeycgto/understanding-the-secret-key-base-in-ruby-on-rails-ce2f6f9968a1)

### [fast_jsonapi](https://github.com/Netflix/fast_jsonapi)

### [ruby timeout 完全手册](https://github.com/ankane/the-ultimate-guide-to-ruby-timeouts)

### tips


#### Make Delegated Methods Private in Rails
```ruby
private *delegate(:first_name, :last_name, to: :@user)
```
```bash
pry> cd UserDecorator
# This pry command puts us within the scope of the UserDecorator class.
pry> delegate :first_name, :last_name, to: :@user
#=> [:first_name, :last_name]
pry> instance_methods
#=> [:full_name, :last_name, :first_name]
pry> private :first_name, :last_name
pry> instance_methods
```
```ruby
# Rails 6+
delegate :first_name, :last_name, to: :@user, private: true
```
#### 2.6 to_h merge

```ruby
#Enumerator
(1..5).to_h { |n| [n, n**2] }
#=> {1=>1, 2=>4, 3=>9, 4=>16, 5=>25}

h1.merge(h2, h3, h4)
```

#### 使用数据库运算代码取数据到内存再让代码运算
```ruby
Loan.minimum(:amount)
Loan.pluck(:amount).min 1017.21x
Loan.maximum(:amount)
Loan.pluck(:amount).max 1113.47x
Loan.sum(:balance)
Loan.sum(&:balance) 209.85x
```
## TODO

### [Replica](https://medium.com/@konole/using-replica-database-with-your-activerecord-models-b2a8ce9ef46)
```ruby
module LeadfeederReplica
  extend ActiveSupport::Concern
  included do |klass|
    database_config = "leadfeeder_read_#{Rails.env}".to_sym
    replica = (klass::Replica = Class.new(klass))
    replica.establish_connection(database_config)
    replica.after_initialize(:readonly!)
  end
end
class Account < ActiveRecord::Base
  include LeadfeederReplica
end
Account::Replica.select(:id).first
```
### [fast-ruby](https://github.com/JuanitoFatas/fast-ruby)

### [sequel](https://bits.citrusbyte.com/building-sql-expressions-with-sequel/)

### https://github.com/ioquatix/covered 代码覆盖,要2.6才能用

### https://github.com/zeisler/visualize_ruby  ruby代码->流程图

### https://blog.eq8.eu/article/rails-api-authentication-with-spa-csrf-tokens.html

### [elixir](http://www.sihui.io/first-impression-of-elixir/)

### truffleruby

https://github.com/rvm/rvm/issues/4297#issuecomment-397908042
rvm get master
rvm install truffleruby

[c extensions](https://github.com/SciRuby/rubex)

### [支付](https://reinteractive.com/posts/357-managing-stripe-subscription-payments-in-rails)

### [http.rb vs rest-client](https://twin.github.io/httprb-is-great/)

### [microservice](https://medium.com/@SergeyChechaev/rails-and-phoenix-microservice-synergy-5433598ab333)

### [last/first](https://andycroll.com/ruby/first-and-last-may-not-mean-what-you-think/)
```ruby
# 当 id 是UUID时会有问题,这样可以解决
class User < ActiveRecord::Base
  scope :by_created, -> { order(created_at: :asc) }
  scope :earliest_created, -> { by_created.first }
  scope :most_recently_created, -> { by_created.last }
  # ...
end

User.most_recently_created
```

### https://itnext.io/trending-open-source-ruby-on-rails-github-repositories-mid-june-2018-6f92515cc645

#### [sharding](https://github.com/drecom/activerecord-turntable)

#### [services](https://github.com/krautcomputing/services)

#### [分页组件](https://github.com/ddnexus/pagy)

#### [simple_form](https://github.com/plataformatec/simple_form)

#### [deep_pluck](https://github.com/khiav223577/deep_pluck)

#### [Attachment](https://github.com/shrinerb/shrine)

#### [role_core](https://github.com/rails-engine/role_core)
  有空看下,应该比我们的那个好

#### [rails_db](https://github.com/igorkasyanchuk/rails_db) 这个不如 mycli 对mysql来说

#### [rubex - A Ruby-like language for writing Ruby C extensions](https://github.com/SciRuby/rubex)

#### [rib](https://github.com/godfat/rib)
#### [komponent](https://github.com/komposable/komponent)
#### [validates_timeliness](https://github.com/adzap/validates_timeliness)

### [数据与代码分开](https://medium.com/root-engineering/separating-data-and-code-in-rails-architecture-3a031e17706b)

### [testing vs](https://mixandgo.com/blog/feature-tests-vs-integration-tests-vs-unit-tests-in-ruby-and-rails)

### [sentry](https://github.com/getsentry/raven-ruby)

### [特殊字符 htmlentities](https://stackoverflow.com/questions/1600526/how-do-i-encode-decode-html-entities-in-ruby/5210999#5210999)
gem 'htmlentities'
HTMLEntities.new.decode "&iexcl;I&#39;m highly&nbsp;annoyed with character references!"

### [free ci](https://depfu.com/how-it-works)

### [vuejs coffeescript](https://blog.codeship.com/vuejs-components-with-coffeescript-for-rails)

### [vue-js-slots](https://gorails.com/episodes/vue-js-slots)

### [vue-data-table](https://medium.com/rubydesign/a-vue-data-table-for-rails-6b692b21e83e)

### [运维](https://semaphoreci.com/community/tutorials/how-to-deploy-rails-applications-with-ansible-capistrano-and-semaphore)

### [nginx unit](https://www.speedshop.co/2018/03/28/nginx-unit-for-ruby.html)

### [I18n数据库化](https://github.com/globalize/globalize)

### [I18n数据库化](https://dejimata.com/2018/3/20/jsonify-your-ruby-translations)

### [关联touch](https://karolgalanciak.com/blog/2018/02/25/rails-quick-tips-temporarily-disabling-touching-with-activerecord-dot-no-touching/?utm_source=rubyweekly&utm_medium=email)

### [优化](https://pawelurbanek.com/2018/02/05/optimize-rails-performance-bottleneck-with-caching-and-rack-middleware)

### 时间问题

#### [保存毫秒ActiveRecord: Store Milliseconds (or Microseconds) in Timestamps/Datetimes with Rails / MySQL](https://gist.github.com/azhao1981/ef62b53dad3058bbe5f1ca097bb9e319)

#### [新版本](https://gist.github.com/azhao1981/49ccdf3e8bee8eb75942e78e5ad55712)

#### [json时的时间格式](https://stackoverflow.com/questions/6976650/rails-always-include-the-milliseconds-with-created-at-for-every-model)

### [yield_self](https://robots.thoughtbot.com/using-yieldself-for-composable-activerecord-relations)

### [GUI](https://saveriomiroddi.github.io/An-overview-of-ruby-gui-development-in-2018/)

### [ruby profiler](https://github.com/rbspy/rbspy)

### [methods](https://www.engineyard.com/blog/five-ruby-methods-you-should-be-using)

### [gems10top](https://medium.freecodecamp.org/10-all-time-most-downloaded-ruby-gems-42b54e6cdf6f)

https://github.com/intridea/multi_json

### [CMS](https://github.com/comfy/comfortable-mexican-sofa)

### [http debug](https://github.com/aderyabin/sniffer)

[ruby with rust](https://blog.codeship.com/improving-ruby-performance-with-rust/)

[cookie session](https://perlkour.pl/2017/11/ruby-cookie-corruption/)

[faktory](http://www.mikeperham.com/2017/11/13/getting-started-with-faktory)

### [resque](https://github.com/resque/resque)

<https://stackshare.io/stackups/delayed_job-vs-resque-vs-sidekiq>

<https://stackoverflow.com/questions/4808351/delayed-jobs-vs-resque-vs-beanstalkd>

进程 sidekiq

[优化](https://hspazio.github.io/2017/worker-pool/)

### [并发](https://vaneyckt.io/posts/ruby_concurrency_building_a_timeout_queue/?utm_source=rubyweekly&utm_medium=email)

<https://www.codeotaku.com/journal/2020-04/ruby-concurrency-final-report/index>

### [spreadsheet](http://blog.arkency.com/a-word-about-spreadsheet-architect)

### [yield_self](http://mlomnicki.com/yield-self-in-ruby-25/)

```ruby
class Object
  def yield_self
    yield(self)
  end
end
```

### [一个事故](https://www.schneems.com/2017/08/30/how-i-lost-17000-github-auth-tokens-in-one-night/)

### [ajax](https://m.patrikonrails.com/how-to-make-ajax-calls-the-rails-way-20174715d176)

### [build](https://github.com/brunofacca/zen-rails-base-app)

### [Hash哪些事](https://kate.io/blog/strange-hash-instances-in-ruby/)

### [Hash#fetch](https://robots.thoughtbot.com/using-hashes-to-bring-back-the-dinosaurs)

### [Array](http://rubyblog.pro/2017/09/couple-words-on-arrays)

### [log4r](http://blog.mmlac.com/log4r-for-rails/)

### [try哪些事](https://karolgalanciak.com/blog/2017/09/24/do-or-do-not-there-is-no-try-object-number-try-considered-harmful/?utm_source=rubyweekly&utm_medium=email)

### [routing](http://blog.arkency.com/all-the-ways-to-generate-routing-paths-in-rails/)

### [AI](https://www.practicalai.io/teaching-ai-play-simple-game-using-q-learning/)

### [AI](https://www.practicalai.io/teaching-a-neural-network-to-play-a-game-with-q-learning/)

### [并发](https://engineering.universe.com/introduction-to-concurrency-models-with-ruby-part-ii-c39c7e612bed)

### [导出](https://infinum.co/the-capsized-eight/superfast-csv-imports-using-postgresqls-copy)

### [pm](https://github.com/Codeminer42/cm42-central)

### [aasm](https://www.nopio.com/blog/ruby-state-machine-aasm-tutorial)

### [system_tester](https://github.com/rlafranchi/system_tester)

### [fabrication](https://ksylvest.com/posts/2017-08-12/fabrication-vs-factorygirl)

### [xss](https://brakemanpro.com/2017/09/08/cross-site-scripting-in-rails)

### [BD事务例子](https://brandur.org/http-transactions#concurrency-protection)

### [记录更新](https://revs.runtime-revolution.com/the-battle-for-auditing-and-versioning-in-rails-audited-vs-paper-trail-17ad0011ecd9)

### [rails-generators](https://www.driftingruby.com/episodes/creating-custom-ruby-on-rails-generators)

  https://www.driftingruby.com/episodes/datatables

### [信号量](https://www.exceptionalcreatures.com/bestiary/SignalException.html)

### [权限控制](https://github.com/palkan/action_policy)

### [位移计算](https://medium.com/@farsi_mehdi/ruby-bitwise-operators-da57763fa368)

### [react](https://blog.shakacode.com/front-end-sadness-to-happiness-the-react-on-rails-story-at-goruco-2017-d63b8fd26ca4)

<https://blog.botreetechnologies.com/how-to-add-react-js-to-your-ruby-on-rails-app-with-webpacker-330d619d11ec>

### [api+react](https://blog.heroku.com/a-rock-solid-modern-web-stack)

[api-client没怎么看懂](https://medium.com/rubyinside/building-a-creative-fun-a-in-ruby-a-builder-pattern-variation-f50613abd4c3)

### [jwt](https://medium.com/devtechtipstricks/build-a-simple-rails-api-server-auth0-jwt-authentication-react-from-scratch-in-30-minutes-or-257cbb2a939a)

### [ruby2js](http://ruby-hyperloop.io/) [gem](https://github.com/ruby-hyperloop/hyper-react)

### [react + rails](https://learnetto.com/users/hrishio/courses/the-complete-react-on-rails-5-course?couponcode=RW60)

### [jwt](https://medium.com/devtechtipstricks/build-a-simple-rails-api-server-auth0-jwt-authentication-react-from-scratch-in-30-minutes-or-257cbb2a939a)

### [jwt_sessions](https://github.com/tuwukee/jwt_sessions)

### [测试rails+ember](https://blog.rubyroidlabs.com/2017/03/smoke-rails-ember/)

### [jit](https://blog.heroku.com/ruby-mjit)

### [nginx unit](https://www.nginx.com/blog/nginx-unit-1-0-released/)
<https://www.nginx.com/products/nginx-unit/>

### [test helpful](http://docs.knapsackpro.com/2017/when-distributed-locks-might-be-helpful-in-ruby-on-rails-application)

### [jemalloc](https://docs.google.com/presentation/d/1-WrYwz-QnSI9yeRZfCCgUno-KOMuggiGHlmOETXZy9c/edit#slide=id.g3ae8351607_1_242)
- <https://github.com/noahgibbs/env_mem>
- <https://github.com/noahgibbs/rails_ruby_bench>
- <https://bubblin.io/blog/jemalloc>

```ruby
GC.start # major
GC.start(full_mark: false) # minor
Destructive(破坏的) operations like gsub! and concat can save CPU and memory.
gem  'env_mem'

# Configure the Ruby source directly
./configure --with-jemalloc
# Or use rvm instead
rvm install 2.5.0 -C --with-jemalloc
# Or rbenv / ruby-build
RUBY_CONFIGURE_OPTS="--with-jemalloc" rbenv install 2.5.0

# mac:
# brew install jemallochttps://stackoverflow.com/questions/57303214/how-to-check-ruby-2-6-3-is-using-jemalloc-i-installed-ruby-2-6-3-as-rvm-inst

To check that your installation of Ruby is using jemalloc, run the following command:

$ ruby -r rbconfig -e "puts RbConfig::CONFIG['LIBS']"
 -lpthread -ljemalloc -lgmp -ldl -lcrypt -lm  # Output

# 2.6.3
# https://stackoverflow.com/questions/57303214/how-to-check-ruby-2-6-3-is-using-jemalloc-i-installed-ruby-2-6-3-as-rvm-inst
 ruby -r rbconfig -e "puts RbConfig::CONFIG['MAINLIBS']"

 sudo apt-get install libjemalloc-dev
 rvm install 2.6.3 -C --with-jemalloc
 rvm reinstall 2.6.3 -C --with-jemalloc
```

其它:
fullstaq-ruby
<https://dev.to/evilmartians/fullstaq-ruby-first-impressions-and-how-to-migrate-your-docker-kubernetes-ruby-apps-today-4fm7>

### [kafka](A simple framework for writing Kafka consumers in Ruby)

https://medium.com/@maciejmensfeld/karafka-ruby-kafka-framework-1-0-0-release-notes-1b0933d47e88

https://github.com/zendesk/racecar

### [Brakeman](https://documentation.codeship.com/general/integrations/brakeman-pro/?utm_source=BrakemanIntegration)

### <https://github.com/nim-lang/Nim> <http://www.bootstrap.me.uk/bootstrapped-blog/nim-for-the-discerning-rubyist>

### [加速](https://gorails.com/episodes/bootsnap)

<https://github.com/Shopify/bootsnap>

### [kafka](https://medium.com/zendesk-engineering/say-hi-to-delivery-boy-f32ef0724f8b)

### [captchas破解](https://medium.com/@Arafat./solving-captchas-with-tensorflow-and-ruby-bc704c6ab92c)

### [加密](https://www.driftingruby.com/episodes/encrypted-credentials-in-rails-5-2?utm_source=rubyweekly&utm_medium=email)

### [next logger](https://github.com/rocketjob/semantic_logger)

### [可执行](https://github.com/pmq20/enclose-io)

### [并发](https://vaneyckt.io/posts/ruby_concurrency_in_praise_of_condition_variables/)

### [hacker news clone](https://github.com/jcs/lobsters)

### [常见的delayjob](https://www.eliotsykes.com/real-world-rails-background-jobs)


### [render_async](https://github.com/renderedtext/render_async)

### [background-workers-using-crontab](https://blog.redpanthers.co/background-workers-using-crontab)

### [当前属性,应该是我想要的](https://github.com/coup-mobility/activesupport-current_attributes)

### [json in db](https://www.driftingruby.com/episodes/virtual-columns-with-json-data-types)

### [obj2json](https://github.com/nesaulov/surrealist)

> <https://medium.com/@billikota/introducing-surrealist-a-gem-to-serialize-ruby-objects-according-to-a-defined-schema-6ca7e550628d>

[json patch](https://formapi.io/blog/posts/json-patch-with-rails-5-and-react)

### [gemfile.lock](https://makandracards.com/makandra/13885-how-to-update-a-single-gem-conservatively)

  [video](https://www.brownwebdesign.com/blog/bundle-update)

### [dep k8](http://blog.bigbinary.com/2017/07/25/deploying-rails-applications-using-kubernetes-with-zero-downtime.html)

### [函数拆分experiment](https://rubyclarity.com/2017/07/is-it-always-a-good-idea-to-split-long-methods-into-smaller-ones-an-experiment/)

### [review](http://blog.planetargon.com/entries/ruby-on-rails-code-audits-8-steps-to-review-your-app)

### [5.2内建上传模块](http://www.akitaonrails.com/2017/07/07/upcoming-built-in-upload-solution-for-rails-5-2-activestorage)

### [Rails 5.2 Active Storage: Previews, Poppler, and Solving Licensing Pitfalls](https://blog.heroku.com/rails-active-storage)

### [Active Storage](https://gorails.com/episodes/direct-uploads-with-rails-active-storage)

### [加速 test ](https://jtway.co/speed-up-your-rails-test-suite-by-6-in-1-line-13fedb869ec4)

### [cvs](https://shift.infinite.red/fast-csv-report-generation-with-postgres-in-rails-d444d9b915ab)

### [online store](https://hackernoon.com/the-11-minute-guide-to-building-and-launching-an-online-store-with-rails-stripe-checkout-and-206d6faec6d8)

### [性能](https://www.speedshop.co/2017/07/11/is-ruby-too-slow-for-web-scale.html)

### [influxdb](http://blog.arkency.com/2017/07/using-influxdb-with-ruby)

### [避免继承](http://mjk.space/how-to-avoid-inheritance-in-ruby/)

### [安全检查](https://philna.sh/blog/2017/07/12/two-tests-you-should-run-against-your-ruby-project-now/)



### [安全](https://blog.codeship.com/4-ways-to-secure-your-authentication-system-in-rails/)

### [shell](http://benoithamelin.tumblr.com/ruby1line/)

### [test practice](https://m.patrikonrails.com/how-i-test-my-rails-applications-cf150e347a6b)

### [test driven rspec](https://www.youtube.com/playlist?list=PLr442xinba86s9cCWxoIH_xq5UE9Wwo4Z#tdrspec)

### [test-prof](https://evilmartians.com/chronicles/testprof-a-good-doctor-for-slow-ruby-tests) 
https://github.com/palkan/test-prof

### [gem](https://dev.to/rob__race/27-gems-i-use-in-almost-every-project)

### [chrome test](https://drivy.engineering/running-capybara-headless-chrome/)

### [数据库优化](https://distillery.com/blog/making-a-rails-app-move-faster-a-tale-of-lessons-learned/)

### [全局变量的一个bug](http://ryanbigg.com/2017/06/current-considered-harmful)

### [读写分离GEM](https://labs.contactually.com/adding-read-replicas-in-a-production-ruby-on-rails-system-with-zero-downtime-using-makara-be1d004654b0)

<https://github.com/taskrabbit/makara>

### [render_sync](https://github.com/renderedtext/render_async)

https://semaphoreci.com/blog/2017/06/08/speeding-up-rails-pages-with-render-async.html

### [ruby bi](http://blog.arkency.com/2017/06/acceptance-testing-ruby-using-actors-personas)

### [bundle tip](https://philna.sh/blog/2017/06/12/speed-up-bundle-install-with-this-one-trick)

```bash
bundle install --jobs=4
bundle config --global jobs 4
time bundle install --path=./gems --quiet --force --jobs=1
real  4m39.836s
user  1m59.692s
sys 0m50.291s
time bundle install --path=./gems --quiet --force --jobs=4
real  2m55.857s
user  2m0.005s
sys 0m47.897s
```

### [utf8mb4](https://blog.fntsr.tw/articles/2016/02/21/mysql-utf8mb4-breaks-qctiverecord-schema-setup/)

http://blog.arkency.com/2015/05/how-to-store-emoji-in-a-rails-app-with-a-mysql-database/

### [test tip](http://blog.arkency.com/2017/06/acceptance-testing-ruby-using-actors-personas)

### [test fast](https://medium.com/appaloosa-store-engineering/tips-to-improve-speed-of-your-test-suite-8418b485205c)

### [cookie](http://blog.arkency.com/2017/06/testing-cookies-in-rails)

### [thread](https://blog.redpanthers.co/managing-threads-queue-sizedqueue)

### [DSL](https://www.toptal.com/ruby/ruby-dsl-metaprogramming-guide)

### [DSL](https://github.com/jannishuebl/orchparty)

### [traefik for dev](https://jc00ke.com/2017/05/30/replacing-nginx-with-traefik-for-local-development)

### Replace therubyracer with mini_racer

ruby 依赖的v8版老,需要更新

https://github.com/rails/rails/pull/29285

### [interview](https://github.com/MaximAbramchuck/awesome-interview-questions#ruby-on-rails)

### mem leak

https://blog.evanweaver.com/2008/02/05/valgrind-and-ruby/

### [global-autocomplete-search](https://gorails.com/episodes/global-autocomplete-search)

### [redis监控](https://github.com/BaseSecrete/redis_dashboard)


### [rack websocket](https://bowild.wordpress.com/2018/05/01/rubys-rack-push-decoupling-the-real-time-web-application-from-the-web/)

### [项目管理](https://github.com/opf/openproject)

### [19-ruby-on-rails-gems](https://blog.rubyroidlabs.com/2017/04/19-ruby-on-rails-gems/)

+ https://github.com/activerecord-hackery/ransack
+ https://github.com/flyerhzm/bullet N+1
+ https://github.com/dkubb/ice_nine
+ https://github.com/chrisalley/pundit-matchers
+ https://github.com/travisjeffery/timecop 用于测试,时光机
+ https://github.com/Netflix/fast_jsonapi


### https://chrisherring.co/posts/testing-a-feature-with-rails-and-rspec-a-deep-dive

### http://schneems.com/2017/05/17/ruby-backend-performance-getting-started-guide/
  https://github.com/flyerhzm/bullet
  https://github.com/MiniProfiler/rack-mini-profiler

### https://leanpub.com/developing-games-with-ruby/read?utm_source=rubyweekly&utm_medium=email

### https://github.com/vcr/vcr

### Decorator 模式
https://robots.thoughtbot.com/decorating-activerecord
https://robots.thoughtbot.com/evaluating-alternative-decorator-implementations-in

### [.railsrc](http://pixelatedworks.com/articles/configuring_new_rails_projects_with_railsrc_and_templates)
### [视频](https://www.driftingruby.com/episodes)
### [ruby开发常用](https://www.sitepoint.com/tools-for-a-modern-ruby-development-setup/)
几个有用的工具:
[Tmux](/doc/linux/tmux.md)
Fish/[gitsome](https://github.com/donnemartin/gitsome)
Vim
  Ruby Specific Plugins
Guard
Pry
[Pgcli](http://pgcli.com/)/[mycli](http://mycli.net/)
Mutt
Irssi

### [vimbyrb](https://subvisual.co/blog/posts/139-how-to-program-vim-using-ruby/)

### [py](https://www.schneems.com/2017/10/02/lifelong-rubyist-makes-some-python-code-5x-faster/)

### [数据结构](https://www.nasseri.io/posts/1.html)

### [index](https://medium.com/@igorkhomenko/rails-make-sure-you-have-proper-db-indexes-for-your-models-unique-validations-ffd0364df26f)

### [常见index](https://semaphoreci.com/blog/2017/05/09/faster-rails-is-your-database-properly-indexed.html?utm_source=rubyweekly&utm_medium=email)

### [vue.js+ turbolink](https://gorails.com/episodes/how-to-use-vuejs-and-turbolinks-together)

<https://paweljw.github.io/2017/07/rails-5.1-api-with-vue.js-frontend-part-4-authentication-and-authorization/>

<https://www.classandobjects.com/tutorial/using_vue_js_with_rails/>

<https://blog.codeship.com/vuejs-as-a-frontend-for-rails/>

### [elm](https://blog.redpanthers.co/integrating-elm-rails)

### [test tip](https://semaphoreci.com/community/tutorials/5-tips-for-more-effective-capybara-tests)

### [api version](https://chriskottom.com/blog/2017/04/versioning-a-rails-api/)

### [graphql]API改进 facebook和github开始使用

[中文文档](http://graphql.cn/)
[阻碍你使用 GraphQL 的十个问题](http://jerryzou.com/posts/10-questions-about-graphql/)

[graphql in github](http://githubengineering.com/the-github-graphql-api/)
  <https://github.com/rmosolgo/graphql-ruby>
  <https://github.com/Shopify/graphql-batch>
  <https://github.com/github/graphql-client>
  <https://github.com/github/github-graphql-rails-example>
  <https://graphql.org>
  <https://github.com/exAspArk/graphql-guard>
  <https://github.com/lucas-aragno/sinatra-graphql>
  https://medium.com/@UnicornAgency/you-should-be-using-graphql-a-ruby-introduction-9b1de3b001dd

[how-to-implement-a-graphql-api-in-rails](https://blog.codeship.com/how-to-implement-a-graphql-api-in-rails)

[using-graphql-with-rails](https://vitobotta.com/2018/06/13/using-graphql-with-rails/)

### [unicorn 超时记录](http://underthehood.meltwater.com/blog/2014/03/21/debugging-unicorn-rails-timeouts/)

http://guides.rubyonrails.org/rails_on_rack.html
https://github.com/kzk/unicorn-worker-killer

### [rails engine](https://www.driftingruby.com/episodes/rails-engines)

### [写GEM](https://blog.faodailtechnology.com/step-by-step-guide-to-publish-your-first-ruby-gem-bae3291aeab4)

### [Creating a Basic Gem](https://www.driftingruby.com/episodes/creating-a-basic-gem)

### [Gradual Typing for Ruby](https://github.com/soutaro/steep)

### [controller/model优化](https://www.rubytapas.com/2017/04/11/skinny-controller-domain-model-events/)

另外的

https://ecommerceonrails.com/2017/04/13/an-alternate-approach-to-avdis-method-of-slimming-down-rails-controllers/?utm_source=rubyweekly&utm_medium=email

### [内存优化](https://www.levups.com/en/blog/2017/optimize_ruby_memory_usage_jemalloc_heroku_scalingo.html)

[reducing-sidekiq-memory-usage-with-jemalloc](https://brandonhilkert.com/blog/reducing-sidekiq-memory-usage-with-jemalloc)

### [rom代码分析](https://blog.mikecordell.com/2017/03/12/reading-ruby-code-rom-exploration.html)
### [ActiveRecord dup](http://blog.arkency.com/2017/03/prototypes-in-ruby)
```ruby
# 快速复制一条记录
u = User.last.dup
u.id #=> nil
u.xx = b
u.save
```
### [Simple and Awesome Database Tricks](https://www.youtube.com/watch?v=N08NHsyaoKM)
	RubyConf AU 2017 - Simple and Awesome Database Tricks, By Barrett Clark

### [8 Useful gem](http://blog.planetargon.com/entries/8-useful-ruby-on-rails-gems-we-couldnt-live-without)
	8 Useful Ruby on Rails Gems We Couldn't Live Without
	Pundit – User Authorization
	WebPacker – Javascript Management
[using-webpack-in-rails-with-webpacker-gem](https://gorails.com/episodes/using-webpack-in-rails-with-webpacker-gem)
	Smarter CSV – CSV Import
	Bundler – Audit
	Rails ERD
	Chartkick
	Annotate
[还上面的胖子](https://gorails.com/episodes/using-vuejs-for-nested-forms-part-1)

[charts](https://github.com/pacuna/frappe_charts)

[dockrails](https://github.com/gmontard/dockrails)

### [TDD问题](http://blog.cleancoder.com/uncle-bob/2017/03/03/TDD-Harms-Architecture.html)

### [exception-track](https://ruby-china.org/topics/32325) ExceptionTrack - 捕捉 Rails 应用运行期的异常，并存储到数据库


### [几个有问题的gem](https://blog.rubyroidlabs.com/2017/02/trouble-ruby-gems)
[turbolinks](https://sevos.io/2017/02/27/turbolinks-lifecycle-explained.html)
### https://www.driftingruby.com/episodes/ruby-on-rails-5-1-0-changes-and-new-features
### [Introducing Webpacker](https://medium.com/statuscode/introducing-webpacker-7136d66cddfb#.x83vsiwoe)

### [携程呼叫中心](https://mp.weixin.qq.com/s?__biz=MzA4Nzg5Nzc5OA==&mid=2651663232&idx=1&sn=164d4643eeaccaeccd4001a0092c85f0&chksm=8bcbe829bcbc613f45ae3192c4a92c4327f615fdc1be45be30c5a7a0bef1ace8cc65d2488db3&mpshare=1&scene=2&srcid=1205BTy1oApI4M53zumhts3c&key=bc2868543c080f44f3da843ad73a6564c68c1d66165c25cbc19484877d50092f4215dab5c16de93309035be7c5595b1d1242006798757e2824425874112ce939330ef13387814b53b985e10693037ea8&ascene=0&uin=OTIwMTgxNDIw&devicetype=iMac+MacBookPro12%2C1+OSX+OSX+10.12.2+build(16C67)&version=12010310&nettype=WIFI&fontScale=100&pass_ticket=hIyM3eP6rtXnoxVfY1VcvENa1JpqkZibfxq1fk3Rt2QwYyWEfB8HcATsJ3Z9bZ2Y)

### [pdf](https://dev.to/strzibny/i-just-released-invoiceprinter-2-0-5da0)
### [pdf2](https://github.com/mileszs/wicked_pdf)

### [large-data](https://blog.codeship.com/deduplicating-large-data-rails/)

### [pwned](https://github.com/philnash/pwned)

### [encrypted](https://www.engineyard.com/blog/encrypted-rails-secrets-on-rails-5.1)

### [多态](https://semaphoreci.com/blog/2017/08/16/polymorphic-associations-in-rails.html)

### [builder](https://medium.com/kkempin/builder-design-pattern-in-ruby-dfa2d557ff1b)

### [Ruby设计模式](https://github.com/davidgf/design-patterns-in-ruby)

### [facade](https://medium.com/kkempin/facade-design-pattern-in-ruby-on-rails-710aa88326f)

### [command](https://drivy.engineering/code_simplicity_command_pattern)

### [Proxy](https://dev.to/redfred7/the-proxy-pattern-revisited--38b4)

### [bot](https://www.youtube.com/watch?v=wgWR6N5PfHQ)

### [Awesome NLP with Ruby](http://rubynlp.org)



### [oss](https://github.com/adamcooke/staytus)

### [算法技巧fizzbuzz](http://www.rubypigeon.com/posts/fizzbuzz-in-too-much-detail/)

### [CHANGELOG](http://keepachangelog.com/zh-CN/0.3.0/)

+ 标明日期（'YYYY-MM-DD'）
+ 标明分类
  + 'Added' 添加的新功能
  + 'Changed' 功能变更
  + 'Deprecated' 不建议使用，未来会删掉
  + 'Removed' 之前不建议使用的功能，这次真的删掉了
  + 'Fixed' 改的bug
  + 'Security' 改的有关安全相关bug

### [worker优化](https://blog.codeship.com/improving-rails-performance-better-background-jobs/)

+ find_in_batches
+ pluck + each
+ GC.start

### [record内存优化](https://github.com/Paxa/light_record)

### [gem check检查表](http://gemcheck.evilmartians.io/)

api设计:
[] Reduce boilerplate(减少模板) as much as possible
[] Do not sacrifice flexibility(不能牺牲伸缩性)
[] Use sensible defaults(预设行为)
[] Follow the Principle of least astonishment(最少意外原则)
[] Use keyword arguments if you really need more than N arguments(参数很多需要用Hash[:key])
[] Raise meaningful errors (管理错误)
[] Monkey-patch reasonably (适度)
[] Encourage developers to avoid dangerous behavior(鼓励)

代码:
[] Write code in style
[]Cover code with tests

架构
[] Adapterize third-party dependencies
[] Keep extensibility(扩展) in mind
[] Provide logging functionality (when necessary)
[] Make code testable
[] Make configuration flexible
[] Manage runtime dependencies carefully
[] Provide interoperability (if it is possible)

文档
[] Provide at least one form of documentation
[] Provide examples for both simple and complex scenarios
[] Show the current state of the project
[] Use semantic versioning
[] Keep a changelog
[] Provide upgrade notes

https://www.ombulabs.com/blog/rails/upgrades/upgrade-rails-from-4-1-to-4-2.html?utm_source=rubyweekly&utm_medium=email

### [使用api json + ember](https://emberigniter.com/modern-bridge-ember-and-rails-5-with-json-api)

### [大公司是怎么发布静态资源的](https://segmentfault.com/a/1190000007122250)

### [机器学习实战，使用朴素贝叶斯来做情感分析](https://segmentfault.com/a/1190000007109901)

应该就是要找的似相似算法

### [programming-blockchains-step-by-step](https://github.com/openblockchains/programming-blockchains-step-by-step)

### [A command line interface for smithing new Ruby gems](https://github.com/bkuhlmann/gemsmith)

### [activerecord-tricks](https://www.driftingruby.com/episodes/activerecord-tricks)

### [rails用例](https://www.engineyard.com/blog/these-5-examples-continue-to-prove-the-value-of-ruby-on-rails)

### [ruby内存分配](https://brandur.org/ruby-memory#slabs-and-slots)

### [tcmalloc](http://www.rubyguides.com/2018/04/ruby-tcmalloc-profiling/) | <https://github.com/gperftools/gperftools>

### [webhook](https://benediktdeicke.com/2017/09/sending-webhooks-with-rails)

### [18ln](https://prograils.com/posts/brief-introduction-to-internationalization-in-rails)

### [recurring-events-with-ice_cube](https://www.driftingruby.com/episodes/recurring-events-with-ice_cube)

### [记录事件](http://blog.arkency.com/one-simple-trick-to-make-event-sourcing-click)

### [ajax](https://learnetto.com/blog/how-to-make-ajax-calls-in-rails-5-1)

### [elasticsearch语句/就是我要的简化查询](https://asok.github.io/ruby/2016/10/03/parslet.html)

### [searchkick](https://github.com/ankane/searchkick)

### [py2rb](https://github.com/naitoh/py2rb)

### [pg 调优工具](https://github.com/bradurani/pg-eyeballs)

### [active_job 的原理/代码](https://karolgalanciak.com/blog/2016/09/25/decoding-rails-magic-how-does-activejob-work/)

### [Microservices](http://blog.mechanicles.com/2016/09/19/microservices-using-rails-http-and-rabbitmq.html)

### [devise](https://www.driftingruby.com/episodes/authentication-crash-course-with-devise)

### [devise-token](https://www.valentinog.com/blog/devise-token-auth-rails-api/)

### [属性类型检查](http://cucumbersome.net/2016/09/06/rails-form-objects-with-dry-rb.html )

### [正确使用gem](http://waiting-for-dev.github.io/blog/2016/09/07/ruby-gems-could-harm-your-memory/)

  + 要看内存问题gem列表
  + rubocop 之类的放dev
  + require: false
    + 只用于rake 就在  rakefile里require
    + 只用某个类在类里  require
  + https://github.com/schneems/derailed_benchmarks

### [RuboCop+overcommit]https://medium.com/@kirill_shevch/lint-your-ruby-code-with-overcommit-and-static-analysis-tools-bd36d3147d2e

### [内存问题gem](https://github.com/ASoftCo/leaky-gems)
  https://github.com/redis/redis-rb/issues/612
  https://github.com/mperham/sidekiq/pull/2598

### [deep_pluck](https://github.com/khiav223577/deep_pluck)

### [日志](https://github.com/igorkasyanchuk/log_analyzer)

### [优化字串](http://tenderlovemaking.com/2018/02/12/speeding-up-ruby-with-shared-strings.html)

### [time](https://blog.dnsimple.com/2018/03/elapsed-time-with-ruby-the-right-way/)

```ruby
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# time consuming operation
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
elapsed # => 9.183449000120163 seconds
```

### [user agent](https://github.com/podigee/device_detector)

### [pry](https://medium.com/@jrmair/dig-deeper-with-pry-introducing-cruby-source-browsing-702cb8358690)

```ruby 
show-source Customer.create
$ Customer.create
gem install pry-doc
```

### [custom-error-pages](https://www.driftingruby.com/episodes/custom-error-pages-with-slack-notification)

### [error](https://gorails.com/episodes/rails-error-tracking-with-errbit)

### [文档类型数据](https://github.com/stepnivlk/firecord)

### [js](https://jes.al/2017/03/incorporating-modern-javascript-build-tools-with-rails/)


### [elastic](http://code.tutsplus.com/articles/full-text-search-in-rails-using-elasticsearch--cms-22920)

### [elasticsearch reindexing](https://medium.com/@vvangemert/asynchronous-elasticsearch-bulk-reindexing-with-rails-searchkick-and-sidekiq-26f2f9aa8513)

### [循环事件模型](http://nithinbekal.com/posts/rails-recurring-events)

### [selenium-ruby 模拟浏览器](http://redgreenrepeat.com/2016/07/29/selenium-ruby)


### [ruby系统工具](* http://www.blackbytes.info/2016/06/linux-tools-with-ruby/)

### [AIRBNB + Datadog](https://medium.com/airbnb-engineering/alerting-framework-at-airbnb-35ba48df894f)

  https://github.com/airbnb/alerts
  
### [turbolinks 开始native了](https://github.com/turbolinks/turbolinks)

  https://www.youtube.com/watch?v=SWEts0rlezA

### [常见错误](https://jetruby.com/expertise/common-rails-mistakes-ruby-way/)

#### 他们不用 rubocop

#### 太执着 when 和 if, 不同选择可以用 hash + send

#### 不是行数短就是好代码

```ruby
def bad
  return unless user_signed_in? || !(current_user.customer? || current_user.admin?)
  redirect_to root_path
end
def good
  return unless user_signed_in?
  return if current_user.customer? || current_user.admin?

  redirect_to root_path
end

```
#### html encode:
```ruby
CGI::unescapeHTML message
```
#### 写看不出什么意思的 if 长语句
#### 不怎么用 send
#### 别留下不用的参数
#### 用有意义的 常量代替 数字或字符串
#### 常量不要用简写
#### 使用顺序 :xx '' ""
#### 使用 memoization
```ruby
## WRONG  ##
def user
  User.find(params[:id})
end
user.articles

##  RIGHT   ##
def user
  @user ||= User.find(params[:id})
end
user.articles
```

#### if 要明确使用 present? nil? blank?
```ruby
## WRONG  ##

if course
  render '...'
end

raise NotAuthorized unless auth_token

##  RIGHT   ##

if course.present?
  render '...'
end

raise NotAuthorized unless auth_token.present?
```

#### 滥用谓语 xx? 返回的是值而不是bool
```ruby
## WRONG ##

def author?
  if current_user.id ==  course.user.id
    current_user.add_role(‘author’)
  end
end

def has_any_courses?
  current_user.courses.count
end

##  RIGHT   ##

current_user.add_role(‘author’) if author?

def author?
  current_user.id == course.user.id
end

def has_any_courses?
  current_user.courses.size > 0
end
```

### string 优化

https://www.mikeperham.com/2018/02/28/ruby-optimization-with-one-magic-comment/
```
"mike".freeze or
# frozen_string_literal: true
```

### Meet Clowne—a flexible tool for all your model cloning needs that comes with no strings attached

https://evilmartians.com/chronicles/clowne-clone-ruby-models-with-a-smile

https://github.com/palkan/clowne

### N+1 问题++

https://blog.heroku.com/solving-n-plus-one-queries#more-than-count
1. 用includes ,并不会计算includes 的量,会直接填满内存
2. N+1 count `group(:xx)` hash 数据
3. 专业gem包 https://github.com/flyerhzm/bullet
4. 性能评测gem包 https://github.com/MiniProfiler/rack-mini-profiler

https://semaphoreci.com/blog/2017/08/09/faster-rails-eliminating-n-plus-one-queries.html

https://engineering.universe.com/batching-a-powerful-way-to-solve-n-1-queries-every-rubyist-should-know-24e20c6e7b94

这个gem是不错的解决方案
https://github.com/exaspark/batch-loader
### [常用27gem](https://hackernoon.com/27-gems-i-use-in-almost-every-project-832986551df8)
### rbenv自动安装 bunlder
```bash
brew install rbenv-default-gems
```
https://philna.sh/blog/2017/03/22/always-install-bundler-alongside-ruby-with-rbenv/

### present? perform
present? =>  2892.7 ms
any?     =>   400.9 ms
empty?   =>   403.9 ms
exists   =>     1.1 ms
```ruby
project = Project.find_by_name("semaphore")

project.builds.load    # eager loads all the builds into the assosiation cache

project.builds.any?    # no database hit
project.builds.exists? # hits the database

# if we bust the association cache
project.builds(true).any?    # hits the database
project.builds(true).exists? # hits the database
```

### rails cap env

http://stackoverflow.com/questions/7602548/capistrano-can-i-set-an-environment-variable-for-the-whole-cap-session

### uuid
```ruby
# config/application.rb
config.active_record.primary_key = :uuid

create_table :users, id: :uuid do |t|
  t.string :name
end

```

### Counts and counters

  + Database queries like `select count(*) from users` are inherently(天生) slow. They literally loop through each record in the recordset to generate their results. If you have a million records, it's going to take a while.

  + Attempts to speed up counters by using "*counter caches*" do work, but they limit your ability to spread writes across many database servers.

  The easiest solution is to avoid using counters wherever possible. This is much easier when you're doing the initial design.

  For example, you might choose to page by date-range instead of by count. You might choose not to show *a mildly-useful statistic* that will be hellish to generate later. You get the idea.

### source_location
object = Object.new
puts object.method(:blank?).source_location
User.instance_method(:github_url).source_location

### bundle open active_support

### caller
```ruby
class Project
  def foo
    puts "====================="
    puts caller
  end
end
```

### paramters
```ruby
def parse(input, skip_code_comments: false, ignore_whitespace: true)
  ap params
end
method(:parse).parameters

### params ?
```

### rake middleware

### pry
.pryrc
https://github.com/pry/pry/wiki/Pry-rc


### 字符串 String
```ruby
str=%Q{he/lo}
```
### 严重BUG review
```ruby
# 这种写法 somevalue 为空必死
def message
  "abc"
end
somevalue = nil
message = somevalue || message
# 原因: message = somevalue || message 会让 message 转为 nil 的变量
# 所以 || 后的message不是"abc",而是 nil
```
### deep_symbolize_keys
```
{}.deep_symbolize_keys
  ```
### Rails 多库
```Ruby
handles_connection_for :master_database
# app/models/animal.rb
class Animal < ActiveRecord::Base
   delegates_connection_to :master_database, :on => [:create, :save, :destroy]
end
```

## db

http://drnicwilliams.com/2007/04/12/magic-multi-connections-a-facility-in-rails-to-talk-to-more-than-one-database-at-a-time/

http://kovyrin.github.io/db-charmer/
http://kovyrin.net/2009/11/03/db-charmer-activerecord-connection-magic-plugin/


https://schneems.com/2017/07/18/how-i-reduced-my-db-server-load-by-80/

[数据库migration打包](https://github.com/jalkoby/squasher)

[migration](https://medium.com/into-the-forest/rails-migrations-tricks-guide-code-cheatsheet-included-dca935354f22)

[migration检查](https://github.com/ankane/strong_migrations)

[查看](https://github.com/iorme1/Rails-DB-Interactive)

[备份导出](https://github.com/callahanrts/dbmgr)

### whenever fix: /bin/bash: bundle: command not found

```ruby
# config/schedule.rb
env :PATH, ENV['PATH']
```

### force index

```ruby
def force_use_index(index)
  if index.blank?
    from("#{self.table_name}")
  else
    from("#{self.table_name} USE INDEX(#{index})")
  end
end
```

### 数据库优化

http://blog.honeybadger.io/common-rails-idioms-that-kill-database-performance

###  logger

```ruby
    Rails.logger.level = 0 ; ActiveRecord::Base.logger = Logger.new(STDOUT); nil
```


#### 删除

```
class Building < ActiveRecord::Base
  has_many :apartments, dependent: :destroy
end

class Apartment < ActiveRecord::Base
  has_many :rooms, dependent: :destroy
end

## rails4.0以后可以使用 数据库自带的方法来删除

class CreateForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :apartments, :buildings, on_delete: :cascade
    add_foreign_key :rooms, :apartments, on_delete: :cascade
    add_foreign_key :furnitures, :rooms, on_delete: :cascade
    add_foreign_key :materials, :furnitures, on_delete: :cascade
  end
end

```

#### [Drag and Drop with Interact.js](https://www.driftingruby.com/episodes/drag-and-drop-with-interact-js)

### [纯ruby chat](http://pdabrowski.com/blog/ruby-on-rails/chart-with-one-line/)

```ruby
gem 'chartkick'
gem 'chartable'
```

### [网络io](https://github.com/jjyr/lightio)

### [rails 前端](https://evilmartians.com/chronicles/evil-front-part-2)

### [Smarter Rails Services with Active Model Modules](https://dev.to/sophiedebenedetto/smarter-rails-services-with-active-model-modules-17o)

[深入了解actionrecord](https://draveness.me/activerecord)

#### comment

```
def is_prime?(n)
  # Any factor greater than sqrt(n) has a corresponding factor less than
  # sqrt(n), so once i >=sqrt(n) we have covered all cases
  while i * i < n
    if n % i == 0
      return false
    end
    i += 1
  end
  true
end
```

#### Struct


```
Struct.new("Person", :height, :hair_color, :dominant_hand, :iq, :astigmatic?)
# Or,

Person = Struct.new(:height, :hair_color, :dominant_hand, :iq, :astigmatic?)

sally = Person.new(165, "red", :left, 180, true)
```

#### sidekiq

[test](https://github.com/mperham/sidekiq/wiki/Testing)

```

# https://blog.codeship.com/improving-rails-performance-better-background-jobs/

# https://devcenter.heroku.com/articles/ruby-memory-use


class ContentSuggestionWorker
  include Sidekiq::Worker

  def perform
    User.where(subscribed: true).find_in_batches(batch_size: 100) do |group|
      group.each { |user| ContentMailer.suggest_to(user).deliver_now }
    end
  end
end

find_in_batches

# 拆分: 在指量的任务中不取出也不真正的进行操作

class ContentSuggestionEnqueuer
  def self.enqueue
    User.where(subscribed: true).pluck(:id).each do |user_id|
      ContentSuggestionWorker.perform_async(user_id)
    end
  end
end
class ContentSuggestionWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    user = User.find(user_id)
    ContentMailer.suggest_to(user).deliver_now
  end
end


# GC ,这个我们自己试好像没有用?
class ContentSuggestionWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    user = User.find(user_id)
    ContentMailer.suggest_to(user).deliver_now
    GC.start
  end
end

# https://github.com/bear-metal/tunemygc gc第三方服务
```

####  constant
```
ALERTS = {
  'info' => InfoAlert,
  'warn' => WarnAlert,
  'error' => ErrorAlert
}

class AlertsController < ApplicationController
  def create
    ALERTS.fetch(params[:alert][:type])).new(params[:alert][:value]))

    # ... other work
    # render page
  end
end
```

# index_by
```
people_by_id = Person.find(ids).index_by(&:id) # Gives you a hash indexed by ID
ids.collect {|id| people_by_id[id] }
```
# Bad. You will add this gem to the production environment even if you are not using it there
gem 'rubocop'

# Good
gem 'rubocop', group: :development
```

```ruby
class A
  private # 后的self.foo 并不是私有方法
  def self.foo
    puts "foo"
  end
end
A.foo  # foo => ok

```
https://github.com/franzejr/best-ruby

======
```ruby
# rails
emum :status, {on: 1, off:2}
status = :on
save    # status = nil
self.status = :on
save    # status = 1
```
```ruby
# class method & instance method
 class Foo
   def self.bar
     "foo bar"
   end
   delegate :bar, to: 'self.class'
 end
# Hash[ object ] → new_hash
Hash[%i(web android ios).map { |e| [e,true] }]  #=> { web:true, android: true, ios: true}
Hash[[:a, :b, :c].map.with_index(0).to_a] # => {:a=>0, :b=>1, :c=>2}
Array(1) #=> [1]
Array([1]) #=> [1]

#lock
REDIS.incr(key) > 1 ? true : (REDIS.expire(key, PUSH_REDUPLICATE_EXPIRE_TIME) && false)

# test valid
# https://www.sitepoint.com/quick-tip-dry-up-your-model-validations-tests
def test_should_require_customer_email
    site = Site.new
    refute site.valid?
    refute site.save
    assert_operator site.errors.count, :>, 0
    assert site.errors.messages.include?(:customer_email)
    assert site.errors.messages[:customer_email].include?("can't be blank")
  end
```

#### [四个不错的方法](https://www.engineyard.com/blog/five-ruby-methods-you-should-be-using) [高级用法]

```ruby
# Object#tap
params.tap {|p| p[:foo] = 'bar' }
# Array#bsearch
require 'benchmark'

data = (0..50_000_000)

Benchmark.bm do |x|
  x.report(:find) { data.find {|number| number > 40_000_000 } }
  x.report(:bsearch) { data.bsearch {|number| number > 40_000_000 } }
end

#          user       system     total       real
# find     3.020000   0.010000   3.030000   (3.028417)
# bsearch  0.000000   0.000000   0.000000   (0.000006)
users.flat_map
# =>
users.map{}.flatten
# Array.new with a Block
Array.new(8)
# => 
Array.new(8) { 'O' }

# <=> -1, 0, and 1
```

#### [query tip](https://medium.com/@apneadiving/active-records-queries-tricks-2546181a98dd)

```ruby
# 1) Join query with condition on the associated table
# User model
scope :activated, ->{
  joins(:profile).where(profiles: { activated: true })
}
# => TO
# Profile model
scope :activated, ->{ where(activated: true) }
# User model
scope :activated, ->{ joins(:profile).merge(Profile.activated) }


# 2) Different nested joins
User.joins(:profiles).merge(Profile.joins(:skills))
=> SELECT users.* FROM users 
   INNER JOIN profiles    ON profiles.user_id  = users.id
   LEFT OUTER JOIN skills ON skills.profile_id = profiles.id
# So you'd rather use:
User.joins(profiles: :skills)
=> SELECT users.* FROM users 
   INNER JOIN profiles ON profiles.user_id  = users.id
   INNER JOIN skills   ON skills.profile_id = profiles.id

# Exist query
# Post
scope :famous, ->{ where("view_count > ?", 1_000) }
# User
scope :without_famous_post, ->{
  where(_not_exists(Post.where("posts.user_id = users.id").famous))
}
def self._not_exists(scope)
  "NOT #{_exists(scope)}"
end
def self._exists(scope)
  "EXISTS(#{scope.to_sql})"
end

# Subqueries
Post.where(user_id: User.created_last_month.pluck(:id))
# => better
Post.where(user_id: User.created_last_month)
# => more
User.created_last_month.select(:id)

# 
.to_sql
```

