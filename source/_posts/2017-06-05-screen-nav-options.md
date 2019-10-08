---
layout: post
title:  "屏幕导航选项(Screen Navigation Options)"
date:   2017-06-05 11:11:11
categories: react navigation
---

每个屏幕可以配置关于如何在父导航器中呈现的几个方面。

#### 两种方式来指定每个选项

**静态配置(Static configuration):** 每个导航选项都可以直接分配：

```js
class MyScreen extends React.Component {
  static navigationOptions = {
    title: 'Great',
  };
  ...
```

**动态配置(Dynamic Configuration)**

或者，选项可以是一个接受以下参数的函数，并返回导航选项的对象，该对象将覆盖路由定义和导航器定义的`navigationOptions`。

- `props` - 可用于屏幕组件的共同的属性
  - `navigation` -屏幕的导航属性( [navigation prop](/docs/navigators/navigation-prop))，和在`navigation.state`里的屏幕路由
  - `screenProps` - 从导航器组件上传递过来的属性
  - `navigationOptions` - 未提供新值时将使用的默认或先前设置的选项

```js
class ProfileScreen extends React.Component {
  static navigationOptions = ({ navigation, screenProps }) => ({
    title: navigation.state.params.name + "'s Profile!",
    headerRight: <Button color={screenProps.tintColor} {...} />,
  });
  ...
```

`screenProps`在渲染时传入。如果此屏幕托管在`SimpleApp`导航器中：

```js
<SimpleApp
  screenProps={{tintColor: 'blue'}}
  // navigation={{state, dispatch}} // optionally control the app
/>
```

#### 通用导航选项(Generic Navigation Options)

标题 `title` 导航选项在每个导航器之间是通用的。它用于设置给定屏幕的标题字符串。

```js
class MyScreen extends React.Component {
  static navigationOptions = {
    title: 'Great',
  };
  ...
```

与导航器视图仅使用的其他导航选项不同，环境中可以使用标题选项来更新浏览器窗口或应用程序切换器中的标题。

#### 默认导航选项(Default Navigation Options)

在屏幕上定义`navigationOptions`是非常常见的，但有时也可以在导航器上定义navigationOptions也很有用

想象下面的情况：您的`TabNavigator`表示应用程序中的一个屏幕，并嵌套在顶级`StackNavigator`中：

```
StackNavigator({
  route1: { screen: RouteOne },
  route2: { screen: MyTabNavigator },
});
```

现在，当`route2`处于活动状态时，您想更改标题的色调颜色。对于`route1`来说很容易做到，对于route2也是很容易的。这是默认导航选项 - 它们只是在导航器上设置的导航选项：

```js
const MyTabNavigator = TabNavigator({
  profile: ProfileScreen,
  ...
}, {
  navigationOptions: {
    headerTintColor: 'blue',
  },
});
```

请注意，您仍然可以决定在叶级别的屏幕上指定`navigationOptions`。上面的`ProfileScreen`屏幕上的`navigationOptions`将逐个合并到导航器的默认选项。无论什么时候导航器和屏幕都定义和相同的选项（例如`headerTintColor`），屏幕将会覆盖导航器的`navigationOptions`。因此，通过执行以下操作，您可以在`ProfileScreen`处于活动状态时更改色彩：

```js
class ProfileScreen extends React.Component {
  static navigationOptions = {
    headerTintColor: 'black',
  };
  ...
}
```

## 导航选项参考(Navigation Option Reference)

可用的导航选项列表取决依赖于添加屏幕的导航器。

检查以下可用选项：
- [`drawer navigator`](/docs/api/navigators/DrawerNavigator.md#screen-navigation-options)
- [`stack navigator`](/docs/api/navigators/StackNavigator.md#screen-navigation-options)
- [`tab navigator`](/docs/api/navigators/TabNavigator.md#screen-navigation-options)
