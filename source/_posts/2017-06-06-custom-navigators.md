---
layout: post
title:  "自定义导航器(Custom Navigators)"
date:   2017-06-06 11:11:11
categories: react navigation
---

导航器是具有一个路由器( [router](/docs/routers/) )的React组件。下面是一个基本的导航器，它使用路由器的API( [router's API](/docs/routers/api) )来获取活动组件进行渲染：

```js
class MyNavigator extends React.Component {
  static router = MyRouter;
  render() {
    const { state, dispatch } = this.props.navigation;
    const { routes, index } = state;

    // 路由器根据导航状态找出要渲染的内容：
    const Component = MyRouter.getComponentForState(state);

    // 活动子屏幕的状态可以在routes [index]
    let childNavigation = { dispatch, state: routes[index] };
    // 如果我们想要，我们也可以修改这里的分发功能来限制或增加我们孩子的行为

    // 假设我们的子屏幕想要方便地调用.navigate（）
    // 我们应该调用addNavigationHelpers来增强我们的导航属性(navigation prop)：
    childNavigation = addNavigationHelpers(childNavigation);

    return <Component navigation={childNavigation} />;
  }
}
```

## 导航属性(Navigation Prop)

传递给导航器的导航属性(navigation prop)只包括状态( `state`) 和分发( `dispatch`)。这是导航器的当前状态，以及发送动作请求的事件通道。

所有导航器都是受控组件：它们总是显示通过`props.navigation.state`进入的内容，而他们改变状态的唯一方法是将动作发送到`props.navigation.dispatch`中。

导航器可以通过自定义路由器( [customizing their router](/docs/routers/))来指定父导航器的自定义行为。例如，导航器能够通过从`router.getStateForAction`返回null来指定应该何时阻止执行动作。或者导航器可以通过重写`router.getActionForPathAndParams`来指定自定义URI处理，以输出相关的导航动作，并在`router.getStateForAction`中处理该动作。

### 导航状态(Navigation State)

传递到导航器的`props.navigation.state`的导航状态具有以下结构：

```
{
  index: 1, // 识别路由数组中的哪个路由是活动的
  routes: [
    {
      // 每个路由都需要一个名称，路由器将用于将每个路由与一个React组件相关联
      routeName: 'MyRouteName',

      // 此路由的唯一ID，用于在路由数组中保持顺序：
      key: 'myroute-123',

      // 路由可以有任何其他数据。包含路由器有的`params`
      ...customRouteData,
    },
    ...moreRoutes,
  ]
}
```

### 导航分发(Navigation Dispatchers)

导航器可以发送导航动作，例如“转到URI”( 'Go to a URI')，“返回”('Go back')。

如果动作成功处理，分发者将返回true，否则返回false。

## 用于构建自定义导航器的API

为了帮助开发人员实现自定义导航器，React Navigation提供了以下实用函数：

### `createNavigator`

该实用函数以标准方式将路由器( [router](/docs/routers/) )和导航视图( [navigation view](/docs/views/) )组合在一起：

```js
const MyApp = createNavigator(MyRouter)(MyView);
```

所有这一切在幕后是：

```js
const MyApp = ({ navigation }) => (
  <MyView router={MyRouter} navigation={navigation} />
);
MyApp.router = MyRouter;
```

### `addNavigationHelpers`

进入一个使用状态( `state` )和分发(`dispatch` )的裸导航器导航属性，并使用【屏幕导航属性中的所有各种函数如 `navigation.navigate()` 和`navigation.goBack()`】增强它。这些功能只是帮助人员创建动作并将其发送到`dispatch`。

### `createNavigationContainer`

如果您希望导航器可用作顶级组件，（没有导航属性被传入），你可以使用`createNavigationContainer`。当导航属性丢失时，此实用函数将使您的导航器像顶级导航器。它将管理应用程序状态，并与应用程序级别的导航功能集成，如处理传入和传出链接以及Android返回按钮行为。