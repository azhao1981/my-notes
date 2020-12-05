# git

## git flight-rules

[git飞行守则](https://github.com/k88hudson/git-flight-rules)

[git飞行守则中文版](https://github.com/k88hudson/git-flight-rules/blob/master/README_zh-CN.md)

### 一些常用的引用

```bash
git show

# 合并上次提交
git commit --amend
git commit --amend -m 'xxxxxxx'

# I want to remove a file from a commit
git checkout HEAD^ myfile
git add -A
git commit --amend

# 删除最后一个提交
git reset HEAD^ --hard
git push -f [remote] [branch]
git reset --soft HEAD@{1}  # 没有提交

#取消已经暂存的文件。即，撤销先前"git add"的操作
git reset HEAD <file>...

# git reset --hard 错了
git reflog     # 显示 HEAD@{N}
git reset --hard SHA1234

git stash
git stash list
git stash apply
```

## github-profile-summary

https://github.com/tipsy/github-profile-summary

## 解决冲突

https://github.com/mkchoi212/fac

## revert 多个commit

https://codeday.me/bug/20170417/2196.html

$ git revert --no-commit D
$ git revert --no-commit C
$ git revert --no-commit B
$ git commit -m 'the commit message'

or
$ git checkout -f A -- .
$ git commit -a

## bare 建库

```bash
git init --bare down.git
git remote set-url origin  s1:/srv/git/down.git
git remote add origin  /srv/git/down.git
```

## cannot-update-paths

<http://stackoverflow.com/questions/22984262/cannot-update-paths-and-switch-to-branch-at-the-same-time>

## Git 使用中显示“Another git process seems to be running in this repository...”问题解决

https://blog.csdn.net/u012814856/article/details/62883795

## error: pathspec 'add_hz_p2_production' did not match any file(s) known to git.

原因: remote 分支里有多个分支是一样的
解决: 手动指定远程库

```bash
git checkout origin/add_hz_p2_production -b add_hz_p2_production
```

## git review

* 建立  review 分支 (本地) `git checkout origin/xxx -b review/xxx`
* 需要进行review的commit
* 使用 fdi 打开
* git rev-list --boundary feature_IM-2031_msg_drive_assign...develop | grep "^-" | cut -c2-
  [引用](http://stackoverflow.com/questions/1527234/finding-a-branch-point-with-git)
*

## git remote update

git remote update
git checkout -b Feature3 origin/Feature3

## git 管理
sublime text:

https://github.com/kemayo/sublime-text-git/wiki

## git config
  http://stackoverflow.com/questions/23918062/simple-vs-current-push-default-in-git-for-decentralized-workflow
  push
    default = simple / current / matching

  如果用matching,会出现把所有的本地与origin名字相同的都上推,如果一担用了git push -f 会强推覆盖,造成不想要的结果
π
  最好用 current

## 忽略已经提交的文件

https://segmentfault.com/q/1010000000430426

git rm --cached logs/xx.log，然后更新 .gitignore
commit

## 删除远程分支

```shell
git push origin :serverfix
git push origin :Develop

git -r -d 遠端branch 刪除一個 tracking 的遠端 branch，例如git branch -r -d wycats/master
```

## git tool

https://github.com/paulirish/git-recent 显示本地分支最后的修改

https://github.com/so-fancy/diff-so-fancy/

https://hub.github.com/ github 工具

checkout tag

git checkout -b tag_name tag_name
git checkout -b v3.2.1 v3.2.1

git config --global https.proxy 'socks5://127.0.0.1:1080'

## 全局忽略

git config --global core.excludesfile ~/.gitignore_global

## 引用

[Git 情境劇](http://gogojimmy.net/2012/02/29/git-scenario/)

<https://dev.to/g_abud/advanced-git-reference-1o9j?utm_source=digest_mailer&utm_medium=email&utm_campaign=digest_email>

## 删除

git clean -f -d
git clean -f -X

## 删除文件

git rm -r --cached a/2.txt                    // 删除a目录下的2.txt文件 

git commit -m  "删除a目录下的2.txt文件"  // commit

## 取得commit hash

git show -s --format=%h
git show -s --format=%H

git rev-parse HEAD

git rev-parse --verify HEAD
git for-each-ref
git show-ref

本来看起来很好的

https://github.com/acaudwell/Gource


## 找一个父结点

https://stackoverflow.com/questions/1527234/finding-a-branch-point-with-git

git rev-list --boundary branch-a...master | grep "^-" | cut -c2-
[alias]
    diverges = !sh -c 'git rev-list --boundary $1...$2 | grep "^-" | cut -c2-'
$ git diverges branch-a master


FROM=$1

function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}

echo "git rev-list --boundary $(parse_git_branch)...$FROM"

function git_from_commit() {
	git rev-list --boundary $(parse_git_branch)...$FROM | grep "^-" | cut -c2-
}

git log $(git_from_commit)


### git丢弃本地修改的所有文件（新增、删除、修改）

<https://blog.csdn.net/leedaning/article/details/51304690>

```bash
# 一个命令完成
git checkout . && git clean -xdf

git checkout . #本地所有修改的。没有的提交的，都返回到原来的状态
git stash #把所有没有提交的修改暂存到stash里面。可用git stash pop回复。
git reset --hard HASH #返回到某个节点，不保留修改。
git reset --soft HASH #返回到某个节点。保留修改

git clean -df #返回到某个节点
git clean 参数
    -n 显示 将要 删除的 文件 和  目录
    -f 删除 文件
    -df 删除 文件 和 目录
```

### Git LFS的使用

https://www.jianshu.com/p/493b81544f80
