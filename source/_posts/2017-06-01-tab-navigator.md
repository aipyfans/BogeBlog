---
layout: post
title:  "标签导航器(TabNavigator)"
date:   2017-06-01 11:11:11
categories: react navigation
---

用于通过TabRouter轻松设置带有多个选项卡的屏幕。有关实例，请参阅我们的展示Demo( [our expo demo](https://exp.host/@react-navigation/NavigationPlayground))。

```js
class MyHomeScreen extends React.Component {
  static navigationOptions = {
    tabBarLabel: 'Home',
    // 注意：默认情况下，该图标仅在iOS上显示。搜索下面的showIcon选项.
    tabBarIcon: ({ tintColor }) => (
      <Image
        source={require('./chats-icon.png')}
        style={[styles.icon, {tintColor: tintColor}]}
      />
    ),
  };

  render() {
    return (
      <Button
        onPress={() => this.props.navigation.navigate('Notifications')}
        title="Go to notifications"
      />
    );
  }
}

class MyNotificationsScreen extends React.Component {
  static navigationOptions = {
    tabBarLabel: 'Notifications',
    tabBarIcon: ({ tintColor }) => (
      <Image
        source={require('./notif-icon.png')}
        style={[styles.icon, {tintColor: tintColor}]}
      />
    ),
  };

  render() {
    return (
      <Button
        onPress={() => this.props.navigation.goBack()}
        title="Go back home"
      />
    );
  }
}

const styles = StyleSheet.create({
  icon: {
    width: 26,
    height: 26,
  },
});

const MyApp = TabNavigator({
  Home: {
    screen: MyHomeScreen,
  },
  Notifications: {
    screen: MyNotificationsScreen,
  },
}, {
  tabBarOptions: {
    activeTintColor: '#e91e63',
  },
});
```

## API 定义

```js
TabNavigator(RouteConfigs, TabNavigatorConfig)
```

### 路由配置(RouteConfigs)

路由配置对象是从路由名称到路由配置的映射，它告诉导航器该路由的内容，请参阅`StackNavigator`中的示例。

### 标签导航器配置(TabNavigatorConfig)

- `tabBarComponent` - 用作标签栏的组件，例如。 `TabBarBottom`（这是iOS上的默认），`TabBarTop`（这是Android上的默认）
- `tabBarPosition` - 标签栏的位置可以是“top”或“bottom”
- `swipeEnabled` - 是否允许在标签之间进行滑动
- `animationEnabled` - 是否在切换标签时启动动画
- `lazy` - 是否根据需要懒加载标签，而不是提前渲染
- `tabBarOptions` - 配置标签栏，见下文。

这几个选项被传递到底层路由器来修改导航逻辑：

- `initialRouteName` - 第一次加载时初始标签路由的routeName
- `order` -定义标签卡顺序的routeNames数组
- `paths` - 提供routeName到路径配置的映射，该配置将覆盖routeConfigs中设置的路径.(不太明白)
- `backBehavior` - 按下后退按钮是否会使Tab键切换到初始选项卡？如果是，设置为`initialRoute`，否则为`none`。默认为`initialRoute`行为。

### `tabBarOptions` for `TabBarBottom` (default tab bar on iOS)

使用`TabBarBottom`组件的标签栏选项(tabBarOptions)(在IOS上默认使用此组件)

- `activeTintColor` -激活标签的标题和图标的颜色值
- `activeBackgroundColor` - 激活标签的标题和图标的背景颜色值
- `inactiveTintColor` - 非激活标签的标签和图标颜色
- `inactiveBackgroundColor` - 非激活标签的标签和图标的背景颜色值
- `showLabel` - 是否显示标签的标题，默认为true显示
- `style` - 标签栏的样式对象
- `labelStyle` - 标签标题样式对象
- `tabStyle` - 标签的样式对象

示例:

```js
tabBarOptions: {
  activeTintColor: '#e91e63',
  labelStyle: {
    fontSize: 12,
  },
  style: {
    backgroundColor: 'blue',
  },
}
```

### `tabBarOptions` for `TabBarTop` (default tab bar on Android)

使用`TabBarTop`组件的标签栏选项(tabBarOptions)(在Android上默认使用此组件)

- `activeTintColor` -激活标签的标题和图标的颜色值
- `inactiveTintColor` - 非激活标签的标签和图标颜色

- `showIcon` - 是否显示标签的图标，默认为false不显示
- `showLabel` - 是否显示标签的标题，默认为true显示
- `upperCaseLabel` - 是否使标签大写，默认为true
- `pressColor` - 按压为材质波纹颜色值 (仅Android >= 5.0)
- `pressOpacity` - 按压标签的不透明度 (iOS 和 仅Android < 5.0)
- `scrollEnabled` - 是否启用可滚动选项卡
- `tabStyle` - 标签的样式对象
- `indicatorStyle` - 标签指示器的样式对象（选项卡底部的行）
- `labelStyle` - 标签标题的样式对象
- `iconStyle` - 标签图标的样式对象
- `style` - 标签栏的对象

示例:

```js
tabBarOptions: {
  labelStyle: {
    fontSize: 12,
  },
  style: {
    backgroundColor: 'blue',
  },
}
```

### 屏幕导航选项(Screen Navigation Options)

#### `title`

可用作`headerTitle`和`tabBarLabel`的回退的通用标题

#### `tabBarVisible`

True或false显示或隐藏选项卡栏，如果未设置，则默认为true

#### `tabBarIcon`

React元素(组件)或赋予{focused：boolean，tintColor：string}的一个函数返回一个React元素(组件)，以在tab栏中显示

#### `tabBarLabel`

标签栏或React元素中显示的标签的标题字符串，或给定{focused：boolean，tintColor：string}的函数返回一个React元素(组件)，用以显示在选项卡栏中。未定义时，使用场景标题(`title`)。要隐藏，请参阅上一节中的`tabBarOptions.showLabel`。

### 导航器属性(Navigator Props)

由`TabNavigator（...）`创建的导航器组件具有以下属性：

- `screenProps` - 向子屏幕传递额外的选项和导航选项，例如：


 ```jsx
 const TabNav = TabNavigator({
   // 配置
 });

 <TabNav
   screenProps={/* 这个属性传递给子屏幕组件，在子屏幕组件中作为this.props.screenProps使用 */}
 />
 ```
