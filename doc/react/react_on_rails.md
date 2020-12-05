# react on rails

## rails + webpack + react_on_rails

### ruby on rails 环境安装

### npm / yarn 安装

### 创建rails + webpack项目

```bash
# SASS_BINARY_SITE 为解决 node-sass 下载问题
SASS_BINARY_SITE=https://npm.taobao.org/mirrors/node-sass/ rails new reactdemo2 --webpack=react --skip-bundle
```

- **node-sass原生安装会使用 github 的aws s3下载,国内下载有问题,使用SASS_BINARY_SITE从国内镜像下载**

- 使用 [gem react_on_rails](https://github.com/shakacode/react_on_rails)
- prerender: false 改成 true 会报错,先跳过

### quick start

```bash
# gemfile
source 'https://ruby.taobao.org'
gem 'react_on_rails', '~> 9.0.1'

bundle install

git init . && git add . && git commit -a -m "init"

./bin/rails generate react_on_rails:install

./bin/webpack-dev-server
./bin/rails s

# 使用浏览器打开
# http://localhost:3000/hello_world

```

### 参考

[tutorial](https://github.com/shakacode/react_on_rails/blob/master/docs/tutorial.md)

[例子](https://github.com/shakacode/react-webpack-rails-tutorial)

## react_on_rails + antd

antd 是类似 material design 的设计理念,同时提供react相关的组件

[官方文档](https://ant.design/docs/react/introduce-cn)

### 开始

```bash
yarn add antd
yarn add babel-plugin-import
```

```json
# .babelrc
plugins: [
  .....,
  [
    "import",
    {
      "libraryName": "antd", "style": "css"
    }
  ]
]
```

> "libraryName": "antd", "style": true
> "libraryName": "antd", "style": "true"

```css
# src/App.css  添加第一行不然不能载入样式

@import '~antd/dist/antd.css';

.App {
  text-align: center;
}

```

```css
# rails app/assets/stylesheets/application.css
@import 'antd/dist/antd.css';
```

```html
# laout app/views/layouts/hello_world.html.erb
<%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
<%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>

```

```javascipt
import { DatePicker,Button } from 'antd';
<DatePicker />
<Button />
```

[antd快速上手](https://ant.design/docs/react/getting-started-cn)

[例子](https://github.com/kbravi/rails_react_antd_boilerplate)

## guide

[reactjs-a-guide-for-rails-developers/基于 react-rails](https://www.airpair.com/reactjs/posts/reactjs-a-guide-for-rails-developers)

[api+react方式](https://medium.com/superhighfives/a-top-shelf-web-stack-rails-5-api-activeadmin-create-react-app-de5481b7ec0b)

[深入antd button](http://reactkungfu.com/2017/03/diving-into-ant-design-internals-button/)

[react 入门](https://segmentfault.com/a/1190000004570818)

[react on chat](https://github.com/learnetto/reactchat)

[参考 react-rails](https://github.com/reactjs/react-rails)

## [react_on_railsapi](/doc/react/react_on_railsapi.md)



## testing

```bash
We did not find a spec/rails_helper.rb or spec/spec_helper.rb to add
the React on Rails Test helper, which ensures that if we are running
js tests, then we are using latest webpack assets. You can later add
this to your rspec config:

# This will use the defaults of :js and :server_rendering meta tags
ReactOnRails::TestHelper.configure_rspec_to_compile_assets(config)


What to do next:

  - See the documentation on https://github.com/rails/webpacker/blob/master/docs/webpack.md
    for how to customize the default webpack configuration.

  - Include your webpack assets to your application layout. 这个是加到 webpack asset 里,不加也可以

      <%= javascript_pack_tag 'hello-world-bundle' %>

  - Run `rails s` to start the Rails server and use Webpacker's default lazy compilation.

  - Visit http://localhost:3000/hello_world and see your React On Rails app running!

  - Run bin/webpack-dev-server to start the Webpack dev server for compilation of Webpack
    assets assets as soon as you save. This default setup with the dev server does not work
    for server rendering

  - Alternately, you may turn off compile in config/webpacker.yml and run the foreman
    command to start the rails server and run webpack in watch mode.

      foreman start -f Procfile.dev

  - To turn on HMR, edit config/webpacker.yml and set HMR to true. Restart the rails server
    and bin/webpack-dev-server. Or use Procfile.dev-server.

  - To server render, change this line app/views/hello_world/index.html.erb to
    `prerender: true` to see server rendering (right click on page and select "view source").

      <%= react_component("HelloWorldApp", props: @hello_world_props, prerender: true) %>
```

### yarn warning 问题

-v=1.0.2 ,是这个版本的问题,估计下周会更新

<https://github.com/yarnpkg/yarn/issues/4433>

```bash
warning "coffee-loader@0.8.0" has incorrect peer dependency "coffeescript@>= 1.8.x".
warning "compression-webpack-plugin@1.0.0" has incorrect peer dependency "webpack@^2.0.0 || ^3.0.0".
warning "babel-loader@7.1.2" has incorrect peer dependency "babel-core@6 || 7 || ^7.0.0-alpha || ^7.0.0-beta || ^7.0.0-rc".
warning "babel-loader@7.1.2" has incorrect peer dependency "webpack@2 || 3".
warning "extract-text-webpack-plugin@3.0.0" has incorrect peer dependency "webpack@^3.1.0".
warning "postcss-cssnext@3.0.2" has incorrect peer dependency "caniuse-lite@^1.0.30000697".
warning "sass-loader@6.0.6" has incorrect peer dependency "node-sass@^4.0.0".
warning "sass-loader@6.0.6" has incorrect peer dependency "webpack@^2.0.0 || >= 3.0.0-rc.0 || ^3.0.0".
warning "rails-erb-loader@5.2.1" has incorrect peer dependency "webpack@^2.0.0 || >= 3.0.0-rc.0 || ^3.0.0".
warning "webpack-manifest-plugin@1.3.2" has incorrect peer dependency "webpack@1 || 2 || 3".
warning "ajv-keywords@2.1.0" has incorrect peer dependency "ajv@>=5.0.0".
warning "uglifyjs-webpack-plugin@0.4.6" has incorrect peer dependency "webpack@^1.9 || ^2 || ^2.1.0-beta || ^2.2.0-rc || ^3.0.0".
```

Agile Web Development with Rails, Edition 5
http://intertwingly.net/projects/AWDwR4/checkdepot/index.html

https://blog.codeship.com/using-react-inside-your-rails-apps/