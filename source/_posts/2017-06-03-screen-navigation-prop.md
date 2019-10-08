---
layout: post
title:  "屏幕导航属性(Screen Navigation Prop)"
date:   2017-06-03 11:11:11
categories: react navigation
---

您应用中的每个屏幕都会收到一个包含以下内容的导航属性(navigation prop)：

* `navigate` - (helper) 链接到其他屏幕
* `state` - 屏幕的当前状态/路由
* `setParams` - (helper) 更改路由的参数
* `goBack` - (helper) 关闭活动屏幕并返回
* `dispatch` - 向路由器发送动作(action)

注意：`navigation` prop传递到每个导航感知组件，包括导航器。一个很大的例外是导航器的`navigation` prop可能没有辅助功能（navigate，goBack等）;它可能只有 `state` 和 `dispatch` 。为了 `navigate` 使用导航器的`navigation` prop，您将不得不使用动作创建者(action creator)进行调度(`dispatch`).

*关于与Redux挂钩的注意事项*

> 人们并不总是使用Redux正确地勾勒出来，因为他们误解导航器的顶级API，导航属性( navigation prop)是可选的。如果导航器没有获得导航属性( navigation prop)，导航器将保持其状态，但这并不是您通过使用redux挂起应用程序时通常希望使用的功能。对于嵌套在主导航器中的导航器，您总是希望通过屏幕的导航属性( navigation prop)往下传递。这允许您的根导航器与所有子导航器通信并提供状态。只有您的根路由器需要与redux集成，因为所有其他路由器都在其中。

## `navigate` - 链接到其他屏幕

Call this to link to another screen in your app. Takes the following arguments:

调用此函数链接到您应用中的另一个屏幕。获得以下参数：

`navigate(routeName, params, action)`

- `routeName` - 已经在应用程序路由器中某处注册的目标routeName
- `params` - 参数合并到目的地路由
- `action` - （高级）在子路由器中运行的子操作，如果屏幕是导航器。有关支持的操作的完整列表，请参阅操作文档。

```js
class HomeScreen extends React.Component {
  render() {
    const {navigate} = this.props.navigation;

    return (
      <View>
        <Text>This is the home screen of the app</Text>
        <Button
          onPress={() => navigate('Profile', {name: 'Brent'})}
          title="Go to Brent's profile"
        />
      </View>
     )
   }
}
```

## `state` - 屏幕的当前状态/路由

屏幕可以通过`this.props.navigation.state`访问其路由。每个都将返回一个具有以下内容的对象：

```js
{
  // 路由器中配置的路由名称
  routeName: 'profile',
  // 用于对路由进行排序的唯一标识符
  key: 'main0',
  //此屏幕的字符串选项的可选对象
  params: { hello: 'world' }
}
```

```js
class ProfileScreen extends React.Component {
  render() {
    const {state} = this.props.navigation;
    // state.routeName === 'Profile'
    return (
      <Text>Name: {state.params.name}</Text>
    );
  }
}
```


## `setParams` - 更改路由参数

启动`setParams`操作允许屏幕(组件)更改路由中的参数，这对于更新按钮和标题很有用。

```js
class ProfileScreen extends React.Component {
  render() {
    const {setParams} = this.props.navigation;
    return (
      <Button
        onPress={() => setParams({name: 'Lucy'})}
        title="Set title name to 'Lucy'"
      />
     )
   }
}
```

## `goBack` - 关闭活动的屏幕并返回

(可选)提供一个键，它指定要从中返回的路由。默认情况下，`goBack`将关闭调用它的路由。如果目标是回到任何地方，不用指定要关闭的路由，请调用`.goBack（null）`

```js
class HomeScreen extends React.Component {
  render() {
    const {goBack} = this.props.navigation;
    return (
      <View>
        <Button
          onPress={() => goBack()}
          title="Go back from this HomeScreen"
        />
        <Button
          onPress={() => goBack(null)}
          title="Go back anywhere"
        />
        <Button
          onPress={() => goBack('screen-123')}
          title="Go back from screen-123"
        />
      </View>
     )
   }
}
```

## `dispatch` - 发送一个动作(action)到路由器(router)

使用dispatch向路由器发送任何导航动作(navigation action)。其他导航功能在幕后使用分发(dispatch)。

请注意，如果要发送react-navigation动作，则应使用此库中提供的动作创建者(action creators)。

有关可用动作的完整列表，请参阅导航动作文档( [Navigation Actions Docs](navigation-actions) )。

```js
import { NavigationActions } from 'react-navigation'

const navigateAction = NavigationActions.navigate({
  routeName: 'Profile',
  params: {},

  // navigate can have a nested navigate action that will be run inside the child router
  action: NavigationActions.navigate({ routeName: 'SubProfileRoute'})
})
this.props.navigation.dispatch(navigateAction)
```
