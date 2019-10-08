---
layout: post
title:  "Ubuntu安装MongoDB"
date:   2018-04-02 14:00:11
categories: CST
tags:
  - Software
  - Server

---



> 相关网站
>
> [MongoDB官网](https://www.mongodb.com) 
>
> [MongoDB中文网](http://www.mongodb.org.cn/)  
>
> [MongoDB社区](http://www.mongoing.com/) 
>
> Ubuntu搭建Node服务器，主要可以通过**两种方式**进行安装：
>
> 1. 二进制文件
> 2. 包管理器

## 二进制文件

1. 获取下载源地址 [点此获取](https://www.mongodb.com/download-center?jmp=nav#community)

   ```
   https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-3.6.3.tgz
   ```

2. 下载安装包并解压

   ```
   wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-3.6.3.tgz
   tar -xzvf mongodb-linux-x86_64-ubuntu1604-3.4.5.tgz
   ```
   > 如果服务器下载特别慢，那就在本地电脑下载好后,使用[SCP命令](https://my.oschina.net/u/1756504/blog/372423)上传到服务器上。
   >
   > scp -r mongodb.tgz root@116.196.91.32:/root/softwares/
   >
   > **解压过程中容易出错，解决方案见下方**

3. 配置环境变量

   ```
   vi .bashrc // 把MongoDB的bin目录添加到环境变量中
   export PATH=$PATH:<mongodb-install-directory>/bin
   source .bashrc
   ```

4. 验证是否安装成功

   ```
   mongod --version
   ```

   ```
   db version v3.2.17
   -----------------------------------------------------
   git version: 186656d79574f7dfe0831a7e7821292ab380f667
   OpenSSL version: OpenSSL 1.0.2g  1 Mar 2016
   allocator: tcmalloc
   modules: none
   build environment:
       distmod: ubuntu1604
       distarch: x86_64
       target_arch: x86_64
   -----------------------------------------------------
   ```

   ​



## 包管理器

> [Ubuntu apt安装MongoDB【官方】文档](https://docs.mongodb.com/master/tutorial/install-mongodb-on-ubuntu/) 
>
> [Ubuntu apt安装MongoDB【中文】文档](https://blog.lijunbo.com/2018/04/02/ubuntu_mongo_install/) 

## 遇到的问题

1. [使apt-get支持SSL源](https://xtu2.com/835.html) 

   > 因为在软件源中要用到HTTPS进行传输，所以，首先安装apt-transport-https，否则会出现：
   > E: The method driver /usr/lib/apt/methods/https could not be found.
   > N: Is the package apt-transport-https installed?
   >
   > 使用下面命令安装apt的ssl支持
   > apt-get install apt-transport-https
   >
   > 顺便分享几个SSL的源站
   > https://mirrors.ustc.edu.cn/
   > https://mirrors.aliyun.com/
   >
   > https://mirrors.tuna.tsinghua.edu.cn/ 似乎限速.... 不推荐用

2. [tar解压出错：gzip: stdin: unexpected end of file的解决办法](https://blog.csdn.net/G_66_hero/article/details/68496801)


   解决方案：重新下载，再次进行解压。

## 参考链接

> [Ubuntu 16.04 安装 MongoDB Community Edition](https://www.jianshu.com/p/1eff9b89189e) 