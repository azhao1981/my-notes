# win10 下使用 node

## 修改默认路径

Windows下NodeJS安装与npm环境变量配置
https://www.jianshu.com/p/2d9fa3659645

Error: EINVAL: invalid argument, mkdir '

按这个改：
https://www.cnblogs.com/xyptechnology/p/11739213.html

根据这个，把 D:\Program Files\nodejs\node_global 设置给 path,而不是 NODE_PATH(没有设置)
https://blog.csdn.net/jianleking/article/details/79130667
这个说得比较清楚
https://juejin.im/post/5e4925e4f265da5747278667

安装 yarn
https://www.jianshu.com/p/5e111693179e
好像还是不行