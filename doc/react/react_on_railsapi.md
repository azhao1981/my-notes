# rails api + create react app + activeadmin

## 参考 

[How to Build a React App that Works with a Rails 5.1 API](https://www.sitepoint.com/react-rails-5-1/)

[a-rock-solid-modern-web-stack](https://blog.heroku.com/a-rock-solid-modern-web-stack)
- 5.2

## 5.2

+ Before you commit, add /public to .gitignore, as this will be populated at build by our front end.
+ bundle
+ bin/rails s -p 3001
+ 这步已经不需要了,天然已经是这样 Before you install ActiveAdmin
  * switch a couple of Rails classes application_controller.rb `ActionController::Api -> ActionController::Base`
  添加 protect_from_forgery with: :exception
  * 加 api_controller.rb
  * add some middleware that it relies on.
    - config/application.rb
```ruby
require "sprockets/railtie"

config.middleware.use Rack::MethodOverride
config.middleware.use ActionDispatch::Flash
config.middleware.use ActionDispatch::Cookies
config.middleware.use ActionDispatch::Session::CookieStore

```

# ActiveAdmin

```ruby
gem 'devise'
gem 'activeadmin'
```

```bash
bundle
bin/rails g active_admin:install
bin/rake db:migrate db:seed
./bin/rails s -p 3001
```
+ npx create-react-app client
+ 删除
```js
// client/src/index.js
import registerServiceWorker from './registerServiceWorker';
registerServiceWorker();

// https://blog.csdn.net/chern1992/article/details/77477037 
//service worker是在后台运行的一个线程，可以用来处理离线缓存、消息推送、后台自动更新等任务。registerServiceWorker就是为react项目注册了一个service worker，用来做资源的缓存，这样你下次访问时，就可以更快的获取资源。而且因为资源被缓存，所以即使在离线的情况下也可以访问应用（此时使用的资源是之前缓存的资源）。注意，registerServiceWorker注册的service worker 只在生产环境中生效（process.env.NODE_ENV === ‘production’）
```

This is because, in some cases, Create React App’s use of service workers clashes with Rails’ routing, and can leave you unable to access ActiveAdmin
+ yarn --cwd client start
+ TODO: --cwd client无效
+ package.json "proxy": "http://localhost:3001"
+ `bin/rails g scaffold Drink title:string description:string steps:string source:string`
  + api_controller.rb in any of your source paths
  + config/application.rb `config.app_generators.scaffold_controller = :scaffold_controller`
+ bin/rails g scaffold Ingredient drink:references description:string
+ has_many 现在不用加 belongs_to 了,框架会自己加上
+ bin/rake db:migrate
bin/rails generate active_admin:resource Drink
bin/rails generate active_admin:resource Ingredient
+ admin/drinks permit_params :title, :description, :steps, :source 
+ admin/ingredients permit_params :description, :drink_id
+ routes scope 'api' do ; resources :drinks ; end
+ rails s
+ 加一些drink 和 ingredients 然后 `bin/rake db:reset`
+ select and include
+ 

## 创建 rails api 项目

这里我们使用 ruby2.4.1 + rails5.1.4

```bash
rails new reactdemo3 --api --skip-bunld
bin/rails s -p 3001
```

```rb
# application_controller.rb
class ApplicationController < ActionController::API
end

# 改成
class ApplicationController < ActionController::Base
end

# api_controller.rb
class ApiController < ActionController::API
end

# 即可生成如下控制器
class ExampleController < ApiController
end

# config/application.rb 添加
require "sprockets/railtie"

config.middleware.use Rack::MethodOverride
config.middleware.use ActionDispatch::Flash
config.middleware.use ActionDispatch::Cookies
config.middleware.use ActionDispatch::Session::CookieStore

# config/application.rb 如下
require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# sprockets也必须添加,不然无法编译 assets
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ListOfIngredients
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Flash
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
  end
end

```

```rb
gem 'devise', '> 4.x'
gem 'activeadmin', github: 'activeadmin'
gem 'inherited_resources', git: 'https://github.com/activeadmin/inherited_resources'
```

```bash
bundle install
bin/rails g active_admin:install
bin/rake db:migrate
bin/rake db:seed
bin/rails s -p 3001
```

如果出现以下错误,是因为没有使用 asset pipeline 需要`require "sprockets/railtie"`

```bash
# TODO
# error for active_admin:install
railties-5.1.4/lib/rails/railtie/configuration.rb:95:in `method_missing': undefined method `assets' for #<Rails::Application::Configuration:0x007f9fb4018e38> (NoMethodError)
Did you mean?  asset_host
	from /Users/weizhao/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/bundler/gems/activeadmin-8f8e2662d5b9/lib/active_admin/engine.rb:9:in `block in <class:Engine>'
```

<http://localhost:3001/admin>

admin@example.com
password

### react

create-react-app client && cd client
yarn start

```json
//client/package.json
"proxy": "http://localhost:3001"
```

```bash
# 这个会失败
bin/rails g scaffold drink
```

```ruby
# config/application.rb
config.api_only = true
config.app_generators.scaffold_controller = :scaffold_controller
```

```bash
bin/rails g scaffold Drink title:string description:string steps:string source:string
bin/rails g scaffold Ingredient drink:references description:string
```

```rb
# app/models/drink.rb
class Drink < ApplicationRecord
  has_many :ingredients
end

# drink:references 会自动加 belongs_to

bin/rake db:migrate
bin/rails generate active_admin:resource Drink
bin/rails generate active_admin:resource Ingredient

# app/admin/drink.rb:
ActiveAdmin.register Drink do
  permit_params :title, :description, :steps, :source

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
end

# app/admin/ingredient.rb
ActiveAdmin.register Ingredient do
  permit_params :description, :drink_id

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
end

```

**Without permit_params, you can never edit your delicious drink recipes. Not on my watch.**

```rb
# /api
Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope '/api' do
    resources :drinks
  end
end
```

```rb
# db/seeds.rb
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

negroni = Drink.create(
  title: "Sparkling Negroni",
  description: "The perfect cocktail for sipping after an alfresco dinner on a summer night, Negronis get their red hue and herbaceous beginning from the Italian apéritif Campari, which is mellowed out by floral gin and sweet vermouth. Top off your drink with some bubbly, and enjoy.",
  steps: "Combine the first three ingredients in an ice-filled cocktail shaker. Shake until cold, then strain the mixture into a glass. Top with prosecco, and garnish with the orange twist.",
  source: "http://www.architecturaldigest.com/gallery/4-easy-entertaining-summer-cocktail-recipes-5-ingredients-or-less",
)
negroni.ingredients.create(description: "⅓ oz. Campari")
negroni.ingredients.create(description: "⅓ oz. gin")
negroni.ingredients.create(description: "⅓ oz. sweet vermouth")
negroni.ingredients.create(description: "Chilled prosecco, or other sparkling wine, for topping")
negroni.ingredients.create(description: "Orange peel twist (optional)")

margarita = Drink.create(
  title: "Pineapple-Jalapeño Margarita",
  description: "No margarita is complete without fresh-squeezed lime juice—there’s something about the sour punch of citrus that goes so well with the smokiness of tequila. To stir things up, try adding pineapple juice to the mix and muddling in some jalapeño peppers for a little heat.",
  steps: "Pour the lime juice and jalapeños into a shaker and muddle with the back of a wood spoon. Fill with ice. Pour in tequila, pineapple juice, and Grand Marnier. Shake until chilled. Dip the rim of a rocks glass in water, then dip it in coarse salt. Fill the glass with ice, and strain the cocktail into the glass. Garnish with pineapple wedge and peel and jalapeño slices.",
  source: "http://www.architecturaldigest.com/gallery/4-easy-entertaining-summer-cocktail-recipes-5-ingredients-or-less"
)
margarita.ingredients.create(description: "½ oz. fresh lime juice")
margarita.ingredients.create(description: "⅓ of a large jalapeño, sliced, plus more for garnish")
margarita.ingredients.create(description: "1¾ oz. tequila")
margarita.ingredients.create(description: "1½ oz. fresh pineapple juice")
margarita.ingredients.create(description: "½ oz. Grand Marnier or other orange liqueur")
margarita.ingredients.create(description: "Coarse salt, for rimming glass")
margarita.ingredients.create(description: "Pineapple wedge and peel, for garnish")
```

`bin/rake db:seed`

<http://localhost:3001/api/drinks>

```rb
class DrinksController < ApiController
  # GET /drinks
  def index
    @drinks = Drink.select("id, title").all
    render json: @drinks.to_json
  end

  # GET /drinks/:id
  def show
    @drink = Drink.find(params[:id])
    render json: @drink.to_json(:include => { :ingredients => { :only => [:id, :description] }})
  end
end

class IngredientsController < ApiController
end
```

### Procfile启动脚本

```bash
# Procfile.dev
web: cd client && PORT=3000 npm start
api: PORT=3001 && bundle exec rails s
```

gem install foreman

foreman start -f Procfile.dev

as rake

```rb
# lib/tasks/start.rake
namespace :start do
  task :development do
    exec 'foreman start -f Procfile.dev'
  end

  desc 'Start production server'
  task :production do
    exec 'NPM_CONFIG_PRODUCTION=true npm run postinstall && foreman start'
  end
end

desc 'Start development server'
task :start => 'start:development'

# Gemfile
group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'foreman', '~> 0.82.0'
end

# bundle install
# bin/rake start
# bin/rake start:production
```

```js
// App.js
import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {
  componentDidMount() {
    window.fetch('api/drinks')
      .then(response => response.json())
      .then(json => console.log(json))
      .catch(error => console.log(error))
  }
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h2>Welcome to React</h2>
        </div>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
      </div>
    );
  }
}

export default App;
```

```bash
npm install semantic-ui-react --save
npm install semantic-ui-css --save

yarn add semantic-ui-react
yarn add semantic-ui-css
```

```js
// client/src/index.js
import React from 'react'
import ReactDOM from 'react-dom'
import App from './App'
import 'semantic-ui-css/semantic.css'
import './index.css'

ReactDOM.render(
  <App />,
  document.getElementById('root')
)

// client/src/app.js
import React, { Component } from 'react'
import { Container, Header, Segment, Button, Icon, Dimmer, Loader, Divider } from 'semantic-ui-react'

class App extends Component {
  constructor () {
    super()
    this.state = {}
    this.getDrinks = this.getDrinks.bind(this)
    this.getDrink = this.getDrink.bind(this)
  }
  componentDidMount () {
    this.getDrinks()
  }
  fetch (endpoint) {
    return new Promise((resolve, reject) => {
      window.fetch(endpoint)
      .then(response => response.json())
      .then(json => resolve(json))
      .catch(error => reject(error))
    })
  }
  getDrinks () {
    this.fetch('api/drinks')
      .then(drinks => {
        this.setState({drinks: drinks})
        this.getDrink(drinks[0].id)
      })
  }
  getDrink (id) {
    this.fetch(`api/drinks/${id}`)
      .then(drink => this.setState({drink: drink}))
  }
  render () {
    let {drinks, drink} = this.state
    return drinks
    ? <Container text>
        <Header as='h2' icon textAlign='center'>
        <Icon name='cocktail' circular />
        <Header.Content>
          List of Ingredients
        </Header.Content>
      </Header>
      <Button.Group fluid widths={drinks.length}>
        {Object.keys(drinks).map((key) => {
          return <Button active={drink && drink.id === drinks[key].id} fluid key={key} onClick={() => this.getDrink(drinks[key].id)}>
            {drinks[key].title}
          </Button>
        })}
      </Button.Group>
      <Divider hidden />
      {drink &&
        <Container>
          <Header as='h2'>{drink.title}</Header>
          {drink.description && <p>{drink.description}</p>}
          {drink.ingredients &&
            <Segment.Group>
              {drink.ingredients.map((ingredient, i) => <Segment key={i}>{ingredient.description}</Segment>)}
            </Segment.Group>
          }
          {drink.steps && <p>{drink.steps}</p>}
        </Container>
      }
    </Container>
    : <Container text>
      <Dimmer active inverted>
        <Loader content='Loading' />
      </Dimmer>
    </Container>
  }
}

export default App
```

### deploy

```json
{
  "name": "list-of-ingredients",
  "engines": {
    "node": "6.3.1"
  },
  "scripts": {
    "build": "cd client && npm install && npm run build && cd ..",
    "deploy": "cp -a client/build/. public/",
    "postinstall": "npm run build && npm run deploy && echo 'Client built!'"
  }
}
```


