# xi-editor

和我理念相同的一个编辑器

使用前端+后端的模式

https://github.com/xi-editor/xi-editor

https://xi-editor.io/docs/plugin.html

## hotkey shortcuts 相关

https://stackoverflow.com/questions/58070236/in-xcode-11-what-are-the-keyboard-shortcuts-to-open-change-file-in-assistant-ed

key bindings + modal editing (vim) discussion #302
https://github.com/xi-editor/xi-editor/issues/302

https://news.ycombinator.com/item?id=16267202
	Hacker News new | past | comments | ask | show | jobs | submit	login
Xi: an editor for the next 20 years [video] (recurse.com)
750 points by davidbalbert on Jan 30, 2018 | hide | past | web | favorite | 295 comments


	
postit on Jan 30, 2018 [-]

Xi creator did an amazing work implementing ropes (https://github.com/google/xi-editor/tree/master/rust/rope)
The design documents (https://github.com/google/xi-editor/tree/master/doc/rope_sci...) explaining the concepts and implementation details is a must for those who want to understand its core.

But I still have my regards regarding input latency being accredited only to the text editor. I recently switched back to Linux (nvim running on alacritty with tmux) and the latency issues magically disapeared. During my iterm2 (and even terminal) period on OSX I felt horrible lag during operations which I don't even have time to blink with my current setup.

The last straw was once I found out iterm2 consuming 10% of my CPU in idle, the issue only happened when any non builtin font (menlo, monaco or courier) was used.


	
eeks on Jan 30, 2018 [-]

I must concur. With an equivalent vim setup and code files, nothing beats X11/suckless terminal on my OpenBSD machine. Comparing to that, even Alacritty looks like a slug.
I must say however that things are looking a bit better in iTerm2 when switching the Metal renderer on. It's just a shame that an Nvidia GPU on OSX is necessary to compete with my $1000 Lenovo with its crappy Intel chip on OpenBSD when it comes to text editing latency.


	
gnachman on Jan 30, 2018 [-]

iTerm2's design is saddled by some history. At the time I took it over, everything was done in a single thread. By the time I realized I was going to stay with the project and how bad the design was, it was too late to change it. I've moved as much work as possible off the main thread (parsing the bytestream and now rendering). I think Terminal gets very nice performance without resorting to Metal by doing only UI work on the main thread. I think the Metal renderer will prove to be worthwhile, even though it was a lot of work to create that could've been avoided (kinda) if the design had been fixed 8 years ago.
As for using CPU when idle, there was a bug where a background thread was doing the equivalent of running `ps` over and over. That's been fixed in the last few versions, but please file issues for such things and I'll get to them as soon as I'm able.


	
jarpineh on Jan 30, 2018 [-]

I'll add my thank you. I'm also backer at Patreon.
With tmux control mode it's already very good and now with faster rendering coming...


	
acoard on Jan 31, 2018 [-]

I've got an unrelated question about tmux/iTerm2 - hope you don't mind me asking.
I'm a heavy iTerm2 user and always been curious about tmux. Is there any reason to try out tmux integration if I'm already comfortable with iTerm2's features and panelling? I kind of got the impression tmux integration was largely for people who love tmux and are migrating to iTerm2, so it just makes it more familiar. Or is it something I should take another look at?


	
jarpineh on Jan 31, 2018 [-]

Not at all, if only to tell about virtues iTerm2 and tmux to wider audience!
Short version: iTerm with tmux control mode (tmux -CC flag) is still iTerm, only now with tmux benefits like persistent shell sessions. iTerm translates regular commands like new window and split pane into tmux commands and acts otherwise like regular iTerm. Mac might crash or SSH get disconnected and tmux stays running to save you from losing anything (well, if it's running on a server..).

In addition you tmux gives you shell sharing and allows using different devices alltogether. I sometimes use iPad or iPhone with Blink.app to connect to my always running sessions. You can connect to existing tmux session attaching with CC mode and iTerm will open windows and panes to accommodate.

One caveat if you require Mosh for network issues: it and tmux control mode aren't compatible. Also, I'd like to open tmux windows as tabs instead of separate iTerm windows, but that's a minor thing.

This page on iTerm's wiki explains things in detail: https://gitlab.com/gnachman/iterm2/wikis/TmuxIntegration


	
wingspan on Jan 31, 2018 [-]

Regarding Mosh and control mode, Eternal Terminal https://mistertea.github.io/EternalTCP/ provides the same resumable session, and works flawlessly with tmux control mode.

	
AlexCoventry on Jan 31, 2018 [-]

ET may be insecure. It was recently possible to segfault it with corrupted network inputs.
https://github.com/MisterTea/EternalTCP/issues/79


	
AceJohnny2 on Jan 31, 2018 [-]

I use tmux with iTerm regularly, and it's my killer feature in iTerm.
I don't think there's much benefit to using tmux integration for a local shell, other than possibly long-lasting sessions that will survive iTerm itself crashing (and maybe you logging out? I'm not sure), which isn't enough of a problem for me to have to work around.

The awesome benefit for me is when using a remote tmux. Tmux integration works over SSH, so thanks to this I can have native-looking tabs and windows that are actually terminals on a remote machine. And if I get disconnected (frequent, with a laptop, as I'm moving around), I can reconnect and get all the remote windows just fine.

Gone are all the usual tmux C-b prefixes to managing windows, non-integrated scrolling, etc. Everything behaves like a normal iTerm window. I can even split/move panes like normal iTerm panes (though that crashed iTerm until about a year ago).

I have the following alias defined:

    ssh -t elf.example.com /opt/local/bin/tmux -u -CC attach
The -t is the SSH option to force pseudo-terminal allocation, which some versions of ssh fail to do when passing a command (in this case tmux) rather than starting a shell.
I'm specifying the /opt/local/bin version of tmux, because that's an updated one I've installed from MacPorts. Unfortunately Apple continues to bundle old versions of tmux in macOS, and last I checked the one that was bundled didn't actually support the Control Channel required by iTerm integration.

-u is a tmux option to force it in Unicode mode, required by iTerm's Tmux integration

-CC tells tmux to start a control channel and disable echo (required by iTerm's tmux integration)

`attach` attaches to the default session that I created prior.


	
hultner on Jan 31, 2018 [-]

I’d say it’s the opposite as an die hard tmux-user. I don’t really use the integration since I’m more comfortable with my terminal in full screen and my own tmux config. The integration services seems more appropriate for someone who doesn’t already have their tmux-bindings and workflow stamped into muscle memory but rather just want the benefits of detaching their terminal sessions from their terminal application while retaining iterm native tabs, windows and panes.
I’ve tried out the integration mode a few times but it just doesn’t fit my workflow (often switching sessions, highly customized tmux configuration, etc).


	
Myrmornis on Jan 31, 2018 [-]

Exactly. For people who already use tmux heavily, and use it on linux as well as macos, the iterm2 integration isn’t going to be an attractive direction. Partly because it will lose the uniform experience across OSs, and partly because they’re happy with session/window/pane management using tmux’s UI.

	
kokey on Jan 31, 2018 [-]

I'm the same, but with screen. I usually have an iTerm2 tab for each screen session. I have a screen session on a work machine and one on a personal machine, each usually with close to 10 virtual terminals. I connect to both with mosh. I haven't seen a compelling reason for me to switch to tmux, yet.

	
wll on Jan 30, 2018 [-]

Thank you for your work on iTerm2, George!

	
bronxbomber92 on Jan 31, 2018 [-]

Did you hit any pain points using Metal?

	
wincent on Jan 31, 2018 [-]

So looking forward to the Metal renderer. Any idea when it will makes into a release?

	
Philipp__ on Jan 30, 2018 [-]

Wow, just gave iTerm2 Nightly with Metal renderer a spin! Holy shiet it's fast and smooth! FINALY! Opened 20k C file in Vim (stock vim 8 that comes with macOS High Sierra), pushed that scroll down and let it roll, it was soooo smooth! Amazing!

	
bhoeting on Jan 31, 2018 [-]

I tried it after reading this comment. You weren't kidding. Unfortunately, my Vim isn't rendering properly. About 10 lines in the middle of the screen are blank for some reason. Both in and out of Tmux. Oh well. I'm just happy that I can look forward to Metal rendering being merged into stable.

	
neoncontrails on Jan 31, 2018 [-]

Not sure if it's the same issue I had recently with iTerm2 periodically going black, but consider disabling the Core Text renderer with the following command:
$ defaults write org.vim.MacVim MMUseCGLayerAlways -bool YES

This was the developers' suggestion and it solved my issue. There's an informative discussion of the root causes here: https://github.com/macvim-dev/macvim/issues/557.


	
bhoeting on Jan 31, 2018 [-]

Hmm, that didn't see to work for me. I think I have a different issue. Thanks, though!

	
wyclif on Jan 31, 2018 [-]

Is there a way to install that with homebrew?

	
bhoeting on Jan 31, 2018 [-]

    brew cask install iterm2-nightly

	
myko on Jan 31, 2018 [-]

I had to:
    brew tap caskroom/versions
as well

	
wyclif on Jan 31, 2018 [-]

Thanks guys, I was a bit embarrassed to ask that question but I suspected the answer wasn't quite intuitive.

	
tomjakubowski on Jan 30, 2018 [-]

Have you tested iTerm2's Metal renderer performance with the integrated Intel GPU?

	
eeks on Jan 31, 2018 [-]

Yes, however matter-of-factly while moving about the office. I did not perceive any difference between the Mac plugged in and on the go.

	
bowmessage on Jan 30, 2018 [-]

Thank you so much for mentioning the new experimental metal renderer feature. This has dramatically improved my development setup.

	
TheAceOfHearts on Jan 31, 2018 [-]

Have you tried Terminal.app recently? A lot of people seem to rush immediately to iTerm2... And I used to be one of those, a few years back. But eventually I gave the built-in Terminal.app a serious chance and found it met all my requirements. Although I also stopped customizing my theme, and I keep as many defaults as possible. SF Mono is a great font!

	
MaxBarraclough on Jan 31, 2018 [-]

I did the same thing a few years ago. Terminal.app has had tab support for years now. What's the killer feature of iTerm these days?
I also recall finding Terminal.app to have lower CPU consumption, matching postit's experience.


	
rdrey on Jan 31, 2018 [-]

The killer feature for me was setting an "alarm" on a currently running process and getting a notification when it finished. It's not something I've seen in any other terminal. (Using Ubuntu now and missing it.)

	
arjunbajaj on Jan 31, 2018 [-]

I believe Elementary OS's terminal has this in-built.

	
jhasse on Jan 31, 2018 [-]

Fedora has this, too.

	
lambdadmitry on Jan 31, 2018 [-]

Quake-style console. I'm too addicted to it unfortunately.

	
girvo on Feb 2, 2018 [-]

Literally the only reason why I use iTerm 2 over Terminal.app as well. Though I'm tempted to see if I can't replicate a similar "show over anything when a hotkey is pressed" in Terminal.app with some cute AppleScript...

	
haskal on Feb 1, 2018 [-]

1. When you exit a terminal it dumps irrelevant stuff rather than just closing the tab.
    ~ % exit 
    
    [Process completed]
2. Cmd + Arrow doesn't doesn't move to the next or last tab. (Cmd + number does work however, but it doesn't show numbers on the tab list like iTerm)
3. Comes with terrible defaults like the screen color.


	
Jakob on Feb 1, 2018 [-]

There certainly are some advantages of iTerm2 but the ones you stated are very easily done in Terminal.app:
1. Settings > Profiles > Shell > When the shell exits: [Close the window|Close if the shell exited early|Don’t close the window]

2. macOS standard for all applications is the following.

  - next tab: ⌃⇥ or ⌘⇧]
  - previous tab: ⌃⇧⇥ or ⌘⇧[
If you really want to change that, you can do so in System Preferences
3. Settings > New window with profile: Pro


	
latexr on Jan 31, 2018 [-]

Probably not a big feature for most, but I work with URLs in the terminal a lot and ⌘+click to immediately open them in the browser is convenient.
I prefer to open a new Terminal only when I need it instead of keeping one open all day (even if that sometimes happens) and I’ve never noticed an increase in CPU usage that’d made me want to check.


	
bluerobotcat on Jan 31, 2018 [-]

Terminal.app does that too

	
latexr on Feb 2, 2018 [-]

You have to double-click and pressing ⌘ gives no visual feedback. That explains why I didn’t find it before. Thank you for the tip.

	
leshow on Jan 31, 2018 [-]

scoff how dare you use a mouse. In urxvt I have it mapped to ctrl+u

	
stormking on Feb 1, 2018 [-]

> What's the killer feature of iTerm these days?
Panes.


	
dmytrish on Feb 1, 2018 [-]

I don't use panes much, but Terminal.app seems to have panes too.

	
eropple on Feb 1, 2018 [-]

- Bafflingly, they split horizontally. I have a 4x4 pane setup, but my default is 2x1.
- Cmd-W closes the window, not the pane. (I get why they do this. I feel that it is wrong.)

- I can't send input to all panes, which is a pretty useful feature I probably use once a week.

- iTerm2 happily maps my panes to tmux. This is by itself perhaps a killer feature.


	
dmytrish on Feb 5, 2018 [-]

Thanks! I feel the same about "tmux vs screen": tmux panes are just so much easier to use and more flexible than in screen, even though screen can split windows).

	
brazzledazzle on Jan 31, 2018 [-]

I really like the tmux integration.

	
coldtea on Jan 31, 2018 [-]

>found it met all my requirements. Although I also stopped customizing my theme, and I keep as many defaults as possible
Well, if your requirements are low and the defaults are OK, sure, Terminal.app can do it. But iTerm2 does so many more things it's not even funny.


	
spinningarrow on Jan 31, 2018 [-]

I still can’t get 256 colours working properly in tmux in Terminal.app - any idea if that’s supported?

	
fergie on Jan 31, 2018 [-]

Terminal with GNU Screen works really well for me.

	
willtim on Jan 30, 2018 [-]

A more interesting approach would be to use persistent data structures. While possibly slower for some operations, undo is more efficient and there are really interesting opportunities for concurrency. See:
https://github.com/arximboldi/ewig/blob/master/README.md


	
raphlinus on Jan 30, 2018 [-]

I believe xi-rope counts as a persistent data structure. We have plug-ins in separate processes now, for isolation, but might explore having them in-process but in separate threads. The underlying data structure should support that just fine. Is there something I'm missing?

	
willtim on Jan 30, 2018 [-]

A rope data structure is very almost persistent. So perhaps I am splitting hairs! It could of course be made fully persistent if mutating operations are avoided. This would allow sharing them between threads.

	
steveklabnik on Jan 30, 2018 [-]

> This would allow sharing them between threads.
This is an area where Rust ends up feeling different than many languages: xi's rope uses https://doc.rust-lang.org/stable/std/rc/struct.Rc.html#metho... like this: https://github.com/google/xi-editor/blob/422948d62688dcc2ee0... , which gives you both options. This code uses Rc, not Arc, so it's not currently sharable between threads, but Arc has the same API.

Rust cares about sharing more than immutability.


	
raphlinus on Jan 30, 2018 [-]

Nope, it's Arc for exactly that reason, though we're not currently using it across threads right now. The fact that it can support immutable semantics safely is one of the really nice features of Rust.

	
arximboldi on Jan 31, 2018 [-]

Thanks willtim, for mentioning Ewig/Immer :)
As Ralph and others have pointed out, their rope is fundamentally a persistent data structure.

I think that one of the fundamental differences between how Rust and C++ deal with value and reference semantics make the two approaches look more different than they are. The C++ API is allowed to look a bit more "immutable", where one can always use the same functional looking API even though sometimes the performance of an operation is gonna depend on the category of the reference you are operating on (l-value, r-value). Rust forces the user to be explicit about everything all the time, making it very explicit when intend to "branch" or "snapshot" the persistent data structure and where do we wanna allow "in place" updates.

I am still undecided about which approach I like most, and I do think that there merits to each approach. But maybe just because I never really wrote anything serious in Rust. The C++ approach has the problem that it becomes unsafe once you introduce `std::move` (but if the C++ type system was not a crazy evolutionary monster one could imagine a similar approach with moves being inserted automatically and safely by the compiler.)


	
anp on Jan 31, 2018 [-]

The author of alacritty suggests that there's an IPC performance issue with tmux/nvim on macOS: https://github.com/jwilm/alacritty#faq

	
jorvi on Jan 30, 2018 [-]

Alacritty is slower than Terminal.app..[1] perhaps placebo effects were/are in play?
[1]https://danluu.com/term-latency/


	
jwilm on Jan 30, 2018 [-]

The article you linked is specifically about latency. There are other factors that contribute to overall terminal experience such as high frame rate and high throughput. Once latency reaches a "good enough" level, it becomes a non issue, and frame rate and throughput remain. Alacritty excels in those areas (there's even a table in that article demonstrating Alacritty's high throughput).
There is also a plan[1] for making Alacritty's latency best-in-class.

[1]: https://github.com/jwilm/alacritty/issues/673


	
squeaky-clean on Jan 31, 2018 [-]

I haven't gone through the whole link yet, but the part where they make video game comparisons doesn't make sense. They say
> When people measure actual end-to-end latency for games on normal computer setups, they usually find latencies in the 100ms range.

And in that very sentence link to a latency test for a game that is notorious for being laggy, and even then it reaches 59.4ms latency. The same video they link, even says (at 1:32) that Overwatch has a button-to-pixel-change latency of about 15 ms! So where is this "usually 100ms" coming from?

Just because of this I don't really trust the rest of the article.


	
XR0CSWV3h3kZWg on Jan 30, 2018 [-]

Yeah iterm2 is pretty unacceptable. For me alacritty is still missing some polish (i.e. text size keeps on changing when I attached/detach monitors), but it's really solid for using nvim.
I've actually been using nvim as my terminal multiplexer instead of using tmux.


	
__jal on Jan 30, 2018 [-]

iTerm2 with the new renderer is awesome. Even without it on a slow old mac, you can tune it to behave normally. One thing I found in the past was that particular fonts would slow it down a lot - never bothered to hunt down what was going on, but I think the author was/is doing something a little odd there.

	
evanrelf on Jan 30, 2018 [-]

Have you tried using Alacritty? https://github.com/jwilm/alacritty

	
postit on Jan 30, 2018 [-]

Have your read my comment? :)

	
evanrelf on Jan 30, 2018 [-]

Oops :)

	
raphlinus on Jan 30, 2018 [-]

Presenter here, feel free to ask questions.
Also thanks to the awesome Recurse Center for inviting me to speak and making the recording, and the audience for their great questions.


	
gnachman on Jan 30, 2018 [-]

I'm surprised you found creating attributed strings and CTLineRefs was acceptable. These are the main bottleneck in iTerm2's renderer, and I ditched them when rewriting the renderer in Metal. Since ASCII is an important fast-path for us, and other than ligatures in fonts for programmers there's no need to go through all that machinery. Did you do anything clever to get around the slowness of creating NSAttributedString's and CTLineRef's?

	
vlovich123 on Jan 31, 2018 [-]

There's caching all over the place so that you don't end up redoing the expensive stuff (ie creating attributed strings & CTLineRefs). It seems to work pretty well in terms of maintaining 60fps.

	
gnachman on Jan 31, 2018 [-]

Caching is great but it doesn’t help you when paging through a big file where the entire screen contents get replaced on each update. Is that not what you benchmark?

	
raphlinus on Jan 31, 2018 [-]

That is correct. I'm measuring scrolling at low to medium speeds, where the majority of the text hasn't changed (this also corresponds to most editing tasks). I don't want to make the claim that I'm keeping up when scrolling at very high speeds. I think my assumptions are reasonable for an editor, but for a terminal scrolling at high speed is much more common. I have certainly considered fast-pathing monospaced font rendering (it would certainly be easy in the current architecture, and in fact we're doing that for the gutter numbers), but it hasn't seemed absolutely necessary, and going forward I want to make sure that rich text and i18n aren't treated as second class wrt code.

	
harshreality on Jan 31, 2018 [-]

Keep in mind a lot of less-sophisticated users will just mash navigation keys (or click-drag the scrollbar) instead of using more sophisticated navigation commands. If high-speed scrolling isn't reasonably optimized, it will be noticed.

	
IshKebab on Jan 31, 2018 [-]

Yeah also I recently tried Xi-mac and the first thing I did to see how fast it was was to drag the scroll bar quickly. Based on my experience of other editors that is where they usually get slow (no editor seriously has problems inserting one character at a time).
Unfortunately Xi was quite laggy in the scrolling department. Slower than VSCode for example.


	
raphlinus on Jan 31, 2018 [-]

Were you perhaps on a debug build? This would be quite surprising in a release build.

	
gnachman on Jan 31, 2018 [-]

That makes sense. Our problems are somewhat different. Do you need to deal with arbitrary combinations of foreground and background colors? For me this was the hardest problem to deal with because of subpixel antialiasing.

	
raphlinus on Jan 31, 2018 [-]

Yes, and I'm quite proud of how that turned out. It's using linear sRGB color space, so colors are blended with correct gamma, and dual source blending for the LCD subpixel stuff. It's all handled inside the graphics hardware; if you look at the code it's pretty simple and accessible.

	
jarpineh on Jan 30, 2018 [-]

Latency and multi-process editing environment has been on my radar recently. Programming languages providing analysis servers, external syntax highlighters and of course REPLs all benefit from editor that’s fast and async. Since Jetbrains editors brought zero latency writing to my attention I’ve begun to notice which apps seem to hinder my writing. It’s getting easier to build your own editing system instead of having to accept full product from one vendor (Jetbrains tools are great, but very hard on my poor machine…). For this I’ll be watching Xi closely.
I’m in the process of learning Kakoune (1) which happens to have JSON-RPC API as well (2). Kak is fully terminal app which doesn’t give it any edge on latency (doing low latency terminals and shells seems to be a hard task). Hopefully Kak’s take on Vi’s commands as selection oriented language can be leveraged from within Xi editing framework in some capacity.

(1)[http://kakoune.org] (2)[https://github.com/mawww/kakoune/wiki/JSON-RPC]


	
cmyr on Jan 30, 2018 [-]

Xi's medium-range plans for modal editing support[1] are intended to be modular/general enough that you could plug in whatever particular modal-editing implementation you'd like.
1: https://github.com/google/xi-editor/issues/302


	
jarpineh on Jan 30, 2018 [-]

Thank you, that's a good thread. I see Kakoune is mentioned. Will have to check back later on.

	
pohl on Jan 30, 2018 [-]

I remember listening to your talk about Xi at RustConf '16, and being amazed at how deeply you've been thinking about text editors. This talk is a nice update on your thoughts.
How soon do you think it will be before more product-level thinking can be brought into the mix?

(Edit: I see I'm not the only one to ask a question along these lines.)


	
JepZ on Jan 30, 2018 [-]

What kind of UX model do you have in mind? Something like the vi modes (command, visual, input, etc.), something more GUI like with input mode by default and hotkeys or something completely different?

	
raphlinus on Jan 30, 2018 [-]

Definitely the standard modeless text editing model (with multiple cursors though) as the default, and vi-compatible modes as an option. The issue for the latter is linked elsethread.

	
Derbasti on Jan 31, 2018 [-]

How powerful are you planning your extensions to be? On a scale from Textmate (shortcuts that run shell scripts) to Emacs (you can implement Vim in Emacs), where would Xi's extensions stand?

	
jzoch on Jan 31, 2018 [-]

Considering plugins can be written in any language and communicate via JSON, I'd posit they can be whatever you prefer. Turing-complete, even.

	
Derbasti on Jan 31, 2018 [-]

Consider the following quedtions: Can they overload arbitrary key presses? Can they modify what is on the screen? Can they change the screen's content without changing the file's content? Can they call the editor's own editing functions? Can they be called by the editor's own editing functions?
Textmate can bind shell scripts to shortcuts, but letter keys always insert letters, and the editor always shows the file's content.

Emacs can execute arbitrary code on arbitrary keys, which enables you to implement vim-style key bindings. Also, Emacs can display stuff that is not a file, which enables mail clients, git clients, and terminal emulators.


	
josteink on Jan 31, 2018 [-]

Coming from the Emacs side of things, I will have to call that an incomplete understanding of the concept of extensibility.

	
javajosh on Jan 30, 2018 [-]

Hi Raph. Do you ever get the feeling that `xi` will inevitably become isomorphic to the "general programming problem" that's been solved many times, at several levels of zoom, distinguished by trade-offs and implementation quality? I mean, what do you do when your general editor implementation inevitably starts feeling like an OS? Or do you think you'll be able to successfully avoid implementing processes, access control, roles, db and/or fs functions etc in your editor, somehow?

	
gradstudent on Jan 30, 2018 [-]

Can you please comment on Xi as a general editor and specifically in relation to vim and Emacs, arguably the two best general editors from the last few decades.
Thanks!


	
raphlinus on Jan 30, 2018 [-]

I don't want to knock either, they're both obviously great editors. My main goal is to build something that feels entirely like a native app. Also, I'm hoping that the async model for plug-ins will preserve responsiveness even when there are a lot of plug-ins and they do nontrivial work.

	
racer-v on Jan 31, 2018 [-]

As an Emacs diehard, I'll be quite tempted to give this a spin once the plug-in model integrates nicely with some Lisp implementation (e.g. SBCL), and someone sets up a repository along the lines of Emacs Lisp Package Archive (ELPA). Cool project!

	
brucephillips on Jan 30, 2018 [-]

> My main goal is to build something that feels entirely like a native app.
It's not clear to me how this relates to the question. Emacs and vim are native apps.


	
cmyr on Jan 30, 2018 [-]

Maybe we're using different definitions of "native". In the most common case, both of these editors use the cross-platform "VT-100 UI Toolkit" (e.g. ansi escape codes in your terminal emulator), regardless of platform. Some exceptions do exist. But native as it's being used in relation to this project refers specifically to whatever frontend framework is 'the standard' for a given platform, where one exists.

	
brucephillips on Jan 30, 2018 [-]

Ah, I see the miscommunication now. To me, native apps are those that have access to the kernel, as opposed to web apps or bytecode.

	
zeveb on Jan 30, 2018 [-]

> > Emacs and vim are native apps.
> In the most common case, both of these editors use the cross-platform "VT-100 UI Toolkit" (e.g. ansi escape codes in your terminal emulator), regardless of platform.

I daresay that the single most common way to deploy emacs is as an X11 editor, followed by a macOS editor, followed by a vt100 console editor. Emacs is a fully GUI programme, and has been for decades at this point.


	
FullyFunctional on Jan 31, 2018 [-]

I'd be careful about such conclusions without a study. It certainly doesn't fit my usage. I'm at least twice as likely to hit "emacs -nw" for a quick edit than launch the GUI version. Being useful in a terminal is a critical requirement for me.

	
eadmund on Jan 31, 2018 [-]

> I'm at least twice as likely to hit "emacs -nw" for a quick edit than launch the GUI version.
I think that alone marks you as an unusual emacs user; the standard pattern for using emacs is to leave it running all the time (either in a window, or as a dæmon), not to launch new instances. But yes, it would be interesting to have numbers.

> Being useful in a terminal is a critical requirement for me.

Oh, certainly; in fact, I have 'vi' aliased to 'emacsclient -t' these days for just that reason. It's awesome to have a powerful, extensible editor available in the terminal.


	
rkangel on Jan 31, 2018 [-]

What do you find that achieves for you that an X11 emacs running a server doesn't?
I have EDITOR set to emacsclient (and some other aliases) and I find it far more convenient than an in-terminal editor, especially when combined with sudoedit.


	
eadmund on Jan 31, 2018 [-]

> What do you find that achieves for you that an X11 emacs running a server doesn't?
I only use it for quick edits to files, when I don't want to turn my head from my terminal to my emacs window. Yeah, it's just a bit lazy …


	
cmyr on Jan 31, 2018 [-]

Okay fair point, my emacs experience is limited to installing spacemacs once while procrastinating.

	
dom96 on Jan 31, 2018 [-]

Indeed. To me "native" implies that the app will also use the typical keyboard shortcuts that are native to the OS. For example, copy to clipboard via Ctrl+C on Windows and Cmd+C on macOS. Is that the case with Xi?

	
cmyr on Jan 31, 2018 [-]

As currently architected, the frontend is responsible for sending the core events such as "copy", "delete to start of line", or "insert 'a'". On xi-mac, the default experience is intended to closely match the behaviour of other native Cocoa apps, and to generally respect platform idioms.

	
amaranth on Jan 30, 2018 [-]

They aren't webapps but they're each a different ecosystem and workflow entirely separate from the rest of the OS. You can add integration to various parts of the OS via extra scripts/plugins but that you need to do so proves the point. With Xi it seems the goal is to have a powerful shared core but the UI frontends are tailored for the OS/DE they're meant to be run in rather than having one generic cross-platform frontend.

	
haberman on Jan 30, 2018 [-]

For the protocol between core and front-end, did you take any inspiration from mosh's state sync protocol? https://mosh.org/mosh-paper-draft.pdf

	
raphlinus on Jan 30, 2018 [-]

Not specifically, but I did dig deep into the state syncing literature in general, both Operational Transforms and CRDT's. The problem we're trying to solve is a bit different than mosh, because we don't need to compensate for network latency in particular; RPC should be very fast.

	
kazinator on Jan 30, 2018 [-]

Text editors shouldn't have a "core" and "front end" and "protocol".
Monolithic machine executable that fits into under a meg of RAM and comes up in a fraction of a second from a cold invocation.


	
vidarh on Jan 31, 2018 [-]

Yes, they should. And here is why:
1. Stability. I'm writing my own editor at the moment, and the text buffers are kept in a server process. Last time I updated the server process it'd been running continuously for a month despite extensive reworking of the frontend. The backed is trivially simple (~300 lines), and easy to keep stable. If the frontend crashes it doesn't take my open buffers with it.

2. Coming up in a fraction of a second with state most of the time. Most of the time I have a ton of buffers in RAM; rather than reloading a ton of files, most of the time when I bring up the frontend, the files I'm working on are already there. Re-establishing an IPC connection to the backend is not noticeable.

3. Faster starts over slow network connections - I can run the backend remotely and not have to transfer a big file other than what is needed to view the bits I care about.

4. Simplicity: I don't need to implement tabs or multiple windows - I got that for free from my window manager. Instead if I want to split the current buffer, I just spawn a new frontend that re-attaches to the same buffer from another process. There should be no need for an editor to re-implement its own window management.

A client-server design makes very little difference to memory usage and doesn't require a separate executable.


	
michaelmrose on Jan 31, 2018 [-]

Even as part of the minority that use window managers on linux I find the idea of merely using the window manager exclusively in place of other forms of UI for multiple documents/pages/buffers within a gui app as fantastically underwhelming.
Lets look at firefox as an example. The fact that a vertical tabbar is more useful in this case due to screen shape and size and it being useful to be able to read a bit more of the text when you have a lot of tabs. This could in theory by done by your wm even though I've not seen one that does. Further tree style tabs shows a visual hierarchy of sorts that can't be replicated by your wm because it doesn't know what link was opened from what. Further you can perform operations on groups of tabs, like closing them, bookmarking them, reloading them. Its difficult to see how your wm could infer this hierarchy and how it could allow application specific operations like bookmarking even if it could. Further its useful to sometimes open a number of links in the background before switching to any of the above. This is trivially effected within the browser but challenging outside of it because the action of opening a link happens inside the browser.

Within my irc client various channels are arranged according to network and color coded according to activity. Right clicking on individual channels or networks allows specific actions regarding those networks or channels. None of the above would work with a bunch of stacked/tabbed windows.

I could make a list for emacs but the complaint is the same wm ends up being an unfixably poorer alternative to dealing with multiple documents in the app.

I use i3wm not because its awesome at managing multiple documents but because its simple and straightforward and 90% of workspaces, which span only a single monitor, have only 1-2 windows on them. Rarely 3 or 4 and never more.

Window managers are just unfixably mediocre in this respect because the UI doesn't have access to context and can't differ based on use.


	
vidarh on Jan 31, 2018 [-]

I neither use a vertical tab-bar or tree style tabs, so maybe I'd think otherwise if I did. But if so, I'd rather see that as an argument to improve on window management (and yes, it'd require new APIs) rather than an argument for making applications continue to implement their own tabs. But for me that's not relevant, and one of the nice things about being able to fully control the structure of my own editor is not having to worry about use-cases like that.
When it comes to emacs, I don't agree - the multi-window support I added to my editor was something I added explicitly to mimic my Emacs usage with i3wm. It's very possible that it's down to how I use emacs - I tend to prefer to split with ^X+2 and ^X+3, and that pattern lends itself perfectly to doing window splits with a window manager. If anything, i3wm's support for tabs etc., selectively for any window, is more advanced than the buffer/frame management emacs offers.

> Window managers are just unfixably mediocre in this respect because the UI doesn't have access to context and can't differ based on use.

That's just not the case when you 1) have the source, and 2) are able to control the wm via an API that can provide additional context. To be clear: My current support for this is 100% tied to i3wm, and relies on i3-msg to let me choose which orientation to do the split and exec another instance, and my needs in that respect are simple.

It would be harder to get the same flexibility with a wm that lacks an equally trivial API to control placement. Again, a benefit of being able to fully control my own editor (I am slowly packaging up less opinionated parts of it as separate projects - my goal is that "my" personal part of the editor should be reduced to nothing more than instantiating various generic components) - because of the client-server approach, the grand total of my "multi window support" boils down to this ("term" in this case is a local alias for whatever my current preferred terminal is) :

    182│     def split_vertical◂
    183│        system("i3-msg 'split vertical; exec term e --buffer #{@buffer.buffer_id}'")◂  
    184│     end◂
    185│
    186│     def split_horizontal◂
    187│        system("i3-msg 'split horizontal; exec term e --buffer #{@buffer.buffer_id}'")◂
    188│     end◂

	
kazinator on Jan 31, 2018 [-]

If you want stability, the way you do that is "do not write your own editor at the moment, or any other moment".

	
vidarh on Jan 31, 2018 [-]

Or, do what I did and split them in different processes, and I get the stability I need and still are able to get an editor that acts precisely the way I want.

	
Jyaif on Jan 30, 2018 [-]

I've got bad news for you: vim and the other editors you are thinking about also have a core (vim), front end (whatever terminal you use), and a protocol to talk in between them.

	
vidarh on Jan 31, 2018 [-]

Not just that, but many editors have a client/server architecture for the editor itself as well.
Quickly scanning Emacs "NEWS" files, the first mention I found of emacsclient dates back to between '86 and '92. I'm pretty sure it's older. This was added as an option exactly because it is more efficient and leaner to start a separate UI than starting a separate editor instance each time, and adds very little bloat (on my system, emacsclient is a 23KB binary), and it adds so little latency as to not be noticeable.


	
ovao on Jan 30, 2018 [-]

Separating these concerns doesn’t strictly preclude (or at least needn’t strictly preclude) shipping a single, sub-megabyte binary.
The “classic example” of this would be Quake — a single binary implements both a server and a client, which communicate over a simple binary protocol.


	
drewm1980 on Jan 31, 2018 [-]

You made a decision to focus on GPU rendering for now. Do you think that architectural decision will impede high performance software rendering as a fallback?
Hardware rendering routinely breaks in Ubuntu (and probably other distros) because NVIDIA's driver still isn't packaged well enough to survive a kernel update, and doesn't work over ssh or on an many embedded systems anyway.


	
ericfrederich on Jan 30, 2018 [-]

Hi, good talk. I was wondering if you could elaborate more on your JSON RPC mechanism and the use of threads vs. processes. Coming from the Python world I could see it very hard or impossible to use one plugin written in Python2 and another written in Python3 within the same process.
I have successfully integrated several interpreters/event loops into the same process (C++/Boost, Python, Tcl/Tk, Qt). It was a real pain to implement and felt very hacky but worked.

Using processes you can achieve something like a micro-service architecture. An example of where I've seen this kind of coupling is the custom transfer agents in Git LFS.

https://github.com/git-lfs/git-lfs/blob/master/docs/custom-t...

They use processes and line delimited JSON for communication.


	
amelius on Jan 30, 2018 [-]

Nice talk!
I wonder, in the talk you say that you took some ideas from the design of Chrome; do you think that --in turn-- browsers could learn from the concepts in Xi?

And another question: you are using multiple languages. Doesn't that make it needlessly difficult to express the same operations in different (concurrent) parts of the system? E.g. a character update is rendered on the screen (in Swift), and simultaneously the operation is sent to the core (in Rust) to reconcile the change in the core data structures; both operations are essentially the same, but now they have to be written in a different language, which means more development work and increased likelihood of mistakes/inconsistencies (?)

PS: I'm not sure if this makes sense; I couldn't finish watching the talk but will watch the rest later!


	
vlovich123 on Jan 31, 2018 [-]

I'm still learning the architecture but my understanding is that the way it works is that the frontend sends the character to the backend which incorporates it into the model & then generates a notification back to the front-end via the regular delta diff algorithm. The front-end then applies this delta to its data structures that represent the view & updates the rendering. All of this turns out to be super quick because the rope data structure applies changes quickly & the frontend is modifying very little data to update its rendering. My hunch is that it's probably less efficient if you're trying to do a lot of little modifications very quickly vs other editors but that's not a realistic use-case; you're usually inputting individual characters at human speed or doing large modifications via bulk operations that can occur in 1 delta.

	
lenkite on Feb 2, 2018 [-]

Well lots of little modifications being done quickly is what we use macros in vi/emacs for. However, I guess this can be solved by the frontend batching.

	
vlovich123 on Feb 14, 2018 [-]

Macros seem to me like they would be trivially batch-able unless they're capturing actions outside the editor that might impact it. Even then, I suspect the performance won't be a huge issue. Remote applications are probably the bigger concern but I suspect the proposed model of running 2 core instances (1 local & 1 remote) & just synchronizing the state between them directly will work better than just trying to connect the frontend to a remote core instance.

	
akmittal on Jan 30, 2018 [-]

Is there any particular reason json-rpc was used compared to more performant gRPC?

	
raphlinus on Jan 30, 2018 [-]

Universal out-of-the-box support in almost every language. The actual performance impact is subtle - for most core/front-end interactions, the messages are very small (because we put so much effort into minimizing the deltas). It's also the case that there are ridiculously fast JSON implementations out there. We did discover that Swift's is not one of them though. I have a prototype of a faster one using Codable; I'd consider upstreaming it to Swift but just need to find the time.
I'd consider a different serialization format, but it doesn't seem to be on the critical path for either performance or functionality, so I feel there are a lot of other things ahead of it.


	
vidarh on Jan 31, 2018 [-]

To second that the serialization format is unlikely to matter: I'm doing my own editor, and I don't put any effort into minimizing deltas, and retransmit more than the full visible window content on every keypress currently. I expected to have to change that to get it fast enough, but latency just isn't noticeable so I've bumped it down to the bottom of my priority list.

	
jacobparker on Jan 30, 2018 [-]

Theoretically you could use gRPC with JSON or Flatbuffers or whatever rather than protobufs.
(I'm not sure how much practice there is behind that theory, currently, but that's the plan.)


	
remram on Jan 30, 2018 [-]

gRPC is not necessarily the magical tool everyone would like to believe. It is mostly developed by Google with a lot of magic in it. For instance, in Python using gRPC is totally incompatible with multiprocessing (meaning: it will crash both processes) and has been for a year (1.4.0...1.8.4), because of all the C logic (and multiple threads) running behind it.
I for one am glad they didn't go towards custom protocols with single complex implementations, towards something that can be assembled easily from standard components.


	
jstewartmobile on Jan 30, 2018 [-]

Off topic, but wonderful job on Inconsolata!

	
raphlinus on Jan 30, 2018 [-]

Hey, stay on thread! Thanks for the kind words though.

	
jstewartmobile on Jan 30, 2018 [-]

I really like the "loose coupling" JSON-RPC approach. You're doing Alan Kay proud!

	
gt_ on Jan 31, 2018 [-]

Sorry to prolong the tangent, but that font is truly legendary. A milestone in the human quest for clarity and form, especially if that human is me.

	
greenhouse_gas on Jan 30, 2018 [-]

Where is the Xi plugin documentation (as in, how to write and install a plugin, what are the APIs).
I found https://github.com/google/xi-editor/blob/master/doc/plugin.m... , but it doesn't have anything technical (or a tutorial).


	
raphlinus on Jan 30, 2018 [-]

It's still a work in progress, we're revving the plug-in protocol. I'm looking forward to the time we can point people to a stable interface, but sadly it's not there yet.

	
kakarot on Jan 31, 2018 [-]

This is not an official Google product (experimental or otherwise), it is just code that happens to be owned by Google
Would you mind elaborating on this?


	
yla92 on Jan 31, 2018 [-]

not the op. just my understanding is that it is raphlinus's code. It means Google has literally nothing to do with it, other than happening to own the code.
(IE it's not an experimental product, it's not a product at all. It's just raphlinus releasing some code)


	
kakarot on Jan 31, 2018 [-]

You repeated the phrase different words.
The question begged is Why does Google own the code?


	
kyrra on Jan 31, 2018 [-]

It is much easier as a Google employee to publish open source projects under Google's copyright[0] rather than getting them to grant the copyright to you.
To have Google give you (the Google employee) full copyright of projects you work on while at Google, you need to go through a committee[1] that reviews the project to make sure it doesn't collide with some other project Google already is working on. As this is really hard to do for many projects, it's easier to just let Google keep copyright ownership of it and have it opensource under them.

[0] https://opensource.google.com/docs/releasing/

[1] https://opensource.google.com/docs/iarc/


	
kakarot on Jan 31, 2018 [-]

As a matter of principle this seems like a negative thing for open source. Can someone explain to my why it isn't?

	
turndown on Jan 31, 2018 [-]

I can't really see an argument to be had that it's not Google's property if it was worked while on the clock.
Considering how protective most companies are of IP, I'm shocked Google even has a mechanism by which a person can take back things they've worked on in office at Google.


	
empath75 on Jan 31, 2018 [-]

Probably because he works on it on the clock.

	
cmrdporcupine on Jan 31, 2018 [-]

Even if it's not on the clock, the open source contribution approval processs at Google is much easier (as another poster pointed out) if you just assign copyright to Google and host on the Google github (with the disclaimer that it's not official Google code).
It's actually a remarkably painless process, which is good because there's actually quite a bit of neat stuff in that neighbourhood of github as a result.


	
virgilp on Jan 31, 2018 [-]

Would you say Xi is usable for "real-life end users"? If yes, what are the best-supported usecases? If not yet - do you have a plan for getting there, or is it still mostly a research project?
(FWIW, I tried compiling Xi on OSx & opening a large file in it. To its credit, it worked, but there are issues; e.g. horizontal scrollbar is wrong, word wrapping is not working etc)


	
joshuak on Jan 30, 2018 [-]

Great work, and I'm looking forward to getting involved if I can. I'm just learning about this project, and am very interested as I'm doing a project with similar performance goals for filesystem navigation. It even has a CRDT based concurrency model, and a multi process architecture with back and front-end applications communicating across a JSON api.
I'm curious about your reasoning for JSON, as compared to protocol buffers, flat-buffers, etc. I would imagine that accessibility and ease of use would be the main reason for choosing JSON, is that in fact the case?

Are there any other reasons you chose JSON over other wire formats/protocols?

I agree with your assertion in the video that this is not much overhead, but I struggle with this debate as I work to scrape every ounce of performance out of the architecture.

Edit: Asked and answered elsewhere https://news.ycombinator.com/item?id=16268332


	
vlovich123 on Jan 31, 2018 [-]

Most of the messages are tiny & the decoding occurs off the main thread (encoding varies I think). JSON is definitely fine as a first choice to get the system running but we are considering at some point upgrading to something more modern like Cap'n'proto or flatbuffers that offers free encode/decode.

	
Improvotter on Jan 30, 2018 [-]

Great talk, I've been eyeing Xi for a bit now and am really looking forward to giving it a shot. Is there any window for when this can actually be put to use on Linux/Mac? I've had a look at the frontends, but they're not very active and they're pretty bare so far. Any idea when these will be more substantial?

	
raphlinus on Jan 30, 2018 [-]

The xi-gtk frontend is in pretty good shape, but overall the editor is not _quite_ at the point where I'd recommend it for daily use. I don't want to make a promise of a particular date, but I'm hoping fairly soon.

	
pacetherace on Jan 30, 2018 [-]

Do you think the language used will last for 20 years in terms of developer interest?

	
raphlinus on Jan 30, 2018 [-]

You mean Rust? Yes. However (and I didn't get into this in the talk), I actually feel that if I figure out proper async _protocols_ that express rich functionality in neatly composable modules, then that protocol is likely to outlast any given implementation. So if in 10 years somebody figures out a way to make ATS-style dependent types easy to use, I wouldn't be surprised if there's a core written in that.

	
jwilk on Jan 30, 2018 [-]

Why the name?

	
raphlinus on Jan 30, 2018 [-]

I wanted something short, and it felt kinda futuristic. The similarity to "vi" was also intentional.

	
kbenson on Jan 30, 2018 [-]

We should be looking forward to "xim" then? ;)

	
degurechaff on Jan 31, 2018 [-]

don't forget neoxim too

	
earenndil on Jan 31, 2018 [-]

Plus elxis, nxi, and xi11.

	
AceJohnny2 on Jan 30, 2018 [-]

(Not the author) I presume a reference to one the many mathematical/scientific usages? https://en.wikipedia.org/wiki/Xi_(letter)#Mathematics_and_sc...
I particularly like the "No change of state" meaning in "Z notation", apparently a formal language for specifying and modeling computer systems.

Edit: never mind, author beat me and debunked my overly-complicated analysis


	
Numberwang on Jan 30, 2018 [-]

How far away are you from a cross platform 'product'?

	
raphlinus on Jan 30, 2018 [-]

At the rate we're going, it will be a while. It takes time, and I'm trying to get the right answers rather than racing toward shipping. It's a very different environment than a product-focused startup, and I'm happy about that.

	
c-smile on Jan 30, 2018 [-]

"Platform text rendering (CoreText, DirectWrite) not performant enough"
That above needs some reliable proof to be honest.

I am testing this claim with Sciter (https://sciter.com)... On Windows Sciter uses Direct2D/DirectWrite (with an option to render on DirectX device directly) and/or Skia/OpenGL. On Mac it uses Skia/OpenGL with an option to use CoreGraphics. On Linux Cairo or Skia/OpenGL.

Here is full screen text rendering on DirectX surface using Direct2D/DirectWrite primitives. Display is 192 ppi - 3840x2160:

https://sciter.com/temp/plain-text-syntax.png

On window caption you see real FPS that is around 500 frames per second for the whole screen for the sample. CPU consumption is 6% as it constantly does rendering in a "game event loop" style. In reality (render on demand as in sciter.exe) CPU consumption is 3% on kinetic scroll (120 FPS).

As you see platform text rendering is quite capable of drawing texts on modern hardware.

As of problems of text layouts ... Not that CPU and memory consuming too to be honest.

Sciter uses custom ::mark(name) pseudo-elements that allow to style arbitrary text runs/ranges without the need of creating artificial DOM elements (like <span> for each "string" in MS Visual Code), see: https://sciter.com/tokenizer-mark-syntax-colorizer/

To try this by yourself: get https://github.com/c-smile/sciter-sdk/blob/master/bin/32/sci... (sciter on DirectX) and sciter.dll nearby. Download https://github.com/c-smile/sciter-sdk/blob/master/samples/%2... and open it with the sciter-dx.exe.


	
raphlinus on Jan 30, 2018 [-]

I'll have to try this out. My experiments indicated that DirectWrite could not keep up with drawing on a 4k monitor at 60 Hz, though was ok at a smaller window. I think it might depend a lot on driver too. I'll see if I can instrument the xi-win prototype to give performance numbers. I do note that your lines aren't very wide, but still, in my tests I wasn't seeing anything like 500fps. DirectWrite does at least seem to use the GPU, while Core Text appears to rely entirely on software rendering.
Skia is definitely capable of good performance, as it resolves down to OpenGL draw calls, pretty much the same as Alacritty, WebRender, and now xi-mac. One thing though is that it doesn't do fully gamma-corrected alpha compositing, so it's not anywhere near pixel-accurate to CoreText rendering.

Doing proper measurement is not easy, but seems worth doing.


	
c-smile on Jan 30, 2018 [-]

Let me know if you need more tests around this.
If to consider more complex DOM cases then you can try https://notes.sciter.com/ application. Or to run it from SDK directly: https://github.com/c-smile/sciter-sdk/blob/master/bin/32/not...

Notes window layout resembles IDE layout pretty close. And Notes works on Window, Mac and Linux so you can compare different native text rendering implementations (I mean without conventional browsers overhead).


	
jwilm on Jan 30, 2018 [-]

> Skia is definitely capable of good performance, as it resolves down to OpenGL draw calls, pretty much the same as Alacritty, WebRender, and now xi-mac.
This claim is a bit surprising to me. I was under the impression Skia is an immediate mode renderer which ends up issuing a lot GL calls that could be avoided with a retained mode renderer.


	
kllrnohj on Jan 31, 2018 [-]

An immediate-style API does not mean the work is performed immediately. Skia defers and reorders internally to batch commands so minimal GL state changes are required.
That said a "lot of GL calls" for a 2D UI is actually a trivially insignificant number of GL calls to the actual GPU/driver for most cases. That's basically never the bottleneck unless you've done something insanely wrong.


	
IshKebab on Jan 31, 2018 [-]

I wouldn't be so sure. A single draw call is surprisingly slow. If you drew each glyph with one draw call that could be hundreds which will definitely cause slowness.

	
kllrnohj on Jan 31, 2018 [-]

"hundreds" is actually what I meant by insignificant to a modern driver.
For example: https://images.anandtech.com/graphs/graph11223/86100.png

Granted that's a 1060 but since we're looking at driver CPU overhead that shouldn't matter much. So 2.3 million draw calls per second in DX11 single threaded.

It's not until you start getting into the 10k+ draw calls a frame that you are putting your 60fps at risk.

It's often worth the work to avoid this anyway, after all faster is better if you're an engine/renderer, but it takes a lot for it to be an actual _problem_


	
IshKebab on Feb 3, 2018 [-]

Yeah, so 2 million, cut that down by 10 for integrated graphics. Then you need 60 fps, that brings it down to 3000. If you're just doing empty draw calls and nothing else. Throw in WebGL and hundreds is really significant.

	
vardump on Jan 30, 2018 [-]

> On window caption you see real FPS that is around 500 frames per second for the whole screen for the sample.
Sure, 500 fps, but that's not the important part. Latency would be. So at 500 fps with how much output latency to the display?


	
c-smile on Jan 30, 2018 [-]

For that particular text editor latency of char typed to appear on screen will be 16ms (normal 60 FPS refresh rate).
Editor keeps each line in separate <text> DOM elements (like <p> but no margins and only text inside).

So we just need to relayout one particular line in order to show typed character.


	
vardump on Jan 30, 2018 [-]

> For that particular text editor latency of char typed to appear on screen will be 16ms (normal 60 FPS refresh rate).
That's very impressive, if so. On Windows 7 with DWM (GPU display compositor) switched off?

How did you validate and measure latency?

Someone correct me if I'm wrong, but I'm under impression Windows 10 DWM adds additional latency making 16 ms latency unachievable.


	
c-smile on Jan 30, 2018 [-]

Not sure I understand your concerns. If you have DirectX there then you will have the same GPU rendering.
If that's about CPU rasterizers then Direct2D/WARP and Skia rasterizers are pretty good.

Problem is that if you have two monitors of the same size but one of "standard" 96ppi and another is, say, Retina grade (300+ ppi) then GPU rendering is the only reasonable option. Number of pixels to rasterize is 9 times more in Retina case. We do not have CPU performance increased 9 times...


	
kllrnohj on Jan 31, 2018 [-]

It would be dependent on how deep the pipeline is. In the fairly common case of 1 to 2 app threads (ui + rendering) + GPU work you're looking at a pipeline depth of 3, so if it's doing 500fps that must mean no stage of the pipeline is taking longer than 2ms. With 3 pipeline stages that puts your worst-case latency at 6ms.

	
z3t4 on Jan 30, 2018 [-]

platform rendering is very hard to beat. i tried to make my own bitmap text rendering but the native is much faster. and you wont notice any difference between 1ms and 10ms due to monitor refresh rate and human perception. text editors like notepad++ and sublime is already at ~5ms input latency. i think text rendering is already a solved problem. and not the bottleneck in for example browser based text editors.

	
jamesrom on Jan 30, 2018 [-]

This is awesome. Thank you for sharing.

	
vardump on Jan 30, 2018 [-]

There finally starts to be consciousness about input and output latency for GUI applications.
Xi sounds like an editor I'd love to use. Latency while typing is a jarring experience.


	
weinzierl on Jan 30, 2018 [-]

> Latency while typing is a jarring experience.
This is so true.

I grew up on the Commodore 64. The machine was usually pretty responsive, but when I typed too quickly in my word processor it sometimes got stuck and ate a few characters. I used to think: "If computers were only fast enough so I could type without interruption...". If you'd asked me back then for a top ten list what I wished computers could do, this would certainly have been on the list.

Now, 30 years later, whenever my cursor gets stuck I like to think:

"If computers were only fast enough so I could type without interruption..."


	
mixmastamyk on Jan 31, 2018 [-]

Recent article: https://danluu.com/input-lag/

	
EddieRingle on Jan 30, 2018 [-]

You might be interested in this article from a JetBrains developer who implemented zero-latency typing in IDEA:
https://pavelfatin.com/typing-with-pleasure/


	
kakarot on Jan 30, 2018 [-]

I first switched to Webstorm in early 2016, on a Windows laptop at the time, and the latency was absolutely horrific.
I'm talking 100-800ms. I was so off-put, even after changing a few settings, that I returned to Notepad++ for a while.

I'd never been so disgusted at a piece of software. It's the 21st century and we're dealing with input latency in a text editor???

Eventually they seemed to fix things and it started running better, and now on Linux it runs buttery smooth and is a joy to use, but clearly they were not finished with their work by the time this article was published.


	
rplnt on Jan 31, 2018 [-]

I bought (though in a sale) PyCharm few years back, without trying it much before (my bad), and found it really really bad. Used maybe 12 hours of my one year license.
Somehow got accustomed to to pretty much vanilla Sublime, mostly because I can't seem to get the language "intelligence" plugins to work correctly.


	
kakarot on Jan 31, 2018 [-]

You should give PyCharm another go. If you don't have a license anymore, JetBrains offers a free community version. It is more than enough to suit my needs.
What did you find bad about it? If it was just input latency, that's fixed.


	
rplnt on Feb 1, 2018 [-]

The UI overall was slow (I wouldn't remember if input delay was part of it). It's been in 2012 or 2013 I think, so yeah, I would hope they got better at it :)

	
kyrra on Jan 30, 2018 [-]

Xi backend repo: https://github.com/google/xi-editor
Fuschia front-end client for Xi: https://fuchsia.googlesource.com/topaz/+/master/app/xi/


	
cmyr on Jan 30, 2018 [-]

The official frontend is a Cocoa/Swift app: https://github.com/google/xi-mac

	
pjmlp on Jan 30, 2018 [-]

> Native UI. Cross-platform UI toolkits never look and feel quite right. The best technology for building a UI is the native framework of the platform. On Mac, that’s Cocoa.
Thumbs up!


	
taeric on Jan 30, 2018 [-]

People used to put a lot of effort into minimizing latencies. In large because they had to. However, you almost always land in an effectively cooperatively multitasking environment if you want truly lightning fast latency. Just after that, you are just reimplmenting schedulers and other preemptive tools. All of which just gives a hot target to a few particularly scheduled jobs that every developer feels their stuff has to happen in.

	
myrandomcomment on Jan 30, 2018 [-]

Pragmatically speaking the issue with switching editors is the fact that if it is not emacs or vi it is not a default install on whatever you sit down at.
I have tried tons of editors, and I always come back to vim. Heck, I have even moved my .vimrc to be the simplest possible with the smallest number of plugins.


	
keithnz on Jan 30, 2018 [-]

What's your reasoning behind needing it to be a default install? seems an odd requirement for an editor.
For instance, notepad is default on windows, and I'll use that when needed on vanilla windows machines, but for the 99% of my editor needs I install and customize a number of enviroments (including Vim). I don't mind whether it's installed by default or not.


	
cortesoft on Jan 30, 2018 [-]

I am guessing he works at a place that has a lot of servers that he connects to, and he wants to be able to use his editor on whatever server he is on.
I know this is an issue where I work. We have 40 thousand plus servers, and we aren't going to have everyone install their editor of choice on all those machines. If I have an issue I need to check on a server that requires some text editing, I have to use one of the default editors.


	
frou_dh on Jan 30, 2018 [-]

This is the appeal of sshfs - to be able to easily mount remote filesystems and use local tools against them.

	
erk__ on Jan 31, 2018 [-]

One of the best tools I have used with something like this is emacs's tramp-mode. It just works when you connect to another host.

	
ivrrimum on Jan 31, 2018 [-]

Yeah, but sshfs has been working pretty slow to me.
There is actually this neat hack you can use(if you use VIM) with rsync.

https://github.com/IvRRimum/rsync-vim

I know it's kind of Hacky, but the performance improvement is worth it IMO.


	
myrandomcomment on Jan 30, 2018 [-]

As the other poster guessed, vi is there on any system I log into that runs some form of Unix, including switch hardware.

	
sgillen on Jan 30, 2018 [-]

Even emacs is not installed by default on most operating systems. Even worse a lot of people customize their emacs setup so much that using the default setting can be painful.

	
lorenzhs on Jan 30, 2018 [-]

I use tramp-mode to connect to remote systems, which provides comfortable editing without requiring anything other than ssh access to the target machine. It’s quite nice.

	
jjrh on Jan 30, 2018 [-]

A emacs-tiny would be nice. Emacs package is just too large to be a default. On servers I usually just install mg/zile/jed.

	
eadmund on Jan 31, 2018 [-]

> On servers I usually just install mg/zile/jed.
I normally just use TRAMP. For those who've not used it, it's an incredible little emacs package which gives one a very Plan-9-esque feeling, in the sense that all the different systems one connects to feel like one whole.

As an example, when one is editing a remote file shell-command runs commands on the remote system, and of course find-file and friends work exactly like normal — only looking at files on the remote system.


	
stochastic_monk on Jan 31, 2018 [-]

I have always, always, always gone back to vim. Fast, efficient, clean, portable, heavily-featured, strongly customizable. It's trivial to call shell commands or inline python code generation.
I glanced over much of the presentation, and none of it was about the editor itself as a user would see it. I'm impressed and glad for the technical investment, but to be even a consideration for a replacement, I need a focus on how it's supposed to be an improvement, not just a substitute, for vim.


	
anderspitman on Jan 31, 2018 [-]

Personally, if I'm willing to copy my vimrc over to some machine I'm logged in to, I'm willing to copy a couple meg binary as well.

	
deadbunny on Jan 31, 2018 [-]

If i'm understanding things correctly you could write a vi/vim compatible frontend for xi so you get the benefits while not losing the functionality or muscle memory when not using xi.

	
xyproto on Jan 31, 2018 [-]

I'm so conflicted about this. On one hand, having the "engine" written in Rust, and the frontend written in language suitable for writing a GUI, per platform, is a sound architectural choice. On the other hand, if there's one type of open source applications we have enough to choose from already, it's editors. If it's for fun and the educational process, then by all means, that's swell.
Bui if it's because the world needs yet another editor, just because it can be written in Rust, I'm not so sure.


	
dsego on Jan 31, 2018 [-]

Probably none of them got it quite right then. There are people who want a lightweight but extendable GUI editor. The fact that people, including me, pay for Sublime Text, when there are powerful open-source alternatives around, kinda proves that there is a demand for such a thing.

	
akmittal on Jan 31, 2018 [-]

We have plenty of editors to choose from but we might use a Editor which has VSCode/Atom features+customization and vim performance.

	
sametmax on Jan 31, 2018 [-]

Sublime text is quite close to that.

	
IshKebab on Jan 31, 2018 [-]

It's not open source though.

	
pier25 on Jan 30, 2018 [-]

Just today I was trying to edit a 15MB JSON file and it was so terribly slow with Sublime Text and wondered if there was something faster out there.
Edit: So I built Xi-Mac and the file opens in a fraction vs ST3 but once it's open performance is just as bad or maybe even worse.


	
PurpleRamen on Jan 31, 2018 [-]

15 MB seems too small for making problems in any mature editor. Was it perhaps lacking newlines? Pretty much every editor sucks when you have very long lines.

	
pier25 on Jan 31, 2018 [-]

Yes, it was a very, very, very long line.

	
cmyr on Jan 31, 2018 [-]

Is this a debug build or a release build? File loading isn't particularly fast atm (we load the whole file into memory) but once a file is open I can breeze through it..

	
pier25 on Jan 31, 2018 [-]

I'm not really sure. I followed the instructions on the README to build with "xcodebuild".
It's painfully slow, moving the cursor 1 character to the right takes like 10 seconds.

Do you want me to file a bug?


	
cmyr on Jan 31, 2018 [-]

Please!

	
patrickaljord on Jan 30, 2018 [-]

A 15MB json file is more like a mini database, it'd be faster to run a quick script to import it in a nosql json database and then query from there. It may take 5 minutes but then you won't want to throw yourself out of the window when trying to edit/query it.

	
cmyr on Jan 31, 2018 [-]

There's no technical reason you shouldn't be able to happily scroll through (and edit) a 15MB json file; and search for an arbitrary string should take ~10ms (ballpark from playing around with ripgrep just now), certainly not slow enough to merit big up front indexing costs.

	
tootie on Jan 31, 2018 [-]

I could open a 15mb file in Eclipse 10 years ago. Idk why we're reinventing the wheel when we have flying cars. If you're not just using a JetBrains editor then you're being a masochist.

	
inferiorhuman on Jan 31, 2018 [-]

Why? jq should be able to make quick work out of it, or Postgres if you need more complex queries.

	
ozten on Jan 30, 2018 [-]

Async and CRDT to coordinate between core and plugins is super clever and seems scalable to future design choices. Levien calls out that there is a high complexity overhead to this architecture, but that it's probably worth it to maintain performance.

	
cryptonector on Jan 30, 2018 [-]

I agree. Async is critical. It's very important to catch the need for async early on, and then implement as async from the get-go. Going from sync to async is pretty much a rewrite, and no fun at all.

	
pnathan on Jan 30, 2018 [-]

> Separation into front-end and back-end modules.
That solves a lot of the Emacs trouble iiuc. (Same for the Async first design).

> The xi editor will communicate with plugins through pipes, letting them be written in any language,

That's caused a lot of trouble for vi/vim, has it not? I get the separation of concerns, but intermingling the concerns has helped emacs in a certain way.


	
eadmund on Jan 31, 2018 [-]

> > Separation into front-end and back-end modules.
> That solves a lot of the Emacs trouble iiuc.

True enough. Despite the fact that it's IMNSHO the best editor out there, emacs is not without its problems. It has a lot of historical baggage.

> I get the separation of concerns, but intermingling the concerns has helped emacs in a certain way.

I agree. One of the huge features of emacs is that (above a very low level) everything is implemented in a fairly decent Lisp, and everything is available to Lisp code. How much will plugins be able to dig into one anothers' internals in order to get work done? Yes, monkey-patching is bad — but it's better than not being able to monkey-patch. Relying on plugin authors to expose extension points is probably not going to work in the long run: it really helps being able to define advice on functions, wrap functions, replace functions, mutate internal variables when one knows what one's doing &c.


	
kranzky on Jan 31, 2018 [-]

Great stuff, and awesome to see this coming from Google (and in Rust instead of Go). Interesting historical note: The author of Sublime Text left Google to work on it by himself when he couldn't get it approved as a 20% project.

	
yla92 on Jan 31, 2018 [-]

It is not "coming" from Google despite it is under Google GitHub organization. There is a disclaimer[1] at the bottom of the repo README, stating that "This is not an official Google product (experimental or otherwise), it is just code that happens to be owned by Google.". It's my understanding that it's Raph code and Google has nothing to do with it other than having to own the code.
[1] : https://github.com/google/xi-editor#disclaimer


	
kranzky on Jan 31, 2018 [-]

Oh. Well, damn. I guess Steve Yegge was right. Anyway, wouldn't it be great if Google launched a kick-ass text editor?

	
JepZ on Jan 30, 2018 [-]

If I understand this correctly Xi and Alacritty are both using OpenGL to do the rendering and recently I heard that Rust supports compiling to Web Assembly.
Sounds as if it should be easy to port those apps to the browser world (WebGL + Web Assembly)? Does anybody know of any plans to do just that?


	
raphlinus on Jan 30, 2018 [-]

"Easy" is not the right word for this, but it's possible. One challenge is that browsers don't export an interface for "shaping". For Latin script, that means kerning and ligatures, and for complex scripts, it means being able to render it correctly at all. Currently, alacritty doesn't really deal with this, but xi-mac does, using the interfaces provided by Core Text.

	
infogulch on Jan 30, 2018 [-]

That's where pathfinder [1] comes in, as the fastest font rasterizer, utilizing the GPU and built in rust. (not affiliated). Ok maybe I'm overselling just a little but it's exciting!
[1]: https://github.com/pcwalton/pathfinder


	
pcwalton on Jan 30, 2018 [-]

Thanks for the kind words :) But Pathfinder doesn't do shaping.

	
infogulch on Jan 30, 2018 [-]

Ah, thanks for the clarification. It seems I need to do a bit more research before I advocate others projects, sorry about that. :)

	
zawerf on Jan 30, 2018 [-]

Figma (a UI design tool written in C++ compiled to JS using emscripten) talked about this briefly in their tech blog. They compiled FreeType to JS for rendering fonts to bitmaps: https://blog.figma.com/building-a-professional-design-tool-o...

	
constexpr on Jan 30, 2018 [-]

Figma actually only uses FreeType for parsing fonts (fonts are rendered using a custom WebGL-based renderer). Figma uses HarfBuzz for text shaping, which is easy to run on the web with emscripten: https://github.com/harfbuzz/harfbuzz.

	
JepZ on Jan 30, 2018 [-]

Just found https://github.com/acheronfail/xi-electron but actually I was more thinking of running the whole editor in the browser, not just the frontend.

	
electricslpnsld on Jan 30, 2018 [-]

Do any of the latency advantages of Xi carry over if you wrap it all up in Electron? The Electron editors do pretty badly on this front [1].
[1] https://pavelfatin.com/typing-with-pleasure/


	
raphlinus on Jan 30, 2018 [-]

I haven't started measuring it yet, but plan to. The idea of keeping the UI component light and doing all the heavy lifting in the core _might_ work well in Electron (as opposed to having all the logic in JS), and xi-electron is a good testbed for exploring that.

	
valarauca1 on Jan 30, 2018 [-]

I'm glad `xi` is separating the editor core from the UI.
This feels more correct. So the GUI authors can work on the chrome and polish, while the editor team focus on performance and all the nitty-gritty memory operations.


	
juancampa on Jan 30, 2018 [-]

NeoVim is moving towards this goal too. If you are a vimmer you should keep an eye on Oni (https://github.com/onivim/oni)

	
erikb on Jan 31, 2018 [-]

Never I would have guessed that "xi" is pronounces "gsai". I would pronounce it "shee" (like chinese) or "ksai" (english) or "ksee" (german).
Also, I don't thin we need another editor with a pluggable focus. It's not true that you need plugins to a text editor. It is plugged into an environment that also contains all the other things you need. It interacts via "open file", "read file", "write file" and "close file" with the other tools. It basically _IS_ the plugin for editing files.

And if you really want an editor containing plugins, then there's a load of it out there. You can start with all the IDEs, you can start with Emacs, you can start even with Neovim or Atom. This is not a feature that needs another project.


	
Retr0spectrum on Jan 31, 2018 [-]

Almost every English word that starts with an X has a "z" sound. e.g. xenon, xylophone, xiphoid. In fact, I can't think of any exceptions.
"zigh" as a pronunciation seems natural to me.


	
erikb on Jan 31, 2018 [-]

That's really good to know (although I'm not sure how the "z" is pronounced in that case either).
I always say "ksenon", "ksülofown" (ü is a sound between -e and -u and funnily exists in German and Chinese but not English), "ksifoid".


	
dhimes on Jan 31, 2018 [-]

Yeah, but when you ask a Chinese person how to pronounce Xi or Xiu the X -> sh. That's why I went with Shee also when I read this.

	
mixmastamyk on Feb 1, 2018 [-]

Portuguese also.

	
RandomCSGeek on Jan 31, 2018 [-]

They say it's pronounced "Zigh". I am a non-native English speaker, so I am not even going to try to question this.

	
erikb on Jan 31, 2018 [-]

Thanks. However "z" is also not really a clear sound, right? "ds" or "ssss" or "tsss". Naturally I would interpret "zigh" very similar to "sigh" but since "sigh" is a real thing I think there is a reason why you write "zigh" instead.
Anyway each hint is helpful. I'll google for that.


	
NoahTheDuke on Jan 31, 2018 [-]

To help out, let me point you to the English phonology page on wikipedia: https://en.wikipedia.org/wiki/English_phonology . Specifically, look into the 'Voiced alveolar sibilant', the 'z' in English. That's the sound you're looking for, as it's the one used by Raph in the linked talk.
For completeness, the vowel is the dipthong 'aɪ', pronounced like the 'i' in the word 'price', discussed on the same wiki page.


	
erikb on Feb 2, 2018 [-]

Great resource, thanks a lot! I think this is really the stuff you can't learn in high school education and have to learn by yourself. There our teachers are native Germans as well and while they are probably better than the average second language English learner they can't be perfect either.
In Chinese the "x" would be pronounced like that: https://en.wikipedia.org/wiki/Voiceless_alveolo-palatal_fric...

So not really a "sh-" either, but English doesn't have that sound at all I believe.


	
netgusto on Jan 30, 2018 [-]

Comment of the author of iterm2 on HN, about latency optimization: https://news.ycombinator.com/item?id=14800195

	
bch on Jan 31, 2018 [-]

I sure did like the core<—>core communicating idea for multiple users of a single document. It seemed like an easy trap to imagine X11 as the f/e, b/e, plugins, async were talked about, but not “just” using a remote f/e to communicate w a remote core was sort of enlightening (having fell into the X11 trap as the talk was progressing).
Question re: json communication though: is there a space for something like protocol buffers here, or is that a case of YAGNI, or simply ill-suited?


	
adultSwim on Jan 31, 2018 [-]

Great work. I love the plug-ins not being tied to a specific language. Surprised about doing rpc within a text editor but it was well argued in the presentation. If I consider it within the context of the tooling in an IDE it totally makes sense.
Text editors running on the desktop that are based on web browsers was a big step backwards. It encouraged features/plugins but now my text editor and my chat client each take gigabytes to run!


	
rcdwealth on Jan 31, 2018 [-]

Emacs: an editor for last 20 years and next 20 years.

	
anotheryou on Jan 30, 2018 [-]

Super cool! I hope you find someone to unfuck the WYSIWYG UX. (I'm hoping your markdown will be both, markdown and WYSI-nearly-WYG)

	
bedros on Jan 30, 2018 [-]

How small the binaries are, with a GUI (GTK, KDE, or QT), if I need to install in a system with no root permissions (local install) that's what I like about sublime, I can install it in home directory without needing admin help.
would you support plugins in a scripting language like python?


	
nkagan on Jan 31, 2018 [-]

What methods and tools were used to capture and collect the per-frame tracing? It looked cool and really clearly presented, I would love to use that myself.

	
mobilemidget on Jan 31, 2018 [-]

Tried it, xi-mac, though trips over a minimised font awesome css here, not even with all fonts, locks/freeze all other open windows.

	
rwx------ on Jan 31, 2018 [-]

Trying to build it, but I get
error: could not find `Cargo.toml` in `/home/xyz/Downloads/xi-editor-0.2.0` or any parent directory


	
Lev1a on Jan 31, 2018 [-]

From a quick glance you should probably cd into the rust/ subdirectory to build the rust code of this project.

	
wakkaflokka on Jan 30, 2018 [-]

What's the best Windows build for this?

	
davidbalbert on Jan 30, 2018 [-]

I believe it will eventually live at https://github.com/google/xi-win, though I think the focus is on getting the Mac version working first.

	
raphlinus on Jan 30, 2018 [-]

Indeed. I was hoping to put more effort into xi-win than it's gotten, but for a variety of reasons have decided to focus on the macOS front end for now, as there's quite a bit of work remaining to get a daily-usable editor up on one platform.

	
MisterTea on Jan 30, 2018 [-]

It's somewhere in /dev/null.

	
_sveq on Jan 31, 2018 [-]

I wonder if the name is a tip of the hat to China and their leader. Anyone know?

	
johnklos on Jan 31, 2018 [-]

Nice ideas, but it's a shame that Rust is barely portable.

	
sinistersnare on Jan 31, 2018 [-]

How is it barely portable? Sure, less than C for now, but its not 'barely.'

		More


Guidelines | FAQ | Support | API | Security | Lists | Bookmarklet | Legal | Apply to YC | Contact

Search: 
