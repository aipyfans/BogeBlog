---
layout: post
title:  "Node.js和NPM版本的升级"
date:   2018-04-21 14:49:48
categories: CST
tags:
  - Software
  - Server
---

## 升级 node.js

npm中有一个模块叫做“n”，专门用来管理node.js版本的。

更新到最新的稳定版只需要在命令行中打下如下代码：

```
npm install -g n
n stable
```

> 注意：Linux系统需要添加sudo权限
>
> eg: sudo npm install -g n

如需最新版本则用`n latest`

![img](https://segmentfault.com/img/remote/1460000009025886?w=562&h=128)

当然，n后面也可以跟具体的版本号：`n v6.2.0`

> 具体细节参见 [n模块的GitHub](https://github.com/tj/n)
>
> 相关资料 [用n管理不同版本的Node](https://github.com/muwenzi/Program-Blog/issues/6) 

## 升级 npm

npm升级就更简单了，只需要在终端中输入：

```
npm -g install npm@latest
```

> 具体可参见阮一峰的[【NPM模块管理器】](http://javascript.ruanyifeng.com/nodejs/npm.html)