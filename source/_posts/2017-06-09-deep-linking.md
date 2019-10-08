---
layout: post
title:  "深度链接(Deep Linking)"
date:   2017-06-09 11:11:11
categories: react navigation
---

在本指南中，我们将设置我们的应用程序来处理外部URI。我们先从[我们在入门指南中创建的SimpleApp开始](http://blog.lijunbo.com/2017/05/27/guide-intro/)。

在这个例子中，我们希望像`mychat://chat/Taylor`这样的URI打开我们的应用程序，并直接链接到Taylor的聊天页面中。

## 配置

以前我们已经定义了一个这样的导航器：

```js
const SimpleApp = StackNavigator({
  Home: { screen: HomeScreen },
  Chat: { screen: ChatScreen },
});
```

我们希望像 `chat/Taylor` 这样的路径使用 `user` 作为参数传递并链接到“Chat”屏幕。让我们重新配置我们的聊天屏幕， `path` 告诉路由器要匹配的相对路径，以及要提取的参数。这个路径规范将是 `chat/:user`.

```js
const SimpleApp = StackNavigator({
  Home: { screen: HomeScreen },
  Chat: {
    screen: ChatScreen,
    path: 'chat/:user',
  },
});
```


### URI前缀

接下来，让我们配置我们的导航器，从应用程序的传入URI中提取路径。

```js
const SimpleApp = StackNavigator({...});

// 在Android上，除了scheme之外，URI前缀通常包含一个host
const prefix = Platform.OS == 'android' ? 'mychat://mychat/' : 'mychat://';

const MainApp = () => <SimpleApp uriPrefix={prefix} />;
```

## iOS

Let's configure the native iOS app to open based on the `mychat://` URI scheme.

让我们根据 `mychat://` URI scheme来配置原生iOS应用程序并将其打开。

在 `SimpleApp/ios/SimpleApp/AppDelegate.m` 中:

```
// 在文件顶部添加标题:
#import <React/RCTLinkingManager.h>

// 在上面添加`@end`:
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
  return [RCTLinkingManager application:application openURL:url
                      sourceApplication:sourceApplication annotation:annotation];
}
```

在Xcode中，在 `SimpleApp/ios/SimpleApp.xcodeproj`下中打开项目。在侧栏中选择项目，然后导航到信息选项卡。向下滚动到"URL Types" 并添加一个。在新的URL类型中，将标识符和url scheme设置为所需的url scheme。

![Xcode project info URL types with mychat added](https://reactnavigation.org/assets/xcode-linking.png)

现在你可以按Xcode play，或在命令行重新构建：

```sh
react-native run-ios
```

要测试模拟器上的URI，请运行以下命令：

```
xcrun simctl openurl booted mychat://chat/Taylor
```

要测试实际设备上的URI，请打开Safari并键入 `mychat://chat/Taylor`.

## Android

要在Android中配置外部链接，您可以在清单中创建新的意图。

在 `SimpleApp/android/app/src/main/AndroidManifest.xml` 中,在MainActivity条目中添加新的 `VIEW` 类型意图过滤器(`intent-filter`)：

```
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="mychat"
          android:host="mychat" />
</intent-filter>
```

现在，重新安装该应用程序：

```sh
react-native run-android
```

To test the intent handling in Android, run the following:

要测试Android中的意图处理，请运行以下命令：

```
adb shell am start -W -a android.intent.action.VIEW -d "mychat://mychat/chat/Taylor" com.simpleapp
```


![](https://reactnavigation.org/assets/examples/linking-android.png)
![](https://reactnavigation.org/assets/examples/linking-iphone.png)
