# fish shell

## 安装

http://fishshell.com/
http://www.ruanyifeng.com/blog/2017/05/fish_shell.html

### linux.ubuntu

```bash
sudo apt instsall fish
fish
```

~/.config/fish/config.fish
fish_config

### fish.pyenv config

```bash
set PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
```

[ref](https://gist.github.com/sirkonst/e39bc28218b57cc78b6f728b8da99f33)

### fish.nvm config

这个太麻烦，先不用，大意现在还不支持

<https://nicedoc.io/brigand/fast-nvm-fish>
<https://github.com/nvm-sh/nvm/blob/master/README.md#install-script>


Note: nvm does not support Fish either (see #303). Alternatives exist, which are neither supported nor developed by us:
```bash
oh-my-fish
curl -L https://get.oh-my.fish | fish

# 最后用：<https://github.com/derekstavis/plugin-nvm>
omf install nvm
```

### fish.goenv config

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fisher add  yamadayuki/goenv

<https://github.com/yamadayuki/goenv>
<https://stanislas.blog/2018/07/how-to-use-nvm-rbenv-pyenv-goenv-with-fish-shell/>

### fish.rbenv config

```bash
set -x PATH $HOME/.rbenv/bin $PATH
rbenv init - | source
```

### fish.alias

```bash
abbr -a <新命令> <原始命令>
# 例如用l来代替ls -al这一命令
abbr -a l ls -al
abbr -a "sshcc" "cat ~/.ssh/conf.d/*.conf > ~/.ssh/config"
```

https://www.jianshu.com/p/87d7d26c5a5c

### fish.history
https://stackoverflow.com/questions/54225341/how-to-load-fish-command-history-from-file
