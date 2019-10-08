---
layout: post
title:  "Handling Events(处理事件)"
date:   2017-04-02 11:11:11
categories: react
---

Handling events with React elements is very similar to handling events on DOM elements. There are some syntactic differences:

使用React元素处理事件与处理DOM元素上的事件非常相似。 只不过有一些语法上的差异：

* React events are named using camelCase, rather than lowercase.
* React事件使用驼峰规则命名，而不是小写。
* With JSX you pass a function as the event handler, rather than a string.
* 使用JSX，您可以传递一个函数作为事件处理程序，而不是一个字符串。

For example, the HTML:

例如，HTML：

```html
<button onclick="activateLasers()">
  Activate Lasers
</button>
```

is slightly different in React:

在React中略有不同：

```js{1}
<button onClick={activateLasers}>
  Activate Lasers
</button>
```

Another difference is that you cannot return `false` to prevent default behavior in React. You must call `preventDefault` explicitly. For example, with plain HTML, to prevent the default link behavior of opening a new page, you can write:

另一个区别是您不能返回`false`以防止在React中的默认行为。 您必须显式调用`preventDefault`。 例如，使用纯HTML，为了防止打开新页面的默认链接行为，您可以写：

```html
<a href="#" onclick="console.log('The link was clicked.'); return false">
  Click me
</a>
```

In React, this could instead be:

在React中，这应该按如下方式代替：

```js{2-5,8}
function ActionLink() {
  function handleClick(e) {
    e.preventDefault();
    console.log('The link was clicked.');
  }

  return (
    <a href="#" onClick={handleClick}>
      Click me
    </a>
  );
}
```

Here, `e` is a synthetic event. React defines these synthetic events according to the [W3C spec](https://www.w3.org/TR/DOM-Level-3-Events/), so you don't need to worry about cross-browser compatibility. See the [`SyntheticEvent`](/react/docs/events.html) reference guide to learn more.

在这里，`e`是一个合成事件。 React根据W3C规范定义了这些合成事件，因此您不必担心跨浏览器的兼容性。 请参阅SyntheticEvent参考指南了解更多信息。

When using React you should generally not need to call `addEventListener` to add listeners to a DOM element after it is created. Instead, just provide a listener when the element is initially rendered.

当使用React时，您通常不需要调用addEventListener来在创建DOM元素之后添加监听器。 而是在元素最初呈现时提供一个监听器。

When you define a component using an [ES6 class](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Classes), a common pattern is for an event handler to be a method on the class. For example, this `Toggle` component renders a button that lets the user toggle between "ON" and "OFF" states:

当您使用ES6类定义组件时，常见的模式是将事件处理程序作为类上的方法。 例如，`Toggle`组件呈现一个按钮，让用户在“ON”和“OFF”状态之间切换：

```js{6,7,10-14,18}
class Toggle extends React.Component {
  constructor(props) {
    super(props);
    this.state = {isToggleOn: true};

    // This binding is necessary to make `this` work in the callback
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick() {
    this.setState(prevState => ({
      isToggleOn: !prevState.isToggleOn
    }));
  }

  render() {
    return (
      <button onClick={this.handleClick}>
        {this.state.isToggleOn ? 'ON' : 'OFF'}
      </button>
    );
  }
}

ReactDOM.render(
  <Toggle />,
  document.getElementById('root')
);
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/xEmzGg?editors=0010)

You have to be careful about the meaning of `this` in JSX callbacks. In JavaScript, class methods are not [bound](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_objects/Function/bind) by default. If you forget to bind `this.handleClick` and pass it to `onClick`, `this` will be `undefined` when the function is actually called.

在JSX回调中你必须要注意`this`的含义。 在JavaScript中，类方法默认不受约束。 如果您忘记绑定`this.handleClick`并将其传递给`onClick`，那么当该函数实际被调用时，这将是未定义的。

This is not React-specific behavior; it is a part of [how functions work in JavaScript](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/). Generally, if you refer to a method without `()` after it, such as `onClick={this.handleClick}`, you should bind that method.

这不是React具体的行为; 它是JavaScript中功能如何工作的一部分。 一般来说，如果你引用一个没有`（）`的方法，比如`onClick = {this.handleClick}`，你应该绑定该方法。

If calling `bind` annoys you, there are two ways you can get around this. If you are using the experimental [property initializer syntax](https://babeljs.io/docs/plugins/transform-class-properties/), you can use property initializers to correctly bind callbacks:

如果调用`绑定`令你烦恼，有两种方法可以解决这个问题。 如果您使用实验属性初始化程序语法，则可以使用属性初始值设置来正确绑定回调：


```js{2-6}
class LoggingButton extends React.Component {
  // This syntax ensures `this` is bound within handleClick.
  // Warning: this is *experimental* syntax.
  handleClick = () => {
    console.log('this is:', this);
  }

  render() {
    return (
      <button onClick={this.handleClick}>
        Click me
      </button>
    );
  }
}
```

This syntax is enabled by default in [Create React App](https://github.com/facebookincubator/create-react-app).

默认情况下，此语法在创建React应用程序中启用。

If you aren't using property initializer syntax, you can use an [arrow function](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Functions/Arrow_functions) in the callback:

如果您不使用属性初始化程序语法，则可以在回调中使用箭头函数：

```js{7-9}
class LoggingButton extends React.Component {
  handleClick() {
    console.log('this is:', this);
  }

  render() {
    // This syntax ensures `this` is bound within handleClick
    return (
      <button onClick={(e) => this.handleClick(e)}>
        Click me
      </button>
    );
  }
}
```

The problem with this syntax is that a different callback is created each time the `LoggingButton` renders. In most cases, this is fine. However, if this callback is passed as a prop to lower components, those components might do an extra re-rendering. We generally recommend binding in the constructor or using the property initializer syntax, to avoid this sort of performance problem.

这种语法的问题是：每次`LoggingButton`渲染时都会创建一个不同的回调函数。 在大多数情况下，这很好。 但是，如果这个回调作为支持传递给子组件，这些组件可能会进行额外的重新渲染。 **我们通常建议在构造函数中使用绑定或使用属性初始化器语法来避免这种性能问题**。



