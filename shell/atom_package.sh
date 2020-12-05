#!/bin/bash

# https://atom.io/packages/merge-conflicts
apm install merge-conflicts   # Merge Conflicts: Detect  alt-m d

# https://atom.io/packages/code-peek
apm install code-peek
# '.platform-darwin atom-text-editor':
#   'cmd-alt-e': 'code-peek:peekFunction'
#   'shift-escape': 'code-peek:toggleCodePeekOff'
#
# '.platform-linux atom-text-editor, .platform-win32 atom-text-editor':
#   'ctrl-alt-e': 'code-peek:peekFunction'
#   'shift-escape': 'code-peek:toggleCodePeekOff'

# https://atom.io/packages/project-plus
apm install project-plus
# git clone https://github.com/mehcode/atom-project-plus.git
# ctrl-alt-p (linux/windows) or ctrl-cmd-p (mac) to open the project finder
#
# ctrl-cmd-tab will switch to the next recently used project
# ctrl-shift-cmd-tab will switch to the previous recently used project

# https://atom.io/packages/terminal-plus
# git clone https://github.com/jeremyramin/terminal-plus.git
# terminal-plus:toggle command (Default:ctrl-`)
# https://github.com/jeremyramin/terminal-plus/issues/201

# Same problem on Atom 1.8.0. Non of the suggested solutions worked. Switched to platformio-atom-ide-terminal.
# 但这个会死机
# git clone https://github.com/platformio/platformio-atom-ide-terminal.git

# https://atom.io/packages/linter-ruby
# https://atom.io/packages/linter-rubocop
# https://atom.io/packages/linter-reek
# https://atom.io/packages/linter-ruby-reek
# https://atom.io/packages/linter-erb

# 中国使用 http://leftstick.github.io/tech/2015/07/01/setup-frontend-env-with-atom
# apm config set strict-ssl false
# apm config set registry https://registry.npm.taobao.org
# 安装前端开发环境所需插件
# curl -L http://leftstick.github.io/assets/scripts/atom_plugin.sh | sh
# 使用非模块化linting预设
#
# cat ~/.eslintrc_browser > ~/.eslintrc
# 该预设通常为浏览器端运行的历史遗留项目使用
#
# 使用模块化linting预设
#
# cat ~/.eslintrc_node > ~/.eslintrc

# reference
# https://stiobhart.net/2015-10-03-my-atom-setup/
