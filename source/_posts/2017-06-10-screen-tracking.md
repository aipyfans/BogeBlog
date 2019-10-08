---
layout: post
title:  "屏幕跟踪和分析(Screen tracking and analytics)"
date:   2017-06-10 11:11:11
categories: react navigation
---

此示例显示如何进行屏幕跟踪并发送到Google Analytics（分析）。该方法可以适应任何其他移动分析SDK。

### 屏幕跟踪(Screen tracking)

使用内置导航容器时，可以使用 `onNavigationStateChange` 方法来跟踪屏幕。

```js
import { GoogleAnalyticsTracker } from 'react-native-google-analytics-bridge';

const tracker = new GoogleAnalyticsTracker(GA_TRACKING_ID);

// 从导航状态获取当前屏幕
function getCurrentRouteName(navigationState) {
  if (!navigationState) {
    return null;
  }
  const route = navigationState.routes[navigationState.index];
  // 潜入嵌套导航仪
  if (route.routes) {
    return getCurrentRouteName(route);
  }
  return route.routeName;
}

const AppNavigator = StackNavigator(AppRouteConfigs);

export default () => (
  <AppNavigator
    onNavigationStateChange={(prevState, currentState) => {
      const currentScreen = getCurrentRouteName(currentState);
      const prevScreen = getCurrentRouteName(prevState);

      if (prevScreen !== currentScreen) {
        // 以下行使用Google Analytics（分析）跟踪器
        // 在此更改跟踪器以使用其他移动分析SDK
        tracker.trackScreenView(currentScreen);
      }
    }}
  />
);
```

### 使用Redux进行屏幕跟踪(Screen tracking with Redux)

使用Redux时，我们可以编写一个Redux中间件来跟踪屏幕。为此，我们将从上一节重用 `getCurrentRouteName` 

```js
import { NavigationActions } from 'react-navigation';
import { GoogleAnalyticsTracker } from 'react-native-google-analytics-bridge';

const tracker = new GoogleAnalyticsTracker(GA_TRACKING_ID);

const screenTracking = ({ getState }) => next => (action) => {
  if (
    action.type !== NavigationActions.NAVIGATE
    && action.type !== NavigationActions.BACK
  ) {
    return next(action);
  }

  const currentScreen = getCurrentRouteName(getState().navigation);
  const result = next(action);
  const nextScreen = getCurrentRouteName(getState().navigation);
  if (nextScreen !== currentScreen) {
    // 以下行使用Google Analytics（分析）跟踪器
    // 在此更改跟踪器以使用其他移动分析SDK
    tracker.trackScreenView(nextScreen);
  }
  return result;
};

export default screenTracking;
```

### 创建 Redux store 并应用上述中间件

`screenTracking` 中间件可以在创建时应用于store。有关详细信息，请参阅[Redux 集成](Redux-Integration.md)。

```js
const store = createStore(
  combineReducers({
    navigation: navigationReducer,
    ...
  }),
  applyMiddleware(
    screenTracking,
    ...
    ),
);
```
