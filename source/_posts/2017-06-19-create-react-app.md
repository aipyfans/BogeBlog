---
layout: post
title:  "Create React App 脚手架的使用说明"
date:   2017-06-19 11:11:11
categories: react
---

This project was bootstrapped with [Create React App](https://github.com/facebookincubator/create-react-app).

这个项目是由`Create React App`工具引导创建。


Below you will find some information on how to perform common tasks.<br>

下面你会找到一些有关如何执行常见任务的信息。

You can find the most recent version of this guide [here](https://github.com/facebookincubator/create-react-app/blob/master/packages/react-scripts/template/README.md).

您可以在这里找到本指南的最新版本。

## Table of Contents(目录)

- [Updating to New Releases](#updating-to-new-releases) 更新到新版本
- [Sending Feedback](#sending-feedback) 发送反馈
- [Folder Structure](#folder-structure) 文件夹结构
- [Available Scripts](#available-scripts) 可用脚本
  - [npm start](#npm-start)
  - [npm test](#npm-test)
  - [npm run build](#npm-run-build)
  - [npm run eject](#npm-run-eject)
- [Supported Language Features and Polyfills](#supported-language-features-and-polyfills) 支持的语言功能和Polyfills (Polyfills是Remy Sharp提出的一个术语，用来补充因缺乏对新API支持而缺失的功能)
- [Syntax Highlighting in the Editor](#syntax-highlighting-in-the-editor) 编辑器中的语法突出显示
- [Displaying Lint Output in the Editor](#displaying-lint-output-in-the-editor) 在编辑器中显示Lint输出
- [Debugging in the Editor](#debugging-in-the-editor) 在编辑器中调试
- [Changing the Page `<title>`](#changing-the-page-title) 更改页面`<title>`
- [Installing a Dependency](#installing-a-dependency) 安装依赖
- [Importing a Component](#importing-a-component) 导入组件
- [Code Splitting](#code-splitting) 代码拆分
- [Adding a Stylesheet](#adding-a-stylesheet) 添加样式表
- [Post-Processing CSS](#post-processing-css) CSS后期处理
- [Adding a CSS Preprocessor (Sass, Less etc.)](#adding-a-css-preprocessor-sass-less-etc) 添加CSS预处理器（Sass，Less等）
- [Adding Images, Fonts, and Files](#adding-images-fonts-and-files) 添加图像，字体和文件
- [Using the `public` Folder](#using-the-public-folder) 使用`public`文件夹
  - [Changing the HTML](#changing-the-html) 更改HTML
  - [Adding Assets Outside of the Module System](#adding-assets-outside-of-the-module-system) 在模块系统之外添加资源
  - [When to Use the `public` Folder](#when-to-use-the-public-folder) 何时使用`public`文件夹
- [Using Global Variables](#using-global-variables) 使用全局变量
- [Adding Bootstrap](#adding-bootstrap) 添加Bootstrap库
  - [Using a Custom Theme](#using-a-custom-theme) 使用自定义主题
- [Adding Flow](#adding-flow) 添加流
- [Adding Custom Environment Variables](#adding-custom-environment-variables) 添加自定义环境变量
  - [Referencing Environment Variables in the HTML](#referencing-environment-variables-in-the-html) 引用HTML中的环境变量
  - [Adding Temporary Environment Variables In Your Shell](#adding-temporary-environment-variables-in-your-shell) 在Shell中添加临时环境变量
  - [Adding Development Environment Variables In `.env`](#adding-development-environment-variables-in-env) 在`.env`中添加开发环境变量
- [Can I Use Decorators?](#can-i-use-decorators) 我可以使用装饰器吗？
- [Integrating with an API Backend](#integrating-with-an-api-backend) 与后端API集成
  - [Node](#node)
  - [Ruby on Rails](#ruby-on-rails)
- [Proxying API Requests in Development](#proxying-api-requests-in-development) 在开发中代理API请求
  - ["Invalid Host Header" Errors After Configuring Proxy](#invalid-host-header-errors-after-configuring-proxy) 配置代理后的“主机头无效”错误
  - [Configuring the Proxy Manually](#configuring-the-proxy-manually) 手动配置代理
- [Using HTTPS in Development](#using-https-in-development) 在开发中使用HTTPS
- [Generating Dynamic `<meta>` Tags on the Server](#generating-dynamic-meta-tags-on-the-server) 在服务器上生成动态`<meta>`标签
- [Pre-Rendering into Static HTML Files](#pre-rendering-into-static-html-files) 预渲染成静态HTML文件
- [Injecting Data from the Server into the Page](#injecting-data-from-the-server-into-the-page) 将数据从服务器注入页面
- [Running Tests](#running-tests) 运行测试
  - [Filename Conventions](#filename-conventions) 文件名约定
  - [Command Line Interface](#command-line-interface) 命令行界面
  - [Version Control Integration](#version-control-integration) 版本控制集成
  - [Writing Tests](#writing-tests) 写测试
  - [Testing Components](#testing-components) 测试组件
  - [Using Third Party Assertion Libraries](#using-third-party-assertion-libraries) 使用第三方断言库
  - [Initializing Test Environment](#initializing-test-environment) 初始化测试环境
  - [Focusing and Excluding Tests](#focusing-and-excluding-tests) 聚焦和排除测试
  - [Coverage Reporting](#coverage-reporting) 覆盖报告
  - [Continuous Integration](#continuous-integration) 持续整合
  - [Disabling jsdom](#disabling-jsdom) 禁用jsdom
  - [Snapshot Testing](#snapshot-testing) 快照测试
  - [Editor Integration](#editor-integration) 编辑器集成
- [Making a Progressive Web App](#making-a-progressive-web-app) 制作一个渐进的Web应用程序
  - [Offline-First Considerations](#offline-first-considerations) 离线优先注意事项
  - [Progressive Web App Metadata](#progressive-web-app-metadata) 不断改进的Web应用程序元数据
- [Deployment](#deployment) 部署
  - [Static Server](#static-server) 静态服务器
  - [Other Solutions](#other-solutions) 其他解决方案
  - [Serving Apps with Client-Side Routing](#serving-apps-with-client-side-routing) 使用客户端路由的服务应用程序
  - [Building for Relative Paths](#building-for-relative-paths) 相对路径建设
  - [Azure](#azure)
  - [Firebase](#firebase)
  - [GitHub Pages](#github-pages)
  - [Heroku](#heroku)
  - [Modulus](#modulus)
  - [Netlify](#netlify)
  - [Now](#now)
  - [S3 and CloudFront](#s3-and-cloudfront)
  - [Surge](#surge)
- [Advanced Configuration](#advanced-configuration) 高级配置
- [Troubleshooting](#troubleshooting) 故障排除
  - [`npm start` doesn’t detect changes](#npm-start-doesnt-detect-changes) `npm start`不能检测到更改
  - [`npm test` hangs on macOS Sierra](#npm-test-hangs-on-macos-sierra) `npm test`挂在macOS Sierra上
  - [`npm run build` silently fails](#npm-run-build-silently-fails) `npm run build`默认失败
  - [`npm run build` fails on Heroku](#npm-run-build-fails-on-heroku) `npm run build`在Heroku上失败
  - [Moment.js locales are missing](#momentjs-locales-are-missing) Moment.js语言环境丢失
- [Something Missing?](#something-missing) 还缺少什么？

## Updating to New Releases
### 更新到新版本

Create React App is divided into two packages:

创建React应用程序分为两个包：

* `create-react-app` is a global command-line utility that you use to create new projects.
* `create-react-app` 是用于创建新项目的全局命令行实用工具.
* `react-scripts` is a development dependency in the generated projects (including this one).
* `react-scripts` 是用于生成项目的开发依赖（包括这个项目）.

You almost never need to update `create-react-app` itself: it delegates all the setup to `react-scripts`.

您几乎不需要更新 `create-react-app` 本身：它将所有设置委托给 `react-scripts`.

When you run `create-react-app`, it always creates the project with the latest version of `react-scripts` so you’ll get all the new features and improvements in newly created apps automatically.

当您运行`create-react-app`时，它始终使用最新版本的`react-scripts`创建项目，以便您自动获得新创建的应用程序的所有新功能和改进。

To update an existing project to a new version of `react-scripts`, [open the changelog](https://github.com/facebookincubator/create-react-app/blob/master/CHANGELOG.md), find the version you’re currently on (check `package.json` in this folder if you’re not sure), and apply the migration instructions for the newer versions.

要将现有项目更新为新版本的`react-scripts`，请打开更改日志，找到当前版本（如果您不确定，请检查此文件夹中的 `package.json` ），然后应用更新的迁移说明版本。

In most cases bumping the `react-scripts` version in `package.json` and running `npm install` in this folder should be enough, but it’s good to consult the [changelog](https://github.com/facebookincubator/create-react-app/blob/master/CHANGELOG.md) for potential breaking changes.

在大多数情况下，在package.json中更改`react-scripts`版本并在此文件夹中运行`npm install`应该是可以顺利更新的，但是对于潜在的突破性更改，请参考更改日志。

We commit to keeping the breaking changes minimal so you can upgrade `react-scripts` painlessly.

我们致力于保持最小化的变化，从而可以无痛地升级`react-scripts`。

## Sending Feedback
### 发送反馈

We are always open to [your feedback](https://github.com/facebookincubator/create-react-app/issues).

我们总是对[您的反馈](https://github.com/facebookincubator/create-react-app/issues)开放。

## Folder Structure
### 文件夹结构

After creation, your project should look like this:

创建后，您的项目结构应如下所示：

```
my-app/
  README.md
  node_modules/
  package.json
  public/
    index.html
    favicon.ico
  src/
    App.css
    App.js
    App.test.js
    index.css
    index.js
    logo.svg
```

For the project to build, **these files must exist with exact filenames**:

对于要构建的项目，**这些文件必须存在精确的文件名**：

* `public/index.html` is the page template;
* `public/index.html` 是页面模板;
* `src/index.js` is the JavaScript entry point.
* `src/index.js` 是`JavaScript`入口点.

You can delete or rename the other files.

您可以删除或重命名其他文件。

You may create subdirectories inside `src`. For faster rebuilds, only files inside `src` are processed by Webpack.<br>
You need to **put any JS and CSS files inside `src`**, or Webpack won’t see them.

您可以在`src`内创建子目录。对于更快的重建，只有`src`中的文件才能被Webpack处理.<br>
您需要**将任何JS和CSS文件放在src中**，否则Webpack将不会发现它们。

Only files inside `public` can be used from `public/index.html`.<br>
Read instructions below for using assets from JavaScript and HTML.

`public/index.html`中只能使用`public`内的文件.<br>
阅读使用JavaScript和HTML资源的说明.

You can, however, create more top-level directories.<br>
They will not be included in the production build so you can use them for things like documentation.

但是，您可以创建更多的顶级目录.<br>
它们不会被包含在生产构建中，因此您可以将它们用于文档等内容.

## Available Scripts
### 可用脚本

In the project directory, you can run:

在项目目录中，您可以运行：

### `npm start`

Runs the app in the development mode.<br>
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

在开发模式下运行应用程序.<br>
打开 [http://localhost:3000](http://localhost:3000)在浏览器中查看。

The page will reload if you make edits.<br>
You will also see any lint errors in the console.

如果进行修改，页面将重新加载.<br>
您还将在控制台中看到任何lint错误。

### `npm test`

Launches the test runner in the interactive watch mode.<br>
See the section about [running tests](#running-tests) for more information.

以交互观察模式启动test runner.<br>
有关更多信息，请参阅有关 [running tests](#running-tests) 的部分。

### `npm run build`

Builds the app for production to the `build` folder.<br>
It correctly bundles React in production mode and optimizes the build for the best performance.

构建生产应用程序到 `build` 文件夹.<br>

它在生产模式下正确地捆绑了React，并优化了构建以获得最佳性能。

The build is minified and the filenames include the hashes.<br>
Your app is ready to be deployed!

构建已经被细化，文件名包括散列.<br>

您的应用程序已准备好部署了！

See the section about [deployment](#deployment) for more information.

有关详细信息，请参阅有关部署的部分。

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

**注意：这是一个单向操作。一旦你`弹出`，你不能返回！**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

如果您对构建工具和配置选项不满意，您可以随时`弹出`。此命令将从项目中删除单个构建依赖关系。

Instead, it will copy all the configuration files and the transitive dependencies (Webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you’re on your own.

相反，它会将所有配置文件和传递依赖项（Webpack，Babel，ESLint等）直接复制到您的项目中，以便您可以完全控制它们。除`弹出`之外的所有命令仍将起作用，但它们将指向复制的脚本，以便您可以调整它们。在这一点上，你是你自己的。

You don’t have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

你不必使用`弹出`。策划的功能集适用于中小型部署，您不应该有义务使用此功能。但是，我们明白，如果您无法自定义此工具，则此工具将无用。

## Supported Language Features and Polyfills

### 支持的语言功能和Polyfills

**Polyfills是Remy Sharp提出的一个术语，用来补充因缺乏对新API支持而缺失的功能**

This project supports a superset of the latest JavaScript standard.<br>
In addition to [ES6](https://github.com/lukehoban/es6features) syntax features, it also supports:

该项目支持最新JavaScript标准的超集.<br>

除了ES6语法功能之外，它还支持：

* [Exponentiation Operator](https://github.com/rwaldron/exponentiation-operator) (ES2016).【指数运算符】
* [Async/await](https://github.com/tc39/ecmascript-asyncawait) (ES2017).【异步&等待关键词】
* [Object Rest/Spread Properties](https://github.com/sebmarkbage/ecmascript-rest-spread) (stage 3 proposal).【对象休眠/扩展属性（第3阶段提案）】
* [Dynamic import()](https://github.com/tc39/proposal-dynamic-import) (stage 3 proposal)【动态导入（第3阶段提案）】
* [Class Fields and Static Properties](https://github.com/tc39/proposal-class-public-fields) (stage 2 proposal).【类字段和静态属性（第3阶段提案）】
* [JSX](https://facebook.github.io/react/docs/introducing-jsx.html) and [Flow](https://flowtype.org/) syntax.【JSX和Flow语法】

Learn more about [different proposal stages](https://babeljs.io/docs/plugins/#presets-stage-x-experimental-presets-).

了解有关不同阶段的更多信息。

While we recommend to use experimental proposals with some caution, Facebook heavily uses these features in the product code, so we intend to provide [codemods](https://medium.com/@cpojer/effective-javascript-codemods-5a6686bb46fb) if any of these proposals change in the future.

虽然我们建议您谨慎使用实验性建议书，但Facebook在产品代码中大量使用这些功能，因此，如果将来有任何这些提案发生变化，我们打算提供代码。

Note that **the project only includes a few ES6 [polyfills](https://en.wikipedia.org/wiki/Polyfill)**:

请注意，该项目仅包括几个ES6 polyfills：

* [`Object.assign()`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Object/assign) via [`object-assign`](https://github.com/sindresorhus/object-assign).
* [`Promise`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) via [`promise`](https://github.com/then/promise).
* [`fetch()`](https://developer.mozilla.org/en/docs/Web/API/Fetch_API) via [`whatwg-fetch`](https://github.com/github/fetch).

If you use any other ES6+ features that need **runtime support** (such as `Array.from()` or `Symbol`), make sure you are including the appropriate polyfills manually, or that the browsers you are targeting already support them.

如果您使用任何需要**运行时支持**的其他ES6功能(例如 `Array.from()` or `Symbol`)，请确保您手动包含相应的polyfills，或者您定位的浏览器已经支持它们。

## Syntax Highlighting in the Editor

### 编辑器中的语法突出显示

To configure the syntax highlighting in your favorite text editor, head to the [relevant Babel documentation page](https://babeljs.io/docs/editors) and follow the instructions. Some of the most popular editors are covered.

要在您喜欢的文本编辑器中配置语法高亮，请转到[相关的Babel文档](https://babeljs.io/docs/editors)页面，然后按照说明进行操作。一些最流行的编辑被覆盖。

## Displaying Lint Output in the Editor

### 在编辑器中显示Lint输出

>Note: this feature is available with `react-scripts@0.2.0` and higher.<br>
>It also only works with npm 3 or higher.
>
>注意：此功能可用在react-scripts@0.2.0及更高版本.<br>
>
>它也只适用于npm 3或更高版本。

Some editors, including Sublime Text, Atom, and Visual Studio Code, provide plugins for ESLint.

一些编辑器，包括Sublime Text，Atom和Visual Studio Code，可以为其提供ESLint插件。

They are not required for linting. You should see the linter output right in your terminal as well as the browser console. However, if you prefer the lint results to appear right in your editor, there are some extra steps you can do.

它们不需要进行Linting。您应该在终端以及浏览器控制台中看到信息输出。但是，如果您喜欢在编辑器中显示lint结果，则可以执行一些额外的步骤。

You would need to install an ESLint plugin for your editor first. Then, add a file called `.eslintrc` to the project root:

您需要先为编辑器安装ESLint插件。然后，将一个名为`.eslintrc`的文件添加到项目根目录中：

```js
{
  "extends": "react-app"
}
```

Now your editor should report the linting warnings.

现在你的编辑器应该报告出那些检索出的警告。

Note that even if you edit your `.eslintrc` file further, these changes will **only affect the editor integration**. They won’t affect the terminal and in-browser lint output. This is because Create React App intentionally provides a minimal set of rules that find common mistakes.

请注意，即使您进一步编辑`.eslintrc`文件，这些更改**只会影响编辑器的集成**。它们不会影响终端和浏览器中的lint输出。这是因为**Create React App **有意提供了一组最常见的错误的规则。

If you want to enforce a coding style for your project, consider using [Prettier](https://github.com/jlongster/prettier) instead of ESLint style rules.

如果要为项目强制执行编码风格，请考虑使用[Prettier](https://github.com/jlongster/prettier)而不是**ESLint**样式规则。

## Debugging in the Editor

### 在编辑器中调试

**This feature is currently only supported by [Visual Studio Code](https://code.visualstudio.com) editor.**

此功能目前仅支持 [Visual Studio Code](https://code.visualstudio.com) 编辑器。

Visual Studio Code supports debugging out of the box with Create React App. This enables you as a developer to write and debug your React code without leaving the editor, and most importantly it enables you to have a continuous development workflow, where context switching is minimal, as you don’t have to switch between tools.

Visual StudioCode支持使用Create React App进行开箱调试。这使您可以作为开发人员编写和调试您的React代码，而不必离开编辑器，最重要的是它可以让您拥有持续的开发工作流程，其中编辑器环境切换是最小的，因为您不必在工具之间进行切换。

You would need to have the latest version of [VS Code](https://code.visualstudio.com) and VS Code [Chrome Debugger Extension](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome) installed.

您需要安装[VS Code](https://code.visualstudio.com)和VS Code [Chrome调试器扩展](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)的最新版本。

Then add the block below to your `launch.json` file and put it inside the `.vscode` folder in your app’s root directory.

然后将下面的代码块添加到您的`launch.json`文件中，并将其放在应用程序根目录中的`.vscode`文件夹中。

```json
{
  "version": "0.2.0",
  "configurations": [{
    "name": "Chrome",
    "type": "chrome",
    "request": "launch",
    "url": "http://localhost:3000",
    "webRoot": "${workspaceRoot}/src",
    "userDataDir": "${workspaceRoot}/.vscode/chrome",
    "sourceMapPathOverrides": {
      "webpack:///src/*": "${webRoot}/*"
    }
  }]
}
```

Start your app by running `npm start`, and start debugging in VS Code by pressing `F5` or by clicking the green debug icon. You can now write code, set breakpoints, make changes to the code, and debug your newly modified code—all from your editor.

通过运行 `npm start` 启动您的应用程序，并通过按`F5`或单击绿色调试图标在VS代码中开始调试。您现在可以编辑代码，设置断点，更改代码，并从编辑器调试新修改的代码。

## Changing the Page `<title>`

### 更改页面`<title>`

You can find the source HTML file in the `public` folder of the generated project. You may edit the `<title>` tag in it to change the title from “React App” to anything else.

您可以在生成的项目的 `public` 文件夹中找到源HTML文件。您可以编辑其中的`<title>`标签，将标题从“React App”更改为其他任何内容。

Note that normally you wouldn’t edit files in the `public` folder very often. For example, [adding a stylesheet](#adding-a-stylesheet) is done without touching the HTML.

请注意，通常您不会经常在 `public` 文件夹中编辑文件。例如，通过添加样式表完成，而不修改HTML文件。

If you need to dynamically update the page title based on the content, you can use the browser [`document.title`](https://developer.mozilla.org/en-US/docs/Web/API/Document/title) API. For more complex scenarios when you want to change the title from React components, you can use [React Helmet](https://github.com/nfl/react-helmet), a third party library.

如果您需要根据内容动态更新页面标题，可以使用浏览器的[document.title API](https://developer.mozilla.org/en-US/docs/Web/API/Document/title)。对于要从React组件更改标题的更复杂的场景，可以使用[React Helmet](https://github.com/nfl/react-helmet)(一个第三方库)。

If you use a custom server for your app in production and want to modify the title before it gets sent to the browser, you can follow advice in [this section](#generating-dynamic-meta-tags-on-the-server). Alternatively, you can pre-build each page as a static HTML file which then loads the JavaScript bundle, which is covered [here](#pre-rendering-into-static-html-files).

如果您在生产中为自己的应用程序使用自定义服务器，并且要在将标题发送到浏览器之前修改标题，则可以在本节中遵循建议。或者，您可以将每个页面预先构建为一个静态HTML文件，然后加载JavaScript包，此处将在此介绍。

## Installing a Dependency

### 安装依赖关系

The generated project includes React and ReactDOM as dependencies. It also includes a set of scripts used by Create React App as a development dependency. You may install other dependencies (for example, React Router) with `npm`:

生成的项目包含`React`和`ReactDOM`作为依赖关系。它还包括`Create React App`用作开发依赖关系的一组脚本。您可以使用`npm`安装其他依赖项（例如`React Router`）

```
npm install --save <library-name>
```

## Importing a Component

### 导入组件

This project setup supports ES6 modules thanks to Babel.<br>

感谢Babel开源模块，因为这个项目设置支持ES6模块.<br>

While you can still use `require()` and `module.exports`, we encourage you to use [`import` and `export`](http://exploringjs.com/es6/ch_modules.html) instead.

虽然您仍然可以使用 `require()` 和 `module.exports`, 但我们建议您改用导入和导出。

For example:

例如:

### `Button.js`

```js
import React, { Component } from 'react';

class Button extends Component {
  render() {
    // ...
  }
}

// Don’t forget to use export default!
// 不要忘记使用export default!
export default Button; 
```

### `DangerButton.js`


```js
import React, { Component } from 'react';

// Import a component from another file
// 从另一个文件导入组件
import Button from './Button'; 

class DangerButton extends Component {
  render() {
    return <Button color="red" />;
  }
}

export default DangerButton;
```

Be aware of the [difference between default and named exports](http://stackoverflow.com/questions/36795819/react-native-es-6-when-should-i-use-curly-braces-for-import/36796281#36796281). It is a common source of mistakes.

请注意默认和命名导出之间的区别。这是错误的常见来源。

We suggest that you stick to using default imports and exports when a module only exports a single thing (for example, a component). That’s what you get when you use `export default Button` and `import Button from './Button'`.

我们建议您在模块仅导出单个对象(例如，组件)时坚持使用默认导入和导出。这就是你使用时所得到的 `export default Button` 和 `import Button from './Button'`.

Named exports are useful for utility modules that export several functions. A module may have at most one default export and as many named exports as you like.

命名导出对导出多个功能的实用程序模块很有用。一个模块最多可能有一个默认的导出，并且有许多命名的导出。

Learn more about ES6 modules: 了解有关ES6模块的更多信息

* [When to use the curly braces?](http://stackoverflow.com/questions/36795819/react-native-es-6-when-should-i-use-curly-braces-for-import/36796281#36796281) 何时使用花括号？
* [Exploring ES6: Modules](http://exploringjs.com/es6/ch_modules.html) 探索ES6：模块
* [Understanding ES6: Modules](https://leanpub.com/understandinges6/read#leanpub-auto-encapsulating-code-with-modules) 了解ES6：模块

## Code Splitting

### 代码拆分

Instead of downloading the entire app before users can use it, code splitting allows you to split your code into small chunks which you can then load on demand.

用户可以使用代码分割，而不是下载整个应用程序，您可以将代码拆分成小块，然后可以按需加载。

This project setup supports code splitting via [dynamic `import()`](http://2ality.com/2017/01/import-operator.html#loading-code-on-demand). Its [proposal](https://github.com/tc39/proposal-dynamic-import) is in stage 3. The `import()` function-like form takes the module name as an argument and returns a [`Promise`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) which always resolves to the namespace object of the module.

此项目设置支持通过 [dynamic `import()`](http://2ality.com/2017/01/import-operator.html#loading-code-on-demand)进行代码分割。它的[提议](https://github.com/tc39/proposal-dynamic-import)处于阶段3。 `import()` 函数式表单将模块名称作为参数，并返回一个 [`Promise`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) ，它始终解析为模块的命名空间对象。

Here is an example:

这是一个例子：

### `moduleA.js`

```js
const moduleA = 'Hello';

export { moduleA };
```
### `App.js`

```js
import React, { Component } from 'react';

class App extends Component {
  handleClick = () => {
    import('./moduleA')
      .then(({ moduleA }) => {
        // Use moduleA
      })
      .catch(err => {
        // Handle failure
      });
  };

  render() {
    return (
      <div>
        <button onClick={this.handleClick}>Load</button>
      </div>
    );
  }
}

export default App;
```

This will make `moduleA.js` and all its unique dependencies as a separate chunk that only loads after the user clicks the 'Load' button.

这将使`moduleA.js`及其所有唯一的依赖关系作为单独的块，仅在用户单击“加载”按钮后加载。

You can also use it with `async` / `await` syntax if you prefer it.

如果您愿意，也可以使用 `async` / `await` 语法。

## Adding a Stylesheet

### 添加样式表

This project setup uses [Webpack](https://webpack.js.org/) for handling all assets. Webpack offers a custom way of “extending” the concept of `import` beyond JavaScript. To express that a JavaScript file depends on a CSS file, you need to **import the CSS from the JavaScript file**:

此项目设置使用 [Webpack](https://webpack.js.org/) 处理所有资源。 Webpack提供了一种“定制”的方式，将 `import` 概念扩展到JavaScript之外。要表示一个JavaScript文件依赖于一个CSS文件，**您需要从JavaScript文件导入CSS**：

### `Button.css`

```css
.Button {
  padding: 20px;
}
```

### `Button.js`

```js
import React, { Component } from 'react';
// Tell Webpack that Button.js uses these styles
// 告诉Webpack，Button.js使用这些样式
import './Button.css'; 

class Button extends Component {
  render() {
    // You can use them as regular CSS styles
    // 您可以将它们用作常规CSS样式
    return <div className="Button" />;
  }
}
```

**This is not required for React** but many people find this feature convenient. You can read about the benefits of this approach [here](https://medium.com/seek-ui-engineering/block-element-modifying-your-javascript-components-d7f99fcab52b). However you should be aware that this makes your code less portable to other build tools and environments than Webpack.

**对于React这不是必需的**，但很多人发现这个功能很方便。您可以在[这里](https://medium.com/seek-ui-engineering/block-element-modifying-your-javascript-components-d7f99fcab52b)阅读这种方法的好处。但是，您应该意识到，相比Webpack，这使得您的代码不便于其他构建工具和环境。

In development, expressing dependencies this way allows your styles to be reloaded on the fly as you edit them. In production, all CSS files will be concatenated into a single minified `.css` file in the build output.

在开发中，通过这种方式表达依赖关系，可以在编辑它们时快速重新加载样式。在生产中，所有的CSS文件将被连接到构建输出中的一个最小化的`.css`文件中。

If you are concerned about using Webpack-specific semantics, you can put all your CSS right into `src/index.css`. It would still be imported from `src/index.js`, but you could always remove that import if you later migrate to a different build tool.

如果您关心使用特定于Webpack的语义，可以将所有CSS正确放入`src/index.css`。它仍将从`src/index.js`导入，但如果以后迁移到其他构建工具，则可以随时删除该导入。

## Post-Processing CSS

### CSS后期处理

This project setup minifies your CSS and adds vendor prefixes to it automatically through [Autoprefixer](https://github.com/postcss/autoprefixer) so you don’t need to worry about it.

这个项目设置可以减少你的CSS，并通过 [Autoprefixer](https://github.com/postcss/autoprefixer) 自动添加浏览器供应商的前缀，所以你不需要担心。

For example, this:

例如：

```css
.App {
  display: flex;
  flex-direction: row;
  align-items: center;
}
```

becomes this:

成为这样

```css
.App {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: horizontal;
  -webkit-box-direction: normal;
      -ms-flex-direction: row;
          flex-direction: row;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
}
```

If you need to disable autoprefixing for some reason, [follow this section](https://github.com/postcss/autoprefixer#disabling).

如果由于某些原因需要禁用autoprefixing，请[参照这一节](https://github.com/postcss/autoprefixer#disabling)。

## Adding a CSS Preprocessor (Sass, Less etc.)

### 添加CSS预处理器(Sass,Less等)

Generally, we recommend that you don’t reuse the same CSS classes across different components. For example, instead of using a `.Button` CSS class in `<AcceptButton>` and `<RejectButton>` components, we recommend creating a `<Button>` component with its own `.Button` styles, that both `<AcceptButton>` and `<RejectButton>` can render (but [not inherit](https://facebook.github.io/react/docs/composition-vs-inheritance.html)).

通常，我们建议您不要在不同的组件之间重复使用相同的CSS类。例如，不要在`<AcceptButton>`和`<RejectButton>`组件中使用`.Button` CSS类，我们建议使用自己的`.Button`样式创建一个`<Button>`组件，`<AcceptButton>`和`<RejectButton>`可以呈现（但不能继承）。

Following this rule often makes CSS preprocessors less useful, as features like mixins and nesting are replaced by component composition. You can, however, integrate a CSS preprocessor if you find it valuable. In this walkthrough, we will be using Sass, but you can also use Less, or another alternative.

遵循这条规则往往使CSS预处理器不太有用，因为诸如混合和嵌套之类的功能被组件的组合所替代。但是，如果您发现它有价值，您可以集成CSS预处理器。在本演练中，我们将使用Sass，但您也可以使用Less或另一种选择。

First, let’s install the command-line interface for Sass:

首先，我们通过命令行界面来安装Sass：

```
npm install node-sass-chokidar --save-dev
```
Then in `package.json`, add the following lines to `scripts`:

然后在`package.json`中，将以下行添加到脚本中：

```diff
   "scripts": {
+    "build-css": "node-sass-chokidar src/ -o src/",
+    "watch-css": "npm run build-css && node-sass-chokidar src/ -o src/ --watch --recursive",
     "start": "react-scripts start",
     "build": "react-scripts build",
     "test": "react-scripts test --env=jsdom",
```

>Note: To use a different preprocessor, replace `build-css` and `watch-css` commands according to your preprocessor’s documentation.
>
>注意：要使用不同的预处理器，请根据预处理器的文档替换`build-css`和`watch-css`命令。

Now you can rename `src/App.css` to `src/App.scss` and run `npm run watch-css`. The watcher will find every Sass file in `src` subdirectories, and create a corresponding CSS file next to it, in our case overwriting `src/App.css`. Since `src/App.js` still imports `src/App.css`, the styles become a part of your application. You can now edit `src/App.scss`, and `src/App.css` will be regenerated.

现在，您可以将 `src/App.css` 重命名为 `src/App.scss` 并运行 `npm run watch-css`。观察器将在`src`子目录中找到每个Sass文件，并在其旁边创建一个相应的CSS文件，在我们的例子中覆盖`src/App.css`。由于`src/App.js` 仍然导入 `src/App.css`，样式将成为您的应用程序的一部分。您现在可以编辑 `src/App.scss`,，并重新生成`src/App.css` 。

To share variables between Sass files, you can use Sass imports. For example, `src/App.scss` and other component style files could include `@import "./shared.scss";` with variable definitions.

要在Sass文件之间共享变量，可以使用Sass导入。例如， `src/App.scss` 和其他组件样式文件可以包括使用变量定义的`@import "./shared.scss"`。

To enable importing files without using relative paths, you can add the  `--include-path` option to the command in `package.json`.

要在不使用相对路径的情况下导入文件，可以在`package.json`中的命令块中添加`--include-path`选项。

```
"build-css": "node-sass-chokidar --include-path ./src --include-path ./node_modules src/ -o src/",
"watch-css": "npm run build-css && node-sass-chokidar --include-path ./src --include-path ./node_modules src/ -o src/ --watch --recursive",
```

This will allow you to do imports like

这样将会允许你可以像这样导入

```scss
// assuming a styles directory under src/
// 假设在src/下的一个样式目录中
@import 'styles/_colors.scss'; 

// importing a css file from the nprogress node module
// 从nprogress节点模块导入一个css文件
@import 'nprogress/nprogress'; 
```

At this point you might want to remove all CSS files from the source control, and add `src/**/*.css` to your `.gitignore` file. It is generally a good practice to keep the build products outside of the source control.

此时，您可能需要从源代码控件中删除所有的CSS文件，并将 `src/**/*.css` 添加到`.gitignore` 文件中。将构建产品保留在源代码控制之外是一个很好的做法。

As a final step, you may find it convenient to run `watch-css` automatically with `npm start`, and run `build-css` as a part of `npm run build`. You can use the `&&` operator to execute two scripts sequentially. However, there is no cross-platform way to run two scripts in parallel, so we will install a package for this:

作为最后一步，您可能会发现使用 `npm start`自动运行 `watch-css` 是方便的，并运行`build-css`作为 `npm run build`的一部分。

```
npm install --save-dev npm-run-all
```

Then we can change `start` and `build` scripts to include the CSS preprocessor commands:

然后我们可以更改 `start` 和 `build` 脚本用来包含CSS预处理器命令：

```diff
   "scripts": {
     "build-css": "node-sass-chokidar src/ -o src/",
     "watch-css": "npm run build-css && node-sass-chokidar src/ -o src/ --watch --recursive",
-    "start": "react-scripts start",
-    "build": "react-scripts build",
+    "start-js": "react-scripts start",
+    "start": "npm-run-all -p watch-css start-js",
+    "build": "npm run build-css && react-scripts build",
     "test": "react-scripts test --env=jsdom",
     "eject": "react-scripts eject"
   }
```

Now running `npm start` and `npm run build` also builds Sass files.

现在运行`npm start`和`npm run build`还构建了Sass文件。

**Why `node-sass-chokidar`?**

**为什么使用 `node-sass-chokidar`?**

`node-sass` has been reported as having the following issues:

`node-sass` 据说存在以下问题：

- `node-sass --watch` has been reported to have *performance issues* in certain conditions when used in a virtual machine or with docker.
- `node-sass --watch` 据说，在虚拟机或docker容器中使用时，在某些情况下会出现性能问题。
- Infinite styles compiling [#1939](https://github.com/facebookincubator/create-react-app/issues/1939)
- 无限风格编译
- `node-sass` has been reported as having issues with detecting new files in a directory [#1891](https://github.com/sass/node-sass/issues/1891)
- `node-sass` 已被报告为检测目录中的新文件有问题 [#1891](https://github.com/sass/node-sass/issues/1891)

 `node-sass-chokidar` is used here as it addresses these issues.

 `node-sass-chokidar` 在这里用于解决这些问题。

## Adding Images, Fonts, and Files

### 添加图像，字体和文件

With Webpack, using static assets like images and fonts works similarly to CSS.

使用Webpack，使用像图像和字体的静态资源与CSS类似。

You can **`import` a file right in a JavaScript module**. This tells Webpack to include that file in the bundle. Unlike CSS imports, importing a file gives you a string value. This value is the final path you can reference in your code, e.g. as the `src` attribute of an image or the `href` of a link to a PDF.

您可以**直接在JavaScript模块中导入文件**。这告诉Webpack将该文件包括在包中。不像CSS导入，导入一个文件会给你一个字符串值。此值是您可以在代码中引用的最终路径，例如作为图像的 `src` 属性或链接到`PDF`的`href`。

To reduce the number of requests to the server, importing images that are less than 10,000 bytes returns a [data URI](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) instead of a path. This applies to the following file extensions: bmp, gif, jpg, jpeg, and png. SVG files are excluded due to [#1153](https://github.com/facebookincubator/create-react-app/issues/1153).

为了减少对服务器的请求数量，导入少于10000个字节的图像可以返回[数据URI](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) 而不是路径。这适用于以下文件扩展名：bmp，gif，jpg，jpeg和png。由于[#1153](https://github.com/facebookincubator/create-react-app/issues/1153)导致SVG文件被排除在外

Here is an example:

```js
import React from 'react';

// Tell Webpack this JS file uses this image
// 告诉Webpack这个JS文件使用这个图像
import logo from './logo.png'; 

console.log(logo); // /logo.84287d09.png

function Header() {
  // Import result is the URL of your image
  // 导入结果是您图像的URL
  return <img src={logo} alt="Logo" />;
}

export default Header;
```

This ensures that when the project is built, Webpack will correctly move the images into the build folder, and provide us with correct paths.

这样可以确保项目建成后，Webpack将正确地将图像移动到构建文件夹中，并为我们提供正确的路径。

This works in CSS too:

这也适用于CSS：

```css
.Logo {
  background-image: url(./logo.png);
}
```

Webpack finds all relative module references in CSS (they start with `./`) and replaces them with the final paths from the compiled bundle. If you make a typo or accidentally delete an important file, you will see a compilation error, just like when you import a non-existent JavaScript module. The final filenames in the compiled bundle are generated by Webpack from content hashes. If the file content changes in the future, Webpack will give it a different name in production so you don’t need to worry about long-term caching of assets.

Webpack查找CSS中的所有相关模块引用（它们以`./`开头），并从编译的捆绑包中替换最终路径。如果您输入错误或意外删除重要文件，则会出现编译错误，就像导入不存在的JavaScript模块时一样。编译包中的最终文件名由Webpack利用内容的哈希值生成。如果将来文件内容发生变化，Webpack会在生产中给出不同的名称，因此您不必担心资源的长期缓存。

Please be advised that this is also a custom feature of Webpack.

请注意，这也是Webpack的自定义功能。

**It is not required for React** but many people enjoy it (and React Native uses a similar mechanism for images).<br>
An alternative way of handling static assets is described in the next section.

对于React它不是必需的，但很多人都喜欢它(和React Native使用类似的图像机制).<br>

下一节将介绍处理静态资源的另一种方法。

## Using the `public` Folder

### 使用`public`文件夹

>Note: this feature is available with `react-scripts@0.5.0` and higher.
>
>注意：此功能可用在react-scripts@0.5.0及更高版本。

### Changing the HTML

### 更改HTML

The `public` folder contains the HTML file so you can tweak it, for example, to [set the page title](#changing-the-page-title).

The `<script>` tag with the compiled code will be added to it automatically during the build process.

 `public` 文件夹包含HTML文件，以便您可以调整它，例如设置页面标题。

编译代码的`<script>`标签将在构建过程中自动添加。

### Adding Assets Outside of the Module System

### 在模块系统之外添加资源

You can also add other assets to the `public` folder.Note that we normally encourage you to `import` assets in JavaScript files instead.For example, see the sections on [adding a stylesheet](#adding-a-stylesheet) and [adding images and fonts](#adding-images-fonts-and-files).This mechanism provides a number of benefits:

您还可以将其他资源添加到 `public` 文件夹。请注意，我们通常鼓励您以JavaScript文件`import` 资源。例如，请参阅[添加样式表](#adding-a-stylesheet)和[添加图像和字体](#adding-images-fonts-and-files)的部分。这个机制提供了许多好处：

* Scripts and stylesheets get minified and bundled together to avoid extra network requests.
* 脚本和样式表被缩小并捆绑在一起，以避免额外的网络请求。
* Missing files cause compilation errors instead of 404 errors for your users.
* 缺少文件会导致编译错误，而不是用户的404错误。
* Result filenames include content hashes so you don’t need to worry about browsers caching their old versions.
* 结果文件名包括内容散列，因此您不必担心浏览器会缓存其旧版本。

However there is an **escape hatch** that you can use to add an asset outside of the module system.

但是，您可以使用一个可用于在模块系统外部添加资产的**逃生舱口**。

If you put a file into the `public` folder, it will **not** be processed by Webpack. Instead it will be copied into the build folder untouched.   To reference assets in the `public` folder, you need to use a special variable called `PUBLIC_URL`.

如果将文件放入 `public` 文件夹，则不会被Webpack处理。相反，它将被复制到构建文件夹中。要引用 `public` 文件夹中的资源，您需要使用一个名为`PUBLIC_URL`的特殊变量。

Inside `index.html`, you can use it like this:

在`index.html`里面，你可以这样使用：

```html
<link rel="shortcut icon" href="%PUBLIC_URL%/favicon.ico">
```

Only files inside the `public` folder will be accessible by `%PUBLIC_URL%` prefix. If you need to use a file from `src` or `node_modules`, you’ll have to copy it there to explicitly specify your intention to make this file a part of the build.

只有`public`文件夹中的文件才能被％PUBLIC_URL％前缀访问。如果您需要使用`src`或`node_modules`中的文件，那么您必须将其复制到其中才能明确指定您将该文件作为构建的一部分。

When you run `npm run build`, Create React App will substitute `%PUBLIC_URL%` with a correct absolute path so your project works even if you use client-side routing or host it at a non-root URL.

当你运行 `npm run build`时，Create React App将使用正确的绝对路径替换％PUBLIC_URL％，这样即使您使用客户端路由或将其托管在非根URL，您的项目也可以工作。

In JavaScript code, you can use `process.env.PUBLIC_URL` for similar purposes:

在JavaScript代码中，您可以使用process.env.PUBLIC_URL进行类似的操作：

```js
render() {
  // Note: this is an escape hatch and should be used sparingly!
  // Normally we recommend using `import` for getting asset URLs
  // as described in “Adding Images and Fonts” above this section.
  
  // 注意：这是一个逃生舱口，应该谨慎使用！
  // 通常，我们建议使用`import`获取资源URL
  // 如本节上面的“添加图像和字体”中所述。
  return <img src={process.env.PUBLIC_URL + '/img/logo.png'} />;
}
```

Keep in mind the downsides of this approach:

记住这种方法的缺点：

* None of the files in `public` folder get post-processed or minified.
* `public` 文件夹中的任何文件都不能进行后处理或缩小。
* Missing files will not be called at compilation time, and will cause 404 errors for your users.
* 在编译时不会调用缺少的文件，并会为您的用户造成404错误。
* Result filenames won’t include content hashes so you’ll need to add query arguments or rename them every time they change.
* 结果文件名不会包含内容散列，因此您需要添加查询参数或每次更改时重命名它们。

### When to Use the `public` Folder

### 何时使用`public`文件夹

Normally we recommend importing [stylesheets](#adding-a-stylesheet), [images, and fonts](#adding-images-fonts-and-files) from JavaScript.
The `public` folder is useful as a workaround for a number of less common cases:

通常我们建议从JavaScript导入[样式表](#adding-a-stylesheet)，[图像和字体](#adding-images-fonts-and-files)。

`public` 文件夹作为一些不太常见情况的解决方法是有用的：

* You need a file with a specific name in the build output, such as [`manifest.webmanifest`](https://developer.mozilla.org/en-US/docs/Web/Manifest).
* 您需要在构建输出中具有特定名称的文件，如 [manifest.webmanifest](https://developer.mozilla.org/en-US/docs/Web/Manifest).
* You have thousands of images and need to dynamically reference their paths.
* 您有成千上万的图像，需要动态引用他们的路径。
* You want to include a small script like [`pace.js`](http://github.hubspot.com/pace/docs/welcome/) outside of the bundled code.
* 您希望在捆绑代码之外加入一个像 [`pace.js`](http://github.hubspot.com/pace/docs/welcome/) 一样的脚本。
* Some library may be incompatible with Webpack and you have no other option but to include it as a `<script>` tag.
* 某些库可能与Webpack不兼容，您没有其他选项，但将其作为`<script>`标签。

Note that if you add a `<script>` that declares global variables, you also need to read the next section on using them.

请注意，如果添加声明全局变量的`<script>`，则还需要阅读下一节如何使用它们。

## Using Global Variables

### 使用全局变量

When you include a script in the HTML file that defines global variables and try to use one of these variables in the code, the linter will complain because it cannot see the definition of the variable.

当您在定义全局变量的HTML文件中包含一个脚本并尝试在代码中使用这些变量之一时，linter会抱怨，因为它看不到变量的定义。

You can avoid this by reading the global variable explicitly from the `window` object, for example:

您可以通过从 `window` 对象显式读取全局变量来避免这种情况，例如：

```js
const $ = window.$;
```

This makes it obvious you are using a global variable intentionally rather than because of a typo.

这显然你有意使用全局变量，而不是因为打字错误。

Alternatively, you can force the linter to ignore any line by adding `// eslint-disable-line` after it.

或者，您可以通过在其后添加// eslint-disable-line来强制linter忽略任何行。

## Adding Bootstrap

### 添加Bootstrap库

You don’t have to use [React Bootstrap](https://react-bootstrap.github.io) together with React but it is a popular library for integrating Bootstrap with React apps. If you need it, you can integrate it with Create React App by following these steps:

您不必与React一起使用[React Bootstrap](https://react-bootstrap.github.io)，但它是将Bootstrap与React应用程序集成的流行库。如果需要，可以通过以下步骤将其与创建应用程序集成：

Install React Bootstrap and Bootstrap from npm. React Bootstrap does not include Bootstrap CSS so this needs to be installed as well:

从npm库中安装React Bootstrap和Bootstrap。React Bootstrap不包括Bootstrap CSS，因此还需要安装它们：

```
npm install react-bootstrap --save
npm install bootstrap@3 --save
```

Import Bootstrap CSS and optionally Bootstrap theme CSS in the beginning of your ```src/index.js``` file:

在 ```src/index.js``` 文件的开头导入Bootstrap CSS和可选的Bootstrap主题CSS：

```js
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap/dist/css/bootstrap-theme.css';
// Put any other imports below so that CSS from your components takes precedence over default styles.
// 在下面放置任何其他导入，以使您的组件中的CSS优先于默认样式。
```

Import required React Bootstrap components within ```src/App.js``` file or your custom component files:

在 ```src/App.js``` 文件或您的自定义组件文件中导入所需的React Bootstrap组件：

```js
import { Navbar, Jumbotron, Button } from 'react-bootstrap';
```

Now you are ready to use the imported React Bootstrap components within your component hierarchy defined in the render method. Here is an example [`App.js`](https://gist.githubusercontent.com/gaearon/85d8c067f6af1e56277c82d19fd4da7b/raw/6158dd991b67284e9fc8d70b9d973efe87659d72/App.js) redone using React Bootstrap.

现在，您可以使用导入的React Bootstrap组件在render方法中定义组件层次结构。以下是使用React Bootstrap重做[App.js](https://gist.githubusercontent.com/gaearon/85d8c067f6af1e56277c82d19fd4da7b/raw/6158dd991b67284e9fc8d70b9d973efe87659d72/App.js)的示例。

### Using a Custom Theme

### 使用自定义主题

Sometimes you might need to tweak the visual styles of Bootstrap (or equivalent package).<br>
We suggest the following approach:

有时您可能需要调整Bootstrap（或等效包）的视觉样式.<br>

我们建议采纳以下方法：

* Create a new package that depends on the package you wish to customize, e.g. Bootstrap.
* 创建一个取决于您要自定义的包的新包, e.g. Bootstrap.
* Add the necessary build steps to tweak the theme, and publish your package on npm.
* 添加必要的构建步骤来调整主题，并在npm发布您的包。
* Install your own theme npm package as a dependency of your app.
* 安装您自己的主题npm软件包作为您的应用程序的依赖。

Here is an example of adding a [customized Bootstrap](https://medium.com/@tacomanator/customizing-create-react-app-aa9ffb88165) that follows these steps.

以下是添加按照这些步骤进行[自定义的Bootstrap](https://medium.com/@tacomanator/customizing-create-react-app-aa9ffb88165)的示例。

## Adding Flow

### 添加流

Flow is a static type checker that helps you write code with fewer bugs. Check out this [introduction to using static types in JavaScript](https://medium.com/@preethikasireddy/why-use-static-types-in-javascript-part-1-8382da1e0adb) if you are new to this concept.

Flow是一种静态类型的检查器，可以帮助您编写更少错误的代码。如果您是这个概念的新手，请参阅[JavaScript中使用静态类型的介绍](https://medium.com/@preethikasireddy/why-use-static-types-in-javascript-part-1-8382da1e0adb) 。

Recent versions of [Flow](http://flowtype.org/) work with Create React App projects out of the box.

Flow的最新版本可以使用“Create React App”工具的开箱即用功能。

To add Flow to a Create React App project, follow these steps:

要将Flow添加到使用Create React App工具创建的项目中，请按照下列步骤操作：

1. Run `npm install --save-dev flow-bin` (or `yarn add --dev flow-bin`).

2. Add `"flow": "flow"` to the `scripts` section of your `package.json`.

3. Run `npm run flow -- init` (or `yarn flow -- init`) to create a [`.flowconfig` file](https://flowtype.org/docs/advanced-configuration.html) in the root directory.

4. Add `// @flow` to any files you want to type check (for example, to `src/App.js`).

   ​

5. 运行 `npm install --save-dev flow-bin` (或 `yarn add --dev flow-bin`)。
6. 将 `"flow": "flow"` 添加到您的`package.json`的 `scripts` 部分。
7. 运行 `npm run flow -- init` (或 `yarn flow -- init`)以在根目录中创建一个`.flowconfig`文件。
8. 将 `// @flow` 添加到要进行类型检查的任何文件中（例如，到`src/App.js`）。

Now you can run `npm run flow` (or `yarn flow`) to check the files for type errors. You can optionally use an IDE like [Nuclide](https://nuclide.io/docs/languages/flow/) for a better integrated experience. In the future we plan to integrate it into Create React App even more closely.

现在，您可以运行 `npm run flow` (或 `yarn flow`) 来检查文件的类型错误。您可以选择使用像[Nuclide](https://nuclide.io/docs/languages/flow/) 这样的IDE来获得更好的集成体验。在将来，我们计划更加紧密地将其整合到Create React App工具中。

To learn more about Flow, check out [its documentation](https://flowtype.org/).

要了解有关Flow的更多信息，请查看其[文档](https://flowtype.org/)。

## Adding Custom Environment Variables

### 添加自定义环境变量

>Note: this feature is available with `react-scripts@0.2.3` and higher.
>
>注意：此功能可用在`react-scripts@0.2.3`及更高版本。

Your project can consume variables declared in your environment as if they were declared locally in your JS files. By default you will have `NODE_ENV` defined for you, and any other environment variables starting with
`REACT_APP_`.

您的项目可以在您的环境中使用声明的变量，就像它们在JS文件中本地声明一样。默认情况下，您将为您定义`NODE_ENV`，以及以`REACT_APP_`开头的任何其他环境变量。

**The environment variables are embedded during the build time**. Since Create React App produces a static HTML/CSS/JS bundle, it can’t possibly read them at runtime. To read them at runtime, you would need to load HTML into memory on the server and replace placeholders in runtime, just like [described here](#injecting-data-from-the-server-into-the-page). Alternatively you can rebuild the app on the server anytime you change them.

**环境变量在构建时嵌入。**由于Create React App生成了一个静态的HTML/CSS/JS包，所以在运行时无法读取它们。要在运行时读取它们，您需要将HTML加载到服务器上的内存中，并在运行时替换占位符，就像[这里所述](#injecting-data-from-the-server-into-the-page)。或者，您可以在更改服务器时重新构建应用程序。

>Note: You must create custom environment variables beginning with `REACT_APP_`. Any other variables except `NODE_ENV` will be ignored to avoid accidentally [exposing a private key on the machine that could have the same name](https://github.com/facebookincubator/create-react-app/issues/865#issuecomment-252199527). Changing any environment variables will require you to restart the development server if it is running.
>
>注意：您必须创建以`REACT_APP_`开头的自定义环境变量。除了`NODE_ENV`之外的任何其他变量将被忽略，以[避免意外暴露可能具有相同名称的机器上的私钥](https://github.com/facebookincubator/create-react-app/issues/865#issuecomment-252199527)。更改任何环境变量将需要重新启动开发服务器，如果它正在运行。

These environment variables will be defined for you on `process.env`. For example, having an environment
variable named `REACT_APP_SECRET_CODE` will be exposed in your JS as `process.env.REACT_APP_SECRET_CODE`.

这些环境变量将在`process.env`上为您定义。例如，将一个名为`REACT_APP_SECRET_CODE`的环境变量作为`process.env.REACT_APP_SECRET_CODE`暴露在您的JS中。

There is also a special built-in environment variable called `NODE_ENV`. You can read it from `process.env.NODE_ENV`. When you run `npm start`, it is always equal to `'development'`, when you run `npm test` it is always equal to `'test'`, and when you run `npm run build` to make a production bundle, it is always equal to `'production'`. **You cannot override `NODE_ENV` manually.** This prevents developers from accidentally deploying a slow development build to production.

还有一个特殊的内置环境变量`NODE_ENV`。你可以从`process.env.NODE_ENV`读取它。当你运行`npm start`时，它总是等于`development`，当你运行`npm test`它总是等于`test`，当你运行 `npm run build` 来生成一个生产包，它总是等于`production` 。**您不能手动覆盖NODE_ENV。**这样可以防止开发人员意外地将缓慢的开发构建部署到生产环境中。

These environment variables can be useful for displaying information conditionally based on where the project is deployed or consuming sensitive data that lives outside of version control.

这些环境变量对于有条件地显示信息[可能会有助于基于项目的部署位置或消费存在于版本控制之外的敏感数据]。

First, you need to have environment variables defined. For example, let’s say you wanted to consume a secret defined in the environment inside a `<form>`:

首先，您需要定义环境变量。例如，假设您想要使用`<form>`中的环境中定义的秘钥：

```jsx
render() {
  return (
    <div>
      <small>You are running this application in <b>{process.env.NODE_ENV}</b> mode.</small>
      <form>
        <input type="hidden" defaultValue={process.env.REACT_APP_SECRET_CODE} />
      </form>
    </div>
  );
}
```

During the build, `process.env.REACT_APP_SECRET_CODE` will be replaced with the current value of the `REACT_APP_SECRET_CODE` environment variable. Remember that the `NODE_ENV` variable will be set for you automatically.

在构建期间，`process.env.REACT_APP_SECRET_CODE`将被`REACT_APP_SECRET_CODE`环境变量的当前值替换。请记住，`NODE_ENV`变量将自动为您设置。

When you load the app in the browser and inspect the `<input>`, you will see its value set to `abcdef`, and the bold text will show the environment provided when using `npm start`:

当您在浏览器中加载应用程序并检查`<input>`时，您将看到其值设置为`abcdef`，粗体文本将显示使用 `npm start`时提供的环境：

```html
<div>
  <small>You are running this application in <b>development</b> mode.</small>
  <form>
    <input type="hidden" value="abcdef" />
  </form>
</div>
```

The above form is looking for a variable called `REACT_APP_SECRET_CODE` from the environment. In order to consume this value, we need to have it defined in the environment. This can be done using two ways: either in your shell or in a `.env` file. Both of these ways are described in the next few sections.

上面的表单正在从环境中寻找一个名为`REACT_APP_SECRET_CODE`的变量。为了消耗这个值，我们需要在环境中定义它。这可以通过两种方式完成：在`shell`或`.env`文件中。这两种方法将在接下来的几节中进行描述。

Having access to the `NODE_ENV` is also useful for performing actions conditionally:

访问`NODE_ENV`对于有条件地执行操作也很有用：

```js
if (process.env.NODE_ENV !== 'production') {
  analytics.disable();
}
```

When you compile the app with `npm run build`, the minification step will strip out this condition, and the resulting bundle will be smaller.

当您使用 `npm run build`编译应用程序时，缩小步骤将剥离此条件，并且生成的包将更小。

### Referencing Environment Variables in the HTML

### 引用HTML中的环境变量

>Note: this feature is available with `react-scripts@0.9.0` and higher.
>
>注意：此功能可用在`react-scripts@0.9.0`及更高版本。

You can also access the environment variables starting with `REACT_APP_` in the `public/index.html`. For example:

您还可以访问 `public/index.html`中的`REACT_APP_`开头的环境变量。例如：

```html
<title>%REACT_APP_WEBSITE_NAME%</title>
```

Note that the caveats from the above section apply:

请注意，上述部分的注意事项适用于：

* Apart from a few built-in variables (`NODE_ENV` and `PUBLIC_URL`), variable names must start with `REACT_APP_` to work.
* 除了几个内置变量(`NODE_ENV` 和 `PUBLIC_URL`)，变量名必须以REACT_APP_开头。
* The environment variables are injected at build time. If you need to inject them at runtime, [follow this approach instead](#generating-dynamic-meta-tags-on-the-server).
* 环境变量在构建时注入。如果您需要在运行时注入它们，[请按照此方法](#generating-dynamic-meta-tags-on-the-server)。

### Adding Temporary Environment Variables In Your Shell

### 在Shell中添加临时环境变量

Defining environment variables can vary between OSes. It’s also important to know that this manner is temporary for the life of the shell session.

定义环境变量会根据操作系统而定。知道这种方式对于shell会话的生命是暂时的也很重要。

#### Windows (cmd.exe)

```cmd
set REACT_APP_SECRET_CODE=abcdef&&npm start
```

(Note: the lack of whitespace is intentional.)(注意：缺乏空白是有意的。)

#### Linux, macOS (Bash)

```bash
REACT_APP_SECRET_CODE=abcdef npm start
```

### Adding Development Environment Variables In `.env`

### 在`.env`添加开发环境变量

>Note: this feature is available with `react-scripts@0.5.0` and higher.
>
>注意：此功能可用在react-scripts@0.5.0及更高版本。

To define permanent environment variables, create a file called `.env` in the root of your project:

要定义永久环境变量，请在项目的根目录中创建一个名为`.env`的文件：

```
REACT_APP_SECRET_CODE=abcdef
```

`.env` files **should be** checked into source control (with the exclusion of `.env*.local`).

#### What other `.env` files are can be used?

### 还可以使用什么其他`.env`文件？

>Note: this feature is **available with `react-scripts@1.0.0` and higher**.
>
>注意：此功能可用在react-scripts@1.0.0及更高版本。

* `.env`: Default.
* `.env`: 默认.
* `.env.local`: Local overrides. **This file is loaded for all environments except test.**
* `.env.local`: 本地覆盖。**该文件加载除了测试之外的所有环境**.
* `.env.development`, `.env.test`, `.env.production`: Environment-specific settings.
* `.env.development`, `.env.test`, `.env.production`: 环境特定设.
* `.env.development.local`, `.env.test.local`, `.env.production.local`: Local overrides of environment-specific settings.
* `.env.development.local`, `.env.test.local`, `.env.production.local`: 本地覆盖环境特定的设置.

Files on the left have more priority than files on the right:

左边的文件比右边的文件更优先：

* `npm start`: `.env.development.local`, `.env.development`, `.env.local`, `.env`
* `npm run build`: `.env.production.local`, `.env.production`, `.env.local`, `.env`
* `npm test`: `.env.test.local`, `.env.test`, `.env` (note `.env.local` is missing。缺少 `.env.local` )

These variables will act as the defaults if the machine does not explicitly set them.<br>
Please refer to the [dotenv documentation](https://github.com/motdotla/dotenv) for more details.

如果机器没有明确设置它们，这些变量将作为默认值.<br>

有关详细信息，请参阅[dotenv文档](https://github.com/motdotla/dotenv)。

>Note: If you are defining environment variables for development, your CI and/or hosting platform will most likely need
>these defined as well. Consult their documentation how to do this. For example, see the documentation for [Travis CI](https://docs.travis-ci.com/user/environment-variables/) or [Heroku](https://devcenter.heroku.com/articles/config-vars).
>
>注意：如果要定义用于开发的环境变量，则您的CI and/or 托管平台最有可能需要这些定义。请咨询他们的文档如何做到这一点。例如，请参阅 [Travis CI](https://docs.travis-ci.com/user/environment-variables/) 或 [Heroku](https://devcenter.heroku.com/articles/config-vars)的文档。

## Can I Use Decorators?

### 我可以使用装饰器吗？

Many popular libraries use [decorators](https://medium.com/google-developers/exploring-es7-decorators-76ecb65fb841) in their documentation.<br>
Create React App doesn’t support decorator syntax at the moment because:

许多受欢迎的库在其文档中使用[装饰器](https://medium.com/google-developers/exploring-es7-decorators-76ecb65fb841)。

Create React App目前不支持装饰器语法，因为：

* It is an experimental proposal and is subject to change.
* 这是一个实验性提案，可能会改变。
* The current specification version is not officially supported by Babel.
* 目前的规范版本没有被Babel正式支持。
* If the specification changes, we won’t be able to write a codemod because we don’t use them internally at Facebook.
* 如果规范发生变化，我们将无法编写一个codemod，因为我们不在Facebook内部使用它们。

However in many cases you can rewrite decorator-based code without decorators just as fine.<br>
Please refer to these two threads for reference:

但是，在许多情况下，您可以重新编写基于装饰器的代码，而不需要装饰器就可以了.<br>

请参考这两个线程以供参考：

* [#214](https://github.com/facebookincubator/create-react-app/issues/214)
* [#411](https://github.com/facebookincubator/create-react-app/issues/411)

Create React App will add decorator support when the specification advances to a stable stage.

当规范进展到稳定的阶段时，Create React App将添加装饰器支持。

## Integrating with an API Backend

### 与后端API集成

These tutorials will help you to integrate your app with an API backend running on another port, using `fetch()` to access it.

这些教程将帮助您将应用程序与在另一个端口上运行的API后端集成，使用`fetch()` 来访问它。

### Node
Check out [this tutorial](https://www.fullstackreact.com/articles/using-create-react-app-with-a-server/). You can find the companion GitHub repository [here](https://github.com/fullstackreact/food-lookup-demo).

看看[这个教程](https://www.fullstackreact.com/articles/using-create-react-app-with-a-server/)。您可以在[这里](https://github.com/fullstackreact/food-lookup-demo)找到配套的GitHub库。

### Ruby on Rails

Check out [this tutorial](https://www.fullstackreact.com/articles/how-to-get-create-react-app-to-work-with-your-rails-api/).You can find the companion GitHub repository [here](https://github.com/fullstackreact/food-lookup-demo-rails).

看看[这个教程](https://www.fullstackreact.com/articles/how-to-get-create-react-app-to-work-with-your-rails-api/)。您可以在[这里](https://github.com/fullstackreact/food-lookup-demo-rails)找到配套的GitHub库。

## Proxying API Requests in Development

### 在开发中代理API请求

>Note: this feature is available with `react-scripts@0.2.3` and higher.
>
>注意：此功能可用在react-scripts@0.2.3及更高版本。

People often serve the front-end React app from the same host and port as their backend implementation.<br>
For example, a production setup might look like this after the app is deployed:

人们经常从后端实施相同的主机和端口为前端的React应用程序提供服务.<br>

例如，应用程序部署后，生产设置可能会如下所示：

```
/             - static server returns index.html with React app
/todos        - static server returns index.html with React app
/api/todos    - server handles any /api/* requests using the backend implementation
```

Such setup is **not** required. However, if you **do** have a setup like this, it is convenient to write requests like `fetch('/api/todos')` without worrying about redirecting them to another host or port during development.

不需要这样的设置。但是，如果您有这样的设置，可以方便地编写`fetch('/api/todos')` 等请求，而不用担心在开发过程中将它们重定向到另一个主机或端口。

To tell the development server to proxy any unknown requests to your API server in development, add a `proxy` field to your `package.json`, for example:

在开发中,要告诉开发服务器代理对您的API服务器的任何未知请求，请向您的`package.json`添加一个`proxy`字段，例如：

```js
  "proxy": "http://localhost:4000",
```

This way, when you `fetch('/api/todos')` in development, the development server will recognize that it’s not a static asset, and will proxy your request to `http://localhost:4000/api/todos` as a fallback. The development server will only attempt to send requests without a `text/html` accept header to the proxy.

这样，当您在开发中`fetch('/api/todos')` 时，开发服务器将会认识到它不是静态资源，并将代理您的请求到`http://localhost:4000/api/todos` 作为回调。开发服务器将只尝试发送没有 `text/html` 接收标头的请求到代理端口。

Conveniently, this avoids [CORS issues](http://stackoverflow.com/questions/21854516/understanding-ajax-cors-and-security-considerations) and error messages like this in development:

这样可以方便地避免在开发过程中发生[CORS issues](http://stackoverflow.com/questions/21854516/understanding-ajax-cors-and-security-considerations)和错误消息：

```
Fetch API cannot load http://localhost:4000/api/todos. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://localhost:3000' is therefore not allowed access. If an opaque response serves your needs, set the request's mode to 'no-cors' to fetch the resource with CORS disabled.
```

Keep in mind that `proxy` only has effect in development (with `npm start`), and it is up to you to ensure that URLs like `/api/todos` point to the right thing in production. You don’t have to use the `/api` prefix. Any unrecognized request without a `text/html` accept header will be redirected to the specified `proxy`.

请记住，代理仅在开发中有效 (使用 `npm start`)，并且由您来确保像 `/api/todos` 这样的URL指向生产中的正确的东西。您不必使用 `/api` 前缀。任何无法识别的没有 `text/html` 接收标头的请求，将被重定向到指定的 `proxy`.

The `proxy` option supports HTTP, HTTPS and WebSocket connections.<br>
If the `proxy` option is **not** flexible enough for you, alternatively you can:

 `proxy` 选项支持HTTP，HTTPS和WebSocket连接.<br>

如果 `proxy` 选项对您不够灵活，或者您可以：

* [Configure the proxy yourself](#configuring-the-proxy-manually)
* [自己配置代理](#configuring-the-proxy-manually)
* Enable CORS on your server ([here’s how to do it for Express](http://enable-cors.org/server_expressjs.html)).
* 在您的服务器上启用CORS（[以下是Express的操作方法](http://enable-cors.org/server_expressjs.html)）。
* Use [environment variables](#adding-custom-environment-variables) to inject the right server host and port into your app.
* 使用[环境变量](#adding-custom-environment-variables) 将正确的服务器主机和端口注入到应用程序中。

### "Invalid Host Header" Errors After Configuring Proxy

### 配置代理后的“主机头无效”错误

When you enable the `proxy` option, you opt into a more strict set of host checks. This is necessary because leaving the backend open to remote hosts makes your computer vulnerable to DNS rebinding attacks. The issue is explained in [this article](https://medium.com/webpack/webpack-dev-server-middleware-security-issues-1489d950874a) and [this issue](https://github.com/webpack/webpack-dev-server/issues/887).

启用代理选项后，您可以选择更严格的主机检查。这是必要的，因为将后端打开到远程主机会使您的计算机容易受到DNS重新绑定攻击。此问题在[这篇文章](https://medium.com/webpack/webpack-dev-server-middleware-security-issues-1489d950874a)和[这个问题](https://github.com/webpack/webpack-dev-server/issues/887)进行了解释。

This shouldn’t affect you when developing on `localhost`, but if you develop remotely like [described here](https://github.com/facebookincubator/create-react-app/issues/2271), you will see this error in the browser after enabling the `proxy` option:

这应该不影响你在本地主机上开发，但是如果你像[这里描述](https://github.com/facebookincubator/create-react-app/issues/2271)的那样进行远程开发，启用代理选项后，您将在浏览器中看到此错误：

>Invalid Host header
>
>主机头无效

To work around it, you can specify your public development host in a file called `.env.development` in the root of your project:

要解决它，您可以在项目根目录中的一个名为`.env.development`的文件中指定您的公共开发主机：

```
HOST=mypublicdevhost.com
```

If you restart the development server now and load the app from the specified host, it should work.

如果现在重新启动开发服务器并从指定的主机加载该应用程序，它应该会正常工作。

If you are still having issues or if you’re using a more exotic environment like a cloud editor, you can bypass the host check completely by adding a line to `.env.development.local`. **Note that this is dangerous and exposes your machine to remote code execution from malicious websites:**

如果您仍然遇到问题，或者如果您正在使用更加异域情调的环境，如云编辑器，您可以通过向`.env.development.local`添加一行来完全绕过主机检查。

```
# NOTE: THIS IS DANGEROUS! 注意：这是危险的！
# It exposes your machine to attacks from the websites you visit.
# 它暴露您的机器将会导致您访问的的网站被攻击。
DANGEROUSLY_DISABLE_HOST_CHECK=true
```

We don’t recommend this approach.

我们不推荐这种方法。

### Configuring the Proxy Manually

### 手动配置代理

>Note: this feature is available with `react-scripts@1.0.0` and higher.
>
>注意：此功能可用在react-scripts@1.0.0及更高版本。

If the `proxy` option is **not** flexible enough for you, you can specify an object in the following form (in `package.json`).<br>
You may also specify any configuration value [`http-proxy-middleware`](https://github.com/chimurai/http-proxy-middleware#options) or [`http-proxy`](https://github.com/nodejitsu/node-http-proxy#options) supports.

如果代理选项对您不够灵活，您可以使用以下格式指定一个对象（在`package.json`中）。

您还可以指定任何配置值 [`http-proxy-middleware`](https://github.com/chimurai/http-proxy-middleware#options) 或 [`http-proxy`](https://github.com/nodejitsu/node-http-proxy#options) 支持。

```js
{
  // ...
  "proxy": {
    "/api": {
      "target": "<url>",
      "ws": true
      // ...
    }
  }
  // ...
}
```

All requests matching this path will be proxies, no exceptions. This includes requests for `text/html`, which the standard `proxy` option does not proxy.

与此路径匹配的所有请求都将是代理，没有例外。这包括 `text/html`的请求，标准代理选项不代理。

If you need to specify multiple proxies, you may do so by specifying additional entries. You may also narrow down matches using `*` and/or `**`, to match the path exactly or any subpath.

如果需要指定多个代理，则可以通过指定其他条目来实现。您还可以使用 `*` 和/或 `**`缩小匹配，以准确匹配路径或任何子路径。

```js
{
  // ...
  "proxy": {
    // Matches any request starting with /api
    "/api": {
      "target": "<url_1>",
      "ws": true
      // ...
    },
    // Matches any request starting with /foo
    "/foo": {
      "target": "<url_2>",
      "ssl": true,
      "pathRewrite": {
        "^/foo": "/foo/beta"
      }
      // ...
    },
    // Matches /bar/abc.html but not /bar/sub/def.html
    "/bar/*.html": {
      "target": "<url_3>",
      // ...
    },
    // Matches /bar/abc.html and /bar/sub/def.html
    "/baz/**/*.html": {
      "target": "<url_4>"
      // ...
    }
  }
  // ...
}
```

## Using HTTPS in Development

### 在开发中使用HTTPS

>Note: this feature is available with `react-scripts@0.4.0` and higher.
>
>注意：此功能可用在react-scripts@0.4.0及更高版本。

You may require the dev server to serve pages over HTTPS. One particular case where this could be useful is when using [the "proxy" feature](#proxying-api-requests-in-development) to proxy requests to an API server when that API server is itself serving HTTPS.

To do this, set the `HTTPS` environment variable to `true`, then start the dev server as usual with `npm start`:

您可能需要开发服务器提供HTTPS页面服务。一个特别的情况可能是有用的，当API服务器本身服务于HTTPS时，[使用“代理”功能](#proxying-api-requests-in-development)来代理对API服务器的请求。

为此，请将`HTTPS`环境变量设置为`true`，然后像以往那样以`npm start`启动开发服务器：

#### Windows (cmd.exe)

```cmd
set HTTPS=true&&npm start
```

(Note: the lack of whitespace is intentional.注意：缺乏空白是有意的。)

#### Linux, macOS (Bash)

```bash
HTTPS=true npm start
```

Note that the server will use a self-signed certificate, so your web browser will almost definitely display a warning upon accessing the page.

请注意，服务器将使用自签名证书，因此您的Web浏览器几乎肯定会在访问页面时显示警告。

## Generating Dynamic `<meta>` Tags on the Server

### 在服务器上生成动态`<meta>`标签

Since Create React App doesn’t support server rendering, you might be wondering how to make `<meta>` tags dynamic and reflect the current URL. To solve this, we recommend to add placeholders into the HTML, like this:

由于Create React App不支持服务器渲染，您可能会想知道如何使`<meta>`标签动态化并反映当前的URL。为了解决这个问题，我们建议在HTML中添加占位符，如下所示：

```html
<!doctype html>
<html lang="en">
  <head>
    <meta property="og:title" content="__OG_TITLE__">
    <meta property="og:description" content="__OG_DESCRIPTION__">
```

Then, on the server, regardless of the backend you use, you can read `index.html` into memory and replace `__OG_TITLE__`, `__OG_DESCRIPTION__`, and any other placeholders with values depending on the current URL. Just make sure to sanitize and escape the interpolated values so that they are safe to embed into HTML!

然后，在服务器上，无论您使用的后端如何，您可以将`index.html`读入内存，并根据当前URL替换`__OG_TITLE__`，`__OG_DESCRIPTION__`和任何其他具有值的占位符。只需确保清理和转义内插的值，以便它们可以安全地嵌入到HTML中！

If you use a Node server, you can even share the route matching logic between the client and the server. However duplicating it also works fine in simple cases.

如果使用节点服务器，您甚至可以在客户端和服务器之间共享路由匹配逻辑。但是在简单的情况下，复制它也可以正常工作。

## Pre-Rendering into Static HTML Files

### **预渲染成静态HTML文件**

If you’re hosting your `build` with a static hosting provider you can use [react-snapshot](https://www.npmjs.com/package/react-snapshot) to generate HTML pages for each route, or relative link, in your application. These pages will then seamlessly become active, or “hydrated”, when the JavaScript bundle has loaded.

如果您使用静态主机提供商托管您的构建程序，则可以使用[react-snapshot](https://www.npmjs.com/package/react-snapshot)为应用程序中的每个路由或相对链接生成HTML页面。然后，这些页面将在JavaScript软件包加载时无缝地变为活动状态或“水合”。

There are also opportunities to use this outside of static hosting, to take the pressure off the server when generating and caching routes.

还有机会在静态托管之外使用它，在生成和缓存路由时将压力从服务器上取下。

The primary benefit of pre-rendering is that you get the core content of each page _with_ the HTML payload—regardless of whether or not your JavaScript bundle successfully downloads. It also increases the likelihood that each route of your application will be picked up by search engines.

预渲染的主要优点是您可以使用HTML有效内容获取每个页面的核心内容，而不管您的JavaScript软件包是否成功下载。这也增加了您的应用程序的每个路由将被搜索引擎拾取的可能性。

You can read more about [zero-configuration pre-rendering (also called snapshotting) here](https://medium.com/superhighfives/an-almost-static-stack-6df0a2791319).

您可以在这里阅读有关[零配置预渲染的更多信息（也称为快照）](https://medium.com/superhighfives/an-almost-static-stack-6df0a2791319)。

## Injecting Data from the Server into the Page

### 将数据从服务器注入页面

Similarly to the previous section, you can leave some placeholders in the HTML that inject global variables, for example:

与上一节类似，您可以在注入全局变量的HTML中留下一些占位符，例如：

```js
<!doctype html>
<html lang="en">
  <head>
    <script>
      window.SERVER_DATA = __SERVER_DATA__;
    </script>
```

Then, on the server, you can replace `__SERVER_DATA__` with a JSON of real data right before sending the response. The client code can then read `window.SERVER_DATA` to use it. **Make sure to [sanitize the JSON before sending it to the client](https://medium.com/node-security/the-most-common-xss-vulnerability-in-react-js-applications-2bdffbcc1fa0) as it makes your app vulnerable to XSS attacks.**

然后，在服务器上，您可以在发送响应之前将`__SERVER_DATA__`替换为真实数据的JSON。客户端代码可以读取`window.SERVER_DATA`来使用它。**确保在将[JSON发送到客户端之前进行清理](https://medium.com/node-security/the-most-common-xss-vulnerability-in-react-js-applications-2bdffbcc1fa0) ，因为它使您的应用程序易受XSS攻击。**

## Running Tests

### 运行测试

>Note: this feature is available with `react-scripts@0.3.0` and higher.<br>
>[Read the migration guide to learn how to enable it in older projects!](https://github.com/facebookincubator/create-react-app/blob/master/CHANGELOG.md#migrating-from-023-to-030)
>
>注意：此功能可用在react-scripts@0.3.0及更高版本。
>
>[阅读迁移指南，了解如何在旧项目中启用它！](https://github.com/facebookincubator/create-react-app/blob/master/CHANGELOG.md#migrating-from-023-to-030)

Create React App uses [Jest](https://facebook.github.io/jest/) as its test runner. To prepare for this integration, we did a [major revamp](https://facebook.github.io/jest/blog/2016/09/01/jest-15.html) of Jest so if you heard bad things about it years ago, give it another try.

Create React App使用[Jest](https://facebook.github.io/jest/)作为其测试运行器。为了做好这个整合的准备，我们做了一个[重大改革](https://facebook.github.io/jest/blog/2016/09/01/jest-15.html)的Jest，所以如果你听到很多年前的坏事，再试一次。

Jest is a Node-based runner. This means that the tests always run in a Node environment and not in a real browser. This lets us enable fast iteration speed and prevent flakiness.

Jest是一个基于Node的运行器。这意味着测试总是在Node环境中运行，而不是在真实的浏览器中运行。这使我们能够实现加快迭代速度并防止碎片化。

While Jest provides browser globals such as `window` thanks to [jsdom](https://github.com/tmpvar/jsdom), they are only approximations of the real browser behavior. Jest is intended to be used for unit tests of your logic and your components rather than the DOM quirks.

虽然Jest提供浏览器全局变量，如 `window` 感谢 [jsdom](https://github.com/tmpvar/jsdom)，但它们只是和真正的浏览器的行为相似。 Jest旨在用于您的逻辑和组件的单元测试，而不是DOM的差异。

We recommend that you use a separate tool for browser end-to-end tests if you need them. They are beyond the scope of Create React App.

如果需要，我们建议您使用单独的浏览器端到端测试工具。它们超出了Create React App的范围。

### Filename Conventions

### 文件名约定

Jest will look for test files with any of the following popular naming conventions:

Jest将使用以下任何常见的命名规则来查找测试文件：

* Files with `.js` suffix in `__tests__` folders. `__tests__`文件夹中带有`.js`后缀的文件。
* Files with `.test.js` suffix. 带有`.test.js`后缀的文件。
* Files with `.spec.js` suffix. 带有`.spec.js`后缀的文件。

The `.test.js` / `.spec.js` files (or the `__tests__` folders) can be located at any depth under the `src` top level folder.

 `.test.js` / `.spec.js` 文件（或`__tests__`文件夹）可以位于`src`顶级文件夹下的任意深度。

We recommend to put the test files (or `__tests__` folders) next to the code they are testing so that relative imports appear shorter. For example, if `App.test.js` and `App.js` are in the same folder, the test just needs to `import App from './App'` instead of a long relative path. Colocation also helps find tests more quickly in larger projects.

我们建议将测试文件（或`__tests__`文件夹）放在正在测试的代码旁边，以使相对导入更短。例如，如果`App.test.js`和`App.js`在同一个文件夹中，测试只需要 `import App from './App'` ，而不是长的相对路径。这样还有助于在更大的项目中更快地找到测试。

### Command Line Interface

### 命令行界面

When you run `npm test`, Jest will launch in the watch mode. Every time you save a file, it will re-run the tests, just like `npm start` recompiles the code.

当您运行`npm test`时，Jest将以观察模式启动。每次保存文件时，都会重新运行测试，就像 `npm start` 重新编译代码一样。

The watcher includes an interactive command-line interface with the ability to run all tests, or focus on a search pattern. It is designed this way so that you can keep it open and enjoy fast re-runs. You can learn the commands from the “Watch Usage” note that the watcher prints after every run:

观察者包括交互式命令行界面，具有运行所有测试的能力，或专注于搜索模式。它是这样设计的，以便您可以保持打开并享受快速重新运行。您可以从“观察使用情况”注意中了解每次运行后观察者打印的命令：

![Jest watch mode](http://facebook.github.io/jest/img/blog/15-watch.gif)

### Version Control Integration

### 版本控制集成

By default, when you run `npm test`, Jest will only run the tests related to files changed since the last commit. This is an optimization designed to make your tests runs fast regardless of how many tests you have. However it assumes that you don’t often commit the code that doesn’t pass the tests.

默认情况下，当您运行`npm test`时，Jest将仅运行与上次提交后更改的文件相关的测试。这是一个优化，旨在使您的测试快速运行，无论您有多少测试。但是，它假定您不经常提交不通过测试的代码。

Jest will always explicitly mention that it only ran tests related to the files changed since the last commit. You can also press `a` in the watch mode to force Jest to run all tests.

Jest将始终明确提到，它只运行与上次提交后更改的文件相关的测试。您也可以按观察表模式强制Jest运行所有测试。

Jest will always run all tests on a [continuous integration](#continuous-integration) server or if the project is not inside a Git or Mercurial repository.

Jest将始终在[持续集成](#continuous-integration)的服务器上运行所有测试，或者该项目不在Git或Mercurial资源库中。

### Writing Tests

### 写测试

To create tests, add `it()` (or `test()`) blocks with the name of the test and its code. You may optionally wrap them in `describe()` blocks for logical grouping but this is neither required nor recommended.

Jest provides a built-in `expect()` global function for making assertions. A basic test could look like this:

要创建测试，请使用测试名称及其代码添加`it()` (or `test()`)块。您可以选择将其包装在 `describe()` 块中进行逻辑分组，但这不是必需的，也不是推荐的。

Jest提供了一个内置的 `expect()` 全局函数来进行断言。基本测试可能如下所示：

```js
import sum from './sum';

it('sums numbers', () => {
  expect(sum(1, 2)).toEqual(3);
  expect(sum(2, 2)).toEqual(4);
});
```

All `expect()` matchers supported by Jest are [extensively documented here](http://facebook.github.io/jest/docs/expect.html).<br>
You can also use [`jest.fn()` and `expect(fn).toBeCalled()`](http://facebook.github.io/jest/docs/expect.html#tohavebeencalled) to create “spies” or mock functions.

Jest支持的所有`expect()`匹配器都在[这里进行了广泛的记录](http://facebook.github.io/jest/docs/expect.html)。

您也可以使用 [`jest.fn()` and `expect(fn).toBeCalled()`](http://facebook.github.io/jest/docs/expect.html#tohavebeencalled)创建“间谍”或模拟函数。

### Testing Components

### 测试组件

There is a broad spectrum of component testing techniques. They range from a “smoke test” verifying that a component renders without throwing, to shallow rendering and testing some of the output, to full rendering and testing component lifecycle and state changes.

这有广泛的组件测试技术。它们的范围从“Smoke Test” ，验证组件是否在不抛出的情况下渲染，浅渲染和测试某些输出，完全渲染和测试组件生命周期和状态更改。

Different projects choose different testing tradeoffs based on how often components change, and how much logic they contain. If you haven’t decided on a testing strategy yet, we recommend that you start with creating simple smoke tests for your components:

不同的项目根据组件变化的频率及其包含的逻辑选择不同的测试权衡进行取舍。如果您尚未决定测试策略，我们建议您首先为组件创建简单的`Smoke Test`：

```js
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<App />, div);
});
```

This test mounts a component and makes sure that it didn’t throw during rendering. Tests like this provide a lot value with very little effort so they are great as a starting point, and this is the test you will find in `src/App.test.js`.

该测试挂在了一个组件，并确保它在渲染过程中没有抛出错误。这样的测试通过很少的努力提供了很多价值，所以他们是伟大的起点，这是你将在`src/App.test.js`中找到的测试。

When you encounter bugs caused by changing components, you will gain a deeper insight into which parts of them are worth testing in your application. This might be a good time to introduce more specific tests asserting specific expected output or behavior.

当您遇到由更改组件导致的错误时，您将深入了解其中哪些部分在您的应用程序中值得测试。这可能是引入更具体的测试来判断具体的预期输出或行为的好时机。

If you’d like to test components in isolation from the child components they render, we recommend using [`shallow()` rendering API](http://airbnb.io/enzyme/docs/api/shallow.html) from [Enzyme](http://airbnb.io/enzyme/). You can write a smoke test with it too:

如果您想要从他们呈现的子组件中孤立测试组件，我们建议使用Enzyme中的[`shallow()` 渲染 API](http://airbnb.io/enzyme/docs/api/shallow.html) 。你也可以写Smoke Test：

```sh
npm install --save-dev enzyme react-test-renderer
```

```js
import React from 'react';
import { shallow } from 'enzyme';
import App from './App';

it('renders without crashing', () => {
  shallow(<App />);
});
```

Unlike the previous smoke test using `ReactDOM.render()`, this test only renders `<App>` and doesn’t go deeper. For example, even if `<App>` itself renders a `<Button>` that throws, this test will pass. Shallow rendering is great for isolated unit tests, but you may still want to create some full rendering tests to ensure the components integrate correctly. Enzyme supports [full rendering with `mount()`](http://airbnb.io/enzyme/docs/api/mount.html), and you can also use it for testing state changes and component lifecycle.

与以前使用`ReactDOM.render()`的Smoke Test不同，这个测试仅仅渲染`<App>`，而不会更深入。例如，即使`<App>`本身渲染抛出的`<Button>`，此测试也将通过。浅渲染非常适合隔离单元测试，但您仍然可能需要创建一些完整的渲染测试，以确保组件正确集成。Enzyme支持[使用`mount()`完全呈现](http://airbnb.io/enzyme/docs/api/mount.html)，还可以使用它来测试状态更改和组件生命周期。

You can read the [Enzyme documentation](http://airbnb.io/enzyme/) for more testing techniques. Enzyme documentation uses Chai and Sinon for assertions but you don’t have to use them because Jest provides built-in `expect()` and `jest.fn()` for spies.

Here is an example from Enzyme documentation that asserts specific output, rewritten to use Jest matchers:

您可以阅读[Enzyme文档](http://airbnb.io/enzyme/)了解更多测试技术。Enzyme文档使用Chai和Sinon作为断言，但您不必使用它们，因为Jest为间谍提供了内置的 `expect()` 和 `jest.fn()` 。

以下是Enzyme文档中的一个例子，该文档声明了特定输出，重写为使用Jest匹配器：

```js
import React from 'react';
import { shallow } from 'enzyme';
import App from './App';

it('renders welcome message', () => {
  const wrapper = shallow(<App />);
  const welcome = <h2>Welcome to React</h2>;
  // expect(wrapper.contains(welcome)).to.equal(true);
  expect(wrapper.contains(welcome)).toEqual(true);
});
```

All Jest matchers are [extensively documented here](http://facebook.github.io/jest/docs/expect.html).<br>
Nevertheless you can use a third-party assertion library like [Chai](http://chaijs.com/) if you want to, as described below.

所有Jest匹配器在[这里被广泛记录](http://facebook.github.io/jest/docs/expect.html)。

不过，如下所述，您可以使用像 [Chai](http://chaijs.com/) 这样的第三方断言库。

Additionally, you might find [jest-enzyme](https://github.com/blainekasten/enzyme-matchers) helpful to simplify your tests with readable matchers. The above `contains` code can be written simpler with jest-enzyme.

此外，您可能会发现[jest-enzyme](https://github.com/blainekasten/enzyme-matchers)有助于简化您的测试与可读匹配器。以上包含的代码可以用jest-enzyme更简单。

```js
expect(wrapper).toContainReact(welcome)
```

To setup jest-enzyme with Create React App, follow the instructions for [initializing your test environment](#initializing-test-environment) to import `jest-enzyme`. **Note that currently only version 2.x is compatible with Create React App.**

要使用Create React App设置jest-enzyme，请按照[初始化测试环境](#initializing-test-environment)的说明导入jest-enzyme。**请注意，目前只有2.x版本与Create React App兼容**

```sh
npm install --save-dev jest-enzyme@2.x
```

```js
// src/setupTests.js
import 'jest-enzyme';
```

### Using Third Party Assertion Libraries

### 使用第三方断言库

We recommend that you use `expect()` for assertions and `jest.fn()` for spies. If you are having issues with them please [file those against Jest](https://github.com/facebook/jest/issues/new), and we’ll fix them. We intend to keep making them better for React, supporting, for example, [pretty-printing React elements as JSX](https://github.com/facebook/jest/pull/1566).

我们建议您使用 `expect()` 的断言和 `jest.fn()` 作为间谍。如果您遇到问题，请[提交给Jest](https://github.com/facebook/jest/issues/new)，我们会解决这些问题。我们打算继续使他们更好地支持React，例如，完美的[打印React元素作为JSX](https://github.com/facebook/jest/pull/1566)。

However, if you are used to other libraries, such as [Chai](http://chaijs.com/) and [Sinon](http://sinonjs.org/), or if you have existing code using them that you’d like to port over, you can import them normally like this:

但是，如果您习惯于其他库，例如[Chai](http://chaijs.com/)和[Sinon](http://sinonjs.org/)，或者如果您现有的代码使用您想要移植的代码，则可以像这样导入它们：

```js
import sinon from 'sinon';
import { expect } from 'chai';
```

and then use them in your tests like you normally do.

然后在你的测试中像你通常那样使用它们。

### Initializing Test Environment

### 初始化测试环境

>Note: this feature is available with `react-scripts@0.4.0` and higher.
>
>注意：此功能可用在react-scripts@0.4.0及更高版本。

If your app uses a browser API that you need to mock in your tests or if you just need a global setup before running your tests, add a `src/setupTests.js` to your project. It will be automatically executed before running your tests.

For example:

如果您的应用程序使用您需要模仿测试的浏览器API，或者在运行测试之前需要全局设置，请将`src/setupTests.js`添加到您的项目中。它将在运行测试之前自动执行。

例如:

#### `src/setupTests.js`
```js
const localStorageMock = {
  getItem: jest.fn(),
  setItem: jest.fn(),
  clear: jest.fn()
};
global.localStorage = localStorageMock
```

### Focusing and Excluding Tests

### 聚焦和排除测试

You can replace `it()` with `xit()` to temporarily exclude a test from being executed.<br>
Similarly, `fit()` lets you focus on a specific test without running any other tests.

您可以用`xit()`替换`it()`以临时排除测试被执行。

同样， `fit()` 可以让您专注于特定的测试，而无需运行任何其他测试。

### Coverage Reporting

Jest has an integrated coverage reporter that works well with ES6 and requires no configuration.<br>
Run `npm test -- --coverage` (note extra `--` in the middle) to include a coverage report like this:

Jest有一个综合报道记者，与ES6工作良好，不需要配置。

运行 `npm test -- --coverage`（在中间注意额外参数 `--`  ）包括覆盖率报告如下：

![coverage report](http://i.imgur.com/5bFhnTS.png)

Note that tests run much slower with coverage so it is recommended to run it separately from your normal workflow.

请注意，测试的运行速度要慢得多，因此建议您从正常的工作流程中分离运行它。

### Continuous Integration

### 持续整合

By default `npm test` runs the watcher with interactive CLI. However, you can force it to run tests once and finish the process by setting an environment variable called `CI`.

默认情况下，`npm test`使用交互式CLI运行观察器。但是，您可以强制运行测试一次，并通过设置一个名为CI的环境变量来完成该过程。

When creating a build of your application with `npm run build` linter warnings are not checked by default. Like `npm test`, you can force the build to perform a linter warning check by setting the environment variable `CI`. If any warnings are encountered then the build fails.

当使用`npm run build`创建一个应用程序的构建时，默认情况下不会检查linter警告。像`npm test`一样，您可以通过设置环境变量CI来强制构建执行linter警告检查。如果遇到任何警告，则构建失败。

Popular CI servers already set the environment variable `CI` by default but you can do this yourself too:

流行的CI服务器默认已经设置了环境变量CI，但您也可以自己做这个：

### On CI servers

### 在CI服务器上

#### Travis CI

1. Following the [Travis Getting started](https://docs.travis-ci.com/user/getting-started/) guide for syncing your GitHub repository with Travis.  You may need to initialize some settings manually in your [profile](https://travis-ci.org/profile) page.

   遵循[Travis入门指南](https://docs.travis-ci.com/user/getting-started/)，将您的GitHub存储库与Travis同步。您可能需要在[个人资料](https://travis-ci.org/profile)页面中手动初始化某些设置。

2. Add a `.travis.yml` file to your git repository.

   将`.travis.yml`文件添加到git存储库。
```
language: node_js
node_js:
  - 4
  - 6
cache:
  directories:
    - node_modules
script:
  - npm test
  - npm run build
```
1. Trigger your first build with a git push.

   用`git push`来触发你的第一个build。

2. [Customize your Travis CI Build](https://docs.travis-ci.com/user/customizing-the-build/) if needed.

   如果需要，定制您的[Travis CI Build](https://docs.travis-ci.com/user/customizing-the-build/)。

### On your own environment

### 在你自己的环境中

##### Windows (cmd.exe)

```cmd
set CI=true&&npm test
```

```cmd
set CI=true&&npm run build
```

(Note: the lack of whitespace is intentional.注意：缺乏空白是有意的。)

##### Linux, macOS (Bash)

```bash
CI=true npm test
```

```bash
CI=true npm run build
```

The test command will force Jest to run tests once instead of launching the watcher.

测试命令将强制Jest运行测试一次，而不是启动观察器。

>  If you find yourself doing this often in development, please [file an issue](https://github.com/facebookincubator/create-react-app/issues/new) to tell us about your use case because we want to make watcher the best experience and are open to changing how it works to accommodate more workflows.
>
>  如果您发现自己在开发中经常遇到这种情况，请[提出一个问题](https://github.com/facebookincubator/create-react-app/issues/new)来告诉我们您的用例，因为我们希望让观察者获得最佳体验，并且可以随时更改工作流程以适应更多的工作流程。

The build command will check for linter warnings and fail if any are found.

构建命令将检查linter警告，如果找到任何警告，则会失败。

### Disabling jsdom

### 禁用jsdom

By default, the `package.json` of the generated project looks like this:

默认情况下，生成的项目的`package.json`如下所示：

```js
  // ...
  "scripts": {
    // ...
    "test": "react-scripts test --env=jsdom"
  }
```

If you know that none of your tests depend on [jsdom](https://github.com/tmpvar/jsdom), you can safely remove `--env=jsdom`, and your tests will run faster.<br>To help you make up your mind, here is a list of APIs that **need jsdom**:

如果你知道你的测试都不依赖于[jsdom](https://github.com/tmpvar/jsdom)，你可以安全地删除`--env = jsdom`，这样你的测试运行得更快。

为了帮助您解决问题，以下是需要jsdom的API列表：

* Any browser globals like `window` and `document`　任何浏览器全局变量，如 `window` 和 `document`
* [`ReactDOM.render()`](https://facebook.github.io/react/docs/top-level-api.html#reactdom.render)
* [`TestUtils.renderIntoDocument()`](https://facebook.github.io/react/docs/test-utils.html#renderintodocument) ([a shortcut](https://github.com/facebook/react/blob/34761cf9a252964abfaab6faf74d473ad95d1f21/src/test/ReactTestUtils.js#L83-L91) for the above)
* [`mount()`](http://airbnb.io/enzyme/docs/api/mount.html) in [Enzyme](http://airbnb.io/enzyme/index.html)

In contrast, **jsdom is not needed** for the following APIs:

相比之下，以下API不需要jsdom：

* [`TestUtils.createRenderer()`](https://facebook.github.io/react/docs/test-utils.html#shallow-rendering) (shallow rendering)
* [`shallow()`](http://airbnb.io/enzyme/docs/api/shallow.html) in [Enzyme](http://airbnb.io/enzyme/index.html)

Finally, jsdom is also not needed for [snapshot testing](http://facebook.github.io/jest/blog/2016/07/27/jest-14.html).

最后，[快照测试](http://facebook.github.io/jest/blog/2016/07/27/jest-14.html)也不需要jsdom。

### Snapshot Testing

### 快照测试

Snapshot testing is a feature of Jest that automatically generates text snapshots of your components and saves them on the disk so if the UI output changes, you get notified without manually writing any assertions on the component output. [Read more about snapshot testing.](http://facebook.github.io/jest/blog/2016/07/27/jest-14.html)

快照测试是Jest的一个功能，可自动生成组件的文本快照并将其保存在磁盘上，以便在UI输出更改时，您可以在不在组件输出上手动写入任何断言的情况下获得通知。[阅读有关快照测试的更多信息.](http://facebook.github.io/jest/blog/2016/07/27/jest-14.html)

### Editor Integration

### **编辑器集成**

If you use [Visual Studio Code](https://code.visualstudio.com), there is a [Jest extension](https://github.com/orta/vscode-jest) which works with Create React App out of the box. This provides a lot of IDE-like features while using a text editor: showing the status of a test run with potential fail messages inline, starting and stopping the watcher automatically, and offering one-click snapshot updates.

如果您使用[Visual Studio Code](https://code.visualstudio.com)，则有一个[Jest扩展名](https://github.com/orta/vscode-jest)可以与`Create React App`开箱即用。这在使用文本编辑器时提供了很多类似IDE的功能：使用潜在的故障消息内联显示测试运行的状态，自动启动和停止观察器，并提供一键式快照更新。

![VS Code Jest Preview](https://cloud.githubusercontent.com/assets/49038/20795349/a032308a-b7c8-11e6-9b34-7eeac781003f.png)

## Developing Components in Isolation

### 处于隔离状态开发组件

Usually, in an app, you have a lot of UI components, and each of them has many different states.
For an example, a simple button component could have following states:

通常，在应用程序中，您有很多UI组件，并且每个都有许多不同的状态。例如，一个简单的按钮组件可以具有以下状态：

* In a regular state, with a text label.在正常状态下，带有文本标签。
* In the disabled mode.禁用模式。
* In a loading state.加载状态。

Usually, it’s hard to see these states without running a sample app or some examples.

通常，在不运行示例应用程序或一些示例的情况下，很难看到这些状态。

Create React App doesn’t include any tools for this by default, but you can easily add  [Storybook for React](https://storybook.js.org/) ([source](https://github.com/storybooks/storybook)) to your project. **It is a third-party tool that lets you develop components and see all their states in isolation from your app**.

默认情况下，Create React App不包含任何工具，但您可以轻松地将 [Storybook for React](https://storybook.js.org/) ([source](https://github.com/storybooks/storybook))添加到您的项目中。**它是一个第三方工具，可让您开发组件，并与您的应用程序隔离，查看所有状态。**

![React Storybook Demo](http://i.imgur.com/7CIAWpB.gif)

A storybook can also be deployed as a static app. This way, everyone in your team can view and review different states of UI components without starting a backend server or creating an account in your app.

故事书也可以作为静态应用程序部署。这样，您的团队中的每个人都可以查看和查看UI组件的不同状态，而无需启动后端服务器或在应用程序中创建一个帐户。

### Setup your app with Storybook

First, install the following npm package globally:

首先，全局安装以下npm软件包：

```sh
npm install -g @storybook/cli
```

Then, run the following command inside your app’s directory:

然后，在你的应用程序的目录中运行以下命令：

```sh
getstorybook
```

After that, follow the instructions on the screen.

之后，请按照屏幕上的说明进行操作。

Learn more about React Storybook:

了解更多关于React Storybook：

* Screencast: [Getting Started with React Storybook](https://egghead.io/lessons/react-getting-started-with-react-storybook)
* [GitHub Repo](https://github.com/kadirahq/react-storybook)
* [Documentation](https://storybooks.js.org/docs/react-storybook/basics/introduction/)
* [Snapshot Testing](https://github.com/kadirahq/storyshots) with React Storybook

## Making a Progressive Web App

### 制作一个渐进的Web应用程序

By default, the production build is a fully functional, offline-first [Progressive Web App](https://developers.google.com/web/progressive-web-apps/).

默认情况下，生产构建的是一个功能齐全的离线优先的渐进式的Web应用程序。

Progressive Web Apps are faster and more reliable than traditional web pages, and provide an engaging mobile experience:

渐进式Web应用程序比传统网页更快，更可靠，并提供引人入胜的移动体验：

 * All static site assets are cached so that your page loads fast on subsequent visits, regardless of network connectivity (such as 2G or 3G). Updates are downloaded in the background.

   所有静态网站资源均被缓存，无论网络连接是2G还是3G，您的网页在后续访问中都能快速加载。更新在后台下载。

 * Your app will work regardless of network state, even if offline. This means your users will be able to use your app at 10,000 feet and on the Subway.

   无论网络状态如何，您的应用都会工作，即使离线。这意味着您的用户将能够在10,000英尺外的地铁上使用您的应用程序。

 * On mobile devices, your app can be added directly to the user's home screen, app icon and all. You can also re-engage users using web **push notifications**. This eliminates the need for the app store.

   在移动设备上，您的应用程序可以将应用程序图标和其他所有的东西直接添加到用户的主屏幕。您也可以使用网络推送通知重新吸引用户。这样就省去了应用商店的需要。

The [`sw-precache-webpack-plugin`](https://github.com/goldhand/sw-precache-webpack-plugin) is integrated into production configuration,and it will take care of generating a service worker file that will automatically precache all of your local assets and keep them up to date as you deploy updates. The service worker will use a [cache-first strategy](https://developers.google.com/web/fundamentals/instant-and-offline/offline-cookbook/#cache-falling-back-to-network) for handling all requests for local assets, including the initial HTML, ensuring that you web app is reliably fast, even on a slow or nreliable network.

 [`sw-precache-webpack-plugin`](https://github.com/goldhand/sw-precache-webpack-plugin) 被集成到生产配置中，它将负责生成一个服务工作者文件，它将自动预处理所有本地资源，并在部署更新时保持最新状态。服务工作者将使用缓存优先策略来处理本地资源的所有请求，包括初始HTML，确保您的Web应用程序可靠地快速运行，即使在较慢或不可靠的网络中。

If you would prefer not to enable service workers prior to your initial production deployment, then remove the call to `serviceWorkerRegistration.register()` from [`src/index.js`](src/index.js).

如果您不希望在初始生产部署之前启用服务工作者，请从 [`src/index.js`](src/index.js)中删除对 `serviceWorkerRegistration.register()`的调用。

If you had previously enabled service workers in your production deployment and have decided that you would like to disable them for all your existing users, you can swap out the call to `serviceWorkerRegistration.register()` in [`src/index.js`](src/index.js) with a call to `serviceWorkerRegistration.unregister()`. After the user visits a page that has `serviceWorkerRegistration.unregister()`, the service worker will be uninstalled.

如果您之前已经在生产部署中启用了服务工作者，并且已经决定要对所有现有用户禁用它们，您可以通过调用`serviceWorkerRegistration.unregister()`将 [`src/index.js`](src/index.js) 中调用的`serviceWorkerRegistration.register()`换掉。用户访问具有`serviceWorkerRegistration.unregister()`的页面后，服务工作者将被卸载。

### Offline-First Considerations

### 离线优先注意事项

1. Service workers [require HTTPS](https://developers.google.com/web/fundamentals/getting-started/primers/service-workers#you_need_https),
  although to facilitate local testing, that policy
  [does not apply to `localhost`](http://stackoverflow.com/questions/34160509/options-for-testing-service-workers-via-http/34161385#34161385).
  If your production web server does not support HTTPS, then the service worker
  registration will fail, but the rest of your web app will remain functional.

  服务工作者[需要HTTPS](https://developers.google.com/web/fundamentals/getting-started/primers/service-workers#you_need_https)，尽管为了方便本地测试，但该策略[不适用于localhost](http://stackoverflow.com/questions/34160509/options-for-testing-service-workers-via-http/34161385#34161385)。如果您的生产Web服务器不支持HTTPS，则服务工作者注册将失败，但您的Web应用程序的其余部分将保持有效。

2. Service workers are [not currently supported](https://jakearchibald.github.io/isserviceworkerready/)
  in all web browsers. Service worker registration [won't be attempted](src/registerServiceWorker.js)
  on browsers that lack support.

  所有网络浏览器[目前不支持](https://jakearchibald.github.io/isserviceworkerready/)服务工作者。在缺乏支持的浏览器上[不会尝试](src/registerServiceWorker.js)服务工作者的注册。

3. The service worker is only enabled in the [production environment](#deployment),
  e.g. the output of `npm run build`. It's recommended that you do not enable an
  offline-first service worker in a development environment, as it can lead to
  frustration when previously cached assets are used and do not include the latest
  changes you've made locally.

  服务工作者只能在[生产环境](#deployment)中启用，例如`npm run build`的输出。建议您不要在开发环境中启用离线优先的服务工作者，因为在使用先前的缓存资源时可能会导致失败，并且不包括您在本地进行的最新更改。

4. If you *need* to test your offline-first service worker locally, build
  the application (using `npm run build`) and run a simple http server from your
  build directory. After running the build script, `create-react-app` will give
  instructions for one way to test your production build locally and the [deployment instructions](#deployment) have
  instructions for using other methods. *Be sure to always use an
  incognito window to avoid complications with your browser cache.

  如果您需要在本地测试您的离线优先的服务工作者，请构建应用程序（使用 `npm run build`），并从构建目录运行简单的http服务器。运行构建脚本后，`create-react-app`将给出本地测试生产环境的一种方法的说明，[部署说明](#deployment)有使用其他方法的说明。

5. If possible, configure your production environment to serve the generated
  `service-worker.js` [with HTTP caching disabled](http://stackoverflow.com/questions/38843970/service-worker-javascript-update-frequency-every-24-hours).
  If that's not possible—[GitHub Pages](#github-pages), for instance, does not
  allow you to change the default 10 minute HTTP cache lifetime—then be aware
  that if you visit your production site, and then revisit again before
  `service-worker.js` has expired from your HTTP cache, you'll continue to get
  the previously cached assets from the service worker. If you have an immediate
  need to view your updated production deployment, performing a shift-refresh
  will temporarily disable the service worker and retrieve all assets from the
  network.

  如果可能，请配置您的生产环境，以便为[禁用HTTP缓存](http://stackoverflow.com/questions/38843970/service-worker-javascript-update-frequency-every-24-hours)的生成的service-worker.js提供服务。如果这是不可能的 - 例如，[GitHub Pages](#github-pages)不允许您更改默认的10分钟HTTP缓存生命周期 - 然后请注意，如果您访问生产站点，然后在service-worker.js从HTTP缓存过期之前重新访问，您将继续从服务工作者获取先前缓存的资产。如果您立即需要查看更新的生产部署，执行班次刷新将暂时禁用服务工作者并从网络中检索所有资源。

6. Users aren't always familiar with offline-first web apps. It can be useful to
  [let the user know](https://developers.google.com/web/fundamentals/instant-and-offline/offline-ux#inform_the_user_when_the_app_is_ready_for_offline_consumption)
  when the service worker has finished populating your caches (showing a "This web
  app works offline!" message) and also let them know when the service worker has
  fetched the latest updates that will be available the next time they load the
  page (showing a "New content is available; please refresh." message). Showing
  this messages is currently left as an exercise to the developer, but as a
  starting point, you can make use of the logic included in [`src/registerServiceWorker.js`](src/registerServiceWorker.js), which
  demonstrates which service worker lifecycle events to listen for to detect each
  scenario, and which as a default, just logs appropriate messages to the
  JavaScript console.

  用户并不总是熟悉离线优先的网络应用程序。让用户知道服务工作者何时完成填充缓存（显示“此Web应用程序脱机工作”消息），并让他们知道服务工作者在获取下次加载页面时可用的最新更新（显示“新内容可用;请刷新”消息）。显示此消息目前作为开发人员的练习，但作为起点，您可以使用 [`src/registerServiceWorker.js`](src/registerServiceWorker.js)中包含的逻辑，这表明哪些服务工作者生命周期事件要监听以检测每个场景，默认情况下，只需将适当的消息记录到JavaScript控制台。

7. By default, the generated service worker file will not intercept or cache any
  cross-origin traffic, like HTTP [API requests](#integrating-with-an-api-backend),
  images, or embeds loaded from a different domain. If you would like to use a
  runtime caching strategy for those requests, you can [`eject`](#npm-run-eject)
  and then configure the
  [`runtimeCaching`](https://github.com/GoogleChrome/sw-precache#runtimecaching-arrayobject)
  option in the `SWPrecacheWebpackPlugin` section of
  [`webpack.config.prod.js`](../config/webpack.config.prod.js).

  默认情况下，生成的服务工作者文件将不会拦截或缓存任何跨原始流量，如HTTP API请求，图像或从其他域加载的嵌入。如果要对这些请求使用运行时缓存策略，可以弹出并在`webpack.config.prod.js`的`SWPrecacheWebpackPlugin`部分中配置`runtimeCaching`选项。

### Progressive Web App Metadata

### 渐进式Web应用程序元数据

The default configuration includes a web app manifest located at　[`public/manifest.json`](public/manifest.json), that you can customize with details specific to your web application.

默认配置包括位于[`public/manifest.json`](public/manifest.json)的Web应用程序清单，您可以使用特定于Web应用程序的详细信息进行自定义。

When a user adds a web app to their homescreen using Chrome or Firefox on Android, the metadata in [`manifest.json`](public/manifest.json) determines what icons, names, and branding colors to use when the web app is displayed.
[The Web App Manifest guide](https://developers.google.com/web/fundamentals/engage-and-retain/web-app-manifest/) provides more context about what each field means, and how your customizations will affect your users' experience.

当用户在Android上使用Chrome或Firefox添加网页应用程序到主屏幕时，[`manifest.json`](public/manifest.json) 中的元数据决定了在显示Web应用程序时要使用的图标，名称和品牌颜色。[Web App清单指南](https://developers.google.com/web/fundamentals/engage-and-retain/web-app-manifest/) 提供了关于每个字段意味着什么的更多上下文信息，以及您的自定义将如何影响用户的体验。

## Deployment

### 部署

`npm run build` creates a `build` directory with a production build of your app. Set up your favourite HTTP server so that a visitor to your site is served `index.html`, and requests to static paths like `/static/js/main.<hash>.js` are served with the contents of the `/static/js/main.<hash>.js` file.

`npm run build` 使用您的应用程序的生产构建创建了一个 `build` 目录。设置您最喜欢的HTTP服务器，以便为您的站点的访问者提供`index.html`，并且静态路径（如`/static/js/main.<hash>.js`）的请求将与 `/static/js/main.<hash>.js` 的内容一起提供。

### Static Server

### 静态服务器

For environments using [Node](https://nodejs.org/), the easiest way to handle this would be to install [serve](https://github.com/zeit/serve) and let it handle the rest:

对于使用[Node](https://nodejs.org/)的环境，处理这种情况的最简单的方法是安装[服务](https://github.com/zeit/serve)并让其处理其余部分：

```sh
npm install -g serve
serve -s build
```

The last command shown above will serve your static site on the port **5000**. Like many of [serve](https://github.com/zeit/serve)’s internal settings, the port can be adjusted using the `-p` or `--port` flags.

上面显示的最后一个命令将为端口5000上的静态站点提供服务。像许多[服务](https://github.com/zeit/serve)的内部设置一样，可以使用-p或--port标志调整端口。

Run this command to get a full list of the options available:

运行此命令以获取可用选项的完整列表：

```sh
serve -h
```

### Other Solutions

### 其他解决方案

You don’t necessarily need a static server in order to run a Create React App project in production. It works just as fine integrated into an existing dynamic one.

您不一定需要静态服务器才能在生产中运行Create React App项目。它的工作原理同样适用于现有的动态应用程序。

Here’s a programmatic example using [Node](https://nodejs.org/) and [Express](http://expressjs.com/):

以下是使用[Node](https://nodejs.org/)和[Express](http://expressjs.com/)的编程示例：

```javascript
const express = require('express');
const path = require('path');
const app = express();

app.use(express.static(path.join(__dirname, 'build')));

app.get('/', function (req, res) {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

app.listen(9000);
```

The choice of your server software isn’t important either. Since Create React App is completely platform-agnostic, there’s no need to explicitly use Node.

您的服务器软件的选择也不重要。由于Create React App完全与平台无关，因此无需明确使用Node。

The `build` folder with static assets is the only output produced by Create React App.

具有静态资源的 `build` 文件夹是由Create React App生成的唯一输出。

However this is not quite enough if you use client-side routing. Read the next section if you want to support URLs like `/todos/42` in your single-page app.

但是，如果您使用客户端路由，这还不够。如果您希望在单页应用程序中支持像 `/todos/42` 这样的URL，请阅读下一节。

### Serving Apps with Client-Side Routing

### 使用客户端路由服务应用程序

If you use routers that use the HTML5 [`pushState` history API](https://developer.mozilla.org/en-US/docs/Web/API/History_API#Adding_and_modifying_history_entries) under the hood (for example, [React Router](https://github.com/ReactTraining/react-router) with `browserHistory`), many static file servers will fail. For example, if you used React Router with a route for `/todos/42`, the development server will respond to `localhost:3000/todos/42` properly, but an Express serving a production build as above will not.

如果您使用的是使用HTML5 [`pushState` history API](https://developer.mozilla.org/en-US/docs/Web/API/History_API#Adding_and_modifying_history_entries) 的路由器（例如，使用browserHistory的[React Router](https://github.com/ReactTraining/react-router) ），则许多静态文件服务器将失败。例如，如果您使用React Router作为`/todos/42`的路由，则开发服务器将正确响应`localhost:3000/todos/42`，但是Express将不会像上面所述那样服务于生产构建。

This is because when there is a fresh page load for a `/todos/42`, the server looks for the file `build/todos/42` and does not find it. The server needs to be configured to respond to a request to `/todos/42` by serving `index.html`. For example, we can amend our Express example above to serve `index.html` for any unknown paths:

这是因为当访问`/todos/42`有一个新的页面加载时，服务器查找文件`build/todos/42`，却找不到它。服务器需要配置为通过提供｀index.html｀来响应`/todos/42`的请求。例如，我们可以修改我们上面的Express示例，为任何未知路径提供`index.html`：

```diff
 app.use(express.static(path.join(__dirname, 'build')));

-app.get('/', function (req, res) {
+app.get('/*', function (req, res) {
   res.sendFile(path.join(__dirname, 'build', 'index.html'));
 });
```

If you’re using [Apache](https://httpd.apache.org/), you need to create a `.htaccess` file in the `public` folder that looks like this:

如果您使用[Apache](https://httpd.apache.org/)，则需要在`public`文件夹中创建一个`.htaccess`文件，如下所示：

```
    Options -MultiViews
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.html [QSA,L]
```

It will get copied to the `build` folder when you run `npm run build`.

运行 `npm run build`时，它将被复制到 `build` 文件夹。

Now requests to `/todos/42` will be handled correctly both in development and in production.

现在，对 `/todos/42` 的请求将在开发和生产中都被正确处理。

On a production build, and in a browser that supports [service workers](https://developers.google.com/web/fundamentals/getting-started/primers/service-workers), the service worker will automatically handle all navigation requests, like for `/todos/42`, by serving the cached copy of your `index.html`. This
service worker navigation routing can be configured or disabled by [`eject`ing](#npm-run-eject) and then modifying the [`navigateFallback`](https://github.com/GoogleChrome/sw-precache#navigatefallback-string) and [`navigateFallbackWhitelist`](https://github.com/GoogleChrome/sw-precache#navigatefallbackwhitelist-arrayregexp) options of the `SWPreachePlugin` [configuration](../config/webpack.config.prod.js).

在生产构建中，在支持[服务工作者](https://developers.google.com/web/fundamentals/getting-started/primers/service-workers)的浏览器中，服务工作者将自动处理所有导航请求，像`/todos/42`,通过提供`index.html`的缓存副本。可以通过 [`eject`ing](#npm-run-eject) 配置或禁用此服务工作者导航路由，然后修改`SWPreachePlugin`配置的`navigateFallback`和`navigateFallbackWhitelist`选项。

### Building for Relative Paths

### 相对路径建设

By default, Create React App produces a build assuming your app is hosted at the server root.<br>
To override this, specify the `homepage` in your `package.json`, for example:

默认情况下，Create React App 会生成一个构建，假设您的应用程序是托管在服务器根目录下。

要覆盖它，请指定`package.json`中的`homepage`，例如：

```js
  "homepage": "http://mywebsite.com/relativepath",
```

This will let Create React App correctly infer the root path to use in the generated HTML file.

这将使Create React App正确地推断在生成的HTML文件中使用的根路径。

#### Serving the Same Build from Different Paths

### 从不同的路径服务于同一构建

>Note: this feature is available with `react-scripts@0.9.0` and higher.
>
>注意：此功能可用在react-scripts@0.9.0及更高版本。

If you are not using the HTML5 `pushState` history API or not using client-side routing at all, it is unnecessary to specify the URL from which your app will be served. Instead, you can put this in your `package.json`:

如果您没有使用HTML5 `pushState`历史API，或者根本不使用客户端路由，则无需指定您的应用程式将被送达的URL。相反，你可以把它放在你的`package.json`中：

```js
  "homepage": ".",
```

This will make sure that all the asset paths are relative to `index.html`. You will then be able to move your app from `http://mywebsite.com` to `http://mywebsite.com/relativepath` or even `http://mywebsite.com/relative/path` without having to rebuild it.

这将确保所有资产路源都相对于`index.html`。然后，您可以将您的应用程序从`http://mywebsite.com`移动到`http://mywebsite.com/relativepath`或`http://mywebsite.com/relative/path`，而无需重新构建它。

### Azure

See [this](https://medium.com/@to_pe/deploying-create-react-app-on-microsoft-azure-c0f6686a4321) blog post on how to deploy your React app to [Microsoft Azure](https://azure.microsoft.com/).

请参阅[此博文](https://medium.com/@to_pe/deploying-create-react-app-on-microsoft-azure-c0f6686a4321) ，了解如何将React应用程序部署到 [Microsoft Azure](https://azure.microsoft.com/)。

### Firebase

Install the Firebase CLI if you haven’t already by running `npm install -g firebase-tools`. Sign up for a [Firebase account](https://console.firebase.google.com/) and create a new project. Run `firebase login` and login with your previous created Firebase account.

Then run the `firebase init` command from your project’s root. You need to choose the **Hosting: Configure and deploy Firebase Hosting sites** and choose the Firebase project you created in the previous step. You will need to agree with `database.rules.json` being created, choose `build` as the public directory, and also agree to **Configure as a single-page app** by replying with `y`.

```sh
    === Project Setup

    First, let's associate this project directory with a Firebase project.
    You can create multiple project aliases by running firebase use --add,
    but for now we'll just set up a default project.

    ? What Firebase project do you want to associate as default? Example app (example-app-fd690)

    === Database Setup

    Firebase Realtime Database Rules allow you to define how your data should be
    structured and when your data can be read from and written to.

    ? What file should be used for Database Rules? database.rules.json
    ✔  Database Rules for example-app-fd690 have been downloaded to database.rules.json.
    Future modifications to database.rules.json will update Database Rules when you run
    firebase deploy.

    === Hosting Setup

    Your public directory is the folder (relative to your project directory) that
    will contain Hosting assets to uploaded with firebase deploy. If you
    have a build process for your assets, use your build's output directory.

    ? What do you want to use as your public directory? build
    ? Configure as a single-page app (rewrite all urls to /index.html)? Yes
    ✔  Wrote build/index.html

    i  Writing configuration info to firebase.json...
    i  Writing project information to .firebaserc...

    ✔  Firebase initialization complete!
```

Now, after you create a production build with `npm run build`, you can deploy it by running `firebase deploy`.

```sh
    === Deploying to 'example-app-fd690'...

    i  deploying database, hosting
    ✔  database: rules ready to deploy.
    i  hosting: preparing build directory for upload...
    Uploading: [==============================          ] 75%✔  hosting: build folder uploaded successfully
    ✔  hosting: 8 files uploaded successfully
    i  starting release process (may take several minutes)...

    ✔  Deploy complete!

    Project Console: https://console.firebase.google.com/project/example-app-fd690/overview
    Hosting URL: https://example-app-fd690.firebaseapp.com
```

For more information see [Add Firebase to your JavaScript Project](https://firebase.google.com/docs/web/setup).

### GitHub Pages

>Note: this feature is available with `react-scripts@0.2.0` and higher.
>
>注意：此功能可用在react-scripts@0.2.0及更高版本。

#### Step 1: Add `homepage` to `package.json`

**The step below is important!**<br>
**If you skip it, your app will not deploy correctly.**

Open your `package.json` and add a `homepage` field:

```js
  "homepage": "https://myusername.github.io/my-app",
```

Create React App uses the `homepage` field to determine the root URL in the built HTML file.

#### Step 2: Install `gh-pages` and add `deploy` to `scripts` in `package.json`

Now, whenever you run `npm run build`, you will see a cheat sheet with instructions on how to deploy to GitHub Pages.

To publish it at [https://myusername.github.io/my-app](https://myusername.github.io/my-app), run:

```sh
npm install --save-dev gh-pages
```

Add the following scripts in your `package.json`:

```js
  // ...
  "scripts": {
    // ...
    "predeploy": "npm run build",
    "deploy": "gh-pages -d build"
  }
```

The `predeploy` script will run automatically before `deploy` is run.

#### Step 3: Deploy the site by running `npm run deploy`

Then run:

```sh
npm run deploy
```

#### Step 4: Ensure your project’s settings use `gh-pages`

Finally, make sure **GitHub Pages** option in your GitHub project settings is set to use the `gh-pages` branch:

<img src="http://i.imgur.com/HUjEr9l.png" width="500" alt="gh-pages branch setting">

#### Step 5: Optionally, configure the domain

You can configure a custom domain with GitHub Pages by adding a `CNAME` file to the `public/` folder.

#### Notes on client-side routing

GitHub Pages doesn’t support routers that use the HTML5 `pushState` history API under the hood (for example, React Router using `browserHistory`). This is because when there is a fresh page load for a url like `http://user.github.io/todomvc/todos/42`, where `/todos/42` is a frontend route, the GitHub Pages server returns 404 because it knows nothing of `/todos/42`. If you want to add a router to a project hosted on GitHub Pages, here are a couple of solutions:

* You could switch from using HTML5 history API to routing with hashes. If you use React Router, you can switch to `hashHistory` for this effect, but the URL will be longer and more verbose (for example, `http://user.github.io/todomvc/#/todos/42?_k=yknaj`). [Read more](https://github.com/reactjs/react-router/blob/master/docs/guides/Histories.md#histories) about different history implementations in React Router.
* Alternatively, you can use a trick to teach GitHub Pages to handle 404 by redirecting to your `index.html` page with a special redirect parameter. You would need to add a `404.html` file with the redirection code to the `build` folder before deploying your project, and you’ll need to add code handling the redirect parameter to `index.html`. You can find a detailed explanation of this technique [in this guide](https://github.com/rafrex/spa-github-pages).

### Heroku

Use the [Heroku Buildpack for Create React App](https://github.com/mars/create-react-app-buildpack).<br>
You can find instructions in [Deploying React with Zero Configuration](https://blog.heroku.com/deploying-react-with-zero-configuration).

#### Resolving Heroku Deployment Errors

Sometimes `npm run build` works locally but fails during deploy via Heroku. Following are the most common cases.

##### "Module not found: Error: Cannot resolve 'file' or 'directory'"

If you get something like this:

```
remote: Failed to create a production build. Reason:
remote: Module not found: Error: Cannot resolve 'file' or 'directory'
MyDirectory in /tmp/build_1234/src
```

It means you need to ensure that the lettercase of the file or directory you `import` matches the one you see on your filesystem or on GitHub.

This is important because Linux (the operating system used by Heroku) is case sensitive. So `MyDirectory` and `mydirectory` are two distinct directories and thus, even though the project builds locally, the difference in case breaks the `import` statements on Heroku remotes.

##### "Could not find a required file."

If you exclude or ignore necessary files from the package you will see a error similar this one:

```
remote: Could not find a required file.
remote:   Name: `index.html`
remote:   Searched in: /tmp/build_a2875fc163b209225122d68916f1d4df/public
remote:
remote: npm ERR! Linux 3.13.0-105-generic
remote: npm ERR! argv "/tmp/build_a2875fc163b209225122d68916f1d4df/.heroku/node/bin/node" "/tmp/build_a2875fc163b209225122d68916f1d4df/.heroku/node/bin/npm" "run" "build"
```

In this case, ensure that the file is there with the proper lettercase and that’s not ignored on your local `.gitignore` or `~/.gitignore_global`.

### Modulus

See the [Modulus blog post](http://blog.modulus.io/deploying-react-apps-on-modulus) on how to deploy your react app to Modulus.

### Netlify

**To do a manual deploy to Netlify’s CDN:**

```sh
npm install netlify-cli
netlify deploy
```

Choose `build` as the path to deploy.

**To setup continuous delivery:**

With this setup Netlify will build and deploy when you push to git or open a pull request:

1. [Start a new netlify project](https://app.netlify.com/signup)
2. Pick your Git hosting service and select your repository
3. Click `Build your site`

**Support for client-side routing:**

To support `pushState`, make sure to create a `public/_redirects` file with the following rewrite rules:

```
/*  /index.html  200
```

When you build the project, Create React App will place the `public` folder contents into the build output.

### Now

[now](https://zeit.co/now) offers a zero-configuration single-command deployment. You can use `now` to deploy your app for free.

1. Install the `now` command-line tool either via the recommended [desktop tool](https://zeit.co/download) or via node with `npm install -g now`.

2. Build your app by running `npm run build`.

3. Move into the build directory by running `cd build`.

4. Run `now --name your-project-name` from within the build directory. You will see a **now.sh** URL in your output like this:

    ```
    > Ready! https://your-project-name-tpspyhtdtk.now.sh (copied to clipboard)
    ```

    Paste that URL into your browser when the build is complete, and you will see your deployed app.

Details are available in [this article.](https://zeit.co/blog/unlimited-static)

### S3 and CloudFront

See this [blog post](https://medium.com/@omgwtfmarc/deploying-create-react-app-to-s3-or-cloudfront-48dae4ce0af) on how to deploy your React app to Amazon Web Services [S3](https://aws.amazon.com/s3) and [CloudFront](https://aws.amazon.com/cloudfront/).

### Surge

Install the Surge CLI if you haven’t already by running `npm install -g surge`. Run the `surge` command and log in you or create a new account.

When asked about the project path, make sure to specify the `build` folder, for example:

```sh
       project path: /path/to/project/build
```

Note that in order to support routers that use HTML5 `pushState` API, you may want to rename the `index.html` in your build folder to `200.html` before deploying to Surge. This [ensures that every URL falls back to that file](https://surge.sh/help/adding-a-200-page-for-client-side-routing).

## Advanced Configuration

You can adjust various development and production settings by setting environment variables in your shell or with [.env](#adding-development-environment-variables-in-env).

| Variable   |      Development       |     Production     | Usage                                    |
| :--------- | :--------------------: | :----------------: | :--------------------------------------- |
| BROWSER    |   :white_check_mark:   |        :x:         | By default, Create React App will open the default system browser, favoring Chrome on macOS. Specify a [browser](https://github.com/sindresorhus/opn#app) to override this behavior, or set it to `none` to disable it completely. If you need to customize the way the browser is launched, you can specify a node script instead. Any arguments passed to `npm start` will also be passed to this script, and the url where your app is served will be the last argument. Your script's file name must have the `.js` extension. |
| HOST       |   :white_check_mark:   |        :x:         | By default, the development web server binds to `localhost`. You may use this variable to specify a different host. |
| PORT       |   :white_check_mark:   |        :x:         | By default, the development web server will attempt to listen on port 3000 or prompt you to attempt the next available port. You may use this variable to specify a different port. |
| HTTPS      |   :white_check_mark:   |        :x:         | When set to `true`, Create React App will run the development server in `https` mode. |
| PUBLIC_URL |          :x:           | :white_check_mark: | Create React App assumes your application is hosted at the serving web server's root or a subpath as specified in [`package.json` (`homepage`)](#building-for-relative-paths). Normally, Create React App ignores the hostname. You may use this variable to force assets to be referenced verbatim to the url you provide (hostname included). This may be particularly useful when using a CDN to host your application. |
| CI         | :large_orange_diamond: | :white_check_mark: | When set to `true`, Create React App treats warnings as failures in the build. It also makes the test runner non-watching. Most CIs set this flag by default. |

## Troubleshooting

### `npm start` doesn’t detect changes

When you save a file while `npm start` is running, the browser should refresh with the updated code.<br>
If this doesn’t happen, try one of the following workarounds:

* If your project is in a Dropbox folder, try moving it out.
* If the watcher doesn’t see a file called `index.js` and you’re referencing it by the folder name, you [need to restart the watcher](https://github.com/facebookincubator/create-react-app/issues/1164) due to a Webpack bug.
* Some editors like Vim and IntelliJ have a “safe write” feature that currently breaks the watcher. You will need to disable it. Follow the instructions in [“Adjusting Your Text Editor”](https://webpack.js.org/guides/development/#adjusting-your-text-editor).
* If your project path contains parentheses, try moving the project to a path without them. This is caused by a [Webpack watcher bug](https://github.com/webpack/watchpack/issues/42).
* On Linux and macOS, you might need to [tweak system settings](https://webpack.github.io/docs/troubleshooting.html#not-enough-watchers) to allow more watchers.
* If the project runs inside a virtual machine such as (a Vagrant provisioned) VirtualBox, create an `.env` file in your project directory if it doesn’t exist, and add `CHOKIDAR_USEPOLLING=true` to it. This ensures that the next time you run `npm start`, the watcher uses the polling mode, as necessary inside a VM.

If none of these solutions help please leave a comment [in this thread](https://github.com/facebookincubator/create-react-app/issues/659).

### `npm test` hangs on macOS Sierra

If you run `npm test` and the console gets stuck after printing `react-scripts test --env=jsdom` to the console there might be a problem with your [Watchman](https://facebook.github.io/watchman/) installation as described in [facebookincubator/create-react-app#713](https://github.com/facebookincubator/create-react-app/issues/713).

We recommend deleting `node_modules` in your project and running `npm install` (or `yarn` if you use it) first. If it doesn't help, you can try one of the numerous workarounds mentioned in these issues:

* [facebook/jest#1767](https://github.com/facebook/jest/issues/1767)
* [facebook/watchman#358](https://github.com/facebook/watchman/issues/358)
* [ember-cli/ember-cli#6259](https://github.com/ember-cli/ember-cli/issues/6259)

It is reported that installing Watchman 4.7.0 or newer fixes the issue. If you use [Homebrew](http://brew.sh/), you can run these commands to update it:

```
watchman shutdown-server
brew update
brew reinstall watchman
```

You can find [other installation methods](https://facebook.github.io/watchman/docs/install.html#build-install) on the Watchman documentation page.

If this still doesn’t help, try running `launchctl unload -F ~/Library/LaunchAgents/com.github.facebook.watchman.plist`.

There are also reports that *uninstalling* Watchman fixes the issue. So if nothing else helps, remove it from your system and try again.

### `npm run build` silently fails

It is reported that `npm run build` can fail on machines with no swap space, which is common in cloud environments. If [the symptoms are matching](https://github.com/facebookincubator/create-react-app/issues/1133#issuecomment-264612171), consider adding some swap space to the machine you’re building on, or build the project locally.

### `npm run build` fails on Heroku

This may be a problem with case sensitive filenames.
Please refer to [this section](#resolving-heroku-deployment-errors).

### Moment.js locales are missing

If you use a [Moment.js](https://momentjs.com/), you might notice that only the English locale is available by default. This is because the locale files are large, and you probably only need a subset of [all the locales provided by Moment.js](https://momentjs.com/#multiple-locale-support).

To add a specific Moment.js locale to your bundle, you need to import it explicitly.<br>
For example:

```js
import moment from 'moment';
import 'moment/locale/fr';
```

If import multiple locales this way, you can later switch between them by calling `moment.locale()` with the locale name:

```js
import moment from 'moment';
import 'moment/locale/fr';
import 'moment/locale/es';

// ...

moment.locale('fr');
```

This will only work for locales that have been explicitly imported before.

## Something Missing?

If you have ideas for more “How To” recipes that should be on this page, [let us know](https://github.com/facebookincubator/create-react-app/issues) or [contribute some!](https://github.com/facebookincubator/create-react-app/edit/master/packages/react-scripts/template/README.md)
