---
layout: post
title:  "Android Application 必备的基本功能"
date:   1986-08-03 00:00:00
categories: android
---

本文所秉承“知其原理，实践证明”的宗旨。来讲述一个 Android Application 所必备的一些基本功能。

* [Android 开发规范](https://github.com/Blankj/AndroidStandardDevelop)


* [日志管理系统](https://developer.android.com/studio/debug/am-logcat.html?hl=zh-cn)
  * [logcat 命令行工具](https://developer.android.com/studio/command-line/logcat.html?hl=zh-cn)
  * [logcat日志输出颜色](http://blog.csdn.net/yy1300326388/article/details/45825123)
  * [如何安全地打印日志](http://weishu.me/2015/10/19/how-to-log-safely-in-android/)
  * 如何优雅地输出日志 
    * [loger](https://github.com/orhanobut/logger)
    * [timber](https://github.com/JakeWharton/timber)
  * [Android Studio Live Templates](https://github.com/huangdali/livetemplates)
  * [日志 Tag 的定义：哪些地方应该打Tag (toto)]()
* [异常管理系统(todo)]()
  * [应用全局异常捕获 Thread.UncaughtExceptionHandler](https://juejin.im/entry/5780d48e5bbb500061f690f9)
  * [获取设备相关信息](https://developer.android.com/reference/android/os/Build.html)
    * [获取系统信息](http://blog.csdn.net/ccpat/article/details/44776313)
    * [唯一标识符最佳做法](https://developer.android.com/training/articles/user-data-ids.html?hl=zh-cn)
  * 第三方异常捕获SDK库以及Bug后台管理系统
    * [Bugly](https://bugly.qq.com/v2/) 客户端集成 后台查看Bug
    * [BugTags](https://work.bugtags.com/) 有 [Bugly](https://bugly.qq.com/v2/) 和 [BugClose](https://www.bugclose.com) 的功能,特点在于全民测试 ( 摇一摇,随时随地提交Bug ).
    * [BugClose](https://www.bugclose.com) 主要给测试人员使用的后台Bug管理系统.
* [通知管理系统(todo)]()
  * 官网资料
    - [Notification](https://developer.android.com/guide/topics/ui/notifiers/notifications.html?hl=zh-cn)
    - [RemoteViews](https://developer.android.com/reference/android/widget/RemoteViews.html)
    - [NotificationManager](https://developer.android.com/reference/android/app/NotificationManager.html)
    - [NotificationCompat.Builder](https://developer.android.com/reference/android/support/v4/app/NotificationCompat.Builder.html)
  * 网络资料
    * [Notification通知栏开发详解](http://www.jcodecraeer.com/a/anzhuokaifa/developer/2014/0323/1600.html)
    * [Notification及RemoteViews整理](https://jestar719.github.io/2017/02/27/Android%E9%80%9A%E7%9F%A5%E5%8F%8ARemoteView%E6%95%B4%E7%90%86/)
    * [通知栏介绍与适配总结](http://iluhcm.com/2017/03/12/experience-of-adapting-to-android-notifications/)
    * [通知栏Notification的整合](http://blog.csdn.net/vipzjyno1/article/details/25248021)
* 页面管理系统
  * Activity管理.
* 文件管理系统
* [网络管理系统]()
  * [Android：检测网络状态&监听网络变化](https://www.jianshu.com/p/983889116526)
* 屏幕适配系统
* 动画管理系统
* 打包发布系统
  * 内测分发
    * [FIR](https://fir.im/)
    * [蒲公英](https://www.pgyer.com/)
* 工具类和基类
  * [AndroidUtilCode 1](https://github.com/Blankj/AndroidUtilCode)
  * [AndroidUtilCode 2](https://github.com/Trinea/android-common)
* 闪屏
* 引导页
* 用户管理系统[登录登出Token]

