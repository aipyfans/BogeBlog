---
layout: post
title:  "配置标题(Configuring the Header)"
date:   2017-05-29 11:11:11
categories: react navigation
---


标题仅适用于栈导航`StackNavigator`。

在前面的例子中，我们创建了一个`StackNavigator`来在我们的应用程序中显示几个屏幕。

导航到聊天屏幕时，我们可以通过将参数提供给导航函数来指定新路由的参数。在这种情况下，我们要在聊天屏幕上提供该人的姓名：

```js
this.props.navigation.navigate('Chat', { user:  'Lucy' });
```

用户 `user` 参数可以从聊天屏幕访问：

```js
class ChatScreen extends React.Component {
  render() {
    const { params } = this.props.navigation.state;
    return <Text>Chat with {params.user}</Text>;
  }
}
```

### 设置标题

接下来，标题可以使用屏幕参数配置：

```js
class ChatScreen extends React.Component {
  static navigationOptions = ({ navigation }) => ({
    title: `Chat with ${navigation.state.params.user}`,
  });
  ...
}
```

Android

![Android](https://reactnavigation.org/assets/examples/basic-header-android.png)

IOS

![IOS](https://reactnavigation.org/assets/examples/basic-header-iphone.png)


### 添加右侧按钮

然后我们可以添加一个标题导航选项( [`header` navigation option](/docs/navigators/navigation-options#Stack-Navigation-Options) )，它允许我们添加一个自定义的右侧按钮：

```js
static navigationOptions = {
  headerRight: <Button title="Info" />,
  ...
```

Android

![Android](https://reactnavigation.org/assets/examples/header-button-android.png)

IOS

![IOS](https://reactnavigation.org/assets/examples/header-button-iphone.png)

导航选项可以使用导航属性([navigation prop](/docs/navigators/navigation-prop))定义。让我们根据路由传递过来的参数渲染一个不同的按钮，并设置按钮，同时当按下按钮时调用`navigation.setParams`。

```js
static navigationOptions = ({ navigation }) => {
  const {state, setParams} = navigation;
  const isInfo = state.params.mode === 'info';
  const {user} = state.params;
  return {
    title: isInfo ? `${user}'s Contact Info` : `Chat with ${state.params.user}`,
    headerRight: (
      <Button
        title={isInfo ? 'Done' : `${user}'s info`}
        onPress={() => setParams({ mode: isInfo ? 'none' : 'info'})}
      />
    ),
  };
};
```

现在，标题可以与屏幕路由/状态(screen route/state)进行交互：

Android

![Android](https://reactnavigation.org/assets/examples/header-interaction-android.png)

IOS

![IOS](https://reactnavigation.org/assets/examples/header-interaction-iphone.png)

要查看其余的标题选项，请参阅导航选项文档([navigation options document](/docs/navigators/navigation-options#Stack-Navigation-Options)).