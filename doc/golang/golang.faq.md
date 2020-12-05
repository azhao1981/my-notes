# golang 常见错误

## go get GOPATH error:

```shell
go get
go install: no install location for directory /Users/azhao/dev/mylg outside GOPATH
    For more details see: go help gopath
go env # 用这个看最有用
```
http://stackoverflow.com/questions/26134975/go-install-no-install-location-for-directory-outside-gopath


git clone https://github.com/golang/net.git $GOPATH/src/github.com/golang/net

git clone https://github.com/golang/sys.git $GOPATH/src/github.com/golang/sys

git clone https://github.com/golang/tools.git $GOPATH/src/github.com/golang/tools

ln -s $GOPATH/src/github.com/golang $GOPATH/src/golang.org/x

## github.com/ramya-rao-a/go-outline

<https://zhuanlan.zhihu.com/p/53566172>

```bash
cd $GOPATH
mkdir -p golang.org/x
cd golang.org/x
git clone https://github.com/golang/tools.git  --depth=1
go get -v github.com/sqs/goreturns
go get -v github.com/ramya-rao-a/go-outline
```