---
layout: post
title:  "Introducing JSX(JSX介绍)"
date:   2017-03-29 11:11:11
categories: react
---

Consider this variable declaration:

考虑这个变量声明：

```js
const element = <h1>Hello, world!</h1>;
```

This funny tag syntax is neither a string nor HTML.

这个有趣的标签语法既不是字符串也不是HTML。

It is called JSX, and it is a syntax extension to JavaScript. We recommend using it with React to describe what the UI should look like. JSX may remind you of a template language, but it comes with the full power of JavaScript.

它被称为JSX，它是JavaScript的语法扩展。 我们建议您使用React来描述UI的外观。 JSX可以说是提示您的一种模板语言，但它和JavaScript的一样强大。

JSX produces React "elements". We will explore rendering them to the DOM in the [next section](/react/docs/rendering-elements.html). Below, you can find the basics of JSX necessary to get you started.

JSX创建React`元素`。 我们将在下一节中讲解如何将它们渲染到DOM。 下面你可以开始学习`JSX`的基础语法知识。

### Embedding Expressions in JSX(在JSX中嵌入表达式)

You can embed any [JavaScript expression](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators#Expressions) in JSX by wrapping it in curly braces.

您可以在JSX中嵌入任何`JavaScript`表达式，方法是将其包装在`花括号{}`中。

For example, `2 + 2`, `user.firstName`, and `formatName(user)` are all valid expressions:

例如，`2 + 2`，`user.firstName`和`formatName（user）`都是有效的表达式：

```js{12}
function formatName(user) {
  return user.firstName + ' ' + user.lastName;
}

const user = {
  firstName: 'Harper',
  lastName: 'Perez'
};

const element = (
  <h1>
    Hello, {formatName(user)}!
  </h1>
);

ReactDOM.render(
  element,
  document.getElementById('root')
);
```

[Try it on CodePen.](http://codepen.io/gaearon/pen/PGEjdG?editors=0010)

We split JSX over multiple lines for readability. While it isn't required, when doing this, we also recommend wrapping it in parentheses to avoid the pitfalls of [automatic semicolon insertion](http://stackoverflow.com/q/2846283).

我们将JSX分成多行，以增强可读性。 虽然这不是必需的，但在这样做的时候，我们也建议把它放在括号中，以避免[分号自动插入的错误](http://stackoverflow.com/q/2846283)。

### JSX is an Expression Too(JSX是一个表达式)

After compilation, JSX expressions become regular JavaScript objects.

编译后，`JSX`表达式成为常规的`JavaScript`对象。

This means that you can use JSX inside of `if` statements and `for` loops, assign it to variables, accept it as arguments, and return it from functions:

这意味着您可以在`if`语句和`for`循环中使用`JSX`语法，将其分配给变量，或者接受它作为参数，也可以从函数返回它：

```js{3,5}
function getGreeting(user) {
  if (user) {
    return <h1>Hello, {formatName(user)}!</h1>;
  }
  return <h1>Hello, Stranger.</h1>;
}
```

### Specifying Attributes with JSX(JSX指定属性)

You may use quotes to specify string literals as attributes:

您可以使用`引号`将字符串文字指定为属性：

```js
const element = <div tabIndex="0"></div>;
```

You may also use curly braces to embed a JavaScript expression in an attribute:

您还可以使用`花括号`将JavaScript表达式嵌入到属性中：

```js
const element = <img src={user.avatarUrl}></img>;
```

Don't put quotes around curly braces when embedding a JavaScript expression in an attribute. Otherwise JSX will treat the attribute as a string literal rather than an expression. You should either use quotes (for string values) or curly braces (for expressions), but not both in the same attribute.

在属性中嵌入JavaScript表达式时，不要在大括号上放置引号。 否则，JSX将该属性视为字符串文字而不是表达式。 您应该使用引号（对于字符串值）或花括号（用于表达式），但不能同时使用。

### Specifying Children with JSX(JSX指定子项)

If a tag is empty, you may close it immediately with `/>`, like XML:

如果是一个空标签，则可以使用`/>`立即关闭它，如XML：

```js
const element = <img src={user.avatarUrl} />;
```

JSX tags may contain children:

JSX标签可能包含子项：

```js
const element = (
  <div>
    <h1>Hello!</h1>
    <h2>Good to see you here.</h2>
  </div>
);
```

>**Caveat:**
>
>Since JSX is closer to JavaScript than HTML, React DOM uses `camelCase` property naming convention instead of HTML attribute names.
>
>For example, `class` becomes [`className`](https://developer.mozilla.org/en-US/docs/Web/API/Element/className) in JSX, and `tabindex` becomes [`tabIndex`](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/tabIndex).
>
>警告：
>
>由于JSX比HTML更接近JavaScript，所以React DOM使用`camelCase`(驼峰)属性命名约定而不是HTML属性名称。
>
>例如，`class`在JSX中变为[`className`](https://developer.mozilla.org/en-US/docs/Web/API/Element/className)，`tabindex`变为[`tabIndex`](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/tabIndex)。

### JSX Prevents Injection Attacks(JSX防止注入攻击)

It is safe to embed user input in JSX:

在JSX中嵌入用户输入是安全的：

```js
const title = response.potentiallyMaliciousInput;
// This is safe:
const element = <h1>{title}</h1>;
```

By default, React DOM [escapes](http://stackoverflow.com/questions/7381974/which-characters-need-to-be-escaped-on-html) any values embedded in JSX before rendering them. Thus it ensures that you can never inject anything that's not explicitly written in your application. Everything is converted to a string before being rendered. This helps prevent [XSS (cross-site-scripting)](https://en.wikipedia.org/wiki/Cross-site_scripting) attacks.

默认情况下，React DOM会在渲染之前转义嵌入在JSX中的任何值。 因此，它确保永远不会注入任何未明确的内容到您的应用程序。 在渲染之前，所有内容都将转换为字符串。 这有助于防止XSS[跨站点脚本](https://en.wikipedia.org/wiki/Cross-site_scripting)攻击。

### JSX Represents Objects(JSX表示对象)

Babel compiles JSX down to `React.createElement()` calls.

Babel将JSX对象编译为传入`React.createElement()`函数的参数，并进行函数。

These two examples are identical:

这两个例子是一样的：

```js
const element = (
  <h1 className="greeting">
    Hello, world!
  </h1>
);
```

```js
const element = React.createElement(
  'h1',
  {className: 'greeting'},
  'Hello, world!'
);
```

`React.createElement()` performs a few checks to help you write bug-free code but essentially it creates an object like this:

`React.createElement()`执行一些检查以帮助您编写无错误代码，但基本上它会创建一个如下所示的对象：

```js
// Note: this structure is simplified
const element = {
  type: 'h1',
  props: {
    className: 'greeting',
    children: 'Hello, world'
  }
};
```

These objects are called "React elements". You can think of them as descriptions of what you want to see on the screen. React reads these objects and uses them to construct the DOM and keep it up to date.

这些对象被称为`"React元素"`。 您可以将它们视为您想要在屏幕上看到的内容。 React读取这些对象，并使用它们构造DOM并更新到屏幕上。

We will explore rendering React elements to the DOM in the next section.

我们将在下一节中研究如何将React元素渲染到DOM中。

>**Tip:**
>
>We recommend searching for a "Babel" syntax scheme for your editor of choice so that both ES6 and JSX code is properly highlighted.
>
>提示：
>
>我们建议您为选择的编辑器搜索“Babel”语法方案，以便ES6和JSX代码都被正确突出显示。

