---
layout: post
title:  "Components and Props(组件和属性)"
date:   2017-03-31 11:11:11
categories: react
---

Components let you split the UI into independent, reusable pieces, and think about each piece in isolation.

组件让您将UI拆分成独立的可重复使用的部分，并单独考虑重复每个部分。

Conceptually, components are like JavaScript functions. They accept arbitrary inputs (called "props") and return React elements describing what should appear on the screen.

在概念上，组件就像JavaScript函数。 他们接受任意输入（称为“属性”），并返回描述应该在屏幕上显示的React元素。

## Functional and Class Components(功能函数和类组件)

The simplest way to define a component is to write a JavaScript function:

定义组件的最简单的方法是编写一个JavaScript函数：

```js
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}
```

This function is a valid React component because it accepts a single "props" object argument with data and returns a React element. We call such components "functional" because they are literally JavaScript functions.

该函数是一个有效的React组件，因为它接受一个单一的“props”对象参数数据并返回一个React元素。 我们将这些组件称为“功能函数”，因为它们是字面上的`JavaScript`函数。

You can also use an [ES6 class](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Classes) to define a component:

你也可以用一个ES6的类定义一个组件：

```js
class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}
```

The above two components are equivalent from React's point of view.

从React的角度来看，上面这两个组件实现的功能都是一样的。

Classes have some additional features that we will discuss in the [next sections](/react/docs/state-and-lifecycle.html). Until then, we will use functional components for their conciseness.

课程有一些额外的功能，我们将在下一节讨论。 在此之前，我们将使用功能组件来简化。

## Rendering a Component(渲染组件)

Previously, we only encountered React elements that represent DOM tags:

以前，我们只遇到代表DOM标签的React元素：

```js
const element = <div />;
```

However, elements can also represent user-defined components:

然而，元素也可以表示用户自定义的组件：

```js
const element = <Welcome name="Sara" />;
```

When React sees an element representing a user-defined component, it passes JSX attributes to this component as a single object. We call this object "props".

当React遇到一个表示用户自定义的组件作为元素时，它将JSX属性作为单个对象传递给该组件。 我们称这个对象为"props(属性)"。

For example, this code renders "Hello, Sara" on the page:

例如，该代码在页面上显示“Hello，Sara”：

```js{1,5}
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}

const element = <Welcome name="Sara" />;
ReactDOM.render(
  element,
  document.getElementById('root')
);
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/YGYmEG?editors=0010)

Let's recap what happens in this example:

1. We call `ReactDOM.render()` with the `<Welcome name="Sara" />` element.
2. React calls the `Welcome` component with `{name: 'Sara'}` as the props.
3. Our `Welcome` component returns a `<h1>Hello, Sara</h1>` element as the result.
4. React DOM efficiently updates the DOM to match `<h1>Hello, Sara</h1>`.

我们来回顾一下在这个例子中会发生什么：

1.我们使用`<Welcome name =“Sara”/>`元素作为`ReactDOM.render()`函数的参数。
2.React调用使用`{name：'Sara'}`作为`Welcome`组件的属性。
3.我们的 `Welcome` 组件返回一个`<h1> Hello，Sara </ h1>`元素作为结果。
4.React DOM有效地更新DOM以匹配`<h1> Hello，Sara </ h1>`元素的变化。

>**Caveat:**
>
>Always start component names with a capital letter.
>
>For example, `<div />` represents a DOM tag, but `<Welcome />` represents a component and requires `Welcome` to be in scope.
>
>警告：
>
>始终使用大写字母组件开始的名称。
>
>例如，`<div />`表示一个DOM标签，但`<Welcome />`表示一个组件，并且要求`Welcome`在要求范围内。

## Composing Components(组成部分)

Components can refer to other components in their output. This lets us use the same component abstraction for any level of detail. A button, a form, a dialog, a screen: in React apps, all those are commonly expressed as components.

组件可以在其输出中引用其他组件。 这使我们可以对任何级别的部分使用相同的组件抽象。 按钮，表单，对话框，屏幕：在React应用程序中，所有这些通常都表示为组件。

For example, we can create an `App` component that renders `Welcome` many times:

例如，我们可以创建一个可以多次呈现`Welcome` 的App组件：

```js{8-10}
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}

function App() {
  return (
    <div>
      <Welcome name="Sara" />
      <Welcome name="Cahal" />
      <Welcome name="Edite" />
    </div>
  );
}

ReactDOM.render(
  <App />,
  document.getElementById('root')
);
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/KgQKPr?editors=0010)

Typically, new React apps have a single `App` component at the very top. However, if you integrate React into an existing app, you might start bottom-up with a small component like `Button` and gradually work your way to the top of the view hierarchy.

通常，新的React应用程序的顶部有一个App组件。 但是，如果将React集成到现有应用程序中，则可以使用像Button这样的小组件从自下而上开始，并逐渐替换到视图层次结构的顶部。

>**Caveat:**
>
>Components must return a single root element. This is why we added a `<div>` to contain all the `<Welcome />` elements.
>
>警告：
>
>组件必须返回单个根元素。 这就是为什么我们添加了一个`<div>`标签来包含所有的`<Welcome />`元素。

## Extracting Components(提取组件)

Don't be afraid to split components into smaller components.

不要担心将组件拆分成更小的组件。

For example, consider this `Comment` component:

例如，考虑这个 `Comment` 组件：

```js
function Comment(props) {
  return (
    <div className="Comment">
      <div className="UserInfo">
        <img className="Avatar"
          src={props.author.avatarUrl}
          alt={props.author.name}
        />
        <div className="UserInfo-name">
          {props.author.name}
        </div>
      </div>
      <div className="Comment-text">
        {props.text}
      </div>
      <div className="Comment-date">
        {formatDate(props.date)}
      </div>
    </div>
  );
}
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/VKQwEo?editors=0010)

It accepts `author` (an object), `text` (a string), and `date` (a date) as props, and describes a comment on a social media website.

它接受作者（对象），文本（字符串）和日期（日期）作为属性，并在社交媒体网站上描述评论。

This component can be tricky to change because of all the nesting, and it is also hard to reuse individual parts of it. Let's extract a few components from it.

由于所有的嵌套，这个组件可能很难改变，并且很难重用它的各个部分。 我们从中提取几个组件。

First, we will extract `Avatar`:

首先，我们将提取`Avatar`：

```js{3-6}
function Avatar(props) {
  return (
    <img className="Avatar"
      src={props.user.avatarUrl}
      alt={props.user.name}
    />
  );
}
```

The `Avatar` doesn't need to know that it is being rendered inside a `Comment`. This is why we have given its prop a more generic name: `user` rather than `author`.

`Avatar`不需要知道它在`Comment`中被渲染。 这就是为什么我们给它的属性一个更通用的名称： `user` 而不是 `author`。

We recommend naming props from the component's own point of view rather than the context in which it is being used.

我们建议从组件自己的角度来命名道具，而不是使用组件所处的环境。

We can now simplify `Comment` a tiny bit:

我们现在可以简化 `Comment` ：

```js{5}
function Comment(props) {
  return (
    <div className="Comment">
      <div className="UserInfo">
        <Avatar user={props.author} />
        <div className="UserInfo-name">
          {props.author.name}
        </div>
      </div>
      <div className="Comment-text">
        {props.text}
      </div>
      <div className="Comment-date">
        {formatDate(props.date)}
      </div>
    </div>
  );
}
```

Next, we will extract a `UserInfo` component that renders an `Avatar` next to user's name:

接下来，我们将提取一个`UserInfo`组件，用于将`Avatar`显示在用户名旁边：

```js{3-8}
function UserInfo(props) {
  return (
    <div className="UserInfo">
      <Avatar user={props.user} />
      <div className="UserInfo-name">
        {props.user.name}
      </div>
    </div>
  );
}
```

This lets us simplify `Comment` even further:

这让我们进一步简化 `Comment` ：

```js{4}
function Comment(props) {
  return (
    <div className="Comment">
      <UserInfo user={props.author} />
      <div className="Comment-text">
        {props.text}
      </div>
      <div className="Comment-date">
        {formatDate(props.date)}
      </div>
    </div>
  );
}
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/rrJNJY?editors=0010)

Extracting components might seem like grunt work at first, but having a palette of reusable components pays off in larger apps. A good rule of thumb is that if a part of your UI is used several times (`Button`, `Panel`, `Avatar`), or is complex enough on its own (`App`, `FeedStory`, `Comment`), it is a good candidate to be a reusable component.

首先，提取组件可能看起来像繁琐的工作，但是在较大的应用程序中可以使用可重用组件的调色板。 一个很好的经验法则是，如果您的UI的一部分被使用了几次 (`Button`, `Panel`, `Avatar`)，或者页面足够复杂 (`App`, `FeedStory`, `Comment`)，那么这作为可重用组件的候选方案 。

## Props are Read-Only(属性只能被读取)

Whether you declare a component [as a function or a class](#functional-and-class-components), it must never modify its own props. Consider this `sum` function:

无论您将组件声明为函数还是类，都不能修改自己的属性。 考虑这个"求和"函数：

```js
function sum(a, b) {
  return a + b;
}
```

Such functions are called ["pure"](https://en.wikipedia.org/wiki/Pure_function) because they do not attempt to change their inputs, and always return the same result for the same inputs.

这些功能被称为“纯函数”，因为它们不会尝试更改其输入的内容，并且总是为相同的输入返回相同的结果。

In contrast, this function is impure because it changes its own input:

相比之下，这个功能不是纯函数，因为它改变了自己的输入：

```js
function withdraw(account, amount) {
  account.total -= amount;
}
```

React is pretty flexible but it has a single strict rule:

React非常灵活，但它有一个严格的规则：

**All React components must act like pure functions with respect to their props.**

**所有React组件必须像纯函数的功能一样对`属性`进行使用。**

Of course, application UIs are dynamic and change over time. In the [next section](/react/docs/state-and-lifecycle.html), we will introduce a new concept of "state". State allows React components to change their output over time in response to user actions, network responses, and anything else, without violating this rule.

当然，应用程序UI是动态的，随着时间的推移而改变。 在下一节中，我们将介绍一个`state(状态)`的新概念。 状态允许React组件根据用户操作，网络响应以及其他任何内容随时间更改其输出，而不会违反此规则。
