---
layout: post
title:  "你好移动导航(Hello Mobile Navigation)"
date:   2017-05-27 11:11:11
categories: react navigation
---


我们使用React Navigation为Android和iOS构建一个简单的聊天应用程序。

## 设置与安装

首先，确保您都设置好了React Native的环境。接下来，创建一个新项目并添加 `react-navigation`:


```sh
# 创建一个RN应用
react-native init SimpleApp
cd SimpleApp

# 通过npm包管理器安装最新版本的react-navigation
npm install --save react-navigation

# 运行App
react-native run-android # or:
react-native run-ios
```

验证您是否可以成功查看在iOS或Android设备上运行的示例应用程序：

Android

![Android](https://reactnavigation.org/assets/examples/bare-project-android.png)

IOS

![IOS](https://reactnavigation.org/assets/examples/bare-project-iphone.png)

我们想在IOS和Android设备上分享同一套代码，所以，我们应该删除 `index.ios.js` 和 `index.android.js` 文件中的代码内容，同时，使用 `import './App';` 进行替换。

现在可以为我们的应用程序实现创建新文件， `App.js` 。



## 介绍栈导航( Stack Navigator)

对于我们的应用程序，我们想使用StackNavigator，因为我们需要一个概念上的“堆栈”导航，每个新屏幕都放在堆栈的顶部，并返回从堆栈顶部移除一个屏幕。我们从一个屏幕开始：

```js
import React from 'react';
import {
  AppRegistry,
  Text,
} from 'react-native';
import { StackNavigator } from 'react-navigation';

class HomeScreen extends React.Component {
  static navigationOptions = {
    title: 'Welcome',
  };
  render() {
    return <Text>Hello, Navigation!</Text>;
  }
}

const SimpleApp = StackNavigator({
  Home: { screen: HomeScreen },
});

AppRegistry.registerComponent('SimpleApp', () => SimpleApp);
```

屏幕的标题 `title` 可以在静态`navigationOptions`上进行配置，其中可以设置许多选项来配置导航器中的屏幕显示。

现在iPhone和Android应用都会出现相同的屏幕：

Android

![Android](https://reactnavigation.org/assets/examples/first-screen-android.png)

IOS

![IOS](https://reactnavigation.org/assets/examples/first-screen-iphone.png)

## 添加一个新屏幕

在我们的 `App.js` 文件中, 添加一个叫 `ChatScreen` 新屏幕:

```js
class ChatScreen extends React.Component {
  static navigationOptions = {
    title: 'Chat with Lucy',
  };
  render() {
    return (
      <View>
        <Text>Chat with Lucy</Text>
      </View>
    );
  }
}
```

然后，我们在 `HomeScreen` 组件中添加一个按钮，并使用路由(`routeName`)`Chat` 链接到`ChatScreen` 组件上。

```js
class HomeScreen extends React.Component {
  static navigationOptions = {
    title: 'Welcome',
  };
  render() {
    const { navigate } = this.props.navigation;
    return (
      <View>
        <Text>Hello, Chat App!</Text>
        <Button
          onPress={() => navigate('Chat')}
          title="Chat with Lucy"
        />
      </View>
    );
  }
}
```

我们正在使用屏幕导航属性( [screen navigation prop](/docs/navigators/navigation-prop) )中的导航功能跳转到`ChatScreen` 组件上。然后，我们将它添加到我们的栈导航组件`StackNavigator`中。

```js
const SimpleApp = StackNavigator({
  Home: { screen: HomeScreen },
  Chat: { screen: ChatScreen },
});
```

现在，你可以导航到你新创建的`ChatScreen`组件上，然后返回上一个`HomeScreen`组件。

Android

![Android](https://reactnavigation.org/assets/examples/first-navigation-android.png)

IOS

![IOS](https://reactnavigation.org/assets/examples/first-navigation-iphone.png)

## 传递参数

将名称硬编码到`ChatScreen`中并不理想。如果我们可以动态地传递一个名称来代替，那将会更有用，所以让我们这样做。

除了在导航功能中指定目标组件`routeName`之外，还可以传递将放入新路由的参数。首先，我们将编辑我们的`HomeScreen`组件，将 `user` 参数传递到路由中。

```js
class HomeScreen extends React.Component {
  static navigationOptions = {
    title: 'Welcome',
  };
  render() {
    const { navigate } = this.props.navigation;
    return (
      <View>
        <Text>Hello, Chat App!</Text>
        <Button
          onPress={() => navigate('Chat', { user: 'Lucy' })}
          title="Chat with Lucy"
        />
      </View>
    );
  }
}
```

然后，我们可以编辑我们的`ChatScreen`组件，以显示通过路由传递的用户参数：

```js
class ChatScreen extends React.Component {
  // 导航选项可以定义为屏幕props的函数：
  static navigationOptions = ({ navigation }) => ({
    title: `Chat with ${navigation.state.params.user}`,
  });
  render() {
    // 屏幕的当前路线被传递到`props.navigation.state`：
    const { params } = this.props.navigation.state;
    return (
      <View>
        <Text>Chat with {params.user}</Text>
      </View>
    );
  }
}
```

现在，当您导航到聊天屏幕时能看到动态专递过来的名字。尝试在`HomeScreen`中更改用户参数，看看会发生什么！

Android

![Android](https://reactnavigation.org/assets/examples/first-navigation-android.png)

IOS

![IOS](https://reactnavigation.org/assets/examples/first-navigation-iphone.png)