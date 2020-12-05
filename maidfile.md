# MAID

## readme

Go to main page

```bash
open https://github.com/egoist/maid
```

## lint

It uses ESLint to ensure code quality.

```bash
eslint --fix
```

## build

Build our main app

<!-- Following line is a maid command for running task -->
Run task `build:demo` after this

```bash
# note that you can directly call binaries inside node_modules/.bin
# just like how `npm scripts` works
babel src -d lib
```

## build:demo

You can use JavaScript to write to task script too!

```js
const webpack = require('webpack')

// Async task should return a Promise
module.exports = () => new Promise((resolve, reject) => {
  const compiler = webpack(require('./webpack.config'))
  compiler.run((err, stats) => {
    if (err) return reject(err)
    console.log(stats.toString('minimal'))
    resolve()
  })
})
```