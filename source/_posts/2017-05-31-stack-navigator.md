---
layout: post
title:  "栈导航器(StackNavigator)"
date:   2017-05-31 11:11:11
categories: react navigation
---

为您的应用程序提供了一种在每个新屏幕放置在堆栈顶部的屏幕之间转换的方法。

默认情况下，`StackNavigator`配置为熟悉的iOS和Android设备外观：iOS上的新屏幕从右侧滑出，Android上的新屏幕从底部渐隐。在iOS上，`StackNavigator`也可以配置为模式风格，让屏幕从底部滑入。

```jsx

class MyHomeScreen extends React.Component {
  static navigationOptions = {
    title: 'Home',
  }

  render() {
    return (
      <Button
        onPress={() => this.props.navigation.navigate('Profile', {name: 'Lucy'})}
        title="Go to Lucy's profile"
      />
    );
  }
}

const ModalStack = StackNavigator({
  Home: {
    screen: MyHomeScreen,
  },
  Profile: {
    path: 'people/:name',
    screen: MyProfileScreen,
  },
});
```

## API 定义

```js
StackNavigator(RouteConfigs, StackNavigatorConfig)
```

### 路由配置(RouteConfigs)

路由配置对象是从路由名称到路由配置的映射，它告诉导航器该路由要呈现什么内容。

```js
StackNavigator({

  // 你可以导航到每个屏幕，创建一个新的屏幕，如下所示：
  Profile: {

    // `ProfileScreen`是一个React组件，将作为屏幕的主要内容。
    screen: ProfileScreen,
    // 当`ProfileScreen`由StackNavigator加载时，它将被赋予“navigation”属性。

    // 可选：在Web应用程序中深链接或使用react-navigation导航时，将使用此路径：
    path: 'people/:name',
    // 从路径中提取动作(action)和路由参数.

    // 可选：覆盖屏幕的`navigationOptions`（即每个组件中的`navigationOptions`）
    navigationOptions: ({navigation}) => ({
      title: `${navigation.state.params.name}'s Profile'`,
    }),
  },

  ...MyOtherRoutes,
});
```

### 栈导航器配置(StackNavigatorConfig)

路由器选项:

- `initialRouteName` - 为栈(stack)设置默认的界面，必须和路由配置(route configs)里面的一个key匹配。
- `initialRouteParams` - 初始路由的参数
- `navigationOptions` - 用于屏幕的默认导航选项
- `paths` - 在路由设置(RouteConfigs)里面设置映射路径的覆盖(不太明白)

视觉选项:

- `mode` - 定义渲染(rendering)和转换(transitions)的样式式,两种选项(给字符串即可)：
  - `card` - 使用标准的iOS和Android的界面切换，这是默认的。
  - `modal` - 使屏幕从底部滑入，这是一种常见的iOS模式。只适用于iOS，对Android没有作用。
- `headerMode` - 指定标题(Header)应该如何被渲染,选项：
  - `float` - 渲染一个保持在顶部的标题，并在屏幕更改时显示动画。这是iOS上的常见模式。(即共用一个header 意思就是有title文字渐变效果)
  - `screen` - 每个屏幕都有一个标题，标题与屏幕一起淡入淡出。这是Android上的常见模式(各用各的header 意思就是没有title文字渐变效果)
  - `none` - 不会显示标题(没有header)
- `cardStyle` - 使用该属性继承或者重载一个在stack中的card的样式.
- `transitionConfig` - 定义一个返回覆盖默认屏幕的换场动画的对象的函数.
- `onTransitionStart` - 当Card换场动画即将开始时，调用此函数.
- `onTransitionEnd` - 当Card换场动画完成时，立即调用此函数.


### 屏幕导航选项(Screen Navigation Options)

#### `title`

页面的标题：用作`headerTitle`和`tabBarLabel`的回退的字符串

#### `header`

React元素(组件)或者一个赋予`HeaderProps`的函数返回的一个React元素(组件)，显示为一个标题栏。设置为null隐藏标题栏。

#### `headerTitle`

标题使用的字符串或React元素(组件)。默认为场景值是标题(`title`)

#### `headerBackTitle`

iOS上的后退按钮使用的标题字符串，或者为空,禁用标签。默认为场景值是标题(`title`)

#### `headerTruncatedBackTitle`

当`headerBackTitle`不适合屏幕时，返回按钮使用的标题字符串。默认情况下为"Back"。

#### `headerRight`

设置显示在标题栏的右侧的React元素(组件)

#### `headerLeft`

设置显示在标题栏的左侧的React元素(组件)

#### `headerStyle`

设置标题栏的样式对象

#### `headerTitleStyle`

设置标题(title)的样式对象

#### `headerBackTitleStyle`

设置返回标题(back title)的样式对象

#### `headerTintColor`

设置标题颜色

#### `headerPressColorAndroid`

设置按下时的材质波纹颜色 (仅Android >= 5.0)

#### `gesturesEnabled`

是否可以使用手势关闭此屏幕。在iOS上默认为true，在Android上为false。

### 导航器属性(Navigator Props)

由`StackNavigator（...）`创建的导航器组件具有以下属性：

- `screenProps` - 向子屏幕传递额外的选项，例如：


 ```jsx
 const SomeStack = StackNavigator({
   // 配置
 });

 <SomeStack
   screenProps={/* 这个属性传递给子屏幕组件，在子屏幕组件中作为this.props.screenProps使用 */}
 />
 ```

### 示例(Examples)

例子请参阅 [SimpleStack.js](https://github.com/react-community/react-navigation/tree/master/examples/NavigationPlayground/js/SimpleStack.js)和 [ModalStack.js](https://github.com/react-community/react-navigation/tree/master/examples/NavigationPlayground/js/ModalStack.js)，您可以在本地运行[NavigationPlayground](https://github.com/react-community/react-navigation/tree/master/examples/NavigationPlayground) 应用程序的一部分。

您可以通过访问我们的展示Demo( [our expo demo](https://exp.host/@react-navigation/NavigationPlayground))直接在手机上查看这些示例。