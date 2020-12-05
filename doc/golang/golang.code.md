# golang code

## json

引用: <https://www.cnblogs.com/ycyoes/p/5398796.html>

### 使用一个 struct 来解析

```golang
import (
    "encoding/json"
    "fmt"
)
type Serverslice struct {
    Servers []Server
}
var s Serverslice
json.Unmarshal([]byte(str), &s)
```

### 使用 interface{}

```golang
var f interface{}
err := json.Unmarshal(b, &f)
m := f.(map[string]interface{})
```

### 成生

```golang
var s Serverslice
s.Servers = append(s.Servers, Server{ServerName: "Shanghai_VPN", ServerIP: "127.0.0.1"})
s.Servers = append(s.Servers, Server{ServerName: "Beijing_VPN", ServerIP: "127.0.0.2"})
b, err := json.Marshal(s)
```
