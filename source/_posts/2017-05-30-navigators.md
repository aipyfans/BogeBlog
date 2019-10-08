---
layout: post
title:  "导航器(Navigator)"
date:   2017-05-30 11:11:11
categories: react navigation
---

导航器允许您定义应用程序的导航结构。导航器还可以渲染你配置过的像标题栏和标签栏等常见元素。在该引擎下，导航器是简单的React组件。

## 内置导航器

`react-navigation` 包括以下功能来帮助您创建导航器：

- [StackNavigator](/docs/navigators/stack) - 一次呈现一个屏幕，并提供屏幕之间的转换。当新屏幕打开时，它被放置在堆栈的顶部。
- [TabNavigator](/docs/navigators/tab) - 渲染一个标签栏，让用户在几个屏幕之间切换
- [DrawerNavigator](/docs/navigators/drawer) - 提供从屏幕左(右)侧滑入的抽屉菜单

## 使用导航器渲染屏幕

导航器渲染仅由React组件组成的应用程序屏幕。

要了解如何创建屏幕，请阅读：

- 屏幕导航属性（[Screen `navigation` prop](/docs/navigators/navigation-prop)允许屏幕分发导航动作(navigation actions)，如打开另一个屏幕
- 屏幕导航选项([Screen `navigationOptions`](/docs/navigators/navigation-options))可以通过导航器自定义如何显示屏幕内容（例如头部标题，标签标题）

### 在根组件上调用导航

如果您想要使用相同级别的Navigator，您可以声明它，您可以使用react的ref选项：

```js
const AppNavigator = StackNavigator(SomeAppRouteConfigs);

class App extends React.Component {
  someEvent() {
    // call navigate for AppNavigator here:
    this.navigator && this.navigator.dispatch({ type: 'Navigate', routeName, params });
  }
  render() {
    return (
      <AppNavigator ref={nav => { this.navigator = nav; }} />
    );
  }
}
```
请注意，此解决方案只能在根导航器上使用。

## 导航容器

当导航属性丢失时，内置导航器可以自动表现为根导航器。该功能提供了一个透明的导航容器，这是顶级导航属性的来源。

当渲染其中一个导航器时，导航属性是可选的。当它丢失时，容器进入并管理其自己的导航状态。它还处理URL，外部链接和Android后退按钮集成。

为了方便起见，内置的导航器具有这种能力，因为幕后他们使用`createNavigationContainer`。通常，导航器需要导航属性才能起作用。

根导航器接受以下属性：

### `onNavigationStateChange(prevState, newState, action)`

每次由导航器管理的导航状态发生变化，该函数都会被调用。它接收到以前的状态，新的导航状态和发生状态变化的动作。默认情况下会将状态更改打印到控制台。

### `uriPrefix`

应用程序可能会处理的URI的前缀。这将在处理深层链接( [deep link](/docs/guides/linking) )以提取路径传递到路由器时使用。