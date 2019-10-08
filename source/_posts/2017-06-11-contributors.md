---
layout: post
title:  "贡献者指南(Contributors Guide)"
date:   2017-06-11 11:11:11
categories: react navigation
---

## 环境(Environment)

最初在macOS 10.12上开发了react navigation，其中使用 node 7+ 和 react-native v0.39+。发现不同环境中的问题时请提交issues。

## 开发(Development)

### Fork代码库

- 在Github 上 fork [`react-navigation`](https://github.com/react-community/react-navigation)

- 在终端中运行这些命令在本地下载并安装它

```
git clone https://github.com/<USERNAME>/react-navigation.git
cd react-navigation
git remote add upstream https://github.com/react-community/react-navigation.git
npm install
```

### 运行示例应用程序

```
cd examples/NavigationPlayground
npm install
cd ../..
npm start

# 在一个单独的终端标签:
npm run run-playground-android
# 或:
npm run run-playground-ios
```

You can also simply run e.g. `react-native run-android` from within the example app directory (instead of `npm run run-playground-android` from the root `react-navigation` directory); both do the same thing.

你也可以在从示例应用程序目录简单地运行(e.g. `react-native run-android` )，而不是`npm run run-playground-android` 从`react-navigation`根目录;因为都做的是同样的事情。

### 运行网站

对于开发模式和实时重新加载：

```
cd website
npm install
npm start
```

使用服务器渲染以生产模式运行网站：

```
npm run prod
```

### 运行测试和类型检查

```
jest
flow
```

您的更改必须测试通过，才能被接受和合并。

流程尚未传递，但您的代码应该被检查，我们期望您的更改不会引入任何错误。

### 开发文档

The docs are indexed in [App.js](https://github.com/react-community/react-navigation/blob/master/website/src/App.js), where all the pages are declared alongside the titles. To test the docs, follow the above instructions for running the website. Changing existing markdown files should not require any testing.

The markdown from the `docs` folder gets generated and dumped into a json file as a part of the build step. To see updated docs appear in the website, re-run the build step by running `npm run build-docs` from the `react-navigation` root folder.

## 提交文稿

### 新视图或独特功能

Often navigation needs are specific to certain apps. If your changes are unique to your app, you may want to fork the view or router that has changed. You can keep the source code in your app, or publish it on npm as a `react-navigation` compatible view or router.

This library is intended to include highly standard and generic navigation patterns.

### 新视图或独特功能

Before embarking on any major changes, please file an issue describing the suggested change and motivation. We may already have thought about it and we want to make sure we all are on the same page before starting on any big changes.

### 新视图或独特功能

Simple bug fixes are welcomed in pull requests! Please check for duplicate PRs before posting.

#### 在提交PR之前，确保与上游状态同步：

- `git fetch upstream`
- `git rebase upstream/master`
