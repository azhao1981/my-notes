# rails on docker

## docker ruby

### truffleruby

```bash
g clone https://github.com/nning/docker-truffleruby.git

docker build -t truffleruby .
docker run -it truffleruby

# https://github.com/andreimc/docker-images/blob/master/rails-api-example/Dockerfile
FROM lusu777/truffle-ruby:1.0.0-rc1

RUN yum -y install sqlite-devel

RUN gem install rails

RUN RUBY_ENGINE=truffleruby rails new api-play --api
```

### jruby

好像也有人提出不少的问题

```bash
docker pull jruby:9.2

# https://ruby-china.org/topics/36865
gem install bundler
gem install rails -v 5.1.6
# 5.2.0暂时有点小问题。
rails new blog -d postgresql

https://raw.githubusercontent.com/cpuguy83/docker-jruby/master/9000/jre/Dockerfile

https://github.com/jruby/jruby/wiki/JRubyOnRails#Getting_Started
```

## 参考

### [docker development environment](https://jes.al/2016/09/setting-up-a-rails-development-environment-using-docker/)

### [docker getting-started](https://www.chrisblunt.com/rails-on-docker-getting-started-docker-ruby-rails)

### [docker2](https://www.chrisblunt.com/rails-on-docker-using-docker-compose-with-your-ruby-on-rails-apps/?utm_source=rubyweekly&utm_medium=email)

[dockerfile-ruby-2.5.1-jemalloc](https://gist.github.com/hooopo/7c36126ecedac811984d0f46770a2a4e)

[docker system test](https://dev.to/dstull/docker--rails--system-tests-with-headless-chrome-d00)

[rails-on-docker-using-yarn-to-manage-frontend-assets](https://www.chrisblunt.com/rails-on-docker-using-yarn-to-manage-frontend-assets/)

<https://dogsnog.blog/2018/02/02/setting-up-a-docker-development-environment-for-ruby-on-rails/?utm_source=rubyweekly&utm_medium=email>

[rails node docker](https://blog.phusion.nl/2016/08/31/efficiently-and-conveniently-building-ruby-and-node-js-application-docker-containers-for-production-2)

https://blog.codeship.com/build-minimal-docker-container-ruby-apps