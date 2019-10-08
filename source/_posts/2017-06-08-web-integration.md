---
layout: post
title:  "Web集成(Web Integration)"
date:   2017-06-08 11:11:11
categories: react navigation
---

React导航路由器可以在web上工作，并允许您与本机应用程序共享导航逻辑。目前在 `react-navigation` 中捆绑的视图目前只适用于React Native，但这可能会与面向未来的项目（如 [react-primitives](https://github.com/lelandrichardson/react-primitives)）发生变化。

## 示例应用程序(Example App)

[该网站](https://reactnavigation.org/)是使用React Navigation[构建](https://github.com/react-community/react-navigation/blob/master/website/)的，具体使用`createNavigator`和`TabRouter`。

在这里查看网站的源代码:[App.js](https://github.com/react-community/react-navigation/blob/master/website/src/App.js).

要了解应用程序如何在服务器上呈现，请参阅[Server.js](https://github.com/react-community/react-navigation/blob/master/website/src/Server.js)。在浏览器上，App被唤醒并使用[BrowserAppContainer.js](https://github.com/react-community/react-navigation/blob/master/website/src/BrowserAppContainer.js)渲染。


## 更多即将推出(More Coming Soon)

不久之后，本指南将被Web上的react-navigation使用的更彻底的演练所取代。