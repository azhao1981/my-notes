# ruby 类型检查

## 其它

https://github.com/tupl-tufts/rdl

## 本期的 ruby weekly 推了 [Sorbet](https://sorbet.org/)

## 官方的 blog

<https://sorbet.org/blog/2019/06/20/open-sourcing-sorbet>

<https://sorbet.org/docs/adopting>

<https://sorbet.org/docs/gradual>

<https://sorbet.org/docs/overview>


[sorbet-rails](https://github.com/chanzuckerberg/sorbet-rails)

[ruby-china 的看法](https://ruby-china.org/search?q=sorbet)


coinbase, stripe 两家大厂出品，估计不会降低性能（运行时检查应该可以关掉）。

类型系统对于重构绝对是必须的，已经提交试用申请了

<https://ruby-china.org/topics/38754>

刚看了一下Sorbet，侵入性太强，已经侵入到运行层面了，其实类型标注是给IDE看得，不需要运行时检查，在注释里写已经足够了。

并不是，好好读读文档吧，Sorbet 是可选的静态检查+可选的动态检查，不要以为 extend 了一个 module 就侵入到动态了

https://github.com/sorbet/sorbet/blob/master/gems/sorbet-runtime/lib/types/sig.rb#L10 说了 "不要以为 extend 了一个 module 就侵入到动态了" 看好这是一个空方法

概念问 Wiki https://zh.wikipedia.org/wiki/%E6%8A%BD%E8%B1%A1%E9%87%8A%E4%B9%89

实际参考这个项目 https://github.com/mame/ruby-type-profiler

抽象解释（按 Wiki 的翻译法）有他自己的问题，算法复杂度很高，那个项目试验性质多半要坑


[编程语言之父谈语言设计，龟叔大赞 TypeScript](https://www.cnbeta.com/articles/tech/841471.htm)

Hejlsberg(typescrit) 将类型系统视为“工具性”的功能，开发者喜欢 IDE 提供的代码补全、重构和代码导航这些功能，而这背后都离不开具有类型系统的编译器。

Hejlsberg 也不认为编程语言添加了类型系统就能提升开发者的生产力，
他觉得**开发者使用动态语言，然后以非侵入性方式来添加类型特性反而能提高开发效率**。

Guido 认为，如果希望编程语言具有可维护性，在灵活和规范的方法之间保持平衡非常重要。

**动态语言对于开发小型项目非常有用，但大型项目需要采用严格的类型检查，因此如果编程语言本身能够实现这种平衡就最好不过了**。

这就是为什么 Guido 计划在 Python 中添加类似 TypeScript 的技术。

除了类型系统，重构引擎对编程语言的可维护性也至关重要，通过它可以更容易地同时执行数百万行代码的大规模重构。

Hejlsberg 表示 TypeScript 的起源正是日益庞大的 JavaScript 代码库，代码库越大，维护它们就变得越加困难，这些代码逐渐成了 “write-only code”。为了易于重构，需要对代码进行语义理解，而这些语义理解的工作恰好需要一个类型系统。

[write-only-code 只写代码](https://whatis.techtarget.com/definition/write-only-code)

Write-only code is an ironic(讽刺) way of describing programming code that is hard to read.

The term is a play on(双关) read-only memory (ROM).

The implication is that the code is so complicated or so poorly structured that not even the person who wrote it will ever be able to modify it.

Complex programming languages, such as C and APL, are sometimes referred to as write-only languages, implying that any programs written in them are automatically write-only code.


