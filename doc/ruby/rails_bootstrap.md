# rails + bootstrap

## 最佳实践

[bootstrap 官方 gem](https://github.com/twbs/bootstrap-rubygem)

```ruby
gem 'bootstrap', '~> 4.3.1'
gem "jquery-rails"
```

```bash
mv app/assets/stylesheets/application.css app/assets/stylesheets/application.css.scss
```
app/assets/stylesheets/application.scss

```
// Custom bootstrap variables must be set or imported *before* bootstrap.
@import "bootstrap";
```

application.js
```javascript
//= require jquery3
//= require popper
//= require bootstrap-sprockets
```
或 require the concatenated bootstrap for faster compilation

```javascript
//= require jquery3
//= require popper
//= require bootstrap
```

```bash
bundle install
```
## 参考

+ rails_layout, 支持 Foundation Bootstrap,但版本有点旧,可以借鉴
<https://github.com/RailsApps/rails_layout>

```bash
rails generate layout:install bootstrap4
rails generate layout:navigation bootstrap4
rails generate layout:devise
```

+ 和上面一起的, rails 的示例,也是两年前
<https://github.com/RailsApps/rails-composer>

+ rails 应用模板
<https://ruby-china.github.io/rails-guides/rails_application_templates.html>
> 这个可以当一个示例

+ 完善布局
<https://railstutorial-china.org/book/chapter5.html>

<https://www.kancloud.cn/wizardforcel/rails-tutorial/151233>

## rails_layout

```
# app/assets/javascripts/application.js
jquery3 popper bootstrap-sprockets 加这几个
//= require jquery3
//= require popper
//= require rails-ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .
```
app/assets/stylesheets/application.css.scss 只改名字不变

app/assets/stylesheets/1st_load_framework.css.scss
```css
// import the CSS framework
// Do not use *= require in Sass or your other stylesheets will not be able to access the Bootstrap mixins and variables.
@import "bootstrap";

// make all images responsive by default
img {
  @extend .img-fluid;
  margin: 0 auto;
}
// override for the 'Home' navigation link
.navbar-brand {
  font-size: inherit;
  }

// THESE ARE EXAMPLES YOU CAN MODIFY
// create your own classes
// to make views framework-neutral
.column {
  @extend .col-md-6;
  text-align: center;
}
.form {
  @extend .col-md-6;
}
.form-centered {
  @extend .col-md-6;
  text-align: center;
}
.submit {
  @extend .btn;
  @extend .btn-primary;
  @extend .btn-lg;
}

// apply styles to HTML elements
// to make views framework-neutral
main {
  @extend .container;
  margin-top: 30px; // accommodate the navbar
}

section {
  @extend .row;
  margin-top: 20px;
}

```
app/views/layouts/application.html.erb
```html
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= content_for?(:title) ? yield(:title) : "Udesk Greatewall" %></title>
    <meta name="description" content="<%= content_for?(:description) ? yield(:description) : "Udesk Greatewall" %>">
    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track' => 'reload' %>
    <%= csrf_meta_tags %>
  </head>
  <body>
    <header>
      <%= render 'layouts/navigation' %>
    </header>
    <main role="main" class="main-container container">
       <%= render 'layouts/messages' %>
       <%= yield %>
    </main>
  </body>
```
app/views/layouts/_messages.html.erb
```
<%# Rails flash messages styled for Bootstrap 4.0 %>
<% flash.each do |name, msg| %>
  <% if msg.is_a?(String) %>
    <div class="alert alert-<%= name.to_s == 'notice' ? 'success' : 'danger' %>" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
      <%= content_tag :div, msg, :id => "flash_#{name}" %>
    </div>
  <% end %>
<% end %>
```
app/views/layouts/_navigation.html.erb,这个就不太好了
```html
<%# navigation styled for Bootstrap 4.0 %>
<div class="container">
  <nav class="navbar navbar-dark bg-inverse">
    <ul class="nav navbar-nav clearfix">
      <li class="nav-item">
        <button class="navbar-toggler hidden-sm-up nav-link" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar2" aria-controls="exCollapsingNavbar2" aria-expanded="false" aria-label="Toggle navigation">
          &#9776;
        </button>
      </li>
    </ul>
    <div class="collapse navbar-toggleable-xs" id="exCollapsingNavbar2">
      <%= link_to "Rails bootstrap", root_path, class: 'navbar-brand' %>
      <ul class="nav navbar-nav">
        <%= render 'layouts/navigation_links' %>
      </ul>
    </div>
  </nav>
</div>
```

