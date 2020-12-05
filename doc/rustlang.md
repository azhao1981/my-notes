# rust 语言

## 教程

https://doc.rust-lang.org/book/ch02-00-guessing-game-tutorial.html

## awesome

[rust 的 ui,不错](https://github.com/redox-os/orbtk)

## 中国镜像

### rustup

不建议使用 brew

#### 方法1:(可用) https://lug.ustc.edu.cn/wiki/mirrors/help/rust-static

```bash
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

引用 https://mirrors.ustc.edu.cn/help/rust-static.html

[Rustup 镜像安装帮助](https://mirror.tuna.tsinghua.edu.cn/help/rustup/)

win10
https://my.oschina.net/u/4308120/blog/3321040
使用 Chocolatey 在 Win10 下配置 rust 开发环境
http://jamsa.github.io/shi-yong-chocolatey-zai-win10-xia-pei-zhi-rust-kai-fa-huan-jing.html

where cargo 需要在 command里运行，不能在 terminel里

#### error: cannot install while Rust is installed
需要先删除以前的版本

brew unlink rust
Unlinking /usr/local/Cellar/rust/1.38.0... 18 symlinks removed

### 包镜像 Rust Crates

https://lug.ustc.edu.cn/wiki/mirrors/help/rust-crates

$HOME/.cargo/config

```bash
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
```

### nat

⚡️ nat - the 'ls' replacement you never knew you needed⚡️
https://github.com/willdoescode/nat
cargo build --release
使用国内镜像加速 Rust 更新与下载
https://cloud.tencent.com/developer/article/1620144