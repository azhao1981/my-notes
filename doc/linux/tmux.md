tmux
----

https://github.com/disavowd/tmux-dotfiles/blob/master/tmux.conf#L30-L33

# Shift arrow to switch windows:
bind -n S-Left  previous-window
bind -n S-Right next-window

https://github.com/tmuxinator/tmuxinator

https://github.com/tmux-plugins/tpm


### 快捷键速查表:

    https://gist.github.com/ryerh/14b7c24dfd623ef8edc7

#### 常见用法
```bash
tmux new -s weiz
# command
# out and hold
ctrl + b -> d
# back
tmux at -t weiz
# quit
ctrl + d
```


#### 翻页

https://superuser.com/questions/209437/how-do-i-scroll-in-tmux
Ctrl-b PgUp