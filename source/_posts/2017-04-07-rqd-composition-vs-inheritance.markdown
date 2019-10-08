---
layout: post
title:  "Composition vs Inheritance(组合与继承)"
date:   2017-04-07 11:11:11
categories: react
---

React has a powerful composition model, and we recommend using composition instead of inheritance to reuse code between components.

React具有强大的组合模型，我们建议使用组合而不是继承来重用组件之间的代码。

In this section, we will consider a few problems where developers new to React often reach for inheritance, and show how we can solve them with composition.

在本节中，我们将考虑开发者创建React应用经常会触碰到使用继承的几个问题，并展示我们如何用组合来解决它们。

## Containment (遏制)

Some components don't know their children ahead of time. This is especially common for components like `Sidebar` or `Dialog` that represent generic "boxes".

一些组件不能提前知道他们的孩子组件。 这对于表示通用“框”的`Sidebar`或`Dialog`的组件尤其常见。

We recommend that such components use the special `children` prop to pass children elements directly into their output:

我们建议像这样的组件使用特殊的`children`属性，将孩子元素直接传递到他们的输出中：

```js{4}
function FancyBorder(props) {
  return (
    <div className={'FancyBorder FancyBorder-' + props.color}>
      {props.children}
    </div>
  );
}
```

This lets other components pass arbitrary children to them by nesting the JSX:

这允许其他组件通过嵌套JSX传递任意孩子组件给它们：

```js{4-9}
function WelcomeDialog() {
  return (
    <FancyBorder color="blue">
      <h1 className="Dialog-title">
        Welcome
      </h1>
      <p className="Dialog-message">
        Thank you for visiting our spacecraft!
      </p>
    </FancyBorder>
  );
}
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/ozqNOV?editors=0010)

Anything inside the `<FancyBorder>` JSX tag gets passed into the `FancyBorder` component as a `children` prop. Since `FancyBorder` renders `{props.children}` inside a `<div>`, the passed elements appear in the final output.

`<FancyBorder>` JSX标签内的任何内容都将作为孩子组件传入`FancyBorder`组件。 由于`FancyBorder`组件将`{props.children}`呈现在`<div>`内，所以传递的孩子元素将显示在最终输出中。

While this is less common, sometimes you might need multiple "holes" in a component. In such cases you may come up with your own convention instead of using `children`:

虽然这不太常见，但有时您在组件中可能需要多个“孔”。 在这种情况下，您可以提出自己的惯例取代使用`children`：

```js{5,8,18,21}
function SplitPane(props) {
  return (
    <div className="SplitPane">
      <div className="SplitPane-left">
        {props.left}
      </div>
      <div className="SplitPane-right">
        {props.right}
      </div>
    </div>
  );
}

function App() {
  return (
    <SplitPane
      left={
        <Contacts />
      }
      right={
        <Chat />
      } />
  );
}
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/gwZOJp?editors=0010)

React elements like `<Contacts />` and `<Chat />` are just objects, so you can pass them as props like any other data.

React元素（例如`<Contacts />`和`<Chat />`）只是对象，因此您可以将其作为任何其他组件的属性并传递给它们。

## Specialization (专业化)

Sometimes we think about components as being "special cases" of other components. For example, we might say that a `WelcomeDialog` is a special case of `Dialog`.

有时我们认为组件是其他组件的“特殊情况”。 例如，我们可以说`WelcomeDialog`是`Dialog`的一个特例。

In React, this is also achieved by composition, where a more "specific" component renders a more "generic" one and configures it with props:

在React中，这也是通过组合来实现的，其中一个更“特定的”组件呈现出更“通用的”组件，并用属性来配置它：

```js{5,8,16-18}
function Dialog(props) {
  return (
    <FancyBorder color="blue">
      <h1 className="Dialog-title">
        {props.title}
      </h1>
      <p className="Dialog-message">
        {props.message}
      </p>
    </FancyBorder>
  );
}

function WelcomeDialog() {
  return (
    <Dialog
      title="Welcome"
      message="Thank you for visiting our spacecraft!" />
  );
}
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/kkEaOZ?editors=0010)

Composition works equally well for components defined as classes:

组合对于定义为类的组件同样适用：

```js{10,27-31}
function Dialog(props) {
  return (
    <FancyBorder color="blue">
      <h1 className="Dialog-title">
        {props.title}
      </h1>
      <p className="Dialog-message">
        {props.message}
      </p>
      {props.children}
    </FancyBorder>
  );
}

class SignUpDialog extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.handleSignUp = this.handleSignUp.bind(this);
    this.state = {login: ''};
  }

  render() {
    return (
      <Dialog title="Mars Exploration Program"
              message="How should we refer to you?">
        <input value={this.state.login}
               onChange={this.handleChange} />
        <button onClick={this.handleSignUp}>
          Sign Me Up!
        </button>
      </Dialog>
    );
  }

  handleChange(e) {
    this.setState({login: e.target.value});
  }

  handleSignUp() {
    alert(`Welcome aboard, ${this.state.login}!`);
  }
}
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/gwZbYa?editors=0010)

## So What About Inheritance? (那么继承如何呢？)

At Facebook, we use React in thousands of components, and we haven't found any use cases where we would recommend creating component inheritance hierarchies.

在Facebook上，我们在数千个组件中使用React，我们还没有发现任何用例，我们建议您创建组件继承层次结构。

Props and composition give you all the flexibility you need to customize a component's look and behavior in an explicit and safe way. Remember that components may accept arbitrary props, including primitive values, React elements, or functions.

属性和组合为您提供了以明确和安全的方式自定义组件外观和行为所需的所有灵活性。 请记住，组件可以接受任意属性，包括基本类型，React元素或函数。

If you want to reuse non-UI functionality between components, we suggest extracting it into a separate JavaScript module. The components may import it and use that function, object, or a class, without extending it.

如果要在组件之间重用非UI功能，我们建议将其提取到单独的JavaScript模块中。 组件可以导入它并使用该函数，对象或类，而不扩展它。