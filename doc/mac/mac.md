# mac

## brew.cn

[主页](https://brew.sh/index_zh-cn)

```bash
# github慢，改成清华镜像：
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install >> brew_install
# 换源
# BREW_REPO = "https://github.com/Homebrew/brew".freeze
BREW_REPO = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew".freeze
# 执行
/usr/bin/ruby ./brew_install

# 等到
Cloning into '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core'...
# 如果又很慢，就手动执行
git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core --depth=1
# 再执行
/usr/bin/ruby ./brew_install
```

## mac 隐藏文件

https://www.zhihu.com/question/24635640
Command+Shift+. 可以显示隐藏文件、文件夹，再按一次，恢复隐藏；
finder下使用Command+Shift+G 可以前往任何文件夹，包括隐藏文件夹。
defaults write com.apple.finder AppleShowAllFiles -bool true;
KillAll Finder

## mac 红点

[macOS 去除MacOS Mojave系统更新小红点](https://www.douzi.link/remove-mac-system-and-new-red-dot/)

```bash
defaults write com.apple.systempreferences AttentionPrefBundleIDs 0
killall Dock
# 运行完这个就成功了

sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist LastUpdatesAvailable 0
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist LastRecommendedUpdatesAvailable 0
sudo defaults delete /Library/Preferences/com.apple.SoftwareUpdate.plist RecommendedUpdates
```

解救强迫症，教你一招轻松取消Macos 10.15系统更新红点 | 这个是忽略某个软件是新
https://www.sohu.com/a/348452236_100253419

```bash
cd /Applications/Utilities/
sudo softwareupdate --list
sudo softwareupdate --ignore "macOS Catalina"
sudo softwareupdate --reset-ignored
```

### mac 微信双开

```bash
nohup /Applications/WeChat.app/Contents/MacOS/WeChat > /dev/null 2>&1 &
```

应用程序 -> 微信应用程序 -> 点击显示包内容 -> 点击打开Contents，打开MacOS，右键点击WeChat，选择制作替身，然后把替身拖到桌面。打开微信，点击登录，然后打开替身，扫描另一个账户。
多个是怎么搞呢？逻辑上，和windows的策略是一样。微信关闭状态下，联系点击拉到桌面上的替身，可以打开多个微信 。动作快的话，大概5、6个都可以 。

<https://www.zhihu.com/question/60153484>

### cask

```bash
# 注意这里不能 --depth=1，不然brew upate会报cask没有传完
git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask
```

### bottles 二进制

```bash
# bash/fish
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile
# .zshrc
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc
```

### 引用

[清华库比阿里好](https://mirror.tuna.tsinghua.edu.cn/help/homebrew/)

[bottles](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/)

[Mac下更换Homebrew镜像源 ](https://blog.csdn.net/lwplwf/article/details/79097565)

[国内镜像安装Homebrew ](https://www.jianshu.com/p/97b2552fed42)

###  翻译

https://github.com/TimothyYe/ydict/blob/master/README_CN.md

```bash
brew tap timothyye/tap
brew install timothyye/tap/ydict
```

### 休眠漏电

https://www.zhihu.com/question/34902513
pmset -g
`hibernate 3` 的意思可以从下面的手册摘录中看到，是系统在合盖后的一段时间内会持续的给内存通电，这就是合盖耗电的根源！
sudo pmset -b hibernatemode 25
25 是合盖后存入 ssd

### 蓝牙问题

mac 蓝牙关闭 不能打开

https://discussionschinese.apple.com/thread/140140376

Option、Command、P 和 R

https://www.v2ex.com/t/450260

### 安装开发环境

https://stackoverflow.com/questions/5014823/how-to-profile-a-bash-shell-script-slow-startup

### 安装开发环境

https://github.com/sb2nov/mac-setup

### 华文黑体

https://www.zhihu.com/question/49948623
https://zhuanlan.zhihu.com/p/22484570

### mymac

https://github.com/nikitavoloboev/my-mac-os

### idea

https://www.haxotron.com/jetbrains-intellij-idea-crack-123/
Install the latest version of IntelliJ IDEA (v2016.3.4)
Start it
When you have to enter the license, change to [License server]
In the Server URL input field enter: http://jetbrains.tech or http://idea.imsxm.com, for older Servers, check out the bottom of the page, they are all listed
Click on [Ok] and everything should work

https://a2zcity.net/intellij-idea-ultimate/

	view/tool windows/database tool
	hibernate
	Persistence

### bogon

https://air20.com/archives/486.html

sudo hostname your-desired-host-name
sudo scutil --set LocalHostName $(hostname)
sudo scutil --set HostName $(hostname)

### slate 和编辑器的热键冲突 done

1. 左右不全
2. subl不能用上下
3. cmd+左右 不能用

### 三指拖

辅助功能->鼠标与触控板->触控板选项->拖拽->三指

### brew

```bash
https://gitee.com/azhao-1981/homebrew-core

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://gitee.com/azhao-1981/homebrew-core.git
git remote set-url origin https://github.com/Homebrew/homebrew-core.git
```

http://heepo.github.io/工具/2015/08/05/Homebrew-Mirror-Links.html
- git://mirrors.tuna.tsinghua.edu.cn/homebrew.git 这个镜像有问题,应该已经不能用了
- https://github.com/tuna/issues/issues/92
- https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git -> https://mirrors.tuna.tsinghua.edu.cn/homebrew/brew.git/
- git remote set-url origin https://github.com/Homebrew/homebrew-core.git 不行,下不来
- https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
- https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/
- [都不能用了] 清华镜像源: http://mirrors.tuna.tsinghua.edu.cn/
- [都不能用了] 科大镜像源: http://mirrors.ustc.edu.cn/

```bash
brew tap homebrew/science
$ cd /usr/local/Library/Taps/homebrew/homebrew-science
$ git remote set-url origin git://mirrors.tuna.tsinghua.edu.cn/homebrew-science.git
$ brew update
```

### slate 缺点: js 的桌面软件框架,有点大,500M小意思

窗口控制 

https://github.com/jigish/slate

https://github.com/jigish/slate/blob/master/Slate/default.slate

vim ~/.slate

```bash
config defaultToCurrentScreen true
config nudgePercentOf screenSize
config resizePercentOf screenSize

# Resize Bindings
bind right:alt       resize +10% +0
bind left:alt        resize -10% +0
bind up:alt          resize +0   -10%
bind down:alt        resize +0   +10%
bind right:ctrl;alt  resize -10% +0 bottom-right
bind left:ctrl;alt   resize +10% +0 bottom-right
bind up:ctrl;alt     resize +0   +10% bottom-right
bind down:ctrl;alt   resize +0   -10% bottom-right

# Push Bindings
bind right:ctrl;alt;cmd  push right bar-resize:screenSizeX/2
bind left:ctrl;alt;cmd   push left  bar-resize:screenSizeX/2
bind up:ctrl;alt;cmd     push up    bar-resize:screenSizeY/2
bind down:ctrl;alt;cmd   push down  bar-resize:screenSizeY/2

# Nudge Bindings
bind right:shift;alt nudge +10% +0
bind left:shift;alt  nudge -10% +0
bind up:shift;alt    nudge +0   -10%
bind down:shift;alt  nudge +0   +10%

# Throw Bindings
bind m:ctrl;alt;cmd         throw 0 resize
```

### mac不能上网

可能是这个pf的问题

http://www.jianshu.com/p/6052831a8e91
https://my.oschina.net/91jason/blog/546711
mac /etc/pf.conf

```bash
16/9/21 上午1:18:56.998 sudo[44776]:     root : TTY=unknown ; PWD=/ ; USER=root ; COMMAND=/sbin/pfctl -evf /etc/elephantoidal.conf
16/9/21 上午1:18:57.025 sudo[44778]:     root : TTY=unknown ; PWD=/ ; USER=pinsons ; COMMAND=/Library/elephantoidal/Contents/MacOS/elephantoidal
16/9/21 上午1:18:57.056 ReportCrash[44669]: Saved crash report for elephantoidal[44779] version ??? to /Library/Logs/DiagnosticReports/elephantoidal_2016-09-21-011857_MacBook-Air.crash

sudo cat /etc/elephantoidal.conf
Password:
rdr pass inet proto tcp from en0 to any port 80 -> 127.0.0.1 port 9882
pass out on en0 route-to lo0  inet proto tcp from en0 to any port 80 keep state
pass out proto tcp all user pinsons
```

https://github.com/eastany/eastany.github.com/issues/55  中文,而且是
http://superuser.com/questions/1088488/pseudohydrophobia-process-mac
https://objective-see.com/blog/blog_0x0E.html 分析

这是一个恶意的广告软件,把机器的80请求都转给9882,显示广告后才会请求真的网站

http://osxdaily.com/2014/10/25/fix-wi-fi-problems-os-x-yosemite/

1: Remove Network Configuration & Preference Files
Manually trashing the network plist files should be your first line of troubleshooting. This is one of those tricks that consistently resolves even the most stubborn wireless problems on Macs of nearly any OS X version. This is particularly effective for Macs who updated to Yosemite that may have a corrupt or dysfunctional preference file mucking things up:

2. Turn Off Wi-Fi from the Wireless menu item
From the OS X Finder, hit Command+Shift+G and enter the following path:
/Library/Preferences/SystemConfiguration/


3. Within this folder locate and select the following files:
com.apple.airport.preferences.plist
 com.apple.network.identification.plist
com.apple.wifi.message-tracer.plist 
NetworkInterfaces.plist 
preferences.plist

4. Move all of these files into a folder on your Desktop called ‘wifi backups’ or something similar – we’re backing these up just in case you break something but if you regularly backup your Mac you can just delete the files instead since you could restore from Time Machine if need be
Reboot the Mac
Turn ON WI-Fi from the wireless network menu again
This forces OS X to recreate all network configuration files. This alone may resolve your problems, but if you’re continuing to have trouble we recommend following through with the second step which means using some custom network settings.

not work

http://www.tomshardware.com/answers/id-1735863/ping-browse.html

not work

download
https://www.freedownloadmanager.org/
https://www.utorrent.com/
https://transmissionbt.com/
http://xclient.info/s/folx-pro.html?_=f49599f195e2d87e8265beb1e55f423b
https://thepiratebay.org/

https://www.upwork.com/blog/2014/02/10-top-sites-online-education/
Coursera
Lynda
Udemy 内容比较新
Udacity
Codecademy 没有
Bloc
iversity 无
Skillshare
General Assembly

### 快捷键
cmd + opt + i chrome 开发者工具


[mac工具](http://computers.tutsplus.com/tutorials/customize-the-menu-bar-with-bitbar--cms-26946)

[Mac 终端Terminal光标移动快捷键 原](https://my.oschina.net/dyl226/blog/752030)

### 打开 Mission Control

+ 在触控板上用三指或四指向上轻扫。
+ 用两指在 Magic Mouse 的表面轻点两下。
+ 点按 Dock 或 Launchpad 中的「Mission Control」 。
+ Apple Keyboard 功能键 F3 位置的 Mission Control 键。
+ 系统偏好设置中 Mission Control 设置页设置的快捷键，默认是 Control-向上箭头。
+ 触发角选择 Mission Control。

### Mac快捷键

系统自带锁屏快捷键：Ctrl + Command + Q

显示桌面: cmd+F3 / ctl+F11

### Mac任何来源

https://jingyan.baidu.com/article/afd8f4de8e55e734e286e92a.html

`sudo spctl --master-disable` 再打开

### brew

brew install 总是要 Updating Homebrew

```
export HOMEBREW_NO_AUTO_UPDATE=true
```

几个加速
https://maomihz.com/2016/06/tutorial-6/

### fuse sshfs

https://www.jianshu.com/p/31205b26deff

```shell
brew cask install osxfuse
brew install sshfs
sudo chown ${whoami}  /usr/local/share/man/man1 
brew link sshfs

sshfs username@server:path local_path

sshfs ud-tim:/srv tim_srv
```

### 黑苹果

[黑苹果](https://github.com/huangyz0918/Hackintosh-Installer-University)


### neofetch

xbrew install neofetch

neofetch

### NTFS

http://xclient.info/s/tuxera-ntfs.html done

http://xclient.info/s/omnigraffle.html

http://xclient.info/s/omni-plan.html

http://xclient.info/s/charles.html

http://xclient.info/s/os-x-server.html

http://xclient.info/s/office-for-mac-2016.html

http://xclient.info/s/scapple.html
将 DMG 中的 Scapple.app 移动至 应用程序 文件夹。
断网，打开 DMG 中的 CORE Keygen.app 左下角选择 Scapple v1，点击 Generate 将 Name 与生成的 Serial填入软件注册界面，点击注册按钮，在弹出来的选项框中选择最后一个 使用 act key 激活，然后填入 Act Key 安装成功，打开 网络。

http://xclient.info/s/adobe-photoshop-cc.html

Omnigraffle Pro 6

Name: mojado Serial: JYFE-JRJN-GSOT-GRAG-EVJI-TEFE-VJI

Name: mojado@live.com Serial: IZAH-IRLI-EFDI-XAEM-JBJJ-JEFJ-BJJ

Name: mojado@gnu.org Serial: EMIP-OSMG-CSJU-ZZBL-INXY-TEFI-NXY

Name: Magic Mike Serial: LGEO-AVRN-TPGY-BZKR-WEQT-ZEB

OmniPLAN
Name: mojado
Serial: JEFZ-ONHC-BDMA-EUAX-DJZT-FEFD-JZT

Name: MOJADO
Serial: GOZN-NTSG-WIGA-MOMD-GMPF-RCZG-MPF

Name: mojado on the rocks
Serial: NIXP-IVEN-HEYC-PRGF-OIGS-GEH

Name: the mojado
Serial: JGUM-WEVF-MSTZ-VHBT-VNTC-NEF


### xx[SP] 常见破解不能在  sierra 上使用

首先Mac上需要安装Xcode，Xcode的作用就是提供提供程序运行的框架，让patcher和eyePatch可以像Dash 3.x [SP].app那样运行在操作系统中

正常安装程序

将 DMG 中的 Patch 工具（ 本例中：Dash 3.x [SP].app）移动到本机，如下载文件夹中，右键显示包内容进入Contents——MacOS。你会看到这两个文件 eyePatch，patcher

打开 终端 ，按照以下顺序，将 对应文件依次拖入终端窗口：

patcher - Dash.app - eyePatch - Dash.app

成功的话，会提示上图中 倒数第三行及第二行内容：

code_alloc_xc_ios:/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/codesign_allocate

proxy :
git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'

.git/config

[remote "origin"]
    url = https://github.com/udesk/udesk_webapp.git
    fetch = +refs/heads/*:refs/remotes/origin/*

grep -a -B 10 -A 100 'elasticsearch' /dev/sda1

memory  

es
sudo elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml  -XX:-UseSuperWord -Xmx50m -Xms10m -d

brctl log --wait --shorten

AlipayDispatcherService

```
  sudo rm -rf /Library/Application Support/Alipay/
  ps -ef|grep -i alipay
  sudo kill -9 84476
```

chrome helper memory

https://discussions.apple.com/thread/5572267?start=0

If you open the Activity Monitor and see that a process called "google chrome helper" is using too much CPU, here's how I fixed it:

I went to Chrome settings/content settings/Plugins and selected Click To Play for all plugins.  (The default is Run Automatically.)

This fixed my problem.  Now you have to click whenever you want to run a youtube video or other plugins, but it's worth it.  It stops those stupid Flash ads from loading, too, so that's an extra bonus.

I'm posting this because when I had the problem, I couldn't find any solutions at all.

Craig...go to Chrome > preferences > settings > show advanced settings > content settings (under privacy)

Then click the 'click to play' button under the Plugins section.

Click done when you are finished.
