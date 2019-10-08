---
layout: post
title:  "Lifting State Up(提升状态)"
date:   2017-04-06 11:11:11
categories: react
---

Often, several components need to reflect the same changing data. We recommend lifting the shared state up to their closest common ancestor. Let's see how this works in action.

通常，一系列的组件需要反映相同的变化的数据。 我们建议将共享状态提升到他们最近的共同的父组件中。 让我们看看这是如何工作的。

In this section, we will create a temperature calculator that calculates whether the water would boil at a given temperature.

在本节中，我们将创建一个温度计算器来计算水在一定温度下是否沸腾。

We will start with a component called `BoilingVerdict`. It accepts the `celsius` temperature as a prop, and prints whether it is enough to boil the water:

我们将从一个名为`BoilingVerdic`t的组件开始。 它接受`摄氏`温度作为支柱，并打印是否足以煮水：

```js{3,5}
function BoilingVerdict(props) {
  if (props.celsius >= 100) {
    return <p>The water would boil.</p>;
  }
  return <p>The water would not boil.</p>;
}
```

Next, we will create a component called `Calculator`. It renders an `<input>` that lets you enter the temperature, and keeps its value in `this.state.temperature`.

接下来，我们将创建一个名为`Calculator`的组件。 它渲染一个允许您输入温度的`<input>`，并将其值保存在`this.state.temperature`中。

Additionally, it renders the `BoilingVerdict` for the current input value.

此外，它为`BoilingVerdict`提供当前输入值。

```js{5,9,13,17-21}
class Calculator extends React.Component {

  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.state = {temperature: ''};
  }

  handleChange(e) {
    this.setState({temperature: e.target.value});
  }

  render() {
    const temperature = this.state.temperature;
    return (
      <fieldset>
        <legend>Enter temperature in Celsius:</legend>
        <input
          value={temperature}
          onChange={this.handleChange} />
        <BoilingVerdict
          celsius={parseFloat(temperature)} />
      </fieldset>
    );
  }
  
}
```

[Try it on CodePen.](http://codepen.io/valscion/pen/VpZJRZ?editors=0010)

## Adding a Second Input(添加第二个输入)

Our new requirement is that, in addition to a Celsius input, we provide a Fahrenheit input, and they are kept in sync.

我们的新要求是，除了摄氏度的输入，我们提供华氏度的输入，并保持同步。

We can start by extracting a `TemperatureInput` component from `Calculator`. We will add a new `scale` prop to it that can either be `"c"` or `"f"`:

我们可以从`Calculator`中提取一个`TemperatureInput`组件。 我们将添加一个可以是`“c”`或`“f”`的新`scale` 属性：

```js{1-4,19,22}
const scaleNames = {
  c: 'Celsius',
  f: 'Fahrenheit'
};

class TemperatureInput extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.state = {temperature: ''};
  }

  handleChange(e) {
    this.setState({temperature: e.target.value});
  }

  render() {
    const temperature = this.state.temperature;
    const scale = this.props.scale;
    return (
      <fieldset>
        <legend>Enter temperature in {scaleNames[scale]}:</legend>
        <input value={temperature}
               onChange={this.handleChange} />
      </fieldset>
    );
  }
}
```

We can now change the `Calculator` to render two separate temperature inputs:

我们现在可以更改 `Calculator` ，以提供两个独立的温度输入：

```js{5,6}
class Calculator extends React.Component {
  render() {
    return (
      <div>
        <TemperatureInput scale="c" />
        <TemperatureInput scale="f" />
      </div>
    );
  }
}
```

[Try it on CodePen.](http://codepen.io/valscion/pen/GWKbao?editors=0010)

We have two inputs now, but when you enter the temperature in one of them, the other doesn't update. This contradicts our requirement: we want to keep them in sync.

我们现在有两个输入，但是当您输入其中一个时，另一个不更新。 这与我们的要求相矛盾：我们希望保持同步。

We also can't display the `BoilingVerdict` from `Calculator`. The `Calculator` doesn't know the current temperature because it is hidden inside the `TemperatureInput`.

我们也无法从 `Calculator`显示`BoilingVerdict`。  `Calculator`不知道当前的温度，因为它隐藏在TemperatureInput内。

## Writing Conversion Functions(写入转换功能)

First, we will write two functions to convert from Celsius to Fahrenheit and back:

首先，我们将写入两个从【摄氏度转换为华氏度】和【华氏度转换为摄氏度】的函数：

```js
function toCelsius(fahrenheit) {
  return (fahrenheit - 32) * 5 / 9;
}

function toFahrenheit(celsius) {
  return (celsius * 9 / 5) + 32;
}
```

These two functions convert numbers. We will write another function that takes a string `temperature` and a converter function as arguments and returns a string. We will use it to calculate the value of one input based on the other input.

这两个函数转换数字。 我们将编写另一个函数，它将字符串温度和转换器函数作为参数，并返回一个字符串。 我们将使用它来根据其他输入来计算一个新的输入的值。

It returns an empty string on an invalid `temperature`, and it keeps the output rounded to the third decimal place:

它在一个无效的`温度`上返回一个空字符串，它保持输出四舍五入到小数点后三位：

```js
function tryConvert(temperature, convert) {
  const input = parseFloat(temperature);
  if (Number.isNaN(input)) {
    return '';
  }
  const output = convert(input);
  const rounded = Math.round(output * 1000) / 1000;
  return rounded.toString();
}
```

For example, `tryConvert('abc', toCelsius)` returns an empty string, and `tryConvert('10.22', toFahrenheit)` returns `'50.396'`.

例如， `tryConvert('abc', toCelsius)` 返回一个空字符串，而`tryConvert('10.22', toFahrenheit)` 返回'50 .396'。

## Lifting State Up(提升状态)

Currently, both `TemperatureInput` components independently keep their values in the local state:

目前，两个`TemperatureInput`组件都将其值保持在本地状态：

```js{5,9,13}
class TemperatureInput extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.state = {temperature: ''};
  }

  handleChange(e) {
    this.setState({temperature: e.target.value});
  }

  render() {
    const temperature = this.state.temperature;
```

However, we want these two inputs to be in sync with each other. When we update the Celsius input, the Fahrenheit input should reflect the converted temperature, and vice versa.

然而，我们希望这两个输入是相互同步的。 当我们更新摄氏温度输入时，华氏输入应反映转换温度，反之亦然。

In React, sharing state is accomplished by moving it up to the closest common ancestor of the components that need it. This is called "lifting state up". We will remove the local state from the `TemperatureInput` and move it into the `Calculator` instead.

在React中，共享状态是通过将其移动到需要它的组件的最近的共同父组件中来实现的。 这被称为`"提升状态"`。 我们将从`TemperatureInput`中删除本地状态，并将其移动到`Calculator`中。

If the `Calculator` owns the shared state, it becomes the "source of truth" for the current temperature in both inputs. It can instruct them both to have values that are consistent with each other. Since the props of both `TemperatureInput` components are coming from the same parent `Calculator` component, the two inputs will always be in sync.

如果 `Calculator` 拥有共享状态，则它将成为两个当前温度的输入的“真实来源”。 它可以指定他们具有彼此一致的值。 由于两个`TemperatureInput`组件的属性来自同一个父组件： `Calculator`，所以两个输入的值将始终保持同步。

Let's see how this works step by step.

让我们看看这是如何一步一步工作的。

First, we will replace `this.state.temperature` with `this.props.temperature` in the `TemperatureInput` component. For now, let's pretend `this.props.temperature` already exists, although we will need to pass it from the `Calculator` in the future:

首先，我们将在`TemperatureInput`组件中用`this.props.temperature`替换`this.state.temperature`。 虽然我们将来需要从 `Calculator` 中传递给它，但现在，假设`this.props.temperature`已经存在：

```js{3}
  render() {
    // Before: const temperature = this.state.temperature;
    const temperature = this.props.temperature;
```

We know that [props are read-only](/react/docs/components-and-props.html#props-are-read-only). When the `temperature` was in the local state, the `TemperatureInput` could just call `this.setState()` to change it. However, now that the `temperature` is coming from the parent as a prop, the `TemperatureInput` has no control over it.

我们知道属性是只读的。 当 `temperature` 处于本地状态时，`TemperatureInput`可以调用`this.setState()`来更改它。 然而，现在 `temperature` 来自父组件并作为作为子组件的属性，温度的输入无法控制。

In React, this is usually solved by making a component "controlled". Just like the DOM `<input>` accepts both a `value` and an `onChange` prop, so can the custom `TemperatureInput` accept both `temperature` and `onTemperatureChange` props from its parent `Calculator`.

在React中，通常通过使组件“受控”来解决。 就像DOM `<input>`一样，同时接受一个 `value` 和一个 `onChange` 支持，所以自定义的`TemperatureInput`也可以接受来自其父组件(`Calculator`)的`temperature`和`onTemperatureChange`函数作为属性。

Now, when the `TemperatureInput` wants to update its temperature, it calls `this.props.onTemperatureChange`:

现在，当`TemperatureInput`想要更新其温度时，它会调用`this.props.onTemperatureChange`：

```js{3}
  handleChange(e) {
    // Before: this.setState({temperature: e.target.value});
    this.props.onTemperatureChange(e.target.value);
```

Note that there is no special meaning to either `temperature` or `onTemperatureChange` prop names in custom components. We could have called them anything else, like name them `value` and `onChange` which is a common convention.

请注意，自定义组件中的 `temperature` 或 `onTemperatureChange` 属性名称没有特殊的含义。 我们可以叫他们任何其他的东西，像命名他们的`value`和`onChange`这是一个常见的惯例。

The `onTemperatureChange` prop will be provided together with the `temperature` prop by the parent `Calculator` component. It will handle the change by modifying its own local state, thus re-rendering both inputs with the new values. We will look at the new `Calculator` implementation very soon.

`onTemperatureChange` 属性将与父组件（`temperature`）的`temperature`属性一起提供。 它将通过修改自己的本地状态来处理更改，从而将输入的新值重新渲染到两个输入组件。 我们将很快看到新的`Calculator`实现。

Before diving into the changes in the `Calculator`, let's recap our changes to the `TemperatureInput` component. We have removed the local state from it, and instead of reading `this.state.temperature`, we now read `this.props.temperature`. Instead of calling `this.setState()` when we want to make a change, we now call `this.props.onTemperatureChange()`, which will be provided by the `Calculator`:

在进入`Calculator`组件中更改之前，让我们回顾一下对`TemperatureInput`组件的更改。 我们已经从中删除了本地状态，而不是读取`this.state.temperature`，我们现在读取`this.props.temperature`。 我们现在调用由 `Calculator`提供的`this.props.onTemperatureChange()`函数，而不是调用`this.setState()`：

```js{8,12}
class TemperatureInput extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    this.props.onTemperatureChange(e.target.value);
  }

  render() {
    const temperature = this.props.temperature;
    const scale = this.props.scale;
    return (
      <fieldset>
        <legend>Enter temperature in {scaleNames[scale]}:</legend>
        <input value={temperature}
               onChange={this.handleChange} />
      </fieldset>
    );
  }
}
```

Now let's turn to the `Calculator` component.

现在我们来看一下`Calculator`组件。

We will store the current input's `temperature` and `scale` in its local state. This is the state we "lifted up" from the inputs, and it will serve as the "source of truth" for both of them. It is the minimal representation of all the data we need to know in order to render both inputs.

我们将当前输入的`temperature`和`scale`存储在本地状态。 这是我们从输入中“提升”的状态，它将作为他们两个输入组件的“数据来源”。 为了渲染两个输入组件，我们需要知道数据对象的精简表示。

For example, if we enter 37 into the Celsius input, the state of the `Calculator` component will be:

例如，如果我们在摄氏度输入中输入37，则计算器组件的状态将是：

```js
{
  temperature: '37',
  scale: 'c'
}
```

If we later edit the Fahrenheit field to be 212, the state of the `Calculator` will be:

如果我们稍后将“华氏”字段编辑为212，则`Calculator`的状态将为：

```js
{
  temperature: '212',
  scale: 'f'
}
```

We could have stored the value of both inputs but it turns out to be unnecessary. It is enough to store the value of the most recently changed input, and the scale that it represents. We can then infer the value of the other input based on the current `temperature` and `scale` alone.

我们可以存储两个输入的值，但实际上是不必要的。 存储最近更改的输入的值以及它所代表的比例就足够了。 然后，我们可以基于当前的`temperature`和`scale`来推断其他输入的值。

The inputs stay in sync because their values are computed from the same state:

因为它们的值是从相同的状态计算的，所以输入能够保持同步：

```js{6,10,14,18-21,27-28,31-32,34}
class Calculator extends React.Component {

  constructor(props) {
    super(props);
    this.handleCelsiusChange = this.handleCelsiusChange.bind(this);
    this.handleFahrenheitChange = this.handleFahrenheitChange.bind(this);
    this.state = {temperature: '', scale: 'c'};
  }

  handleCelsiusChange(temperature) {
    this.setState({scale: 'c', temperature});
  }

  handleFahrenheitChange(temperature) {
    this.setState({scale: 'f', temperature});
  }

  render() {
    const scale = this.state.scale;
    const temperature = this.state.temperature;
    const celsius = scale === 'f' ? tryConvert(temperature, toCelsius) : temperature;
    const fahrenheit = scale === 'c' ? tryConvert(temperature, toFahrenheit) : temperature;

    return (
      <div>
        <TemperatureInput
          scale="c"
          temperature={celsius}
          onTemperatureChange={this.handleCelsiusChange} />
        <TemperatureInput
          scale="f"
          temperature={fahrenheit}
          onTemperatureChange={this.handleFahrenheitChange} />
        <BoilingVerdict
          celsius={parseFloat(celsius)} />
      </div>
    );
  }
}
```

[Try it on CodePen.](http://codepen.io/valscion/pen/jBNjja?editors=0010)

Now, no matter which input you edit, `this.state.temperature` and `this.state.scale` in the `Calculator` get updated. One of the inputs gets the value as is, so any user input is preserved, and the other input value is always recalculated based on it.

现在，无论您编辑哪个输入，`Calculator`中的`this.state.temperature`和`this.state.scale`都会更新。 其中一个输入组件获取值，所以任何用户输入都被保留，另一个输入组件总是基于它重新计算值。

Let's recap what happens when you edit an input:

让我们回顾一下编辑输入时会发生什么：

* React calls the function specified as `onChange` on the DOM `<input>`. In our case, this is the `handleChange` method in `TemperatureInput` component.
* React调用在DOM `<input>`上指定为`onChange`的函数。 在我们的例子中，这是调用`TemperatureInput`组件中的`handleChange`方法。
* The `handleChange` method in the `TemperatureInput` component calls `this.props.onTemperatureChange()` with the new desired value. Its props, including `onTemperatureChange`, were provided by its parent component, the `Calculator`.
* `TemperatureInput`组件中的`handleChange`函数使用新的输入值调用`this.props.onTemperatureChange()`函数。 其属性包括`onTemperatureChange`，由其父组件`Calculator`提供。
* When it previously rendered, the `Calculator` has specified that `onTemperatureChange` of the Celsius `TemperatureInput` is the `Calculator`'s `handleCelsiusChange` method, and `onTemperatureChange` of the Fahrenheit `TemperatureInput` is the `Calculator`'s `handleFahrehnheitChange` method. So either of these two `Calculator` methods gets called depending on which input we edited.
* 当它初次渲染时，`Calculator`已经指定了摄氏组件`TemperatureInput`的`onTemperatureChange`函数作为`Calculator`的`handleCelsiusChange`方法的回调，而华氏组件`TemperatureInput`的`onTemperatureChange`函数作为`Calculator`的`handleFahrehnheitChange`方法的回调。 因此，根据我们编辑的输入，回调这两个`Calculator`方法。
* Inside these methods, the `Calculator` component asks React to re-render itself by calling `this.setState()` with the new input value and the current scale of the input we just edited.
* 在这些方法中，`Calculator` 组件要求React通过使用新的输入值和刚刚编辑输入的当前比例调用`this.setState（）`来重新渲染自身。
* React calls the `Calculator` component's `render` method to learn what the UI should look like. The values of both inputs are recomputed based on the current temperature and the active scale. The temperature conversion is performed here.
* React调用`Calculator`组件的`render`方法了解UI的外观。 基于当前温度和有效刻度重新计算两个输入的值，并在这里进行温度转换。
* React calls the `render` methods of the individual `TemperatureInput` components with their new props specified by the `Calculator`. It learns what their UI should look like.
* React使用计算器指定的新属性值调用各个·TemperatureInput·组件的`render`方法。 它会了解UI的外观。
* React DOM updates the DOM to match the desired input values. The input we just edited receives its current value, and the other input is updated to the temperature after conversion.
* React DOM更新DOM以匹配所需的输入值。 我们刚刚编辑的输入接收其当前值，另一个输入更新为转换后的温度。

Every update goes through the same steps so the inputs stay in sync.

每个更新都会执行相同的步骤，以便输入保持同步。

## Lessons Learned(学到的经验)

There should be a single "source of truth" for any data that changes in a React application. Usually, the state is first added to the component that needs it for rendering. Then, if other components also need it, you can lift it up to their closest common ancestor. Instead of trying to sync the state between different components, you should rely on the [top-down data flow](/react/docs/state-and-lifecycle.html#the-data-flows-down).

对于在React应用程序中更改的任何数据，应该有一个“真实来源”。 通常，状态首先被添加到需要渲染的组件中。 然后，如果其他组件也需要它，您可以将其提升到最近的同一父组件。 而不是尝试同步不同组件之间的状态，您应该依靠自上而下的数据流。

Lifting state involves writing more "boilerplate" code than two-way binding approaches, but as a benefit, it takes less work to find and isolate bugs. Since any state "lives" in some component and that component alone can change it, the surface area for bugs is greatly reduced. Additionally, you can implement any custom logic to reject or transform user input.

提升状态涉及编写比“双向绑定”方法更多的“样板”代码，但有一个好处，找到隔离错误的工作要少一些。 由于任何状态“生活“在某些组件中，并且该组件单独可以改变它，所以错误的表面积大大降低。 此外，您可以实现任何自定义逻辑来拒绝或转换用户输入。

If something can be derived from either props or state, it probably shouldn't be in the state. For example, instead of storing both `celsiusValue` and `fahrenheitValue`, we store just the last edited `temperature` and its `scale`. The value of the other input can always be calculated from them in the `render()` method. This lets us clear or apply rounding to the other field without losing any precision in the user input.

如果数据可以从属性或状态得到，那么它可能不应该处于状态。 例如，我们不是存储`celsiusValue`和`fahrenheitValue`，而是仅存储最后编辑的`temperature` 和 `scale`。 在`render（）`方法中，其他输入的值始终可以从它们中计算出来。 这使我们可以清除或应用四舍五入到其他字段，而不会在用户输入中丢失任何精度。

When you see something wrong in the UI, you can use [React Developer Tools](https://github.com/facebook/react-devtools) to inspect the props and move up the tree until you find the component responsible for updating the state. This lets you trace the bugs to their source:

当您在UI中看到错误时，您可以使用React Developer Tools来检查道具，并向上移动树，直到找到负责更新状态的组件。 这可以让你跟踪这些错误来源：

<img src="https://facebook.github.io/react/img/docs/react-devtools-state.gif" alt="Monitoring State in React DevTools" width="100%">
