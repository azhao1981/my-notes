# vscode

## hot key

| md 另一页预览 | ⇧⌘ + V |
| md 开半页预览 |CMD+shift+P Open Preview to the Side |
| 隐藏 命令行面板 | CMD+j / cmd+` |
| 隐藏 右侧栏 | CMD+B |

1. 不打开 markdown -> 装了这个 https://marketplace.visualstudio.com/items?itemName=hnw.vscode-auto-open-markdown-preview ,关掉
用: instant-markdown, 配置-> port: 9088 和 sublime 不一样就可以
2. 快捷把命令行最大化

## [快捷键大全](https://blog.csdn.net/crper/article/details/54099319)

## 文件乱码

[VS code 编码设置/文件乱码解决方法听](https://jingyan.baidu.com/article/5552ef4792ac5a518ffbc996.html)
> 右下角 UTF-8

[这个转的不全|Mac下GBK与UTF8编码文件的批量转换](https://blog.csdn.net/u011595231/article/details/10213049)
> iconv -f GB2312 -t UTF-8 a.html

## ruby server

`gem install solargraph`

## run by rails

code runner -> 配置 -> 默认 rails

executor map

```json
{
    "code-runner.executorMap": {
            "rails": "bin/rails runner"
        }
}
```

## gopls

Couldn't start client gopls
https://github.com/microsoft/vscode-go/issues/3231
https://github.com/Microsoft/vscode/issues/55907

## 新页面打开

https://imtx.me/archives/2679.html

## [tips](https://github.com/Microsoft/vscode-tips-and-tricks)

## markdonw plugin

[lint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)

[shortcuts](https://marketplace.visualstudio.com/items?itemName=mdickin.markdown-shortcuts)

[toc](https://marketplace.visualstudio.com/items?itemName=AlanWalk.markdown-toc)

[theme](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Theme-MarkdownKit)

https://github.com/viatsko/awesome-vscode

## C++

https://www.jianshu.com/p/050fa455bc74

c_cpp_properties.json
/usr/local/opt/openssl/include/

## 插件

### [vscode 效能插件] Snipsnap

<https://github.com/snipsnapdev/snipsnap>

Snipsnap is the ultimate snippets collection and VS Code extension that automatically exposes all available snippets for every library you are using in your project.

主要还是 js
