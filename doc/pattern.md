# 设计模式

## proxy vs adapter

有一个东西,要变成不同的形式,叫 proxy

有不同的时候,要变成同样东西,需要 adapter

### adapter

+ 要处理的数据,即为 service 中的对象,下好定义
+ 先确定  client 和 client 需要的 interface(方法或函数)
+ 给 适配器 取个名字,建一个虚类,要求实现 interface函数
+ 适配器虚类定义选择函数

### 引用

ruby adapter-design-pattern
https://www.sitepoint.com/using-and-testing-the-adapter-design-pattern/

动态代理模式（Proxy Pattern） - 最易懂的设计模式解析
https://juejin.im/entry/5acb0850f265da239531482b

适配器模式 Adapter Design Pattern
https://juejin.im/post/5d40173be51d4561f95ee9bc

Adapter和Proxy两种设计模式
https://blog.csdn.net/wangzwhu/article/details/3484392