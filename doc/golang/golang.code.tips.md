# go 代码 tips

## Golang新开发者要注意的陷阱和常见错误

<http://colobu.com/2015/09/07/gotchas-and-common-mistakes-in-go-golang/>

## 设计模式

<https://github.com/tmrts/go-patterns>

## 字符串

<http://www.cnblogs.com/golove/p/3262925.html>

http://xuzhenglun.github.io/2016/04/19/Golang-byte-string-dont-share-menory/

大概是 []byte 对内存的操作不复制

```golang
pckage main

import "fmt"

func main() {
    str := []byte("this is a fucking string")
    str2 := str[0:5]
    str3 := str2[0:2]
    fmt.Printf("%p\n", str)
    fmt.Printf("%p\n", str2)
    fmt.Printf("%p\n", str3)
}
```

```golang
// 从Golang Runtime源代码来看，[]byte与string的转换分别调用了以下两个函数：

runtime.stringtoslicebyte()
runtime.slicebytetostring()

func slicebytetostring(b Slice) (s String) {
    void *pc;

    if(raceenabled) {
        pc = runtime·getcallerpc(&b);
        runtime·racereadrangepc(b.array, b.len, pc, runtime·slicebytetostring);
    }
        s = gostringsize(b.len);
        runtime·memmove(s.str, b.array, s.len);
}

func stringtoslicebyte(s String) (b Slice) {
    b.array = runtime·mallocgc(s.len, 0, FlagNoScan|FlagNoZero);
    b.len = s.len;
    b.cap = s.len;
    runtime·memmove(b.array, s.str, s.len);
}
```
