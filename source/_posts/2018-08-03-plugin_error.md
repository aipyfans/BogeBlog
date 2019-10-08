---
layout: post
title:  "Android Studio PluginManager$StartupAbortedException 异常解决方案(Mac平台)"
date:   2018-08-03 22:11:00
categories: android
---

这是自己亲自动手解决的首个 Android Studio 异常，网上的方案大都是人云亦云，没有自己的思考

> [java.lang.RuntimeException: com.intellij.ide.plugins.PluginManager$StartupAbortedException: Fatal error initializing](https://intellij-support.jetbrains.com/hc/en-us/community/posts/360000125550-Android-Studio-3-0-1-won-t-start-up-accidentally-reverted-something-during-an-update-) 

### 原因

我们从上面的异常名称来分析一下：

`PluginManager$StartupAbortedException` 见名知意：由于`插件管理`导致的启动终止

1. 最近有没有添加一些新的插件？
2. 有没有异常关机的情况？

### 方案

既然找到原因了，我们就要动手解决一下：

1. 暴力方案：找到插件所在的文件夹，将整个插件文件夹删除
2. 优雅方案：知道自己最近安装了哪些插件，删除指定的插件

> 出现此异常大多都是因为我们安装了第三方插件导致的不兼容异常


### 备注

1. Android Studio 【第三方插件】所在的文件夹路径【出现上面的异常，一般情况下，操作此文件夹】

   ```
   /Users/william/Library/Application Support/AndroidStudio3.1
   ```

2. Android Studio 【内置插件】所在的文件夹路径

   ```
   /Applications/Android Studio.app/Contents/plugins 
   ```

3. Android Studio IDE 【程序】所在的文件夹路径

   ```
   /Applications/Android Studio.app/Contents
   ```

4. Android Studio IDE 【配置】所在的文件夹路径

   ```
   /Users/william/Library/Preferences/AndroidStudio3.1
   ```

   

