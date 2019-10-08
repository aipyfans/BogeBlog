---
layout: post
title:  "Refs and the DOM(DOM节点的引用)"
date:   2017-04-11 11:11:11
categories: react
---



In the typical React dataflow, [props](/react/docs/components-and-props.html) are the only way that parent components interact with their children. To modify a child, you re-render it with new props. However, there are a few cases where you need to imperatively modify a child outside of the typical dataflow. The child to be modified could be an instance of a React component, or it could be a DOM element. For both of these cases, React provides an escape hatch.

在典型的React数据流中， [props]()是父组件与子组件互动的唯一方法。 要修改子组件，请用新的props重新渲染。 但是，有几种情况需要在典型数据流之外强制修改子组件。 要修改的子组件可以是React组件的一个实例，也可以是一个DOM元素。 对于这两种情况，React提供了一个逃生舱口。

### When to Use Refs (何时使用Refs引用)

There are a few good use cases for refs:

在这里有一些关于Refs很好的用例

* Managing focus, text selection, or media playback.
* 管理焦点，文本选择或媒体播放。
* Triggering imperative animations.
* 触发强制性动画。
* Integrating with third-party DOM libraries.
* 与第三方DOM库集成。

Avoid using refs for anything that can be done declaratively.

避免使用refs声明性地做任何事情。

For example, instead of exposing `open()` and `close()` methods on a `Dialog` component, pass an `isOpen` prop to it.

例如，不要在Dialog组件上暴露`open（）`和`close（）`方法，而是将一个`isOpen`属性传递给它。

### Adding a Ref to a DOM Element (添加Ref引用到DOM元素)

React supports a special attribute that you can attach to any component. The `ref` attribute takes a callback function, and the callback will be executed immediately after the component is mounted or unmounted.

React支持一个可以附加到任何组件的特殊属性。 `ref`属性采用回调函数，并且在组件被装载或卸载之后立即执行回调。

When the `ref` attribute is used on an HTML element, the `ref` callback receives the underlying DOM element as its argument. For example, this code uses the `ref` callback to store a reference to a DOM node:

当在HTML元素上使用`ref`属性时，`ref`回调接收底层的DOM元素作为其参数。 例如，此代码使用引用回调来存储对DOM节点的引用：

```javascript{8,9,19}
class CustomTextInput extends React.Component {

  constructor(props) {
    super(props);
    this.focus = this.focus.bind(this);
  }

  focus() {
    // Explicitly focus the text input using the raw DOM API
    // 使用原始DOM API明确地将文本输入聚焦
    this.textInput.focus();
  }

  render() {
    // Use the `ref` callback to store a reference to the text input DOM
    // element in an instance field (for example, this.textInput).
    // 使用`ref`回调来存储对文本输入DOM的引用
    // 实例字段中的元素（例如this.textInput）
    return (
      <div>
        <input
          type="text"
          ref={(input) => { this.textInput = input; }} />
        <input
          type="button"
          value="Focus the text input"
          onClick={this.focus}
        />
      </div>
    );
  }
}
```

React will call the `ref` callback with the DOM element when the component mounts, and call it with `null` when it unmounts.

当组件挂载时，React将使用DOM元素调用`ref`回调，并在卸载时将其调用为`null`。

Using the `ref` callback just to set a property on the class is a common pattern for accessing DOM elements. The preferred way is to set the property in the `ref` callback like in the above example. There is even a shorter way to write it: `ref={input => this.textInput = input}`. 

使用`ref`回调只是为了在类上设置属性，这是访问DOM元素的常见模式。 首选的方法是在`ref`回调中设置属性，就像上面的例子一样。 甚至有一个较短的写法：`ref = {input => this.textInput = input}`。

### Adding a Ref to a Class Component (添加Ref引用到类组件)

When the `ref` attribute is used on a custom component declared as a class, the `ref` callback receives the mounted instance of the component as its argument. For example, if we wanted to wrap the `CustomTextInput` above to simulate it being clicked immediately after mounting:

当在声明为类的自定义组件中使用`ref`属性时，`ref`回调接收组件的已挂载实例作为其参数。 例如，如果我们想要包装上面的`CustomTextInput`来模拟它在安装后立即被点击：

```javascript{3,9}
class AutoFocusTextInput extends React.Component {

  componentDidMount() {
    this.textInput.focus();
  }

  render() {
    return (
      <CustomTextInput
        ref={(input) => { this.textInput = input; }} />
    );
  }
}
```

Note that this only works if `CustomTextInput` is declared as a class:

请注意，这仅在`CustomTextInput`被声明为类时才有效：

```js{1}
class CustomTextInput extends React.Component {
  // ...
}
```

### Refs and Functional Components (Refs引用和功能组件)

**You may not use the `ref` attribute on functional components** because they don't have instances:

**您不能在功能组件上使用`ref`属性**，因为它们没有实例：

```javascript{1,7}
function MyFunctionalComponent() {
  return <input />;
}

class Parent extends React.Component {
  render() {
    // This will *not* work!
    // 这样是 不能 运行的
    return (
      <MyFunctionalComponent
        ref={(input) => { this.textInput = input; }} />
    );
  }
}
```

You should convert the component to a class if you need a ref to it, just like you do when you need lifecycle methods or state.

如果需要Ref去引用它，您应该将组件转换为类，就像在需要生命周期方法或状态时一样。

You can, however, **use the `ref` attribute inside a functional component** as long as you refer to a DOM element or a class component:

但是，只要您引用DOM元素或类组件，您可以使用功能组件中的`ref`属性：

```javascript{2,3,6,13}
function CustomTextInput(props) {
  // textInput must be declared here so the ref callback can refer to it
  // textInput必须在这里声明，所以ref回调可以引用它
  let textInput = null;

  function handleClick() {
    textInput.focus();
  }

  return (
    <div>
      <input
        type="text"
        ref={(input) => { textInput = input; }} />
      <input
        type="button"
        value="Focus the text input"
        onClick={handleClick}
      />
    </div>
  );  
}
```

### Don't Overuse Refs (不要过度使用Refs引用)

Your first inclination may be to use refs to "make things happen" in your app. If this is the case, take a moment and think more critically about where state should be owned in the component hierarchy. Often, it becomes clear that the proper place to "own" that state is at a higher level in the hierarchy. See the [Lifting State Up](/react/docs/lifting-state-up.html) guide for examples of this.

您的第一个倾向可能是在应用程序中使用Refs引用“使事情发生”。 如果是这种情况，请花一点时间，更多地关注组件层次结构中的状态应该如何拥有。 通常，很明显，“拥有”该状态的适当位置在层次结构中处于较高级别。 有关示例，请参阅[提升状态向导]()”。

### Legacy API: String Refs (旧版API：字符串引用参考)

If you worked with React before, you might be familiar with an older API where the `ref` attribute is a string, like `"textInput"`, and the DOM node is accessed as `this.refs.textInput`. We advise against it because string refs have [some issues](https://github.com/facebook/react/pull/8333#issuecomment-271648615), are considered legacy, and **are likely to be removed in one of the future releases**. If you're currently using `this.refs.textInput` to access refs, we recommend the callback pattern instead.

如果您之前使用过React，您可能会熟悉一个旧的API，其中`ref`属性是一个字符串，如`“textInput”`，DOM节点作为`this.refs.textInput`进行访问。 我们建议反对这样使用它，因为字符串引用有一些问题，被认为是遗留的Bug，并且可能会在以后的版本中被删除。 如果您正在使用`this.refs.textInput`访问引用，则建议使用回调模式。

### Caveats (警告)

If the `ref` callback is defined as an inline function, it will get called twice during updates, first with `null` and then again with the DOM element. This is because a new instance of the function is created with each render, so React needs to clear the old ref and set up the new one. You can avoid this by defining the `ref` callback as a bound method on the class, but note that it shouldn't matter in most cases.

如果`ref`回调被定义为内联函数，则在更新期间将被调用两次，首先为`null`，然后再次使用DOM元素。 这是因为每次渲染都创建了一个新的函数实例，所以React需要清除旧的引用并设置新的引用。 您可以通过将`ref`回调定义为类的绑定方法来避免这种情况，但请注意，在大多数情况下，这并不重要。