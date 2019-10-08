---
layout: post
title:  "Conditional Rendering(条件渲染)"
date:   2017-04-03 11:11:11
categories: react
---

In React, you can create distinct components that encapsulate behavior you need. Then, you can render only some of them, depending on the state of your application.

在React中，您可以创建不同的组件来封装所需的行为。 然后，您可以只渲染其中的一部分，具体取决于应用程序的状态。

Conditional rendering in React works the same way conditions work in JavaScript. Use JavaScript operators like [`if`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/if...else) or the [conditional operator](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/Conditional_Operator) to create elements representing the current state, and let React update the UI to match them.

React中的条件渲染与JavaScript中的条件相同。 使用if或条件运算符等JavaScript运算符创建表示当前状态的元素，然后让React更新UI来匹配它们。

Consider these two components:

考虑这两个组件：

```js
function UserGreeting(props) {
  return <h1>Welcome back!</h1>;
}

function GuestGreeting(props) {
  return <h1>Please sign up.</h1>;
}
```

We'll create a `Greeting` component that displays either of these components depending on whether a user is logged in:

我们将创建一个`Greeting`组件，根据用户是否登录，显示这些组件之一：

```javascript{3-7,11,12}
function Greeting(props) {
  const isLoggedIn = props.isLoggedIn;
  if (isLoggedIn) {
    return <UserGreeting />;
  }
  return <GuestGreeting />;
}

ReactDOM.render(
  // Try changing to isLoggedIn={true}:
  <Greeting isLoggedIn={false} />,
  document.getElementById('root')
);
```

[Try it on CodePen.](https://codepen.io/gaearon/pen/ZpVxNq?editors=0011)

This example renders a different greeting depending on the value of `isLoggedIn` prop.

此示例根据`isLoggedIn` prop的值呈现不同的问候语。

### Element Variables(元素变量)

You can use variables to store elements. This can help you conditionally render a part of the component while the rest of the output doesn't change.

您可以使用变量来存储元素。 这可以帮助您有条件地渲染组件的一部分，而输出的其余部分不会更改。

Consider these two new components representing Logout and Login buttons:

考虑这两个代表注销和登录按钮的新组件：

```js
function LoginButton(props) {
  return (
    <button onClick={props.onClick}>
      Login
    </button>
  );
}

function LogoutButton(props) {
  return (
    <button onClick={props.onClick}>
      Logout
    </button>
  );
}
```

In the example below, we will create a [stateful component](/react/docs/state-and-lifecycle.html#adding-local-state-to-a-class) called `LoginControl`.

在下面的例子中，我们将创建一个名为`LoginControl`的有状态组件。

It will render either `<LoginButton />` or `<LogoutButton />` depending on its current state. It will also render a `<Greeting />` from the previous example:

它将根据当前状态渲染`<LoginButton />`或`<LogoutButton />`。 它还将从上一个示例中呈现`<Greeting />`：

```javascript{20-25,29,30}
class LoginControl extends React.Component {
  constructor(props) {
    super(props);
    this.handleLoginClick = this.handleLoginClick.bind(this);
    this.handleLogoutClick = this.handleLogoutClick.bind(this);
    this.state = {isLoggedIn: false};
  }

  handleLoginClick() {
    this.setState({isLoggedIn: true});
  }

  handleLogoutClick() {
    this.setState({isLoggedIn: false});
  }

  render() {
    const isLoggedIn = this.state.isLoggedIn;

    let button = null;
    if (isLoggedIn) {
      button = <LogoutButton onClick={this.handleLogoutClick} />;
    } else {
      button = <LoginButton onClick={this.handleLoginClick} />;
    }

    return (
      <div>
        <Greeting isLoggedIn={isLoggedIn} />
        {button}
      </div>
    );
  }
}

ReactDOM.render(
  <LoginControl />,
  document.getElementById('root')
);
```

[Try it on CodePen.](https://codepen.io/gaearon/pen/QKzAgB?editors=0010)

While declaring a variable and using an `if` statement is a fine way to conditionally render a component, sometimes you might want to use a shorter syntax. There are a few ways to inline conditions in JSX, explained below.

虽然声明变量并使用if语句是有条件地渲染组件的好方法，但有时您可能希望使用较短的语法。 在JSX中有几种内联条件的方法，如下所述。

### Inline If with Logical && Operator(内联[比较运算符或逻辑运算符])

You may [embed any expressions in JSX](/react/docs/introducing-jsx.html#embedding-expressions-in-jsx) by wrapping them in curly braces. This includes the JavaScript logical `&&` operator. It can be handy for conditionally including an element:

您可以在JSX中嵌入任何表达式，方法是将其包裹在花括号中。 这包括JavaScript逻辑`&&`运算符。 它有助于有条件地渲染一个元素：

```js{6-10}
function Mailbox(props) {
  const unreadMessages = props.unreadMessages;
  return (
    <div>
      <h1>Hello!</h1>
      {unreadMessages.length > 0 &&
        <h2>
          You have {unreadMessages.length} unread messages.
        </h2>
      }
    </div>
  );
}

const messages = ['React', 'Re: React', 'Re:Re: React'];
ReactDOM.render(
  <Mailbox unreadMessages={messages} />,
  document.getElementById('root')
);
```

[Try it on CodePen.](https://codepen.io/gaearon/pen/ozJddz?editors=0010)

It works because in JavaScript, `true && expression` always evaluates to `expression`, and `false && expression` always evaluates to `false`.

因为在JavaScript中，它是有效的，`true && expression`总是认为表达式，并且 `false && expression` 总是认为false。

Therefore, if the condition is `true`, the element right after `&&` will appear in the output. If it is `false`, React will ignore and skip it.

所以，如果条件为`true`，则`&&`后面的元素将显示在输出中。 如果是`false`，React会忽略并跳过它。

### Inline If-Else with Conditional Operator(内联[if-Else有条件运算符])

Another method for conditionally rendering elements inline is to use the JavaScript conditional operator [`condition ? true : false`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/Conditional_Operator).

有条件地渲染元素的另一种方法是使用JavaScript条件运算符[`条件 ? 真 : 假`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/Conditional_Operator).

In the example below, we use it to conditionally render a small block of text.

```javascript{5}
render() {
  const isLoggedIn = this.state.isLoggedIn;
  return (
    <div>
      The user is <b>{isLoggedIn ? 'currently' : 'not'}</b> logged in.
    </div>
  );
}
```

It can also be used for larger expressions although it is less obvious what's going on:

虽然不太明显改变了什么，但它也可以用于更复杂的表达式：

```js{5,7,9}
render() {
  const isLoggedIn = this.state.isLoggedIn;
  return (
    <div>
      {isLoggedIn ? (
        <LogoutButton onClick={this.handleLogoutClick} />
      ) : (
        <LoginButton onClick={this.handleLoginClick} />
      )}
    </div>
  );
}
```

Just like in JavaScript, it is up to you to choose an appropriate style based on what you and your team consider more readable. Also remember that whenever conditions become too complex, it might be a good time to [extract a component](/react/docs/components-and-props.html#extracting-components).

就像在JavaScript中一样，您可以根据您和您的团队认为更易读的方式选择合适的样式。 还要记住，只要条件变得太复杂，可能是提取组件的好时机。

### Preventing Component from Rendering(防止组件渲染)

In rare cases you might want a component to hide itself even though it was rendered by another component. To do this return `null` instead of its render output.

在极少数情况下，您可能希望组件隐藏自身，即使它由另一个组件呈现。 为此，返回`null`而不是其渲染输出。

In the example below, the `<WarningBanner />` is rendered depending on the value of the prop called `warn`. If the value of the prop is `false`, then the component does not render:

在下面的示例中，根据名为`warn`的属性值渲染`<WarningBanner />`。 如果属性值为`false`，则该组件不呈现：

```javascript{2-4,29}
function WarningBanner(props) {
  if (!props.warn) {
    return null;
  }

  return (
    <div className="warning">
      Warning!
    </div>
  );
}

class Page extends React.Component {
  constructor(props) {
    super(props);
    this.state = {showWarning: true}
    this.handleToggleClick = this.handleToggleClick.bind(this);
  }

  handleToggleClick() {
    this.setState(prevState => ({
      showWarning: !prevState.showWarning
    }));
  }

  render() {
    return (
      <div>
        <WarningBanner warn={this.state.showWarning} />
        <button onClick={this.handleToggleClick}>
          {this.state.showWarning ? 'Hide' : 'Show'}
        </button>
      </div>
    );
  }
}

ReactDOM.render(
  <Page />,
  document.getElementById('root')
);
```

[Try it on CodePen.](https://codepen.io/gaearon/pen/Xjoqwm?editors=0010)

Returning `null` from a component's `render` method does not affect the firing of the component's lifecycle methods. For instance, `componentWillUpdate` and `componentDidUpdate` will still be called.

从组件的`render`方法返回null不会影响组件生命周期方法的触发。 例如，componentWillUpdate和componentDidUpdate仍将被调用。