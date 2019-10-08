---
layout: post
title:  "Rendering Elements(渲染组件)"
date:   2017-03-30 11:11:11
categories: react
---

Elements are the smallest building blocks of React apps.

元素是React应用程序中最小的构建块。

An element describes what you want to see on the screen:

一个元素描述您想要在屏幕上看到的内容：

```js
const element = <h1>Hello, world</h1>;
```

Unlike browser DOM elements, React elements are plain objects, and are cheap to create. React DOM takes care of updating the DOM to match the React elements.

与浏览器DOM元素不同，React元素是简单的对象，而且便于创建。 React DOM负责更新浏览器DOM，从而匹配React元素。

> **Note:**
>
> One might confuse elements with a more widely known concept of "components". We will introduce components in the [next section](/react/docs/components-and-props.html). Elements are what components are "made of", and we encourage you to read this section before jumping ahead.
>
> 注意：
>
> 人们可能会将元素与更广为人知的“组件”概念相混淆。 我们将在下一节介绍组件。 元素是“由...组成”的组件，我们建议您在跳到下一节之前阅读本节。

## Rendering an Element into the DOM(将元素渲染到DOM中)

Let's say there is a `<div>` somewhere in your HTML file:

假设你的HTML文件中有一个<div>标签：

```html
<div id="root"></div>
```

We call this a "root" DOM node because everything inside it will be managed by React DOM.

我们称之为“根”DOM节点，因为其中的所有内容都将由React DOM管理。

Applications built with just React usually have a single root DOM node. If you are integrating React into an existing app, you may have as many isolated root DOM nodes as you like.

使用React构建的应用程序通常具有单个根DOM节点。 如果您将React集成到现有应用程序中，则可能需要像您所需的一样多的孤立根DOM节点。

To render a React element into a root DOM node, pass both to `ReactDOM.render()`:

要将React元素渲染到根DOM节点中，请将它们都传递给`ReactDOM.render()`函数：

```js
const element = <h1>Hello, world</h1>;
ReactDOM.render(
  element,
  document.getElementById('root')
);
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/rrpgNB?editors=1010)

It displays "Hello, world" on the page.

它在页面上显示“Hello，world”。

## Updating the Rendered Element(更新渲染元素)

React elements are [immutable](https://en.wikipedia.org/wiki/Immutable_object). Once you create an element, you can't change its children or attributes. An element is like a single frame in a movie: it represents the UI at a certain point in time.

React元素是不可变的。 创建元素后，您无法更改其子项或属性。 一个元素就像一个电影中的一帧：它代表了某个时间点的画面。

With our knowledge so far, the only way to update the UI is to create a new element, and pass it to `ReactDOM.render()`.

根据我们目前所学的知识，更新UI的唯一方法是创建一个新元素，并将其传递给`ReactDOM.render()`。

Consider this ticking clock example:

考虑这个滴答作响的时钟示例：

```js{8-11}
function tick() {
  const element = (
    <div>
      <h1>Hello, world!</h1>
      <h2>It is {new Date().toLocaleTimeString()}.</h2>
    </div>
  );
  ReactDOM.render(
    element,
    document.getElementById('root')
  );
}

setInterval(tick, 1000);
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/gwoJZk?editors=0010)

It calls `ReactDOM.render()` every second from a [`setInterval()`](https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers/setInterval) callback.

它每秒从一个`setInterval()`回调函数中调用`ReactDOM.render()`。

> **Note:**
>
> In practice, most React apps only call `ReactDOM.render()` once. In the next sections we will learn how such code gets encapsulated into [stateful components](/react/docs/state-and-lifecycle.html).
>
> We recommend that you don't skip topics because they build on each other.
>
> 注意：
>
> 实际上，大多数React应用只会调用`ReactDOM.render()`一次。 在接下来的章节中，我们将学习如何将这些代码封装到有状态的组件中。
>
> 我们建议您不要跳过主题，因为它们建立在彼此之间。

## React Only Updates What's Necessary(React仅更新必要更新的元素)

React DOM compares the element and its children to the previous one, and only applies the DOM updates necessary to bring the DOM to the desired state.

React DOM将元素及其子元素与上一个元素进行比较，并将所需更新的DOM更新到所需的状态。

You can verify by inspecting the [last example](http://codepen.io/gaearon/pen/gwoJZk?editors=0010) with the browser tools:

您可以使用浏览器工具检查最后一个示例来验证：

![DOM inspector showing granular updates](https://facebook.github.io/react/img/docs/granular-dom-updates.gif)

Even though we create an element describing the whole UI tree on every tick, only the text node whose contents has changed gets updated by React DOM.

即使我们创建了一个描述整个UI树的元素，只有内容已经改变的文本节点才被React DOM更新。

In our experience, thinking about how the UI should look at any given moment rather than how to change it over time eliminates a whole class of bugs.

根据我们的经验，思考一下在特定时刻UI应该是什么样，而不是随着时间的推移去改变它以排除一系列漏洞。

