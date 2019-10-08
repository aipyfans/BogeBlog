---
layout: post
title:  "Hello World(你好世界)"
date:   2017-03-28 11:11:11
categories: react
---

The easiest way to get started with React is to use [this Hello World example code on CodePen](http://codepen.io/gaearon/pen/ZpvBNJ?editors=0010). You don't need to install anything; you can just open it in another tab and follow along as we go through examples. If you'd rather use a local development environment, check out the [Installation](/react/docs/installation.html) page.

使用React开始的最简单的方法是在CodePen上使用这个Hello World示例代码。 你不需要安装任何东西; 您可以在另一个选项卡中打开它，并按照我们通过实例进行跟踪。 如果您希望使用本地开发环境，请查看安装页面。

The smallest React example looks like this:

最简洁的React示例如下所示：

```js
ReactDOM.render(
  <h1>Hello, world!</h1>,
  document.getElementById('root')
);
```

It renders a header saying "Hello, world!" on the page.

它在页面上渲染了一个标题 “Hello World!”

The next few sections will gradually introduce you to using React. We will examine the building blocks of React apps: elements and components. Once you master them, you can create complex apps from small reusable pieces.

接下来的几节将逐步地为您介绍使用React。 我们将解释React应用程序的构建块：【元素和组件】。 掌握它们后，您可以利用精简的元素和可复用的组件去创建复杂的应用程序。

## A Note on JavaScript（JS注意事项）

React is a JavaScript library, and so it assumes you have a basic understanding of the JavaScript language. If you don't feel very confident, we recommend [refreshing your JavaScript knowledge](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript) so you can follow along more easily.

React是一个JavaScript库，因此我们假设你对JavaScript语言有基本的了解。 如果您不太自信，我们建议您重新学习JavaScript知识，以便更轻松地学习React。

We also use some of the ES6 syntax in the examples. We try to use it sparingly because it's still relatively new, but we encourage you to get familiar with [arrow functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions), [classes](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes), [template literals](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Template_literals), [`let`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/let), and [`const`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const) statements. You can use <a href="http://babeljs.io/repl/#?babili=false&evaluate=true&lineWrap=false&presets=es2015%2Creact&experimental=false&loose=false&spec=false&code=const%20element%20%3D%20%3Ch1%3EHello%2C%20world!%3C%2Fh1%3E%3B%0Aconst%20container%20%3D%20document.getElementById('root')%3B%0AReactDOM.render(element%2C%20container)%3B%0A">Babel REPL</a> to check what ES6 code compiles to.

我们还在示例中使用了一些ES6语法。 因为它还比较新，所以我们会谨慎地尝试使用它，但是我们鼓励你熟悉箭头函数，类，模板文字，let和const语句。 您可以使用Babel REPL来检查ES6代码编译的内容。

