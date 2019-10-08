---
layout: post
title:  "Uncontrolled Components(不受控组件)"
date:   2017-04-12 11:11:11
categories: react
---

In most cases, we recommend using [controlled components](/react/docs/forms.html) to implement forms. In a controlled component, form data is handled by a React component. The alternative is uncontrolled components, where form data is handled by the DOM itself.

在大多数情况下，我们建议使用受控组件来实现表单。 在受控组件中，表单数据由React组件处理。 替代方案是不受控制的组件，其中表单数据由DOM本身处理。

To write an uncontrolled component, instead of writing an event handler for every state update, you can [use a ref](/react/docs/refs-and-the-dom.html) to get form values from the DOM.

要编写一个不受控组件，而不是为每个状态更新编写事件处理程序，您可以使用`ref`从DOM获取表单值。

For example, this code accepts a single name in an uncontrolled component:

例如，此代码在不受控的组件中接受单个名称：

```javascript{8,17}
class NameForm extends React.Component {

  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(event) {
    alert('A name was submitted: ' + this.input.value);
    event.preventDefault();
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Name:
          <input type="text" ref={(input) => this.input = input} />
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}
```

[Try it on CodePen.](https://codepen.io/gaearon/pen/WooRWa?editors=0010)

Since an uncontrolled component keeps the source of truth in the DOM, it is sometimes easier to integrate React and non-React code when using uncontrolled components. It can also be slightly less code if you want to be quick and dirty. Otherwise, you should usually use controlled components.

由于不受控组件在DOM中保留了真实的来源，因此在使用不受控制的组件时集成React和Non-React代码有时更为容易。 虽然它也可以稍微减少代码量，但你会快速污染代码环境。 否则，您应该通常使用受控组件。

If it's still not clear which type of component you should use for a particular situation, you might find [this article on controlled versus uncontrolled inputs](http://goshakkk.name/controlled-vs-uncontrolled-inputs-react/) to be helpful.

如果仍然不清楚您应该为特定情况使用哪种类型的组件，那么您可能会发现[这篇关于受控制和不受控制的输入的文章](http://goshakkk.name/controlled-vs-uncontrolled-inputs-react/) 是有帮助的。

### Default Values(默认值)

In the React rendering lifecycle, the `value` attribute on form elements will override the value in the DOM. With an uncontrolled component, you often want React to specify the initial value, but leave subsequent updates uncontrolled. To handle this case, you can specify a `defaultValue` attribute instead of `value`.

在React渲染生命周期中，form元素上的`value`属性将覆盖DOM中的值。 使用不受控制的组件，您通常希望React指定初始值，但不再控制后续更新。 要处理这种情况，可以指定一个`defaultValue`属性而不是`value`。

```javascript{7}
render() {
  return (
    <form onSubmit={this.handleSubmit}>
      <label>
        Name:
        <input
          defaultValue="Bob"
          type="text"
          ref={(input) => this.input = input} />
      </label>
      <input type="submit" value="Submit" />
    </form>
  );
}
```

Likewise, `<input type="checkbox">` and `<input type="radio">` support `defaultChecked`, and `<select>` and `<textarea>` supports `defaultValue`.

同样，`<input type ="checkbox">`和`<input type ="radio">`支持`defaultChecked`，而`<select>`和`<textarea>`支持`defaultValue`。