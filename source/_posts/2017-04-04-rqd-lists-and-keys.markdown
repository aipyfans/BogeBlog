---
layout: post
title:  "Lists and Keys(列表和键)"
date:   2017-04-04 11:11:11
categories: react
---

First, let's review how you transform lists in JavaScript.

首先，我们来看看如何在JavaScript中转换列表。

Given the code below, we use the [`map()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) function to take an array of `numbers` and double their values. We assign the new array returned by `map()` to the variable `doubled` and log it:

给出下面的代码，我们使用`map（）`函数操作一个 `numbers` 数组，并将其值加倍。 我们将`map（）`返回的翻倍的数组分配给一个新数组并输出它：

```javascript{2}
const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map((number) => number * 2);
console.log(doubled);
```

This code logs `[2, 4, 6, 8, 10]` to the console.

此代码将数组 `[2, 4, 6, 8, 10]` 输出到控制台。

In React, transforming arrays into lists of [elements](/react/docs/rendering-elements.html) is nearly identical.

在React中，将数组转换为元素列表几乎相同。

### Rendering Multiple Components(渲染多个组件)

You can build collections of elements and [include them in JSX](/react/docs/introducing-jsx.html#embedding-expressions-in-jsx) using curly braces `{}`.

您可以构建元素集合，并使用`花括号{}`将它们包含在JSX中。

Below, we loop through the `numbers` array using the Javascript [`map()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) function. We return an `<li>` element for each item. Finally, we assign the resulting array of elements to `listItems`:

下面，我们使用Javascript `map（）`函数将 `numbers` 数组进行循环操作。 我们返回每个项目的`<li>`元素。 最后，我们将结果的元素数组分配给listItems：

```javascript{2-4}
const numbers = [1, 2, 3, 4, 5];
const listItems = numbers.map((number) =>
  <li>{number}</li>
);
```

We include the entire `listItems` array inside a `<ul>` element, and [render it to the DOM](/react/docs/rendering-elements.html#rendering-an-element-into-the-dom):

我们将整个`listItems`数组包含在一个`<ul>`元素中，并将其渲染到DOM中：

```javascript{2}
ReactDOM.render(
  <ul>{listItems}</ul>,
  document.getElementById('root')
);
```

[Try it on CodePen.](https://codepen.io/gaearon/pen/GjPyQr?editors=0011)

This code displays a bullet list of numbers between 1 and 5.

此代码显示1到5之间的数字项目符号列表。

### Basic List Component(基本列表组件)

Usually you would render lists inside a [component](/react/docs/components-and-props.html).

通常你会在一个组件中渲染列表。

We can refactor the previous example into a component that accepts an array of `numbers` and outputs an unordered list of elements.

我们可以将前面的例子重构成接受数字数组的一个组件，并输出一个无序的元素列表。

```javascript{3-5,7,13}
function NumberList(props) {
  const numbers = props.numbers;
  const listItems = numbers.map((number) =>
    <li>{number}</li>
  );
  return (
    <ul>{listItems}</ul>
  );
}

const numbers = [1, 2, 3, 4, 5];
ReactDOM.render(
  <NumberList numbers={numbers} />,
  document.getElementById('root')
);
```

When you run this code, you'll be given a warning that a key should be provided for list items. A "key" is a special string attribute you need to include when creating lists of elements. We'll discuss why it's important in the next section.

当您运行此代码时，您将被给予一个警告，以便为列表项提供一个密钥。  "key" 是创建元素列表时需要包含的特殊字符串属性。 我们将在下一节讨论为什么它很重要。

Let's assign a `key` to our list items inside `numbers.map()` and fix the missing key issue.

让我们分配一个`key`到我们的`list.map（）`列表项中，并修复缺少的关键字问题。

```javascript{4}
function NumberList(props) {
  const numbers = props.numbers;
  const listItems = numbers.map((number) =>
    <li key={number.toString()}>
      {number}
    </li>
  );
  return (
    <ul>{listItems}</ul>
  );
}

const numbers = [1, 2, 3, 4, 5];
ReactDOM.render(
  <NumberList numbers={numbers} />,
  document.getElementById('root')
);
```

[Try it on CodePen.](https://codepen.io/gaearon/pen/jrXYRR?editors=0011)

## Keys(键)

Keys help React identify which items have changed, are added, or are removed. Keys should be given to the elements inside the array to give the elements a stable identity:

键帮助React确定哪些项目已更改，添加或删除。 应该给元素数组中的元素赋予一个稳定的身份：

```js{3}
const numbers = [1, 2, 3, 4, 5];
const listItems = numbers.map((number) =>
  <li key={number.toString()}>
    {number}
  </li>
);
```

The best way to pick a key is to use a string that uniquely identifies a list item among its siblings. Most often you would use IDs from your data as keys:

选择`key`的最好方法是使用一个字符串来唯一标识其组件之间的列表项。 您通常会使用数据中的ID作为`key`：

```js{2}
const todoItems = todos.map((todo) =>
  <li key={todo.id}>
    {todo.text}
  </li>
);
```

When you don't have stable IDs for rendered items, you may use the item index as a key as a last resort:

当您没有用于渲染项目的稳定ID时，您可以使用项目索引作为`key`的最后手段：

```js{2,3}
const todoItems = todos.map((todo, index) =>
  // Only do this if items have no stable IDs
  <li key={index}>
    {todo.text}
  </li>
);
```

We don't recommend using indexes for keys if the items can reorder, as that would be slow. You may read an [in-depth explanation about why keys are necessary](/react/docs/reconciliation.html#recursing-on-children) if you're interested.

如果项目可以重新排序，我们不建议使用键的索引，因为这会很慢。 如果您有兴趣，您可以阅读《深入了解为什么需要键》。

### Extracting Components with Keys(用键提取组件)

Keys only make sense in the context of the surrounding array.

键只有在数组周围的上下文中才有意义。

For example, if you [extract](/react/docs/components-and-props.html#extracting-components) a `ListItem` component, you should keep the key on the `<ListItem />` elements in the array rather than on the root `<li>` element in the `ListItem` itself.

例如，如果您提取了`ListItem`组件，则应该将该键保存在数组中的`<ListItem />`元素上，而不是`ListItem`本身中的根`<li>`元素上。

**Example: Incorrect Key Usage**

**示例：不正确使用密钥**

```javascript{4,5,14,15}
function ListItem(props) {
  const value = props.value;
  return (
    // 错误！ 这里没有必要指定键：
    <li key={value.toString()}>
      {value}
    </li>
  );
}

function NumberList(props) {
  const numbers = props.numbers;
  const listItems = numbers.map((number) =>
    // 错误！ key应该在这里指定：
    <ListItem value={number} />
  );
  return (
    <ul>
      {listItems}
    </ul>
  );
}

const numbers = [1, 2, 3, 4, 5];
ReactDOM.render(
  <NumberList numbers={numbers} />,
  document.getElementById('root')
);
```

**Example: Correct Key Usage**

**示例：正确使用密钥**

```javascript{2,3,9,10}
function ListItem(props) {
  // 正确！ 这里没有必要指定键：
  return <li>{props.value}</li>;
}

function NumberList(props) {
  const numbers = props.numbers;
  const listItems = numbers.map((number) =>
    // 正确！ key应在数组内指定。
    <ListItem key={number.toString()} value={number} />
  );
  return (
    <ul>
      {listItems}
    </ul>
  );
}

const numbers = [1, 2, 3, 4, 5];
ReactDOM.render(
  <NumberList numbers={numbers} />,
  document.getElementById('root')
);
```

[Try it on CodePen.](https://codepen.io/rthor/pen/QKzJKG?editors=0010)

A good rule of thumb is that elements inside the `map()` call need keys.

一个很好的经验法则是在`map（）`函数调用中添加元素需要的`key`。

### Keys Must Only Be Unique Among Siblings(Key在兄弟组件中必须是唯一的)

Keys used within arrays should be unique among their siblings. However they don't need to be globally unique. We can use the same keys when we produce two different arrays:

数组中使用的Key在其兄弟组件之间应该是唯一的。 然而，它们不需要是全局唯一的。 当我们生成两个不同的数组时，我们可以使用相同的键：

```js{2,5,11,12,19,21}
function Blog(props) {
  const sidebar = (
    <ul>
      {props.posts.map((post) =>
        <li key={post.id}>
          {post.title}
        </li>
      )}
    </ul>
  );
  const content = props.posts.map((post) =>
    <div key={post.id}>
      <h3>{post.title}</h3>
      <p>{post.content}</p>
    </div>
  );
  return (
    <div>
      {sidebar}
      <hr />
      {content}
    </div>
  );
}

const posts = [
  {id: 1, title: 'Hello World', content: 'Welcome to learning React!'},
  {id: 2, title: 'Installation', content: 'You can install React from npm.'}
];
ReactDOM.render(
  <Blog posts={posts} />,
  document.getElementById('root')
);
```

[Try it on CodePen.](https://codepen.io/gaearon/pen/NRZYGN?editors=0010)

Keys serve as a hint to React but they don't get passed to your components. If you need the same value in your component, pass it explicitly as a prop with a different name:

Key充当React的一个提示，但它不会传递给您的组件。 如果您的组件中需要相同的值，请将其作为具有不同名称的属性进行显式传递：

```js{3,4}
const content = posts.map((post) =>
  <Post
    key={post.id}
    id={post.id}
    title={post.title} />
);
```

With the example above, the `Post` component can read `props.id`, but not `props.key`.

通过上面的例子，`Post`组件可以读取`props.id`，而不是`props.key`。

### Embedding map() in JSX(在JSX中嵌入map() )

In the examples above we declared a separate `listItems` variable and included it in JSX:

在上面的例子中，我们声明了一个单独的`listItems`变量并将其包含在JSX中：

```js{3-6}
function NumberList(props) {
  const numbers = props.numbers;
  const listItems = numbers.map((number) =>
    <ListItem key={number.toString()}
              value={number} />
  );
  return (
    <ul>
      {listItems}
    </ul>
  );
}
```

JSX allows [embedding any expressions](/react/docs/introducing-jsx.html#embedding-expressions-in-jsx) in curly braces so we could inline the `map()` result:

JSX允许将任何表达式嵌入到花括号中，以便我们可以内联`map（）`结果：

```js{5-8}
function NumberList(props) {
  const numbers = props.numbers;
  return (
    <ul>
      {numbers.map((number) =>
        <ListItem key={number.toString()}
                  value={number} />
      )}
    </ul>
  );
}
```

[Try it on CodePen.](https://codepen.io/gaearon/pen/BLvYrB?editors=0010)

Sometimes this results in clearer code, but this style can also be abused. Like in JavaScript, it is up to you to decide whether it is worth extracting a variable for readability. Keep in mind that if the `map()` body is too nested, it might be a good time to [extract a component](/react/docs/components-and-props.html#extracting-components).

有时这会使代码更清晰的，但这种风格写法也可能被滥用。 像JavaScript一样，由你决定是否值得提取可变性的变量。 请记住，如果`map（）`内容嵌套太深，这可能是提取组件的好时机。



