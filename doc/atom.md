ATOM
=======
ruby 不能使用默认RoR

https://atom.io/packages/file-types

https://github.com/atom/keybinding-resolver
cmd + . 造成的

[纪要](http://www.jeffjade.com/2016/03/03/2016-03-02-how-to-use-atom/?fsg=)

markdown-writer
```
快捷键操作	作用效果
“shift-cmd-K”:	“markdown-writer : insert-link”
“shift-cmd-I”:	“markdown-writer : insert-image”
“cmd-i”:	“markdown-writer : toggle-italic-text”
“cmd-b”:	“markdown-writer : toggle-bold-text”
“cmd-‘“:	“markdown-writer : toggle-code-text”
“cmd-k”:	“markdown-writer : toggle-keystroke-text”
“cmd-h”:	“markdown-writer : toggle-strikethrough-text”
“ctrl-alt-1”:	“markdown-writer : toggle-h1”
“ctrl-alt-2”:	“markdown-writer : toggle-h2”
“ctrl-alt-3”:	“markdown-writer : toggle-h3”
“ctrl-alt-4”:	“markdown-writer : toggle-h4”
“ctrl-alt-5”:	“markdown-writer : toggle-h5”
“shift-cmd-O”:	“markdown-writer : toggle-ol”
“shift-cmd-U”:	“markdown-writer : toggle-ul”
“shift-cmd->”:	“markdown-writer : toggle-blockquote”
‘shift-cmd-“‘:	“markdown-writer : toggle-codeblock-text”
“cmd-j cmd-p”:	“markdown-writer : jump-to-previous-heading”
“cmd-j cmd-n”:	“markdown-writer : jump-to-next-heading”
“cmd-j cmd-d”:	“markdown-writer : jump-between-reference-definition”
“cmd-j cmd-t”:	“markdown-writer : jump-to-next-table-cell”
```

开发插件

http://www.jianshu.com/p/98f99c20493c

这个问题的

https://discuss.atom.io/t/open-rb-files-with-ror-grammar-by-default-instead-of-ruby/14093/7

markdown
ctl + shift + M
![Alt text](/path/to/img.jpg)

快捷键
https://github.com/futantan/atom

atom ~/.atom/snippets.cson


apm install merge-conflicts


快捷键
ctrl-cmd-G 选取文档中所有和当前光标单词相同的位置
cmd-shift-L 将多行选取改为多行光标

文件切换

ctrl-shift-s 保存所有打开的文件
cmd-shift-o 打开目录
cmd-\ 显示或隐藏目录树
ctrl-0 焦点移到目录树
目录树下，使用a，m，delete来增加，修改和删除
cmd-t或cmd-p 查找文件
cmd-b 在打开的文件之间切换
cmd-shift-b 只搜索从上次git commit后修改或者新增的文件

导航

（等价于上下左右）
ctrl-p 前一行
ctrl-n 后一行
ctrl-f 前一个字符
ctrl-b 后一个字符

alt-B, alt-left 移动到单词开始
alt-F, alt-right 移动到单词末尾

cmd-right, ctrl-E 移动到一行结束
cmd-left, ctrl-A 移动到一行开始

cmd-up 移动到文件开始
cmd-down 移动到文件结束

ctrl-g 移动到指定行 row:column 处

cmd-r 在方法之间跳转

目录树操作

cmd-\ 或者 cmd-k cmd-b 显示(隐藏)目录树
ctrl-0 焦点切换到目录树(再按一次或者Esc退出目录树)
a 添加文件
d 将当前文件另存为(duplicate)
i 显示(隐藏)版本控制忽略的文件
alt-right 和 alt-left 展开(隐藏)所有目录
ctrl-al-] 和 ctrl-al-[ 同上
ctrl-[ 和 ctrl-] 展开(隐藏)当前目录
ctrl-f 和 ctrl-b 同上
cmd-k h 或者 cmd-k left 在左半视图中打开文件
cmd-k j 或者 cmd-k down 在下半视图中打开文件
cmd-k k 或者 cmd-k up 在上半视图中打开文件
cmd-k l 或者 cmd-k right 在右半视图中打开文件
ctrl-shift-C 复制当前文件绝对路径

书签

cmd-F2 在本行增加书签
F2 跳到当前文件的下一条书签
shift-F2 跳到当前文件的上一条书签
ctrl-F2 列出当前工程所有书签

选取

大部分和导航一致，只不过加上shift
ctrl-shift-P 选取至上一行
ctrl-shift-N 选取至下一样
ctrl-shift-B 选取至前一个字符
ctrl-shift-F 选取至后一个字符
alt-shift-B, alt-shift-left 选取至字符开始
alt-shift-F, alt-shift-right 选取至字符结束
ctrl-shift-E, cmd-shift-right 选取至本行结束
ctrl-shift-A, cmd-shift-left 选取至本行开始
cmd-shift-up 选取至文件开始
cmd-shift-down 选取至文件结尾
cmd-A 全选
cmd-L 选取一行，继续按回选取下一行
ctrl-shift-W 选取当前单词

编辑和删除文本

基本操作

ctrl-T 使光标前后字符交换
cmd-J 将下一行与当前行合并
ctrl-cmd-up, ctrl-cmd-down 使当前行向上或者向下移动
cmd-shift-D 复制当前行到下一行
cmd-K, cmd-U 使当前字符大写
cmd-K, cmd-L 使当前字符小写

删除和剪切

ctrl-shift-K 删除当前行
cmd-backspace 删除到当前行开始
cmd-fn-backspace 删除到当前行结束
ctrl-K 剪切到当前行结束
alt-backspace 或 alt-H 删除到当前单词开始
alt-delete 或 alt-D 删除到当前单词结束

多光标和多处选取

cmd-click 增加新光标
cmd-shift-L 将多行选取改为多行光标
ctrl-shift-up, ctrl-shift-down 增加上（下）一行光标
cmd-D 选取文档中和当前单词相同的下一处
ctrl-cmd-G 选取文档中所有和当前光标单词相同的位置

括号跳转

ctrl-m 相应括号之间，html tag之间等跳转
ctrl-cmd-m 括号(tag)之间文本选取
alt-cmd-. 关闭当前XML/HTML tag

编码方式

ctrl-shift-U 调出切换编码选项

查找和替换

cmd-F 在buffer中查找
cmd-shift-f 在整个工程中查找

代码片段

  alt-shift-S 查看当前可用代码片段

在~/.atom目录下snippets.cson文件中存放了你定制的snippets
定制说明

自动补全

ctrl-space 提示补全信息

折叠

alt-cmd-[ 折叠
alt-cmd-] 展开
alt-cmd-shift-{ 折叠全部
alt-cmd-shift-} 展开全部
cmd-k cmd-N 指定折叠层级 N为层级数

文件语法高亮

ctrl-shift-L 选择文本类型

使用Atom进行写作

ctrl-shift-M Markdown预览
可用代码片段

b, legal, img, l, i, code, t, table
git操作

cmd-alt-Z checkout HEAD 版本
cmd-shift-B 弹出untracked 和 modified文件列表
alt-g down alt-g up 在修改处跳转
alt-G D 弹出diff列表
alt-G O 在github上打开文件
alt-G G 在github上打开项目地址
alt-G B 在github上打开文件blame
alt-G H 在github上打开文件history
alt-G I 在github上打开issues
alt-G R 在github打开分支比较
alt-G C 拷贝当前文件在gihub上的网址

推荐一些好用的插件

主题
atom-material-ui 好看到爆
atom-material-syntax
美化
atom-beautify 一键代码美化
file-icons 给文件加上好看的图标
atom-minimap 方便美观的缩略滚动图
git
atomatigit 可视化git操作
代码提示
emmet 这个不用介绍了吧
atom-ternjs js代码提示很强大，高度定制化
docblockr jsdoc 给js添加注释
autoclose-html 闭合html标签
color-picker 取色器 必备插件
pigments 颜色显示插件 必装
terminal-panel 直接在atom里面写命令了
svg-preview svg预览
便捷操作
advanced-open-file 快速打开、切换文件
project-folder 快速打开、切换项目
就这些了，欢迎pull更多好用的插件！