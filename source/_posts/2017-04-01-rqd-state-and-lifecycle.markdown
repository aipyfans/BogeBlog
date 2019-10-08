---
layout: post
title:  "State and Lifecycle(状态和生命周期)"
date:   2017-04-01 11:11:11
categories: react
---

Consider the ticking clock example from [one of the previous sections](/react/docs/rendering-elements.html#updating-the-rendered-element).

考虑上一节的秒表时钟示例。

So far we have only learned one way to update the UI.

到目前为止，我们只学到了一种更新UI的方法。

We call `ReactDOM.render()` to change the rendered output:

我们调用 `ReactDOM.render()`来更改渲染的输出：

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

In this section, we will learn how to make the `Clock` component truly reusable and encapsulated. It will set up its own timer and update itself every second.

在本节中，我们将学习如何使`Clock`组件真正可重用和并对其封装。 它将设置自己的计时器并每秒更新一次。

We can start by encapsulating how the clock looks:

我们可以从封装时钟开始：

```js{3-6,12}
function Clock(props) {
  return (
    <div>
      <h1>Hello, world!</h1>
      <h2>It is {props.date.toLocaleTimeString()}.</h2>
    </div>
  );
}

function tick() {
  ReactDOM.render(
    <Clock date={new Date()} />,
    document.getElementById('root')
  );
}

setInterval(tick, 1000);
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/dpdoYR?editors=0010)

However, it misses a crucial requirement: the fact that the `Clock` sets up a timer and updates the UI every second should be an implementation detail of the `Clock`.

然而，它错过了一个关键的要求：`Clock`设置定时器并每秒更新UI的事实应该是`Clock`的实现细节。

Ideally we want to write this once and have the `Clock` update itself:

理想情况下，我们要写一下这个时钟更新本身：

```js{2}
ReactDOM.render(
  <Clock />,
  document.getElementById('root')
);
```

To implement this, we need to add "state" to the `Clock` component.

为了实现这一点，我们需要在`Clock`组件中添加"state"。

State is similar to props, but it is private and fully controlled by the component.

状态(State)类似于属性，但它是私有的，完全由组件控制。

We [mentioned before](/react/docs/components-and-props.html#functional-and-class-components) that components defined as classes have some additional features. Local state is exactly that: a feature available only to classes.

我们之前提到，定义为类的组件具有一些附加功能。 本地状态就是这样：一个功能只适用于类。

## Converting a Function to a Class(将函数转换为类)

You can convert a functional component like `Clock` to a class in five steps:

1. Create an [ES6 class](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Classes) with the same name that extends `React.Component`.
2. Add a single empty method to it called `render()`.
3. Move the body of the function into the `render()` method.
4. Replace `props` with `this.props` in the `render()` body.
5. Delete the remaining empty function declaration.

---

您可以通过五个步骤将时钟功能组件转换为类：

1. 创建一个名称继承为`React.Component`的ES6类。
2. 在类中添加一个名为`render()`的空方法。
3. 将函数体移动到`render()`方法中。
4. 在`render()`函数中使用this.props替换`props`。
5. 删除剩余的空函数声明。

```js
class Clock extends React.Component {
  render() {
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {this.props.date.toLocaleTimeString()}.</h2>
      </div>
    );
  }
}
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/zKRGpo?editors=0010)

`Clock` is now defined as a class rather than a function.

`Clock`现在被定义为一个类而不是一个函数。

This lets us use additional features such as local state and lifecycle hooks.

这使我们可以使用其他功能，如本地状态和生命周期的钩子函数。

## Adding Local State to a Class(将本地状态添加到类)

We will move the `date` from props to state in three steps:

我们将分三个步骤，将`date`的属性映射到状态。

1) Replace `this.props.date` with `this.state.date` in the `render()` method:

1）在`render()`方法中将this.props.date替换为this.state.date：

```js{6}
class Clock extends React.Component {
  render() {
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {this.state.date.toLocaleTimeString()}.</h2>
      </div>
    );
  }
}
```

2) Add a [class constructor](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Classes#Constructor) that assigns the initial `this.state`:

2）添加分配初始this.state到类的构造函数中：

```js{4}
class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {date: new Date()};
  }

  render() {
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {this.state.date.toLocaleTimeString()}.</h2>
      </div>
    );
  }
}
```

Note how we pass `props` to the base constructor:

注意我们如何将 `props` 传递给基础构造函数：

```js{2}
  constructor(props) {
    super(props);
    this.state = {date: new Date()};
  }
```

Class components should always call the base constructor with `props`.

类组件应始终使用 `props`调用基础构造函数。

3) Remove the `date` prop from the `<Clock />` element:

3）从`<Clock />`元素中删除日期：

```js{2}
ReactDOM.render(
  <Clock />,
  document.getElementById('root')
);
```

We will later add the timer code back to the component itself.

稍后将定时器代码添加回组件本身。

The result looks like this:

结果如下：

```js{2-5,11,18}
class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {date: new Date()};
  }

  render() {
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {this.state.date.toLocaleTimeString()}.</h2>
      </div>
    );
  }
}

ReactDOM.render(
  <Clock />,
  document.getElementById('root')
);
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/KgQpJd?editors=0010)

Next, we'll make the `Clock` set up its own timer and update itself every second.

接下来，我们将使`Clock`设置自己的定时器并每秒更新一次。

## Adding Lifecycle Methods to a Class(将生命周期方法添加到类中)

In applications with many components, it's very important to free up resources taken by the components when they are destroyed.

在具有许多组件的应用程序中，在销毁时释放组件所占用的资源非常重要。

We want to [set up a timer](https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers/setInterval) whenever the `Clock` is rendered to the DOM for the first time. This is called "mounting" in React.

当`Clock`第一次渲染到DOM时，我们要设置一个定时器。 这在React中称为“挂载”。

We also want to [clear that timer](https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers/clearInterval) whenever the DOM produced by the `Clock` is removed. This is called "unmounting" in React.

当`Clock`产生的DOM被删除时，我们也想清除该计时器。 这在React中称为“卸载”。

We can declare special methods on the component class to run some code when a component mounts and unmounts:

当组件挂载和卸载时，我们可以在组件类上声明特殊的方法来运行一些代码：

```js{7-9,11-13}
class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {date: new Date()};
  }

  componentDidMount() {

  }

  componentWillUnmount() {

  }

  render() {
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {this.state.date.toLocaleTimeString()}.</h2>
      </div>
    );
  }
}
```

These methods are called "lifecycle hooks".

这些方法称为“生命周期钩子函数”。

The `componentDidMount()` hook runs after the component output has been rendered to the DOM. This is a good place to set up a timer:

在组件输出已经渲染给DOM之后， `componentDidMount()` 钩子函数运行。 这是一个建立定时器的好地方：

```js{2-5}
  componentDidMount() {
    this.timerID = setInterval(
      () => this.tick(),
      1000
    );
  }
```

Note how we save the timer ID right on `this`.

注意我们如何在`this`上保存正确的计时器ID。

While `this.props` is set up by React itself and `this.state` has a special meaning, you are free to add additional fields to the class manually if you need to store something that is not used for the visual output.

虽`this.props`由React本身设置，而this.state具有特殊的含义，但如果需要存储未用于可视输出的内容，则可以手动向类中添加其他字段。

If you don't use something in `render()`, it shouldn't be in the state.

如果您不在 `render()`,中使用某些东西，则不应该处于该状态。

We will tear down the timer in the `componentWillUnmount()` lifecycle hook:

我们将在componentWillUnmount()生命周期钩子函数中终止计时器：

```js{2}
  componentWillUnmount() {
    clearInterval(this.timerID);
  }
```

Finally, we will implement the `tick()` method that runs every second.

最后，我们将实现每秒运行的`tick()` 方法。

It will use `this.setState()` to schedule updates to the component local state:

它将使用`this.setState()` 来计划更新组件的本地状态：

```js{18-22}
class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {date: new Date()};
  }

  componentDidMount() {
    this.timerID = setInterval(
      () => this.tick(),
      1000
    );
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  tick() {
    this.setState({
      date: new Date()
    });
  }

  render() {
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {this.state.date.toLocaleTimeString()}.</h2>
      </div>
    );
  }
}

ReactDOM.render(
  <Clock />,
  document.getElementById('root')
);
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/amqdNA?editors=0010)

Now the clock ticks every second.

现在时钟每秒钟滴答滴答的跑个不停。

Let's quickly recap what's going on and the order in which the methods are called:

让我们快速回顾一下发生了什么以及调用方法的顺序：

1) When `<Clock />` is passed to `ReactDOM.render()`, React calls the constructor of the `Clock` component. Since `Clock` needs to display the current time, it initializes `this.state` with an object including the current time. We will later update this state.

1）当`<Clock />`传递给`ReactDOM.render（）`时，React调用`Clock`组件的构造函数。 由于`Clock`需要显示当前时间，所以它将使用包含当前时间的对象来初始化`this.state`。 我们稍后会更新此状态。

2) React then calls the `Clock` component's `render()` method. This is how React learns what should be displayed on the screen. React then updates the DOM to match the `Clock`'s render output.

2）React然后调用`Clock`组件的`render（）`方法。 这时React知道如何在屏幕上显示内容。 然后，React更新DOM以匹配`Clock`的渲染输出。

3) When the `Clock` output is inserted in the DOM, React calls the `componentDidMount()` lifecycle hook. Inside it, the `Clock` component asks the browser to set up a timer to call `tick()` once a second.

3）当时钟输出插入到DOM中时，React调用`componentDidMount（）`生命周期钩子函数。 在其中，`Clock`组件要求浏览器设置一个定时器来每秒调用`tick（）`一次。

4) Every second the browser calls the `tick()` method. Inside it, the `Clock` component schedules a UI update by calling `setState()` with an object containing the current time. Thanks to the `setState()` call, React knows the state has changed, and calls `render()` method again to learn what should be on the screen. This time, `this.state.date` in the `render()` method will be different, and so the render output will include the updated time. React updates the DOM accordingly.

4）浏览器每秒钟调用`tick（）`方法。 在其中，`Clock`组件通过使用包含当前时间的对象调用`setState（）`来调动UI更新。 感谢`setState（`）调用，React知道状态已经改变，并再次调用`render（）`方法来了解屏幕上应该更新或渲染什么。 这一次，`render（）`方法中的`this.state.date`将不同，因此渲染输出将包含更新的时间。 React会相应地更新DOM。

5) If the `Clock` component is ever removed from the DOM, React calls the `componentWillUnmount()` lifecycle hook so the timer is stopped.

5）如果时钟组件从DOM中删除，则React会调用`componentWillUnmount（）`生命周期钩子函数，以使定时器停止。

## Using State Correctly（正确使用状态）

There are three things you should know about `setState()`.

你应该知道有关`setState（）`的三件事情。

### Do Not Modify State Directly(不要直接修改状态)

For example, this will not re-render a component:

例如，这不会重新渲染组件：

```js
// Wrong
this.state.comment = 'Hello';
```

Instead, use `setState()`:

而是使用`setState（）`代替：

```js
// Correct
this.setState({comment: 'Hello'});
```

The only place where you can assign `this.state` is the constructor.

唯一可以分配`this.state`的地方是构造函数。

### State Updates May Be Asynchronous(状态更新可能是异步的)

React may batch multiple `setState()` calls into a single update for performance.

React可以将多个setState（）批量调用转化为单个更新以实现性能优化。

Because `this.props` and `this.state` may be updated asynchronously, you should not rely on their values for calculating the next state.

因为`this.props`和`this.state`可能会异步更新，所以您不应该依靠它们的值来计算下一个状态。

For example, this code may fail to update the counter:

例如，此代码可能无法更新计数器：

```js
// Wrong
this.setState({
  counter: this.state.counter + this.props.increment,
});
```

To fix it, use a second form of `setState()` that accepts a function rather than an object. That function will receive the previous state as the first argument, and the props at the time the update is applied as the second argument:

要修复它，请使用第二个形式的接受函数而不是对象的`setState（）`。 该函数将接收先前的状态作为第一个参数，并且更新应用时的属性作为第二个参数：

```js
// Correct
this.setState((prevState, props) => ({
  counter: prevState.counter + props.increment
}));
```

We used an [arrow function](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Functions/Arrow_functions) above, but it also works with regular functions:

我们使用了上面的箭头函数，但它也适用于常规函数：

```js
// Correct
this.setState(function(prevState, props) {
  return {
    counter: prevState.counter + props.increment
  };
});
```

### State Updates are Merged（状态更新即合并）

When you call `setState()`, React merges the object you provide into the current state.

当您调用`setState()`时，React将您提供的对象合并到当前状态。

For example, your state may contain several independent variables:

例如，您的状态可能包含几个独立变量：

```js{4,5}
  constructor(props) {
    super(props);
    this.state = {
      posts: [],
      comments: []
    };
  }
```

Then you can update them independently with separate `setState()` calls:

然后可以使用单独的`setState（）`调用独立更新它们：

```js{4,10}
  componentDidMount() {
    fetchPosts().then(response => {
      this.setState({
        posts: response.posts
      });
    });

    fetchComments().then(response => {
      this.setState({
        comments: response.comments
      });
    });
  }
```

The merging is shallow, so `this.setState({comments})` leaves `this.state.posts` intact, but completely replaces `this.state.comments`.

合并很浅，所以`this.setState（{comments}）`与`this.state.posts`各自完整，但完全替代了`this.state.comments`。

## The Data Flows Down（数据流）

Neither parent nor child components can know if a certain component is stateful or stateless, and they shouldn't care whether it is defined as a function or a class.

父组件和子组件都不能知道某个组件是有状态还是无状态，并且它们不应该关心它是否被定义为函数或类。

This is why state is often called local or encapsulated. It is not accessible to any component other than the one that owns and sets it.

这就是为什么状态通常被称为局部调用或封装。 除了设置它自身之外，它不可访问其它的任何组件。

A component may choose to pass its state down as props to its child components:

组件可以选择将其状态作为属性传递给其子组件：

```js
<h2>It is {this.state.date.toLocaleTimeString()}.</h2>
```

This also works for user-defined components:

这也适用于用户自定义的组件：

```js
<FormattedDate date={this.state.date} />
```

The `FormattedDate` component would receive the `date` in its props and wouldn't know whether it came from the `Clock`'s state, from the `Clock`'s props, or was typed by hand:

`FormattedDate`组件将在其属性中收到`日期`，并且不知道它是来自`时钟`的状态，还是来自`时钟`的属性，还是手动输入：

```js
function FormattedDate(props) {
  return <h2>It is {props.date.toLocaleTimeString()}.</h2>;
}
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/zKRqNB?editors=0010)

This is commonly called a "top-down" or "unidirectional" data flow. Any state is always owned by some specific component, and any data or UI derived from that state can only affect components "below" them in the tree.

这通常被称为“自顶向下”或“单向”数据流。 任何状态始终由某个特定组件所有，并且从该状态导出的任何数据或UI只能影响树中“下方”的组件。

If you imagine a component tree as a waterfall of props, each component's state is like an additional water source that joins it at an arbitrary point but also flows down.

如果你想象一个组件树作为属性的瀑布，每个组件的状态就像一个额外的水源，它连接在一个任意点，但也流下来。

To show that all components are truly isolated, we can create an `App` component that renders three `<Clock>`s:

为了表明所有组件都是真正隔离的，我们可以创建一个应用程序组件，呈现三个`<Clock>`：

```js{4-6}
function App() {
  return (
    <div>
      <Clock />
      <Clock />
      <Clock />
    </div>
  );
}

ReactDOM.render(
  <App />,
  document.getElementById('root')
);
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/vXdGmd?editors=0010)

Each `Clock` sets up its own timer and updates independently.

每个时钟设置自己的定时器并独自更新。

In React apps, whether a component is stateful or stateless is considered an implementation detail of the component that may change over time. You can use stateless components inside stateful components, and vice versa.

在React应用程序中，组件是有状态还是无状态被认为是可能随时间而变化的组件的实现细节。 可以在有状态组件中使用无状态组件，反之亦然。
