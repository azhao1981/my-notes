emacs.md
-----


放弃 ,做为一个 vim 的传人不要花时间去搞这个东西.

git clone https://github.com/azhao1981/emacs.d.git ~/.emacs.d

https://github.com/emacs-tw/emacs-101/blob/master/06-安裝套件入門.org

https://gist.github.com/shijinkui/2048195 基础快捷键

http://www.slideshare.net/bobo52310/elixir-64190936 好用的elixir 编辑器

https://github.com/nightire/dotfiles/blob/master/neovim.md 好的建议



http://man.linuxde.net/emacs
基本

C-x C-c : 退出Emacs
C-x C-f : 打开一个文件，如果文件不存在，则创建一个文件
C-g : 取消未完成的命令
C-x RET = M-x
上下左右
C-x C-s     保存当前缓冲区

光标移动命令
C-f         前进一个字符 forward
C-b       后退一个字符 back
C-p       上一行 pre
C-n       下一行 next
M-f       前进一个单词
M-b     后退一个单词
C-a       行首
C-e       行尾
C-v       下翻一页
M-v      上翻一页
M-<      文件头
M->      文件尾

Evil emacs 的vim模式

http://mazhuang.org/2015/05/10/emacs/#common-lisp-

来自: http://man.linuxde.net/emacs

/************************************/
基本命令
C-x C-f      打开/新建文件


C-x C-w    当前缓冲区另存为
C-x C-v     关闭当前Buffer并打开新文件
C-x i          光标处插入文件
C-x b         切换Buffer
C-x C-b     显示Buffer列表
C-x k         关闭当前Buffer
C-x C-c     关闭Emacs

/************************************/
窗口命令
C-x 2       水平分割窗格
C-x 3       垂直分割窗格
C-x 0      关闭当前窗口
C-x o      切换窗口
C-x 1       关闭其他窗口
C-x 5 2   新建窗口
C-x 5 f    新窗口中打开文件

/************************************/
光标移动命令
C-f         前进一个字符
C-b       后退一个字符
C-p       上一行
C-n       下一行
M-f       前进一个单词
M-b     后退一个单词
C-a       行首
C-e       行尾
C-v       下翻一页
M-v      上翻一页
M-<      文件头
M->      文件尾

/**********************************/
编辑命令
C-Space         设置开始标记
C-@                设置开始标记(C-space可能被操作系统拦截)
M-w                复制标记区内容
C-y                  帖粘
M-u                使光标处的单词大写
M-l                 使光标处的单词小写
M-c                使光标处单词首字母大写
C-k                  删除一行

/**********************************/
搜索/替换命令
C-s          向下搜索
C-r          向上搜索
M-%       替换
-              space/y     替换当前匹配
-              Del/n          不要替换当前匹配
-              .                    仅替换当前匹配并退出
-              ,                    替换并暂停(按space或y继续)
-              !                    替换所有匹配
-             ^                   回到上一个匹配位置
-             return/q    退出替换
