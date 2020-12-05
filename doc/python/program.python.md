# 简易 python

简易,一定要挑最简单方法来

## 基础

"1 2 3 4 5".split() => ["1","2","3","4","5"]

https://www.runoob.com/python/att-string-split.html

拼接
print("str", str(1))

string in/find

```python
s = "This be a string"
if s.find("is") == -1:
    print "No 'is' here!"
elif "string" in s:
    print "string in there"
```

https://blog.csdn.net/zhuhai__yizhi/article/details/77671498

```python
map(str, [1, 2, 3, 4, 5])
```

## python3异常

https://www.runoob.com/python3/python3-errors-execptions.html

## switch/case

https://blog.csdn.net/l460133921/article/details/74892476

建议: 使用 `if/else`

## 进阶

### null vs none

https://blog.csdn.net/Li_Danny/article/details/49815761

### 用__init__参数自动初始化实例变量

https://blog.csdn.net/u010039733/article/details/49430889

```python
def attributesFromDict(d):
  self = d.pop('self')
  for n, v in d.iteritems():
    setattr(self, n, v)
class A(object):
    def __init__(self,foo,bar,baz,boom=1,bang=2):
        print locals()
        attributesFromDict(locals())

a = A('A','B',1)
print "a.foo=", a.foo
print "a.bar=", a.bar
```

### 调用系统命令

python 多用于运维场景,那么调用系统命令就非常重要.

+ [os.popen](https://docs.python.org/zh-cn/3/library/os.html#os.popen),可以返回打印的结果
+ [os.system](https://docs.python.org/zh-cn/3/library/os.html#os.system)
  不能返回打印的内容,只能返回最后的0/xxx,运行是否成功

[参考|python执行系统命令后获取返回值的几种方式](https://blog.csdn.net/konglongaa/article/details/80327446)

### 只在被直接调用时运行

```python
if __name__ == '__main__':
  print("hello world")
```

### 私有方法继承

```python
class base():
    def process(self):
        self.step()
        self.__step2()
    def __step3(self):
        print("this is step3 of base")
    def __step2(self):
        print("this is step2 of base")
    def step(self):
        print("this is step of base")

class A(base):
    def __init__(self):
        self.name = 'A'

    def process2(self):
        self.__step3()
    def __step2(self):
        print("this is step2 of A")
    def step(self):
        print("this is step of A")

A().process()
# 输出：
# this is step of A
# this is step2 of base
A().process2()
# 报错：
# AttributeError: 'A' object has no attribute '_A__step3'
```

私有函数因为会被“转”成 _类名__函数名

所以在类继承从会失效，父类和子类中的私有函数有很强的“独立”性

+ 子类中继承的函数，如果调用了私有函数，那永远是父类私有函数
+ 子类中的新方法，也无法调用在其它语言中会继承的私有函数

可见python的继承有点后爹的概念，公开的东西法律上支持你继承，但私有的东西基本上不会给了

### logging

[Python之日志处理（logging模块）](https://www.cnblogs.com/yyds/p/6901864.html)

```python
import logging

logging.basicConfig(level=logging.DEBUG)

logging.debug("This is a debug log.")
logging.info("This is a info log.")
logging.warning("This is a warning log.")
logging.error("This is a error log.")
logging.critical("This is a critical log.")
```

#### error: not all arguments converted during string formatting

### unittest

https://docs.python.org/zh-cn/3/library/unittest.html

### import

How to import the class within the same directory or sub directory?
https://stackoverflow.com/questions/4142151/how-to-import-the-class-within-the-same-directory-or-sub-directory