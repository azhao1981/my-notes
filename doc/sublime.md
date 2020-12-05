# sublime

## 设置

### 解决：Sublime Text3 packagecontrol.io 无法访问的问题

引用: <https://www.jianshu.com/p/23b823d6e786>

`Preferences > Package Settings > Package Control > Settings - User`

```json
"channels":["https://raw.githubusercontent.com/HBLong/channel_v3_daily/master/channel_v3.json"]
```

### 不更新/显示行数

```json
{
  // 不更新
   "update_check":false,
  // 默认字符集
  "default_encoding": "UTF-8",
  "ignored_packages": [
    "Vintage"
  ],
    // 热推出功能！退出时不会提示是否保存文件，而是直接退出
    // 下次打开软件时，文件保持退出前的状态，没来得及保存的内容都在，但并没有真实的写在原文件里
    "hot_exit": true,
    // 软件使用最后的设定打开文件，hot_exit为true时没有效果
    "remember_open_files": true,

  "font_face": "'Fira Code', Menlo, Monaco, 'Courier New', monospace",
  // 设置行间距，看起来不那么”挤“
  "line_padding_bottom": 1, 
  "line_padding_top": 1,
  // 在文字上双击会全选当前的内容，如果里面出现以下字符，就会被截断
//  "word_separators": "./\\()\"'-:,.;<>~!@#$%^&*|+=[]{}`~?",

  // 是否显示行号
  "line_numbers": true,
  // 是否显示行号边栏
  "gutter": true,
  // 行号边栏和文字的间距
  "margin": 4,
  // 是否显示代码折叠按钮
  "fold_buttons": true,
  // Tab键制表符宽度
  "tab_size": 2,
  // 设为true时，缩进和遇到Tab键时使用空格替代
  "translate_tabs_to_spaces": true,
  // 突出显示当前光标所在的行
  "highlight_line": true,
  // 设置光标闪动方式
  "caret_style": "smooth"
}
```

### [x] | 暂没有用 [安装插件优化](https://github.com/wilon/wilon.github.io/issues/8)

  https://github.com/wilon/sublime

  Add Channel https://github.com/wilon/sublime/raw/master/download/channel_v3.json

  curl -Lo ~/.sublime3/channel_v3.json https://packagecontrol.io/channel_v3.json

## 插件

[TODO list](https://github.com/aziz/PlainTasks) 手动装
```
cmd + i new
cmd + d done
ctrl+ c cancelled
```

https://github.com/jonathandelgado/SublimeTodoReview

[Sublime Text 常用插件和设置](https://wido.me/sunteya/sublime-text-packages-and-settings)

[如何优雅地使用Sublime Text3](https://cloud.tencent.com/developer/article/1101653)

[主页](https://packagecontrol.io/)

### rubocop

https://github.com/bbatsov/rubocop

install package

rubocop
  config: check rbenv true
sublimeLinter rubocop
~/.rubocop.yml

### Alignment

不过这插件默认使用的是 ctrl + cmd + a 和 那个抢了 5个全局个快捷键的QQ冲突, 所以需要修改插件的快捷键. 点击菜单 Preferences -> KeyBindings - User, 加入如下内容

```json
{
  "keys": ["super+ctrl+alt+]"],
  "command": "alignment"
}
```

### CTAG

https://github.com/SublimeText/CTags

navigate_to_definition  ctrl+t, ctrl+t  | ctrl+> | ctrl+shift+left_click

jump_prev ctrl+t, ctrl+b  | ctrl+<  | ctrl+shift+right_click

显示所有的,但是太不实用了,打开就很慢

show_symbols (all files)  alt+shift+s

show_symbols (suffix) ctrl+alt+shift+s

### [revive](https://github.com/mgechev/revive) 代替golinter
### [x] Sublime Terminal
### Open In Browser
### Babel
### JsPrettier
### SublimeLinter
### TrailingSpaces
### StringUtilities
### SideBarEnhancements 插件

SideBarEnhancements是一款很实用的右键菜单增强插件；在安装该插件前，在Sublime Text左侧FOLDERS栏中点击右键，只有寥寥几个简单的功能；安装了就相当于给其丰了大胸一般。 更强大的是，该插件还能让我们自定义快捷键呼出某个浏览器以预览页面！这样就不用到项目目录下寻找和拖动到特定浏览器中预览了。

安装此插件后，点击菜单栏的preferences->package setting->side bar->Key Building-User，键入以下代码：

```json
[
    { "keys": ["ctrl+shift+c"], "command": "copy_path" },
    //chrome
    { "keys": ["f2"], "command": "side_bar_files_open_with",            "args": {                "paths": [],                "application": "C:\\Users\\jeffj\\AppData\\Local\\Google\\Chrome\\Application\\chrome.exe",                "extensions":".*"
            }
     }
]
```

这里设置按Ctrl+Shift+C复制文件路径，按F2即可在Chrome浏览器预览效果(如果需要的话，也可以根据自己的需要为Firefox，Safari，IE，Opera等加上)，当然你也可以自己定义喜欢的快捷键，最后注意代码中的浏览器路径要以自己电脑里的文件路径为准。

### markdown

- MarkDown Editing
- [omnimarkuppreviewer](https://macplay.github.io/posts/shi-yong-sublime-text-xie-zuo-markdown/)
- Markdown TOC
- [x] MarkDown Preview
- [x] MarkDown Live Preview

### git

- Git​Gutter
- Gitignore

### sftp

### golang
- [GOLANG](https://www.jianshu.com/p/07308fc14efb)
    + GoSublime
    + [x] Golang build
### rails

- RAILS

### trimmer

- 多余空格高亮，方便删除，强迫症者福音 trimmer

## 设置

### 默认显示 markdonw word wrap true

markdown editing 有自己的配置,需要自己配

```json
"word_wrap": "auto",
"wrap_width": 0
```

### 不使用默认的ruby

> 很简单 右下角-> open all with current extensions as -> 选你想默认打开的

## 快捷键

### goto_definition

[
    {
        "button": "button1", 
        "count": 1, 
        "modifiers": ["ctrl"],
        "press_command": "drag_select",
        "command": "goto_definition"
    },
]

### 如何优雅地使用Sublime Text

https://jeffjade.com/2015/12/15/2015-04-17-toss-sublime-text/

### [devtips ](http://www.rubyguides.com/2017/11/atom-tricks-for-ruby-developers)

  https://github.com/irohiroki/RubyBlockConverter

  `ctrl+shift+[` `ctrl+shift+]`

  https://github.com/spadgos/sublime-ToggleQuotes `ctrl+'`

### emmet 快捷键冲突问题

<https://github.com/sergeche/emmet-sublime#overriding-keyboard-shortcuts>

open Emmet.sublime-settings

package setting -> Emmet-> Setting-User (not key Binding-User )

{
  "disabled_keymap_actions": "expand_abbreviation, update_image_size"
}

ctrl+e ctrl+u

### 一些问题

<http://www.jianshu.com/p/6d90ec28aaa8>

[omnimarkdonw 不能render](https://github.com/timonwong/OmniMarkupPreviewer/issues/85#issuecomment-168078270)

流程图

### plugin

cd ~/Library/Application Support/Sublime Text 3/Packages

git clone git://github.com/kemayo/sublime-text-2-clipboard-history.git ClipboardHistory

alt+cmd + V

git clone https://github.com/skuroda/Sublime-AdvancedNewFile.git
alt+cmd + N tip: 可以用tab键

git clone https://github.com/wuub/SublimeREPL.git
shift-cmd-P  REPL 来 运行

git clone https://github.com/titoBouzout/SideBarFolders.git

Terminality
Ctrl+Key+R

https://github.com/SublimeLinter
要自己选,暂没装
https://github.com/SublimeLinter/SublimeLinter-rubocop

#### theme 自定义
http://tmtheme-editor.herokuapp.com/#!/editor/theme/1337

### 好的用法

[](http://www.jeffjade.com/2015/12/15/2015-04-17-toss-sublime-text/)

### 不打开历史文件

  https://www.douban.com/group/topic/35139258/

  打开 Settings--User

  ```json
    {
      "hot_exit": false,
      "remember_open_files": false,
    }
  ```

### SN

下官网文件,用sn就可以

最新3124能用
```
—– BEGIN LICENSE —–
Michael Barnes
Single User License
EA7E-821385
8A353C41 872A0D5C DF9B2950 AFF6F667
C458EA6D 8EA3C286 98D1D650 131A97AB
AA919AEC EF20E143 B361B1E7 4C8B7F04
B085E65E 2F5F5360 8489D422 FB8FC1AA
93F6323C FD7F7544 3F39C318 D95E6480
FCCC7561 8A4A1741 68FA4223 ADCEDE07
200C25BE DBBC4855 C4CFB774 C5EC138C
0FEC1CEF D9DCECEC D3A5DAD1 01316C36
—— END LICENSE ——

—– BEGIN LICENSE —–
Michael Barnes
Single User License
EA7E-821385
8A353C41 872A0D5C DF9B2950 AFF6F667
C458EA6D 8EA3C286 98D1D650 131A97AB
AA919AEC EF20E143 B361B1E7 4C8B7F04
B085E65E 2F5F5360 8489D422 FB8FC1AA
93F6323C FD7F7544 3F39C318 D95E6480
FCCC7561 8A4A1741 68FA4223 ADCEDE07
200C25BE DBBC4855 C4CFB774 C5EC138C
0FEC1CEF D9DCECEC D3A5DAD1 01316C36
—— END LICENSE ——

—– BEGIN LICENSE —–
Nicolas Hennion
Single User License
EA7E-866075
8A01AA83 1D668D24 4484AEBC 3B04512C
827B0DE5 69E9B07A A39ACCC0 F95F5410
729D5639 4C37CECB B2522FB3 8D37FDC1
72899363 BBA441AC A5F47F08 6CD3B3FE
CEFB3783 B2E1BA96 71AAF7B4 AFB61B1D
0CC513E7 52FF2333 9F726D2C CDE53B4A
810C0D4F E1F419A3 CDA0832B 8440565A
35BF00F6 4CA9F869 ED10E245 469C233E
—— END LICENSE ——

—– BEGIN LICENSE —–
Anthony Sansone
Single User License
EA7E-878563
28B9A648 42B99D8A F2E3E9E0 16DE076E
E218B3DC F3606379 C33C1526 E8B58964
B2CB3F63 BDF901BE D31424D2 082891B5
F7058694 55FA46D8 EFC11878 0868F093
B17CAFE7 63A78881 86B78E38 0F146238
BAE22DBB D4EC71A1 0EC2E701 C7F9C648
5CF29CA3 1CB14285 19A46991 E9A98676
14FD4777 2D8A0AB6 A444EE0D CA009B54
—— END LICENSE ——

—– BEGIN LICENSE —–
Alexey Plutalov
Single User License
EA7E-860776
3DC19CC1 134CDF23 504DC871 2DE5CE55
585DC8A6 253BB0D9 637C87A2 D8D0BA85
AAE574AD BA7D6DA9 2B9773F2 324C5DEF
17830A4E FBCF9D1D 182406E9 F883EA87
E585BBA1 2538C270 E2E857C2 194283CA
7234FF9E D0392F93 1D16E021 F1914917
63909E12 203C0169 3F08FFC8 86D06EA8
73DDAEF0 AC559F30 A6A67947 B60104C6
—— END LICENSE ——
```

Sublime Text 3 配置解释(默认)
{
// 设置主题文件
“color_scheme”: “Packages/Color Scheme – Default/Monokai.tmTheme”,
// 设置字体和大小
“font_face”: “Consolas”,
“font_size”: 12,
// 字体选项：no_bold不显示粗体字，no_italic不显示斜体字，no_antialias和no_antialias关闭反锯齿
// subpixel_antialias和no_round是OS X系统独有的
“font_options”: [],
// 在文字上双击会全选当前的内容，如果里面出现以下字符，就会被截断
“word_separators”: “./\\()\”‘-:,.;<>~!@#$%^&*|+=[]{}`~?”,
// 是否显示行号
“line_numbers”: true,
// 是否显示行号边栏
“gutter”: true,
// 行号边栏和文字的间距
“margin”: 4,
// 是否显示代码折叠按钮
“fold_buttons”: true,
// 不管鼠标在不在行号边栏，代码折叠按钮一直显示
“fade_fold_buttons”: true,
//列显示垂直标尺，在中括号里填入数字，宽度按字符计算
“rulers”: [],
// 是否打开拼写检查
“spell_check”: false,
// Tab键制表符宽度
“tab_size”: 4,
// 设为true时，缩进和遇到Tab键时使用空格替代
“translate_tabs_to_spaces”: false,
// 设置行间距，看起来不那么”挤“
"line_padding_bottom": 1,
"line_padding_top": 1,
// 否则作用于单个空格
“use_tab_stops”: true,
“detect_indentation”: true,
// 按回车时，自动与制表位对齐
“auto_indent”: true,
//针对C语言的
“smart_indent”: false,
// 需要启用auto_indent，第一次打开括号缩进时插入空格？（没测试出来效果…）
“indent_to_bracket”: true,
// 显示对齐的白线是否根据回车、tab等操作自动填补
“trim_automatic_white_space”: true,
// 是否自动换行，如果选auto，需要加双引号
“word_wrap”: false,
// 设置窗口内文字区域的宽度
“wrap_width”: 0,
// 防止被缩进到同一级的字换行
“indent_subsequent_lines”: true,
// 如果没有定义过，则文件居中显示（比如新建的文件）
“draw_centered”: false,
// 自动匹配引号，括号等
“auto_match_enabled”: true,
// 拼写检查的单词列表路径
“dictionary”: “Packages/Language – English/en_US.dic”,
// 代码地图的可视区域部分是否加上边框，边框的颜色可在配色方案上加入minimapBorder键
“draw_minimap_border”: false,
// 突出显示当前光标所在的行
“highlight_line”: false,
// 设置光标闪动方式
“caret_style”: “smooth”,
// 是否特殊显示当前光标所在的括号、代码头尾闭合标记
“match_brackets”: true,
// 设为false时，只有光标在括号或头尾闭合标记的两端时，match_brackets才生效
“match_brackets_content”: true,
// 是否突出显示圆括号，match_brackets为true生效
“match_brackets_square”: false,
// 是否突出显示大括号，match_brackets为true生效
“match_brackets_braces”: false,
// 是否突出显示尖括号，match_brackets为true生效
“match_brackets_angle”: false,
// html和xml下突出显示光标所在标签的两端，影响HTML、XML、CSS等
“match_tags”: true,
// 全文突出显示和当前选中字符相同的字符
“match_selection”: true,
// 设置每一行到顶部，以像素为单位的间距，效果相当于行距
“line_padding_top”: 1,
// 设置每一行到底部，以像素为单位的间距，效果相当于行距
“line_padding_bottom”: 1,
// 设置为false时，滚动到文本的最下方时，没有缓冲区
“scroll_past_end”: true,
// 控制向上或向下到第一行或最后一行时发生什么
“move_to_limit_on_up_down”: false,
// 按space或tab时，实际会产生白色的点（一个空格一个点）或白色的横线（tab_size设置的制表符的宽度），选中状态下才能看到
// 设置为none时，什么情况下都不显示这些点和线
// 设置为selection时，只显示选中状态下的点和线
// 设置为all时，则一直显示
“draw_white_space”: “selection”,
// 制表位的对齐白线是否显示，颜色可在主题文件里设置（guide，activeGuide，stackGuide）
“draw_indent_guides”: true,
// 制表位的对齐白线，draw_normal为一直显示，draw_active为只显示当前光标所在的代码控制域
“indent_guide_options”: ["draw_normal"],
// 为true时，保存文件时会删除每行结束后多余的空格
“trim_trailing_white_space_on_save”: false,
// 为true时，保存文件时光标会在文件的最后向下换一行
“ensure_newline_at_eof_on_save”: false,
// 切换到其它文件标签或点击其它非本软件区域，文件自动保存
“save_on_focus_lost”: false,
// 编码时不能自动检测编码时，将自动检测ASCII, UTF-8 和 UTF-16
“fallback_encoding”: “Western (Windows 1252)”,
// 默认编码格式
“default_encoding”: “UTF-8″,
// 包含空字节的文件被打开默认为十六进制
“enable_hexadecimal_encoding”: true,
// 每一行结束的时候用什么字符做终止符
“default_line_ending”: “system”,
// 设置为enabled时，在一个字符串间按Tab将插入一个制表符
// 设置为true时，按Tab会根据前后环境进行代码自动匹配填补
“tab_completion”: true,
// 代码提示
“auto_complete”: true,
// 代码提示的大小限制
“auto_complete_size_limit”: 4194304,
// 代码提示延迟显示
“auto_complete_delay”: 50,
// 代码提示的控制范围
“auto_complete_selector”: “source – comment”,
// 触发代码提示的其他情况
“auto_complete_triggers”: [ {"selector": "text.html", "characters": "<"} ],
// 设为false时，选择提示的代码按回车或点击可以输出出来，但选择true时不会输出而是直接换行
“auto_complete_commit_on_tab”: false,
// 设置为false，使用Shift + tab总是插入制表符
“shift_tab_unindent”: true,
// 选中的文本按Ctrl + f时，自动复制到查找面板的文本框里
“find_selected_text”: true,
// Data\Packages\Theme – Default\Default.sublime-theme控制软件的主题
“theme”: “Default.sublime-theme”,
// 滚动的速度
“scroll_speed”: 1.0,
// 左边边栏文件夹动画
“tree_animation_enabled”: true,
// 标签页的关闭按钮
“show_tab_close_buttons”: true,
// 针对OS X
“use_simple_full_screen”: false,
// 水平垂直滚动条：system和disabled为默认显示方式，enabled为自动隐藏显示
“overlay_scroll_bars”: “system”,
// 热推出功能！退出时不会提示是否保存文件，而是直接退出
// 下次打开软件时，文件保持退出前的状态，没来得及保存的内容都在，但并没有真实的写在原文件里
“hot_exit”: true,
// 软件使用最后的设定打开文件，hot_exit为true时没有效果
“remember_open_files”: true,
// 针对OS X
“open_files_in_new_window”: true,
// 针对OS X
“close_windows_when_empty”: true,
// 哪些文件会被显示到边栏上
“folder_exclude_patterns”: [".svn", ".git", ".hg", "CVS"],
“file_exclude_patterns”: ["*.pyc", "*.pyo", "*.exe", "*.dll", "*.obj","*.o", "*.a", "*.lib", "*.so", "*.dylib", "*.ncb", "*.sdf", "*.suo", "*.pdb", "*.idb", ".DS_Store", "*.class", "*.psd", "*.db"],
// Goto Anything or Find in Files
“binary_file_patterns”: ["*.jpg", "*.jpeg", "*.png", "*.gif", "*.ttf", "*.tga", "*.dds", "*.ico", "*.eot", "*.pdf", "*.swf", "*.jar", "*.zip"],
// 删除你想要忽略的插件，需要重启, 去掉Vinage开启vim模式
“ignored_packages”: ["Vintage"]
}

我的配置:
{
    "default_encoding": "UTF-8",
    "auto_complete_commit_on_tab": false,
    "auto_complete_delay": 0,
    "auto_complete_with_fields": true,
    "auto_indent": true,
    "auto_match_enabled": true,
    "bold_folder_labels": true,
    "caret_style": "wide",
    "color_scheme": "Packages/Color Scheme - Default/Monokai Bright.tmTheme",
    "fade_fold_buttons": false,
    "fold_buttons": true,
    "font_face": "Consolas",
    "font_options":[],
    "font_size": 13,
    "highlight_line": true,
    "hot_exit": false,
    "ignored_packages":[],
    "match_brackets_angle": true,
    "match_brackets_content": true,
    "match_tags": true,
    "remember_open_files": false,
    "smart_indent": true,
    "tab_size": 4,
    "line_padding_bottom": 1,
    "line_padding_top": 1,
    "translate_tabs_to_spaces": true,
    "word_wrap": "false"
}

快捷键:
[
    { "keys": ["ctrl+["], "command": "exit_insert_mode"},

    { "keys": ["alt+h"], "command": "move", "args": {"by": "characters", "forward": false} },
    { "keys": ["alt+l"], "command": "move", "args": {"by": "characters", "forward": true} },
    { "keys": ["alt+k"], "command": "move", "args": {"by": "lines", "forward": false} },
    { "keys": ["alt+j"], "command": "move", "args": {"by": "lines", "forward": true} },

    { "keys": ["ctrl+j"], "command": "insert", "args": {"characters": "\n"} },
    { "keys": ["ctrl+i"], "command": "auto_complete" },

    { "keys": ["ctrl+i"], "command": "replace_completion_with_auto_complete", "context":
        [
            { "key": "last_command", "operator": "equal", "operand": "insert_best_completion" },
            { "key": "auto_complete_visible", "operator": "equal", "operand": false },
            { "key": "setting.tab_completion", "operator": "equal", "operand": true }
        ]
    },
    { "keys": ["ctrl+d"], "command": "right_delete" },

    { "keys": ["ctrl+h"], "command": "show_panel", "args": {"panel": "replace", "reverse": false} },

    { "keys": ["f3"], "command": "goto_definition" },
    { "keys": ["f4"], "command": "exec", "args": {"kill": true} },
    { "keys": ["f5"], "command": "build" },

    { "keys": ["alt+s"], "command": "save" }
]

