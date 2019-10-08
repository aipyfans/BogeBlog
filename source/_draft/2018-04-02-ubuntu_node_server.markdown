---
layout: post
title:  "Ubuntu搭建Node服务器"
date:   2018-04-02 14:00:05
categories: CST
tags:
  - Software
  - Server
---

> Ubuntu搭建Node服务器，主要可以通过**三种方式**进行安装：
>
> 1. 编译源码
> 2. 包管理器
> 3. 二进制文件

## 编译源码

1. 安装依赖

   nodejs的一些模块可能会依赖一些编译工具，如c编译器和python环境，wget命令用来从指定的URL下载文件。
   apt-get是在各个平台都有相关的包管理工具，你可以直接使用apt-get安装。

   ```
   apt-get install python gcc make g++ wget
   ```

2. 安装Node

   在linux下默认源中没有node的程序,所以不推荐使用apt-get安装。推荐使用wget下载nodejs源码安装，nodejs个版本源码列表：<https://nodejs.org/download/rc/>

   ```
   cd /home
   mkdir softwares  
   cd softwares 
   wget https://nodejs.org/download/rc/v9.0.0-rc.0/node-v9.0.0-rc.0.tar.gz   
   tar -zxvf node-v9.0.0-rc.0.tar.gz     
   cd node-v9.0.0-rc.0
   ```

   解压后的目录下会有一个configure文件，是一个shell脚本，它可以自动设定源程序以符合各种不同平台上Unix系统的特性，并且根据系统叁数及环境产生合适的Makefile文件或是C的头文件(header file)，让源程序可以很方便地在这些不同的平台上被编译连接。 
   使用./configure 配置源码：

   ```
   ./configure
   ```

   使用make insatll进行安装：

   ```
   make insatll
   ```

   或许等待过程很漫长，执行完毕之时node即安装完成。

## 包管理器

```
sudo apt-get update
sudo apt-get install nodejs
```

参考《[Debian and Ubuntu based Linux distributions](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)》部分

## 二进制文件

1. 首先下载NodeJS的二进制文件，<http://nodejs.org/download/>

   > 在 Linux Binaries (.tar.gz)处根据自己系统的位数选择

2. 下载后将安装包移动到要安装到的文件夹下，根据个人喜好设置即可

   >  这里放置在/home/softwares/ 下面,依次执行如下命令，可看到 
   >
   > ```
   > cd /home/softwares/
   > ls
   > tar zxvf 
   > ```



> 参考链接
>
> [Ubuntu 搭建 Nodejs服务器](https://segmentfault.com/a/1190000012322221) 
>
> [Ubuntu 安装 Nodejs](https://segmentfault.com/a/1190000008653668) 
>
> [Linux 下部署 Nodejs 两种方式](http://www.cnblogs.com/dubaokun/p/3558848.html)  