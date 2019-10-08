---
layout: post
title:  "导航动作(Navigation Actions)"
date:   2017-06-04 11:11:11
categories: react navigation
---

所有导航动作返回【可以使用`navigation.dispatch（）`方法发送到路由器】的对象。

请注意，如果要发送(dispatch) react-navigation动作，则应使用此库中提供的动作创建者(action creators)。

支持以下操作：
* [Navigate](#Navigate) - 导航到另一个路由
* [Reset](#Reset) - 使用新状态替换当前状态
* [Back](#Back) - 返回上一个状态
* [Set Params](#SetParams) - 给指定的路由设置参数
* [Init](#Init) - 如果状态未定义，则使用初始化的第一个状态

### 导航(Navigate)
导航(Navigate)动作将通过导航(Navigate)动作的结果更新当前状态。

- `routeName` - *String*  - 必需 - 已在应用程序的路由器中某处注册的目标routeName
- `params` - *Object* - 可选 - 将参数合并到目标路由中
- `action` - *Object* - 可选 - （高级）如果屏幕是导航器，则在子路由器中运行的子操作。本文档中描述的任何一个操作都可以设置为子操作。

```js
import { NavigationActions } from 'react-navigation'

const navigateAction = NavigationActions.navigate({

  routeName: 'Profile',

  params: {},

  action: NavigationActions.navigate({ routeName: 'SubProfileRoute'})
})

this.props.navigation.dispatch(navigateAction)

```


### 复位(Reset)

复位 `Reset` 动作会擦除整个导航状态，并将其替换为多个动作的结果

- `index` - *number* - required - 在导航状态的路由数组上的活动路由索引.
- `actions` - *array* - required - 导航动作的阵列将取代导航状态.

```js
import { NavigationActions } from 'react-navigation'

const resetAction = NavigationActions.reset({
  index: 0,
  actions: [
    NavigationActions.navigate({ routeName: 'Profile'})
  ]
})
this.props.navigation.dispatch(resetAction)

```
#### 如何使用索引 `index` 参数
索引 `index` 参数用于指定当前的活动路由。

例如：给定一个使用两个路由配置的（`Profile`和`Settings`）基本的堆栈导航。要将状态重置为活动屏幕为`Settings`但将其堆叠在`Profile`屏幕顶部的位置，则可以执行以下操作：

```js
import { NavigationActions } from 'react-navigation'

const resetAction = NavigationActions.reset({
  index: 1,
  actions: [
    NavigationActions.navigate({ routeName: 'Profile'}),
    NavigationActions.navigate({ routeName: 'Settings'})
  ]
})
this.props.navigation.dispatch(resetAction)
```

### 返回(Back)

返回上一屏幕并关闭当前屏幕。返回( `back` )动作创建者具有一个可选参数：

- `key` - *string or null* - 可选 - 如果设置，导航将从给定的键返回。如果为空，导航将返回任何地方.

```js
import { NavigationActions } from 'react-navigation'

const backAction = NavigationActions.back({
  key: 'Profile'
})
this.props.navigation.dispatch(backAction)
```

### 设置参数(SetParams)

当发送`SetParams`动作时，路由器将产生一个新的状态，该状态改变了特定路由的参数，由密钥标识

- `params` - *object* - required - 新的参数将被合并到现有的路由参数中
- `key` - *string* - required - 路由密钥应该得到新的参数

```js
import { NavigationActions } from 'react-navigation'

const setParamsAction = NavigationActions.setParams({
  params: { title: 'Hello' },
  key: 'screen-123',
})
this.props.navigation.dispatch(setParamsAction)
```
