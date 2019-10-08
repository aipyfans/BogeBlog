---
layout: post
title:  "React Architecture"
date:   1986-08-04 00:00:00
categories: react
---

> 说明:本博文的目的只有一个:记录React项目架构搭建过程.

### 创建React应用

```
npm install -g create-react-app
create-react-app my-app

cd my-app
npm start
```

### 添加库

#### [添加CSS预处理器(Sass)](https://github.com/li-jun-bo/hello_react#post-processing-css)

```
npm install node-sass-chokidar --save-dev
npm install --save-dev npm-run-all


"build-css": "node-sass-chokidar src/ -o src/",
"watch-css": "npm run build-css && node-sass-chokidar src/ -o src/ --watch --recursive",
"start-js": "react-scripts start",
"start": "npm-run-all -p watch-css start-js",
"build": "npm run build-css && react-scripts build",
```

####[添加Bootstrap库](https://github.com/li-jun-bo/hello_react#adding-bootstrap)

```
npm install react-bootstrap --save
npm install bootstrap@3 --save
```

在 `src/index.js` 文件的开头导入Bootstrap CSS和可选的Bootstrap主题CSS：

```
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap/dist/css/bootstrap-theme.css';
// 在下面放置任何其他导入，以使您的组件中的CSS优先于默认样式。
```

Import required React Bootstrap components within `src/App.js` file or your custom component files:

在 `src/App.js` 文件或您的自定义组件文件中导入所需的React Bootstrap组件：

```
import { Navbar, Jumbotron, Button } from 'react-bootstrap';
```

#### [添加Flow(静态类型检查器)](https://github.com/li-jun-bo/hello_react#adding-flow)

```
1. 运行 npm install --save-dev flow-bin (或 yarn add --dev flow-bin)
2. 将 "flow": "flow" 添加到您的package.json的 scripts 部分
3. 运行 npm run flow -- init (或 yarn flow -- init)以在根目录中创建一个.flowconfig文件
4. 将 // @flow 添加到要进行类型检查的任何文件中（例如，到src/App.js）
5. 现在，您可以运行 npm run flow (或 yarn flow) 来检查文件的类型错误
```

#### [添加React Router](http://www.zcfy.cc/article/react-router-v4-the-complete-guide-mdash-sitepoint-4448.html)

1. 安装 React Router

   ```
   npm install --save react-router-dom
   npm install --save react-router-redux
   ```

2. 添加 Root Router

   ```
   <BrowserRouter>
       <App />
   </BrowserRouter>
   ```

3. 添加 Route

   ```
   <Switch>
       <Route path="/" exact component={HomeMgmt}/>
       <Route path="/courses" component={CoursesMgmt}/>
       <Route path="/students" component={StudentsMgmt}/>
       <Route path="/teachers" component={TeachersMgmt}/>
       <Route path="/parents" component={ParentsMgmt}/>
   </Switch>
   ```

4. 添加 Link

   ```
   <Link to="/courses">课程管理</Link>
   <Link to="/students">学生管理</Link>
   <Link to="/teachers">老师管理</Link>
   <Link to="/parents">家长管理</Link>
   ```

#### 添加 Redux 以及相关的中间件

```
npm install --save redux
npm install --save react-redux
npm install --save redux-thunk
npm install --save redux-logger
```

###测试React应用 

React 应用内默认集成了 [Jest](https://facebook.github.io/jest/zh-Hans/) 和 [Jsdom](https://github.com/jsdom/jsdom)

```
npm test
npm test -- --coverage // 测试并生成覆盖率报告
```

### 构建React应用

```
npm run build
```

### 持续集成(CI) && 部署(Deploy)








