# javascript

## 安装

[ 安装 Node.js 的最佳方案 —— NVM](https://learnku.com/docs/environment-setup/use-nvm-to-manage-your-nodejs-environment/3131)

+ nvm
+ node
+ npm
+ cnpm
+ yarn

### nvm

[清除旧版本](http://bubkoo.com/2017/01/08/quick-tip-multiple-versions-node-nvm/)

[主机](https://github.com/nvm-sh/nvm)

最新版本
```bash
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

echo 'export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node' >> ~/.bash_profile
```

### node

cn: `export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node`

https://nodejs.org/en/

```bash
# 最新稳定版本
nvm install 14.5.0
# 用户最多版本
nvm install 12.18.3
nvm use 12
nvm alias default 12.18.3
```

**io.js** 好像没有必要 <https://www.csdn.net/article/2014-12-17/2823170>

https://iojs.org -> 已经指向 nodejs.org 了

nvm is not compatible with the npm config "prefix" option

### npm

```bash
npm -v
npm config set registry=https://registry.npm.taobao.org
npm install -g npm
```

### cnpm

https://cnpmjs.org/

```bash
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

或者使用 alias
```bash
alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/mirrors/node \
--userconfig=$HOME/.cnpmrc"
```

```bash
npm config get registry
npm config set registry https://registry.npm.taobao.org
yarn config get registry
yarn config set registry https://registry.npm.taobao.org
```

### yarn

`npm install -g yarn`

### 用法

``` bash
# alias
nvm alias awesome-version 4.2.2
nvm use awesome-version
nvm unalias awesome-version
nvm alias default node
nvm ls
# 导入包
nvm install v5.0.0 --reinstall-packages-from=4.2
```

## 中台

https://pro.ant.design/docs/getting-started-cn

npm install node-fetch

## Prettier

[Prettier看这一篇就行了](https://zhuanlan.zhihu.com/p/81764012)
https://blog.bitsrc.io/let-the-computer-do-the-formatting-ddb799e8a068
https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode
https://prettier.io/playground/

## node 打印对象

https://cnodejs.org/topic/54bfc3972d19f08315f355bb

```js
console.dir(response)
var inspect = require('util').inspect;
console.log(inspect(response))
console.log("%j", obj)
```

## node 性能分析
1.Linux perf
参考文章：nodejs调试指南 perf + FlameGraph

2.Node.js 自带的分析工具
Node.js4.4.0开始，node本身就可以记录进程中V8引擎的性能信息(profiler)，只需要在启动的时候加上参数--prof。

启动应用的时候，node需要带上—-prof参数

然后就会将性能相关信息收集到node运行目录下生成isolate-xxxxxxxxxxxxx-v8.log文件

npm有一个包可以方便的直接将isolate文件转换成，html形式的火焰图GitHub - mapbox/flamebearer: Blazing fast flame graph tool for V8 and Node 🔥

完成以上步骤火焰图果不其然的跑了出来
3.使用Dtrace收集性能数据
方案四：v8-profiler
Node.js 是基于 V8 引擎的，V8 暴露了一些 profiler API，我们可以通过 v8-profiler 收集一些运行时的CPU和内存数据。



[Node使用火焰图优化CPU爆涨](https://mp.weixin.qq.com/s/yE4patSpBA6PpKpc8B8hEQ)
