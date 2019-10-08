---
layout: post
title:  "Redux集成(Redux Integration)"
date:   2017-06-07 11:11:11
categories: react navigation
---

要在redux中处理您的应用程序的导航状态，您可以将自己的导航(`navigation`)属性传递给导航器。您的导航属性必须提供当前状态，以及访问分发者(dispatcher)来处理导航选项。

使用redux，您的应用程序的状态由reducer定义。每个导航路由器实际上都有一个reducer，调用`getStateForAction`。以下是在redux应用程序中如何使用导航器的小示例：

```
import { addNavigationHelpers } from 'react-navigation';

const AppNavigator = StackNavigator(AppRouteConfigs);

const initialState = AppNavigator.router.getStateForAction(AppNavigator.router.getActionForPathAndParams('Login'));

const navReducer = (state = initialState, action) => {
  const nextState = AppNavigator.router.getStateForAction(action, state);

  // 简单实现：如果`nextState`为null或未定义，则返回原来的`state`.
  return nextState || state;
};

const appReducer = combineReducers({
  nav: navReducer,
  ...
});

class App extends React.Component {
  render() {
    return (
      <AppNavigator navigation={addNavigationHelpers({
        dispatch: this.props.dispatch,
        state: this.props.nav,
      })} />
    );
  }
}

const mapStateToProps = (state) => ({
  nav: state.nav
});

const AppWithNavigationState = connect(mapStateToProps)(App);

const store = createStore(appReducer);

class Root extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <AppWithNavigationState />
      </Provider>
    );
  }
}
```

一旦你这样做，你的导航状态被存储在您的redux store中，在那时你可以使用redux的分发(dispatch)函数来发送导航动作。

请记住，当导航器获得导航属性时，它放弃对其内部状态的控制。这意味着您现在有责任维护好原有的状态，处理任何深链接，集成后退按钮等。

当您嵌套它们时，导航状态将自动从一个导航器传递到另一个导航器。请注意，为了使子导航器从父导航器接收状态，应将其定义为屏幕(`screen`)。

将其应用于上述示例，您可以将`AppNavigator`定义为包含嵌套的`TabNavigator`，如下所示：

```js
const AppNavigator = StackNavigator({
  Home: { screen: MyTabNavigator },
});
```

在这种情况下，在`AppWithNavigationState`中一旦将`AppNavigator`连接( `connect` )到`Redux`完成时，`MyTabNavigator`将作为导航属性( `navigation` prop)自动进入导航状态。

## 完整的例子(Full example)

如果你想自己尝试，这里( [here](https://github.com/react-community/react-navigation/tree/master/examples/ReduxExample) )有一个有redux的工作示例应用程序。

## 模拟测试(Mocking tests)

为了使您的react-navigation应用程序可以进行测试，您需要更改package.json中的`jest preset`，请参阅：

```
"jest": {
  "preset": "react-native",
  "transformIgnorePatterns": [
    "node_modules/(?!(jest-)?react-native|react-navigation)"
  ]
}
```
