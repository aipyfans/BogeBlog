---
layout: post
title:  "JSX In Depth(深入JSX)"
date:   2017-04-10 11:11:11
categories: react
---

Fundamentally, JSX just provides syntactic sugar for the `React.createElement(component, props, ...children)` function. The JSX code:

基本上，JSX只是为 `React.createElement(component, props, ...children)` 函数提供语法糖。 JSX代码：

```js
<MyButton color="blue" shadowSize={2}>
  Click Me
</MyButton>
```

compiles into:

编译成:

```js
React.createElement(
  MyButton,
  {color: 'blue', shadowSize: 2},
  'Click Me'
)
```

You can also use the self-closing form of the tag if there are no children. So:

如果没有子标签或子组件，也可以使用标签的自封闭形式。 所以：

```js
<div className="sidebar" />
```

compiles into:

编译成:

```js
React.createElement(
  'div',
  {className: 'sidebar'},
  null
)
```

If you want to test out how some specific JSX is converted into JavaScript, you can try out [the online Babel compiler](https://babeljs.io/repl/#?babili=false&evaluate=true&lineWrap=false&presets=es2015%2Creact%2Cstage-0&code=function%20hello()%20%7B%0A%20%20return%20%3Cdiv%3EHello%20world!%3C%2Fdiv%3E%3B%0A%7D).

如果您想测试JSX如何转换为JavaScript，您可以使用在线Babel编译器进行尝试。

## Specifying The React Element Type(指定React元素类型)

The first part of a JSX tag determines the type of the React element.

JSX标签的第一部分决定了React元素的类型。

Capitalized types indicate that the JSX tag is referring to a React component. These tags get compiled into a direct reference to the named variable, so if you use the JSX `<Foo />` expression, `Foo` must be in scope.

大写类型表示的JSX标签指的是React组件。 这些标签被编译成对命名变量的直接引用，所以如果使用JSX `<Foo />`表达式，`Foo`必须在范围内。

### React Must Be in Scope(React必须在范围内)

Since JSX compiles into calls to `React.createElement`, the `React` library must also always be in scope from your JSX code.

由于JSX编译成对`React.createElement`的调用，所以`React`库也必须始终在JSX代码的范围内。

For example, both of the imports are necessary in this code, even though `React` and `CustomButton` are not directly referenced from JavaScript:

例如，即使`React`和`CustomButton`不直接从JavaScript引用，这两个导入都是必需的：

```js{1,2,5}
import React from 'react';
import CustomButton from './CustomButton';

function WarningButton() {
  // return React.createElement(CustomButton, {color: 'red'}, null);
  return <CustomButton color="red" />;
}
```

If you don't use a JavaScript bundler and added React as a script tag, it is already in scope as a `React` global.

如果您不使用JavaScript绑定器并将React添加为脚本标记，则它已作为`React`全局的范围。

### Using Dot Notation for JSX Type(对JSX类型使用点表示法)

You can also refer to a React component using dot-notation from within JSX. This is convenient if you have a single module that exports many React components. For example, if `MyComponents.DatePicker` is a component, you can use it directly from JSX with:

您还可以使用JSX中的`点表示法`引用React组件。 如果您有一个导出许多React组件的单个模块，这很方便。 例如，如果`MyComponents.DatePicker`是一个组件，则可以直接从JSX中使用它：

```js{10}
import React from 'react';

const MyComponents = {
  DatePicker: function DatePicker(props) {
    return <div>Imagine a {props.color} datepicker here.</div>;
  }
}

function BlueDatePicker() {
  return <MyComponents.DatePicker color="blue" />;
}
```



### User-Defined Components Must Be Capitalized(用户定义的组件必须大写)

When an element type starts with a lowercase letter, it refers to a built-in component like `<div>` or `<span>` and results in a string `'div'` or `'span'` passed to `React.createElement`. Types that start with a capital letter like `<Foo />` compile to `React.createElement(Foo)` and correspond to a component defined or imported in your JavaScript file.

当元素类型以小写字母开头时，它引用一个内置的组件，如`<div>`或`<span>`，并将一个字符串'div'或'span'传递给`React.createElement`。 以大写字母开头的类型，如`<Foo />`编译为`React.createElement(Foo)`，并对应于您的JavaScript文件中定义或导入的组件。

We recommend naming components with a capital letter. If you do have a component that starts with a lowercase letter, assign it to a capitalized variable before using it in JSX.

我们建议用大写字母命名组件。 如果您的组件以小写字母开头，请在JSX中使用之前将其分配给大写的变量。

For example, this code will not run as expected:

例如，此代码将无法按预期运行：

```js{3,4,10,11}
import React from 'react';

// Wrong! This is a component and should have been capitalized:
// 错误！ 这是一个组件，应该被大写：
function hello(props) {
  // Correct! This use of <div> is legitimate because div is a valid HTML tag:
  // 正确！ 这种使用<div>是合法的，因为div是一个有效的HTML标记：
  return <div>Hello {props.toWhat}</div>;
}

function HelloWorld() {
  // Wrong! React thinks <hello /> is an HTML tag because it's not capitalized:
  // 错了！ React认为<hello />是一个HTML标签，因为它不大写：
  return <hello toWhat="World" />;
}
```

To fix this, we will rename `hello` to `Hello` and use `<Hello />` when referring to it:

要解决这个问题，我们将重命名`hello`为`Hello`，并在引用它时使用`<Hello />`：

```js{3,4,10,11}
import React from 'react';

// Correct! This is a component and should be capitalized:
// 正确！ 这是一个组件，应该被大写：
function Hello(props) {
  // Correct! This use of <div> is legitimate because div is a valid HTML tag:
  // 正确！ 这种使用<div>是合法的，因为div是一个有效的HTML标记：
  return <div>Hello {props.toWhat}</div>;
}

function HelloWorld() {
  // Correct! React knows <Hello /> is a component because it's capitalized.
  // 正确！ React知道<Hello />是一个组件，因为它是大写的。
  return <Hello toWhat="World" />;
}
```

### Choosing the Type at Runtime(在运行时选择类型)

You cannot use a general expression as the React element type. If you do want to use a general expression to indicate the type of the element, just assign it to a capitalized variable first. This often comes up when you want to render a different component based on a prop:

您不能使用通用表达式作为React元素类型。 如果您想使用通用表达式来表示元素的类型，请先将其分配给大写的变量。 当您要根据属性渲染不同的组件时，会出现这种情况：

```js{10,11}
import React from 'react';
import { PhotoStory, VideoStory } from './stories';

const components = {
  photo: PhotoStory,
  video: VideoStory
};

function Story(props) {
  // Wrong! JSX type can't be an expression.
  // 错了！ JSX类型不能是表达式。
  return <components[props.storyType] story={props.story} />;
}
```

To fix this, we will assign the type to a capitalized variable first:

要解决这个问题，我们将首先将类型分配给大写的变量：

```js{9-11}
import React from 'react';
import { PhotoStory, VideoStory } from './stories';

const components = {
  photo: PhotoStory,
  video: VideoStory
};

function Story(props) {
  // Correct! JSX type can be a capitalized variable.
  // 正确！ JSX类型可以是大写的变量。
  const SpecificStory = components[props.storyType];
  return <SpecificStory story={props.story} />;
}
```

## Props in JSX(JSX属性)

There are several different ways to specify props in JSX.

在JSX中有几种不同的方式来指定属性。

### JavaScript Expressions(JavaScript表达式)

You can pass any JavaScript expression as a prop, by surrounding it with `{}`. For example, in this JSX:

您可以传递任何JavaScript表达式作为属性，通过使用`{}`围绕它。 例如，在这个JSX中：

```js
<MyComponent foo={1 + 2 + 3 + 4} />
```

For `MyComponent`, the value of `props.foo` will be `10` because the expression `1 + 2 + 3 + 4` gets evaluated.

对于`MyComponent`，因为表达式`1 + 2 + 3 + 4`会被计算，所以`props.foo`的值将为`10`。

`if` statements and `for` loops are not expressions in JavaScript, so they can't be used in JSX directly. Instead, you can put these in the surrounding code. For example:

`if`语句和`for`循环在JavaScript中不是表达式，所以它们不能直接在JSX中使用。 相反，您可以将它们放在周围的代码中。 例如：

```js{3-7}
function NumberDescriber(props) {
  let description;
  if (props.number % 2 == 0) {
    description = <strong>even</strong>;
  } else {
    description = <i>odd</i>;
  }
  return <div>{props.number} is an {description} number</div>;
}
```

### String Literals(字符串文字)

You can pass a string literal as a prop. These two JSX expressions are equivalent:

你可以传递字符串文字作为属性。 这两个JSX表达式是等价的：

```js
<MyComponent message="hello world" />

<MyComponent message={'hello world'} />
```

When you pass a string literal, its value is HTML-unescaped. So these two JSX expressions are equivalent:

当您传递字符串文字时，其值为HTML未转义。 所以这两个JSX表达式是等价的：

```js
<MyComponent message="&lt;3" />

<MyComponent message={'<3'} />
```

This behavior is usually not relevant. It's only mentioned here for completeness.

这种行为通常是不相关的。 这里只提到完整性。

### Props Default to "True"(属性默认为“True”)

If you pass no value for a prop, it defaults to `true`. These two JSX expressions are equivalent:

如果你没有传递一个属性的值，它默认为`true`。 这两个JSX表达式是等价的：

```js
<MyTextBox autocomplete />

<MyTextBox autocomplete={true} />
```

In general, we don't recommend using this because it can be confused with the [ES6 object shorthand](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/Object_initializer#New_notations_in_ECMAScript_2015) `{foo}` which is short for `{foo: foo}` rather than `{foo: true}`. This behavior is just there so that it matches the behavior of HTML.

一般来说，我们不建议使用它，因为它可能与`{foo：foo}`而不是`{foo：true}`的缩写为{foo}的ES6对象简写{foo}混淆。 这种行为就在这里，因此它符合HTML的行为。

### Spread Attributes(传递属性)

If you already have `props` as an object, and you want to pass it in JSX, you can use `...` as a "spread" operator to pass the whole props object. These two components are equivalent:

如果您已经拥有 `props` 作为对象，并且想要在JSX中传递，则可以使用`...`作为“扩展”运算符来传递整个 `props` 对象。 这两个组件是等效的

```js{7}
function App1() {
  return <Greeting firstName="Ben" lastName="Hector" />;
}

function App2() {
  const props = {firstName: 'Ben', lastName: 'Hector'};
  return <Greeting {...props} />;
}
```

Spread attributes can be useful when you are building generic containers. However, they can also make your code messy by making it easy to pass a lot of irrelevant props to components that don't care about them. We recommend that you use this syntax sparingly.

构建通用容器组件时，扩展属性可能很有用。 然而，他们也可以通过将很多不相关的属性传递给不关心它们的组件来使您的代码变得凌乱。 我们建议您谨慎使用此语法。

## Children in JSX(JSX中的孩子)

In JSX expressions that contain both an opening tag and a closing tag, the content between those tags is passed as a special prop: `props.children`. There are several different ways to pass children:

在包含开始标签和结束标签的JSX表达式中，这些标签之间的内容作为特殊的属性(`props.children`)进行传递。 有几种不同的方法来传递子组件：

### String Literals(字符串文字)

You can put a string between the opening and closing tags and `props.children` will just be that string. This is useful for many of the built-in HTML elements. For example:

您可以在开始和结束标签之间放置一个字符串，而`props.children`将只是该字符串。 这对于许多内置的HTML元素很有用。 例如：

```js
<MyComponent>Hello world!</MyComponent>
```

This is valid JSX, and `props.children` in `MyComponent` will simply be the string `"Hello world!"`. HTML is unescaped, so you can generally write JSX just like you would write HTML in this way:

这是有效的JSX，而组件中的`props.children`将只是字符串`“Hello world！`”。 HTML可以是未转义的，所以你一般可以写JSX，就像你用这种方式写HTML：

```html
<div>This is valid HTML &amp; JSX at the same time.</div>
```

JSX removes whitespace at the beginning and ending of a line. It also removes blank lines. New lines adjacent to tags are removed; new lines that occur in the middle of string literals are condensed into a single space. So these all render to the same thing:

JSX在行的开始和结尾处移除空格。 它也删除空行。 删除与标签相邻的新行; 出现在字符串文字中间的新行被压缩成一个空格。 所以这些渲染都是相同的事情：

```js
<div>Hello World</div>

<div>
  Hello World
</div>

<div>
  Hello
  World
</div>

<div>

  Hello World
</div>
```

### JSX Children(JSX子组件)

You can provide more JSX elements as the children. This is useful for displaying nested components:

您可以提供更多的JSX元素作为子组件。 这对于显示嵌套组件很有用：

```js
<MyContainer>
  <MyFirstComponent />
  <MySecondComponent />
</MyContainer>
```

You can mix together different types of children, so you can use string literals together with JSX children. This is another way in which JSX is like HTML, so that this is both valid JSX and valid HTML:

你可以混合不同类型的子组件，所以你可以和JSX子组件一起使用字符串文字。 这是JSX的另一种方式，就像HTML一样，JSX和HTML都是有效的：

```html
<div>
  Here is a list:
  <ul>
    <li>Item 1</li>
    <li>Item 2</li>
  </ul>
</div>
```

A React component can't return multiple React elements, but a single JSX expression can have multiple children, so if you want a component to render multiple things you can wrap it in a `div` like this.

一个React组件不能返回多个React元素，但单个JSX表达式可以有多个子元素，因此，如果您想要一个组件来呈现多个元素，则可以将其包装在这样的`div`中。

### JavaScript Expressions(JavaScript表达式)

You can pass any JavaScript expression as children, by enclosing it within `{}`. For example, these expressions are equivalent:

您可以将任何JavaScript表达式作为孩子传递，并将其包含在`{}`中。 例如，这些表达式是等价的：

```js
<MyComponent>foo</MyComponent>

<MyComponent>{'foo'}</MyComponent>
```

This is often useful for rendering a list of JSX expressions of arbitrary length. For example, this renders an HTML list:

这对于呈现任意长度的JSX表达式的列表通常很有用。 例如，这将呈现HTML列表：

```js{2,9}
function Item(props) {
  return <li>{props.message}</li>;
}

function TodoList() {
  const todos = ['finish doc', 'submit pr', 'nag dan to review'];
  return (
    <ul>
      {todos.map((message) => <Item key={message} message={message} />)}
    </ul>
  );
}
```

JavaScript expressions can be mixed with other types of children. This is often useful in lieu of string templates:

JavaScript表达式可以与其他类型的孩子(这里指字符串)混合使用。 这通常用于代替字符串模板：

```js{2}
function Hello(props) {
  return <div>Hello {props.addressee}!</div>;
}
```

### Functions as Children(函数作为孩子)

Normally, JavaScript expressions inserted in JSX will evaluate to a string, a React element, or a list of those things. However, `props.children` works just like any other prop in that it can pass any sort of data, not just the sorts that React knows how to render. For example, if you have a custom component, you could have it take a callback as `props.children`:

通常，插入JSX中的JavaScript表达式将被转换字符串，React元素或这些内容的列表。 然而，`props.children`就像任何其他的属性一样工作，因为它可以传递任何数据，而不仅仅是React知道如何呈现的种类。 例如，如果您有自定义组件，则可以将其作为`props.children`进行回调：

```js{4,13}
// Calls the children callback numTimes to produce a repeated component
// 调用子回调 numtimes 以产生一个重复的组件
function Repeat(props) {
  let items = [];
  for (let i = 0; i < props.numTimes; i++) {
    items.push(props.children(i));
  }
  return <div>{items}</div>;
}

function ListOfTenThings() {
  return (
    <Repeat numTimes={10}>
      {(index) => <div key={index}>This is item {index} in the list</div>}
    </Repeat>
  );
}
```

Children passed to a custom component can be anything, as long as that component transforms them into something React can understand before rendering. This usage is not common, but it works if you want to stretch what JSX is capable of.

传递给自定义组件的孩子可以是任何东西，只要该组件将它们转换为React在呈现之前可以理解的东西。 这个用法并不常见，但是如果你想扩展JSX的功能，这样也是可以工作的。

### Booleans, Null, and Undefined Are Ignored(布尔值，空值和未定义被忽略)

`false`, `null`, `undefined`, and `true` are valid children. They simply don't render. These JSX expressions will all render to the same thing:

`false`, `null`, `undefined`, 和`true`是有效的孩子。 他们根本不渲染。 这些JSX表达式将全部呈现为相同的东西：

```js
<div />

<div></div>

<div>{false}</div>

<div>{null}</div>

<div>{undefined}</div>

<div>{true}</div>
```

This can be useful to conditionally render React elements. This JSX only renders a `<Header />` if `showHeader` is `true`:

这有助于有条件地渲染React元素。 如果`showHeader`为`true`，则此JSX仅呈现`<Header />`：

```js{2}
<div>
  {showHeader && <Header />}
  <Content />
</div>
```

One caveat is that some ["falsy" values](https://developer.mozilla.org/en-US/docs/Glossary/Falsy), such as the `0` number, are still rendered by React. For example, this code will not behave as you might expect because `0` will be printed when `props.messages` is an empty array:

一个值得注意的是，React提供了一些“伪造”值，如`0`数字。 例如，此代码将不会像您预期的那样运行，因为当`props.messages`为空数组时将打印`0`数字：

```js{2}
<div>
  {props.messages.length &&
    <MessageList messages={props.messages} />
  }
</div>
```

To fix this, make sure that the expression before `&&` is always boolean:

要解决这个问题，请确保`&&`之前的表达式始终为布尔值：

```js{2}
<div>
  {props.messages.length > 0 &&
    <MessageList messages={props.messages} />
  }
</div>
```

Conversely, if you want a value like `false`, `true`, `null`, or `undefined` to appear in the output, you have to [convert it to a string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String#String_conversion) first:

相反，如果您想要一个像 `false`, `true`, `null`, 或 `undefined` 这样的值出现在输出中，则必须先将其转换为字符串：

```js{2}
<div>
  My JavaScript variable is {String(myVariable)}.
</div>
```