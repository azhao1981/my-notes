# go get 上网问题

## golang.org/x 不能访问问题

### github.com 代换大法 | 最简单

```bash
# 先合并现在的
cd $GOPATH
mkdir -p $GOPATH/src/golang.org/x/
cd $GOPATH/src
mv golang.org/x/* github.com/golang/
rm -rf golang.org/x
# 软链
ln -ns  $GOPATH/src/github.com/golang $GOPATH/src/golang.org/x

cd $GOPATH/src/github.com/golang
git clone https://github.com/golang/net.git 
git clone https://github.com/golang/crypto.git

go install net
```

### CHINA 国内镜像编译 | 推荐

[主页](https://gopm.io/) | [github](https://github.com/gpmgo/gopm) | [doc](https://github.com/gpmgo/docs/blob/master/zh-CN/README.md)

tips
  - 和 $GOPATH 共享目录 `ln -nfs $GOPATH/src /Users/$your_name/.gopm/repos` 
  - 安装需要用替换大法来完成 `go get -u github.com/gpmgo/gopm`

### 代理方式

Shadowsocks虽然能访问一些屏蔽的站点比如 golang.org ,但是它基于socks5协议，对于go get来说，依然不可用。

参考 [如何在长城后面go get一些库](http://colobu.com/2017/01/26/how-to-go-get-behind-GFW/)

[cow](https://github.com/cyfdecyf/cow/) 启动一个http代理，以shadowsocks为二级代理。

```shell
listen = http://127.0.0.1:7777
proxy = socks5://127.0.0.1:1080
```

```bash
export http_proxy=http://127.0.0.1:7777
export https_proxy=http://127.0.0.1:7777
```

### 其它

[GVM](https://gist.github.com/rambolee/f7bc4cfdc52d8c2535513bd933d71c78)

[清华镜像](https://github.com/ustclug/ustcmirror-images)
  - 只有golang下载,没有用

下一个完整的 docker 的一个想法 
  - https://github.com/zalemwoo/goget-forward 这个好像不能用

[go get 获得 golang.org 的项目](https://studygolang.com/articles/5690)

go get -v github.com/fsouza/go-dockerclient

http://www.it610.com/article/4943854.htm
http://blog.wuxu92.com/go-get-use-sock5-proxy/

http_proxy=http://localhost:1080 go get -u github.com/nickng/dingo-hunter

host/
https://coding.net/u/scaffrey/p/hosts/git/raw/master/hosts

```bash
go get 的参数说明：

-d 只下载不安装 
-f 只有在你包含了-u参数的时候才有效，不让-u去验证import中的每一个都已经获取了，这对于本地fork的包特别有用 
-fix 在获取源码之后先运行fix，然后再去做其他的事情 
-t 同时也下载需要为运行测试所需要的包 
-u 强制使用网络去更新包和它的依赖包 
-v 显示执行的命令 
注意，这里的 –v 参数对我们分析问题很有帮助。

$ mkdir -p $GOPATH/src/golang.org/x/
$ cd $GOPATH/src/golang.org/x/
$ git clone https://github.com/golang/net.git net 
$ go install net 

$ cd $GOPATH/src
$ mkdir golang.org
$ cd golang.org
$ mkdir x
$ cd x
$ git clone https://github.com/golang/crypto.git
```

```bash
$ mkdir -p $GOPATH/src/golang.org/x/ 
$ git clone https://github.com/golang/net.git $GOPATH/src/golang.org/x/net 
$ go install net
```

[让golang依赖也走mirror](https://zhuanlan.zhihu.com/p/31402004)

[比较全的工具](https://github.com/xkeyideal/glide)
  - <https://github.com/xkeyideal/glide/blob/master/README_CN.md>

由于这两个网站在 github 上都有一个同步仓库，分别在 
  - http://github.com/golang
  - http://github.com/kubernetes 

所以比较笨的方法就是去下载 github 上对应的代码，然后在手动把目录名改回去，这样 golang 就可以认了。但是这种做法一来比较麻烦，二来升级库的时候会很麻烦，三来很多自动化的依赖管理工具就不能用了，所以大的项目并不推荐这么搞。

glide 算是一个还比较流行的 golang 依赖管理，他提供了一个 mirror 的命令，可以进行自动的 package 地址替换，

比如我想下载 http://golang.org/x/net 那么先敲一个

`glide mirror set https://golang.org/x/net https://github.com/golang/net  --vcs git `

不过 glide mirror 有一个问题就是无法正确的处理 subpackage 
  - 比如我想下载 http://golang.org/x/net/http2 这个 mirror 就没有办法设置了
  - 设置成 http://github.com/golang/net 会把这个项目覆盖到 http2 目录，
  - 设置为 http://github.com/golang/net/http2 又会报找不到 vcs 文件信息。

也就是终极方法，使用一个我国程序员 patch 过的一个 glide 版本（大概国外人都没这个需求），
  - 给 mirror 命令新加了一个 base 参数，
  - 上面的例子通过 `glide mirror set https://golang.org/x/net/http2 https://github.com/golang/net  --base golang.org/x/net --vcs git` 就可以解决了

<https://github.com/xkeyideal/glide/blob/master/README_CN.md>

## orgalorg go  不能下载 还不能用

http://stackoverflow.com/questions/10383299/how-do-i-configure-go-to-use-a-proxy

http_proxy=127.0.0.1:1080 go get code.google.com/p/go.crypto/bcrypt

http://www.tiege.me/?p=802

socket5 to http
privoxy
brew install privoxy

vim /usr/local/etc/privoxy/config

```bash
forward-socks5 / 127.0.0.1:1080 .
listen-address 127.0.0.1:8118
# local network do not use proxy
forward 192.168.*.*/ .
forward 10.*.*.*/ .
forward 127.*.*.*/ .
```

```bash
http_proxy=127.0.0.1:8118 go get github.com/reconquest/orgalorg
orgalorg -o webuser@123.56.190.63 -x -C whoami #root sudo
orgalorg -o webuser@123.56.190.63 -C whoami
```

https://github.com/reconquest/orgalorg
