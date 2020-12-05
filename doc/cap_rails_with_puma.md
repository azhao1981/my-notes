# cap rails with puma

## DSL

 gem cap3_rails_with_puma, group: :development

 http://waterdoge.com/ror/2017/02/18/deploy-rails-app.html

 https://coderwall.com/p/ttrhow/deploying-rails-app-using-nginx-puma-and-capistrano-3

## 显示本地时间

```ruby
module Capistrano
  class Configuration
    def timestamp
      @timestamp ||= Time.now
    end
  end
end
```