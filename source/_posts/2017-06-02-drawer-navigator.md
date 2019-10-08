---
layout: post
title:  "抽屉导航器(DrawerNavigator)"
date:   2017-06-02 11:11:11
categories: react navigation
---

用于轻松设置带抽屉导航的屏幕。有关实例，请参阅我们的展示Demo( [our expo demo](https://exp.host/@react-navigation/NavigationPlayground))。

```js
class MyHomeScreen extends React.Component {
  static navigationOptions = {
    drawerLabel: 'Home',
    drawerIcon: ({ tintColor }) => (
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
    drawerLabel: 'Notifications',
    drawerIcon: ({ tintColor }) => (
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
    width: 24,
    height: 24,
  },
});

const MyApp = DrawerNavigator({
  Home: {
    screen: MyHomeScreen,
  },
  Notifications: {
    screen: MyNotificationsScreen,
  },
});
```

要打开和关闭抽屉导航器，分别导航到`DrawerOpen`和`DrawerClose`。

```js
this.props.navigation.navigate('DrawerOpen'); // 打开抽屉导航器
this.props.navigation.navigate('DrawerClose'); // 关闭抽屉导航器
```

## API 定义

```js
DrawerNavigator(RouteConfigs, DrawerNavigatorConfig)
```

### 路由配置(RouteConfigs)

路由配置对象是从路由名称到路由配置的映射，它告诉导航器该路由的内容，请参阅`StackNavigator`中的示例。


### 抽屉导航器配置(DrawerNavigatorConfig)

- `drawerWidth` - 抽屉导航器的宽度
- `drawerPosition` - 选项：`left` 和 `right` ，默认的位置是左侧`left`
- `contentComponent` - 用于呈现抽屉导航器内容的组件，例如导航项。接收抽屉导航器的 `navigation` 属性 。默认为`DrawerItems`。有关详细信息，请参阅下文。
- `contentOptions` - 配置抽屉导航器内容，见下文。

#### 示例:

默认`DrawerView`不可滚动。要实现可滚动视图，您必须使用`contentComponent`自定义容器，如下面的示例所示。

```js
{
  drawerWidth: 200,
  drawerPosition: 'right',
  contentComponent: props => <ScrollView><DrawerItems {...props} /></ScrollView>
}
```

下面几个选项被传递到底层路由器来修改导航逻辑：

- `initialRouteName` - 初始路由的routeName。
- `order` - 定义抽屉导航器项顺序的routeNames数组。
- `paths` -提供routeName到路径配置的映射，该配置将覆盖routeConfigs中设置的路径。
- `backBehavior` - 按下后退按钮是否会切换到初始路由？如果是，设置为`initialRoute`，否则为`none`。默认为`initialRoute`行为。

### 提供自定义的`contentComponent`

您可以轻松地覆盖 `react-navigation`使用的默认组件：

```js
import { DrawerItems } from 'react-navigation';

const CustomDrawerContentComponent = (props) => (
  <View style={style.container}>
    <DrawerItems {...props} />
  </View>
);

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
```

### `contentOptions` for `DrawerItems`

- `items` - 路由数组，可以修改或覆盖
- `activeItemKey` -键确定活动路线
- `activeTintColor` - 活动标签的标题和图标颜色
- `activeBackgroundColor` -活动标签的背景颜色
- `inactiveTintColor` - 非活动标签的标签和图标颜色
- `inactiveBackgroundColor` - 非活动标签的背景颜色
- `onItemPress(route)` - 当按下项(Item)时调用的函数
- `style` - Item内容部分的样式对象
- `labelStyle` - 当您的标签是字符串时，此样式对象将覆盖内容部分中的文本样式

#### 示例:

```js
contentOptions: {
  activeTintColor: '#e91e63',
  style: {
    marginVertical: 0,
  }
}
```

### 屏幕导航器选项(Screen Navigation Options)

#### `title`

可以用作`headerTitle`和`drawerLabel`的回退的通用标题

#### `drawerLabel`

字符串，React元素(组件)或赋予`{focused：boolean，tintColor：string}`的函数返回一个React元素(组件)，显示在抽屉导航器侧边栏中。未定义时，使用场景标题(`title`)

#### `drawerIcon`

React元素(组件)或一个函数，给定`{focused：boolean，tintColor：string}`返回一个React元素(组件)，显示在抽屉侧边栏中。

### 导航器属性(Navigator Props)

由`DrawerNavigator（...）`创建的导航器组件具有以下属性：

- `screenProps` - 向子屏幕传递额外的选项，例如：


 ```jsx
 const DrawerNav = DrawerNavigator({
   // 配置
 });

 <DrawerNav
   screenProps={/* 这个属性传递给子屏幕组件，在子屏幕组件中作为this.props.screenProps使用 */}
 />
 ```

 ### Nesting `DrawerNavigation`

Please bear in mind that if you nest the DrawerNavigation, the drawer will show below the parent navigation.
