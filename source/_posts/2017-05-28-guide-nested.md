---
layout: post
title:  "嵌套导航(Nesting Navigators)"
date:   2017-05-28 11:11:11
categories: react navigation
---

通常在移动应用中组合各种形式的导航。 React Navigation中的路由器和导航器是可组合的，它允许您为应用程序定义一个复杂的导航结构。

对于我们的聊天应用程序，我们要在第一个屏幕上放置几个选项卡，查看最近的聊天和所有联系人。

## 介绍标签导航(Introducing Tab Navigator)

让我们在`App.js` 创建一个新的 `TabNavigator` 导航：

```js
import { TabNavigator } from "react-navigation";

class RecentChatsScreen extends React.Component {
  render() {
    return <Text>List of recent chats</Text>
  }
}

class AllContactsScreen extends React.Component {
  render() {
    return <Text>List of all contacts</Text>
  }
}

const MainScreenNavigator = TabNavigator({
  Recent: { screen: RecentChatsScreen },
  All: { screen: AllContactsScreen },
});
```

如果`MainScreenNavigator`被渲染为顶级导航器组件，它将如下所示：

![Android](https://reactnavigation.org/assets/examples/simple-tabs-android.png)



![IOS](https://reactnavigation.org/assets/examples/simple-tabs-iphone.png)



## 在一个屏幕中嵌套一个导航器

我们希望这些选项卡在应用的第一个屏幕中可见，但是推入栈中的新屏幕应该覆盖当前选项卡屏幕。

让我们将我们的选项卡导航器作为我们在上一步中设置的顶级`StackNavigator`中的屏幕。

```js
const SimpleApp = StackNavigator({
  Home: { screen: MainScreenNavigator },
  Chat: { screen: ChatScreen },
});
```

因为`MainScreenNavigator`被当做一整个屏幕，所以我们可以给它设置导航选项（ `navigationOptions`）：

```js
MainScreenNavigator.navigationOptions = {
  title: 'My Chats',
};
```

我们也可以在每个标签组件中添加一个按钮，链接到聊天组件：

```js
<Button
  onPress={() => this.props.navigation.navigate('Chat', { user: 'Lucy' })}
  title="Chat with Lucy"
/>
```

现在我们将一个导航器放在另一个导航器中，我们可以在导航器之间导航：

![Android](https://reactnavigation.org/assets/examples/nested-android.png)



![IOS](https://reactnavigation.org/assets/examples/nested-iphone.png)