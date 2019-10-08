---
layout: post
title:  "Ubuntu Development Tools"
date:   2017-01-11 11:11:11
categories: linux
---



### 一、翻墙

[修改Hosts文件 ---> 翻墙](https://github.com/racaljk/hosts)

```
sudo gedit /etc/hosts
sudo /etc/init.d/networking restart
```

[自由上网方法](https://github.com/Alvin9999/new-pac/wiki)

[谷歌浏览器Chrome+ShadowSocks+Proxy SwitchyOmega自动翻墻教程](https://github.com/FelisCatus/SwitchyOmega/wiki/GFWList)

```
https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt
```

[解决Github访问超慢问题](http://zengrong.net/post/2092.htm)

### 二、小工具

##### [安装Ubuntu 16.04后要做的事](http://blog.csdn.net/skykingf/article/details/45267517)

##### 自定义 Ubuntu 16.04 Unity 所处位置

```
gsettings set com.canonical.Unity.Launcher launcher-position Bottom
gsettings set com.canonical.Unity.Launcher launcher-position Left
sudo apt-get install dconf-editor
```

##### Ubuntu 16.04 无法安装软件解决办法

```
试图双击deb文件进行安装，点击install按钮
提示“This software comes from a 3rd party and may contain non-free components”

sudo apt install gdebi

安装完成后，将deb文件默认打开方式设为gdebi：
右键点击deb文件，打开properties，选择open with，选中GDebi Package Installer. 并Set as default
```

### 三、应用工具

[1-安装Sogou输入法](http://pinyin.sogou.com/linux/?r=pinyin)

[解决搜狗输入法切换无效的方法](https://www.ubuntukylin.com/ukylin/forum.php?mod=viewthread&tid=29283)

rm -Rf ~/.config/SogouPY
rm -Rf ~/.config/SogouPY.users
rm -Rf ~/.config/sogou-qimpanel

[2-安装shadowsocks](https://shadowsocks.com/)

[3-安装Chrome浏览器](https://www.google.com/chrome/browser/desktop/index.html)

[4-安装Evernote](https://app.yinxiang.com)

[5-安装NetEase Cloud Music](http://music.163.com/#/download)

[6-安装Nutstore](https://www.jianguoyun.com/)

[7-安装WPS Office](http://linux.wps.cn/)

[8-安装FCC](https://www.freeconferencecall.com/support)

[9-安装Typora]([https://typora.io/](https://typora.io/))

### 四、开发工具

[SdkMan](http://sdkman.io/)

[Groovy](http://www.groovy-lang.org/)	 [Gradle](https://gradle.org/)	 [C语言](http://wiki.jikexueyuan.com/project/c/)	 [C++](http://wiki.jikexueyuan.com/project/cplusplus/)

[0-安装KDK](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

[1-安装Android Studio](https://developer.android.com/studio/index.html)

[2-安装IntelliJ IDEA](https://www.jetbrains.com/idea/download/#section=linux)

[3-安装Xmind](http://www.xmind.net/download/linux/)

[4-安装JD-JUI](https://github.com/java-decompiler/jd-gui)

[5-安装Dex2Jar](https://github.com/pxb1988/dex2jar)

[6-安装Vim](https://github.com/vim)

[7-安装Git](https://git-scm.com)

```
$ git config --global user.name "william"
$ git config --global user.email "william.lee@gtedx.com"
$ ssh-keygen -t rsa -C “william.lee@gtedx.com”
```

### 五、配置环境

所有的环境变量都配置到~/.bashrc文件中

sudo gedit ~/.bashrc

source ~/.bashrc

**# set oracle jdk environment**

export JAVA_HOME=/home/william/Develop/Kit/jdk ## 这里要注意目录要换成自己解压的jdk 目录

export JRE_HOME=${JAVA_HOME}/jre  

export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib:$CLASSPATH  

export PATH=${JAVA_HOME}/bin:$PATH

**# set android sdk enviroment**

export ANDROID_HOME=/home/william/Develop/Kit/sdk

export PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:$PATH

**#set git environment**

**#set gradle environment**

**#set groovy environment**



