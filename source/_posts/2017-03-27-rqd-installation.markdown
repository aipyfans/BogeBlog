---
layout: post
title:  "Installation（安装）"
date:   2017-03-27 11:11:11
categories: react
---

React is flexible and can be used in a variety of projects. You can create new apps with it, but you can also gradually introduce it into an existing codebase without doing a rewrite.

React能够灵活的适用于各种项目。 您可以使用它创建新的应用程序，同时您也可以逐渐将其引入到现有的代码库中，而无需重写。

## Trying Out React（尝试使用React）

If you're just interested in playing around with React, you can use CodePen. Try starting from [this Hello World example code](http://codepen.io/gaearon/pen/rrpgNB?editors=0010). You don't need to install anything; you can just modify the code and see if it works.

If you prefer to use your own text editor, you can also <a href="/react/downloads/single-file-example.html" download="hello.html">download this HTML file</a>, edit it, and open it from the local filesystem in your browser. It does a slow runtime code transformation, so don't use it in production.

如果您对React感兴趣，想尝试一下，您可以使用CodePen。 尝试从这个Hello World示例代码开始。 你不需要安装任何东西; 你只需要修改一下代码，看看它是否正常运行。

如果您喜欢使用自己已有的文本编辑器，您还可以下载此HTML文件，进行编辑，并从浏览器中的本地文件系统中打开它。 它在运行时执行代码转换比较缓慢，所以不要在生产环境中使用它。

## Creating a Single Page Application(创建单页面应用程序)

[Create React App](http://github.com/facebookincubator/create-react-app) is the best way to start building a new React single page application. It sets up your development environment so that you can use the latest JavaScript features, provides a nice developer experience, and optimizes your app for production.

创建React应用程序是开始构建一个新的React单页面应用程序的最佳方式。 它设置您的开发环境，以便您可以使用最新的JavaScript功能，提供不错的开发人员体验，并优化您的应用程序。

```bash
npm install -g create-react-app
create-react-app hello-world
cd hello-world
npm start
```

Create React App doesn't handle backend logic or databases; it just creates a frontend build pipeline, so you can use it with any backend you want. It uses [webpack](https://webpack.js.org/), [Babel](http://babeljs.io/) and [ESLint](http://eslint.org/) under the hood, but configures them for you.

Create React App不处理后端逻辑或数据库; 它只是创建一个前端构建管道，所以你可以使用任何你想使用的后台。 你可以在React中使用webpack，Babel和ESLint进行配置。

## Adding React to an Existing Application(将React添加到已有的应用程序中)

You don't need to rewrite your app to start using React.

您不需要重写您的应用程序,就可以开始使用React。

We recommend adding React to a small part of your application, such as an individual widget, so you can see if it works well for your use case.

我们建议您将React添加到应用程序的一小部分，例如单个窗口小部件，以便您可以看到它在您的用例中，是否能更好地运行。

While React [can be used](/react/docs/react-without-es6.html) without a build pipeline, we recommend setting it up so you can be more productive. A modern build pipeline typically consists of:

虽然React可以在没有构建管道的情况下使用，但我们建议你对其进行设置，以便你的开发工作更为高效。 流行的构建管道通常包括：

- A **package manager**, such as [Yarn](https://yarnpkg.com/) or [npm](https://www.npmjs.com/). It lets you take advantage of a vast ecosystem of third-party packages, and easily install or update them.
- 一个包管理器，如Yarn 或 npm。 它可以让您利用庞大的第三方软件包的生态系统，从而更轻松安装和更新它们。


- A **bundler**, such as [webpack](https://webpack.js.org/) or [Browserify](http://browserify.org/). It lets you write modular code and bundle it together into small packages to optimize load time.


- 一个打包器，如webpack或Browserify。 它允许您编写模块化代码并将其打包在一起，成为压缩包，以优化加载时间。


- A **compiler** such as [Babel](http://babeljs.io/). It lets you write modern JavaScript code that still works in older browsers.


- 一个编译器，如Babel。 它可以让您编写最新的JavaScript代码，但仍旧能运行在旧版浏览器上。

### Installing React(安装React)

We recommend using [Yarn](https://yarnpkg.com/) or [npm](https://www.npmjs.com/) for managing front-end dependencies. If you're new to package managers, the [Yarn documentation](https://yarnpkg.com/en/docs/getting-started) is a good place to get started.

我们建议使用Yarn 或 npm来管理前端依赖关系。 如果您是新来的软件包管理员，则该[Yarn文档](https://yarnpkg.com/en/docs/getting-started)是开始使用Yarn的好地方。

To install React with Yarn, run:（使用Yarn安装React，请运行）

```bash
yarn init
yarn add react react-dom
```

To install React with npm, run:（使用npm安装React，请运行）

```bash
npm init
npm install --save react react-dom
```

Both Yarn and npm download packages from the [npm registry](http://npmjs.com/).

从npm注册表中下载Yarn和npm的软件包。

### Enabling ES6 and JSX(启用ES6和JSX)

We recommend using React with [Babel](http://babeljs.io/) to let you use ES6 and JSX in your JavaScript code. ES6 is a set of modern JavaScript features that make development easier, and JSX is an extension to the JavaScript language that works nicely with React.

我们建议您使用Babel来将React代码进行转换，以便于您可以在JavaScript代码中使用ES6语法和JSX语法。 ES6是JavaScript的一组最新的特性，可以使开发变得更简单，JSX是对JavaScript语言的一种扩展，它能使React的很好地运行。

The [Babel setup instructions](https://babeljs.io/docs/setup/) explain how to configure Babel in many different build environments. Make sure you install [`babel-preset-react`](http://babeljs.io/docs/plugins/preset-react/#basic-setup-with-the-cli-) and [`babel-preset-es2015`](http://babeljs.io/docs/plugins/preset-es2015/#basic-setup-with-the-cli-) and enable them in your [`.babelrc` configuration](http://babeljs.io/docs/usage/babelrc/), and you're good to go.

Babel设置说明：声明了如何在许多不同的构建环境中配置Babel。 确保您安装了[babel-preset-react](http://babeljs.io/docs/plugins/preset-react/#basic-setup-with-the-cli-) 和[babel-preset-es2015](http://babeljs.io/docs/plugins/preset-es2015/#basic-setup-with-the-cli-)，并在[.babelrc](http://babeljs.io/docs/usage/babelrc/)配置中启用它们。

### Hello World with ES6 and JSX(使用ES6和JSX构建Hello World程序)

We recommend using a bundler like [webpack](https://webpack.js.org/) or [Browserify](http://browserify.org/) so you can write modular code and bundle it together into small packages to optimize load time.

我们建议你使用像webpack或Browserify这样的打包器。 这样您可以编写模块化代码并将其打包在一起，成为压缩包，以优化加载时间。

The smallest React example looks like this:

最见得的React示例如下所示：

```js
import React from 'react';
import ReactDOM from 'react-dom';

ReactDOM.render(
  <h1>Hello, world!</h1>,
  document.getElementById('root')
);
```

This code renders into a DOM element with the id of `root` so you need `<div id="root"></div>` somewhere in your HTML file.

这块代码将其它元素渲染进一个ID为root的DOM元素，因此您需要在HTML文件中的某个位置使用<div id =“root”> </ div>。

Similarly, you can render a React component inside a DOM element somewhere inside your existing app written with any other JavaScript UI library.

类似地，您可以在现有应用程序中的任何其他地方，将DOM元素中渲染为（使用任何其他的JavaScript UI库编写的任何）React组件。

### Development and Production Versions(开发和生产版本)

By default, React includes many helpful warnings. These warnings are very useful in development. However, they make React larger and slower so you should make sure to use the production version when you deploy the app.

默认情况下，React包含许多有用的警告。 这些警告在开发中非常有用。 但是，它们使React应用包更大，运行更加缓慢，所以您应该确保在部署应用程序时，使用生产版本。

#### Brunch

To create an optimized production build with Brunch, just add the `-p` flag to the build command. See the [Brunch docs](http://brunch.io/docs/commands) for more details.

要使用Brunch创建优化的生产构建，只需将`-p`标志添加到build命令中即可。 有关详细信息，请参阅Brunch文档。

#### Browserify

Run Browserify with `NODE_ENV` environment variable set to `production` and use [UglifyJS](https://github.com/mishoo/UglifyJS) as the last build step so that development-only code gets stripped out.

运行Browserify时，将`NODE_ENV`环境变量设置为`production`，并使用UglifyJS作为最后一个构建步骤，以便将开发代码进行分离。

#### Create React App

If you use [Create React App](https://github.com/facebookincubator/create-react-app), `npm run build` will create an optimized build of your app in the `build` folder.

如果您使用Create React App命令行工具，`npm run build`将在`build`文件夹中创建一个已经优化过的应用程序。

#### Rollup

Use [rollup-plugin-replace](https://github.com/rollup/rollup-plugin-replace) plugin together with [rollup-plugin-commonjs](https://github.com/rollup/rollup-plugin-commonjs) (in that order) to remove development-only code. [See this gist](https://gist.github.com/Rich-Harris/cb14f4bc0670c47d00d191565be36bf0) for a complete setup example.

使用rollup-plugin-replace插件和rollup-plugin-commonjs（按顺序）来分离开发代码。 [参考这个一个完整的设置示例]()。

#### Webpack

Include both `DefinePlugin` and `UglifyJsPlugin` into your production Webpack configuration as described in [this guide](https://webpack.js.org/guides/production-build/).

将DefinePlugin和UglifyJsPlugin包含在本指南中描述的生产Webpack配置中，[在这个指导](https://webpack.js.org/guides/production-build/)中进行详细的描述。

### Using a CDN(使用CDN)

If you don't want to use npm to manage client packages, the `react` and `react-dom` npm packages also provide single-file distributions in `dist` folders, which are hosted on a CDN:

如果您不想使用npm来管理客户端软件依赖包，那么`React`和`React-dom` npm软件包也会在`dist`文件夹中提供单文件分发,它们托管在CDN上：

```html
<script src="https://unpkg.com/react@15/dist/react.js"></script>
<script src="https://unpkg.com/react-dom@15/dist/react-dom.js"></script>
```

The versions above are only meant for development, and are not suitable for production. Minified and optimized production versions of React are available at:

以上版本仅用于开发，不适合生产。 React优化生产版本可在以下网址获得：

```html
<script src="https://unpkg.com/react@15/dist/react.min.js"></script>
<script src="https://unpkg.com/react-dom@15/dist/react-dom.min.js"></script>
```

To load a specific version of `react` and `react-dom`, replace `15` with the version number.

要加载`react` 和 `react-dom`的特定版本，请使用其它的版本号替换15。

If you use Bower, React is available via the `react` package.

如果您使用Bower，React可通过 `react` 包获得。