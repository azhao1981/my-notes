# js

## 在 2016 年学 JavaScript 是一种什么样的体验？

<https://hackernoon.com/how-it-feels-to-learn-javascript-in-2016-d3a717dd577f#.axai1uwuo>

https://www.v2ex.com/t/310767

## js函数式编程指南

<https://www.gitbook.com/book/llh911001/mostly-adequate-guide-chinese/>

## [vscode debug](http://jerryzou.com/posts/vscode-debug-guide/)

## [vuejs心法和技法](http://www.cnblogs.com/kidsitcn/p/5409994.html)

## [如何更好地运用 Chrome (Google)](http://jeffjade.com/2017/05/01/122-how-to-better-use-google_chrome/)

## 大数据显示

[Clusterize.js](http://blog.nrowegt.com/get-rails-data-to-glass-quicker-with-clusterize-js-coffeescript/)

## baidu echarts

<http://echarts.baidu.com/>

<https://github.com/ecomfe/echarts>

## sockio

<https://www.zhihu.com/question/20215561>

<http://www.alloyteam.com/2015/04/qian-duan-qiang-hou-duan-fan-wan-node-js-socket-io-zhi-zuo-jian-yi-liao-tian-shi/>

## 取ip

http://www.expressjs.com.cn/guide/behind-proxies.html

## yarn

npm install -g cnpm --registry=https://registry.npm.taobao.org

yarn config set registry https://registry.npm.taobao.org -g

## node npm cn

```bash
# node:
# node install:
brew install nodejs
# or
brew upgrade nodejs
# npm install:
curl -L https://www.npmjs.com/install.sh | sh

# npm cn:
npm install -g cnpm --registry=https://registry.npm.taobao.org

# 如果以前装了 npm 会有错误
which npm # 为空

ll /usr/local/bin/ | grep npm
#=> lrwxr-xr-x  1 azhao  staff    30B  6 20 10:46 npm -> ../Cellar/node/0.10.21/bin/npm

# 需要重新link一下

cd /usr/local/bin/

ln -nfs ../Cellar/node/6.2.0/bin/npm npm

which npm
# => /usr/local/bin/npm

```

http://npm.taobao.org/mirrors/node/latest-v5.x/

http://npm.taobao.org

npm install -g node-gyp

http://www.oschina.net/translate/going-native-with-react

http://stack.formidable.com/radium/

`npm install radium`

## markdown ppt

[nodePPT](https://github.com/ksky521/nodePPT)

[推荐nodeppt：使用markdown语法来写网页ppt](http://js8.in/2013/11/16/%E6%8E%A8%E8%8D%90nodeppt%EF%BC%9A%E4%BD%BF%E7%94%A8markdown%E8%AF%AD%E6%B3%95%E6%9D%A5%E5%86%99%E7%BD%91%E9%A1%B5ppt/)

[用Markdown写一个极客范儿的PPT](http://www.jianshu.com/p/e063303317cb)

  https://github.com/adamzap/landslide

  https://github.com/hakimel/reveal.js

```bash
  npm install -g nodeppt

  nodeppt start -p port
```
  # or

```bash
  nodeppt start -p port -d path/for/ppts

  # 支持markdown语法快速创建网页幻灯片。
  nodeppt create ppt-name

  # html版本，
  nodeppt create ppt-name.html
```

  title: 这是演讲的题目

  speaker: 演讲者名字

  url: 可以设置链接

  transition: 转场效果，例如：zoomin

  files: 引入js和css的地址，如果有的话~自动放在页面底部

## 其它

### meteor

<http://zh.discovermeteor.com/chapters/introduction/>

<http://www.telescopeapp.org>

<https://www.nitrous.io>

<https://github.com/facebook/watchman>

<https://github.com/facebook/flow>

<https://github.com/facebook/mysql-5.6>

<https://github.com/facebook/presto>

<https://github.com/facebook/nuclide An open IDE for web and native mobile development>

<https://github.com/facebook/osquery>

<https://github.com/facebook/jest Painless JavaScript Unit Testing>

<http://react-china.org/latest>

<http://wiki.jikexueyuan.com/project/react-native/>

<https://github.com/shakacode/react_on_rails>

<https://github.com/kadirahq/react-storybook>

<https://github.com/Codiad/Codiad>

<http://www.hongkiat.com/blog/cloud-ide-developers/>
