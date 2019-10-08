---
layout: post
title:  "Thinking in React(React的思想)"
date:   2017-04-08 11:11:11
categories: react
---

React is, in our opinion, the premier way to build big, fast Web apps with JavaScript. It has scaled very well for us at Facebook and Instagram.

在我看来，React 是快速 构建大型`Web`应用的首选方式。它已经在`Facebook`和`Instagram`被我们有了广泛的应用。

One of the many great parts of React is how it makes you think about apps as you build them. In this document, we'll walk you through the thought process of building a searchable product data table using React.

React许多优点之一：它使得你在构建 app 的过程中不断思考。在本文里，我将带你经历一次使用 React 构建可搜索的商品数据表的思考过程。

## Start With A Mock(从模型开始)

Imagine that we already have a JSON API and a mock from our designer. The mock looks like this:

想象我们已经有个一个 JSON API 和一个来自设计师的模型。我们的设计师显然做得不够好，因为模型看起来像这样：

![Mockup](https://facebook.github.io/react/img/blog/thinking-in-react-mock.png)

Our JSON API returns some data that looks like this:

我们的 JSON API 返回一些看起来像这样的数据：

```
[
  {category: "Sporting Goods", price: "$49.99", stocked: true, name: "Football"},
  {category: "Sporting Goods", price: "$9.99", stocked: true, name: "Baseball"},
  {category: "Sporting Goods", price: "$29.99", stocked: false, name: "Basketball"},
  {category: "Electronics", price: "$99.99", stocked: true, name: "iPod Touch"},
  {category: "Electronics", price: "$399.99", stocked: false, name: "iPhone 5"},
  {category: "Electronics", price: "$199.99", stocked: true, name: "Nexus 7"}
];
```

## Step 1: Break The UI Into A Component Hierarchy

## 第一步：把UI拆分为一些有层级结构的组件

The first thing you'll want to do is to draw boxes around every component (and subcomponent) in the mock and give them all names. If you're working with a designer, they may have already done this, so go talk to them! Their Photoshop layer names may end up being the names of your React components!

首先你想要做的，是在模型里的每一个组件周围绘制边框，并给它们命名。如果你和设计师一起工作，他们应该已经完成这步了，所以去和他们谈谈！他们的 Photoshop 图层名也许最终会成为你的 React 组件名。

But how do you know what should be its own component? Just use the same techniques for deciding if you should create a new function or object. One such technique is the [single responsibility principle](https://en.wikipedia.org/wiki/Single_responsibility_principle), that is, a component should ideally only do one thing. If it ends up growing, it should be decomposed into smaller subcomponents.

但是你如何知道什么东西应该是独立的组件？只需在你创建一个函数或者对象时，根据是否使用过相同技术来做决定。一种这样的技术是[单一功能原则（single responsibility principle）](https://en.wikipedia.org/wiki/Single_responsibility_principle)，也就是一个组件在理想情况下只做一件事情。如果它最终增长了，它就应该被分解为更小的组件。

Since you're often displaying a JSON data model to a user, you'll find that if your model was built correctly, your UI (and therefore your component structure) will map nicely. That's because UI and data models tend to adhere to the same *information architecture*, which means the work of separating your UI into components is often trivial. Just break it up into components that represent exactly one piece of your data model.

既然你频繁显示一个 JSON 的数据模型给用户，你会发现，如果你的模型构建正确，你的 UI（因此也有你的组件结构）就将映射良好。那是因为 UI 和数据模型趋向附着于相同的 *信息架构*，这意味着，把你的 UI 分离为组件的工作通常是琐碎的，只需把 UI 拆分成能准确对应数据模型的每块组件。

![Component diagram](https://facebook.github.io/react/img/blog/thinking-in-react-components.png)

You'll see here that we have five components in our simple app. We've italicized the data each component represents.

在这里你会看到，在我们的简单的APP里有五个组件。我用斜体表示每个组件的数据。

1. **`FilterableProductTable` (orange):** contains the entirety of the example

   **FilterableProductTable (橙色):** 包含示例的整体

2. **`SearchBar` (blue):** receives all *user input*

   **SearchBar (蓝色):** 接收所有 *用户输入*

3. **`ProductTable` (green):** displays and filters the *data collection* based on *user input*

   **ProductTable (绿色):** 基于 *用户输入* 显示和过滤的 *数据集合(data collection)*

4. **`ProductCategoryRow` (turquoise):** displays a heading for each *category*

   **ProductCategoryRow (蓝绿色):** 为每个 *分类* 显示一个列表头

5. **`ProductRow` (red):** displays a row for each *product*

   **ProductRow (红色):** 为每个 *商品* 显示一行

If you look at `ProductTable`, you'll see that the table header (containing the "Name" and "Price" labels) isn't its own component. This is a matter of preference, and there's an argument to be made either way. For this example, we left it as part of `ProductTable` because it is part of rendering the *data collection* which is `ProductTable`'s responsibility. However, if this header grows to be complex (i.e. if we were to add affordances for sorting), it would certainly make sense to make this its own `ProductTableHeader` component.

如果你看着 `ProductTable`，你会看到表头(包含了 "Name" 和 "Price" 标签) 不是独立的组件。这是一个个人喜好问题，并且无论采用哪种方式都有争论。对于这个例子，我把它留做 `ProductTable` 的一部分，因为它是 *data collection*渲染的一部分，而 *data collection* 渲染是 `ProductTable` 的职责。然而，当列表头增长到复杂的时候(例如：如果我们添加排序功能)，那么使它成为独立的 `ProductTableHeader` 组件无疑是有意义的。

Now that we've identified the components in our mock, let's arrange them into a hierarchy. This is easy. Components that appear within another component in the mock should appear as a child in the hierarchy:

既然现在我们已经识别出了我们模型中的组件，让我们把他们安排到一个层级中。这很容易。在模型中，出现在一个组件里面的另一组件 ，应该在层级中表现为一种子级关系：

* `FilterableProductTable`
  * `SearchBar`
  * `ProductTable`
    * `ProductCategoryRow`
    * `ProductRow`

## Step 2: Build A Static Version in React

## 第二步：用React创建一个静态版本

<p data-height="600" data-theme-id="0" data-slug-hash="vXpAgj" data-default-tab="js" data-user="lacker" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/lacker/pen/vXpAgj/">Thinking In React: Step 2</a> on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

Now that you have your component hierarchy, it's time to implement your app. The easiest way is to build a version that takes your data model and renders the UI but has no interactivity. It's best to decouple these processes because building a static version requires a lot of typing and no thinking, and adding interactivity requires a lot of thinking and not a lot of typing. We'll see why.

既然你已经了解了组件的层级结构，是时候实现你的app了。简单的方式是构建一个版本，它取走你的数据模型并渲染UI，除了没有互动性。这是将过程解耦的最好办法，因为构建一个静态版本需要不假思索地写很多代码，而添加互动性需要很多思考但不需要太多代码。之后我们将会看到原因。

To build a static version of your app that renders your data model, you'll want to build components that reuse other components and pass data using *props*. *props* are a way of passing data from parent to child. If you're familiar with the concept of *state*, **don't use state at all** to build this static version. State is reserved only for interactivity, that is, data that changes over time. Since this is a static version of the app, you don't need it.

要构建一个静态版本 app 来渲染你的数据模型，你将会想到构建一个重用其它组件并利用 *props* 传递数据的组件。*props* 是一种从父级传递数据到子级的方式。如果你对 *state* 的观念很熟悉，**绝不要用state** 来构建这个静态版本。State 仅仅是为互动性，也就是随时间变化的数据所预留的。由于这是一个静态版本，你还不需要用到它。

You can build top-down or bottom-up. That is, you can either start with building the components higher up in the hierarchy (i.e. starting with `FilterableProductTable`) or with the ones lower in it (`ProductRow`). In simpler examples, it's usually easier to go top-down, and on larger projects, it's easier to go bottom-up and write tests as you build.

你可以自顶向下或自底向上的构建。也就是说，你可以既从较高的层级（比如从 `FilterableProductTable` 开始）也可以从较低的层级（`ProductRow`）开始构建组件。在较简单的例子里，通常自顶向下要容易一些，然而在更大的项目上，自底向上地构建更容易，并且更方便伴随着构建写测试。

At the end of this step, you'll have a library of reusable components that render your data model. The components will only have `render()` methods since this is a static version of your app. The component at the top of the hierarchy (`FilterableProductTable`) will take your data model as a prop. If you make a change to your underlying data model and call `ReactDOM.render()` again, the UI will be updated. It's easy to see how your UI is updated and where to make changes since there's nothing complicated going on. React's **one-way data flow** (also called *one-way binding*) keeps everything modular and fast.

在这一步的最后，你会获得一个渲染数据模型的可重用组件库。这些组件只有 `render()` 方法，因为这是一个静态版本。在层级顶端的组件 (`FilterableProductTable`) 将会接受你的数据模型，并将其作为一个prop。如果你改变了底层数据模型，并且再次调用 `React.render()` ，UI 将会更新。你可以很容易地看到 UI 是如何更新的，以及哪里变动了，因为这没什么复杂的。React的 **单向数据流** (也被称为 *单向绑定*)使一切保持了模块化和快速。

Simply refer to the [React docs](/react/docs/) if you need help executing this step.

如果你在执行这步时需要帮助，请参阅 [React 文档](http://www.lijunbo.com/react/2017/03/28/rqd-hello-world.html)。

### A Brief Interlude: Props vs State

There are two types of "model" data in React: props and state. It's important to understand the distinction between the two; skim [the official React docs](/react/docs/interactivity-and-dynamic-uis.html) if you aren't sure what the difference is.

## Step 3: Identify The Minimal (but complete) Representation Of UI State

## 第三步：确定最小（但完备）的 UI state 表达

To make your UI interactive, you need to be able to trigger changes to your underlying data model. React makes this easy with **state**.

要让你的 UI 互动，你需要做到触发底层数据模型发生变化。React用 **state** 来让此变得容易。

To build your app correctly, you first need to think of the minimal set of mutable state that your app needs. The key here is DRY: *Don't Repeat Yourself*. Figure out the absolute minimal representation of the state your application needs and compute everything else you need on-demand. For example, if you're building a TODO list, just keep an array of the TODO items around; don't keep a separate state variable for the count. Instead, when you want to render the TODO count, simply take the length of the TODO items array.

要正确的构建你的 app，你首先需要思考你的 app 需要的可变 state 的最小组。这里的关键是 DRY 原则：*Don't Repeat Yourself(不要重复自己)*。想出哪些是你的应用需要的绝对最小 state 表达，并按需计算其他任何数据。例如，如果你要构建一个 TODO 列表，只要保持一个 TODO 项的数组；不要为了计数保持一个单独的 state 变量。当你想渲染 TODO 的计数时，简单的采用 TODO 项目的数组长度作为替代。

fdsajhgfiuytretrewq7lkz2Think of all of the pieces of data in our example application. We have:

考虑我们示例应用中的数据所有块，包括：

* The original list of products
* 原始的商品列表
* The search text the user has entered
* 用户输入的搜索文本
* The value of the checkbox
* 复选框的值
* The filtered list of products
* 商品的过滤列表

Let's go through each one and figure out which one is state. Simply ask three questions about each piece of data:

让我们逐个检查出哪一个是state，只需要简单地问以下三个问题:

1. Is it passed in from a parent via props? If so, it probably isn't state.

   它是通过props从父级传递来的吗？如果是，它可能不是 state。

2. Does it remain unchanged over time? If so, it probably isn't state.

   它随时间变化吗？如果不是,它可能不是 state。

3. Can you compute it based on any other state or props in your component? If so, it isn't state.

   你能基于其他任何组件里的 state 或者 props 计算出它吗？如果是,它可能不是state.

The original list of products is passed in as props, so that's not state. The search text and the checkbox seem to be state since they change over time and can't be computed from anything. And finally, the filtered list of products isn't state because it can be computed by combining the original list of products with the search text and value of the checkbox.

原始的商品列表以 props 传入，所以它不是 state。搜索文本和复选框看起来是 state，因为他们随时间变化并且不能从任何东西计算出。最后，过滤出的商品列表不是 state，因为它可以通过原始列表与搜索文本及复选框的值组合计算得出。

So finally, our state is:(所以最后,我们的 state 是:)

* The search text the user has entered (用户输入的搜索文本)
* The value of the checkbox(checkbox 的值)

## Step 4: Identify Where Your State Should Live

## 第四步：确定你的 state 应该存在于哪里

<p data-height="600" data-theme-id="0" data-slug-hash="ORzEkG" data-default-tab="js" data-user="lacker" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/lacker/pen/ORzEkG/">Thinking In React: Step 4</a> by Kevin Lacker (<a href="http://codepen.io/lacker">@lacker</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

OK, so we've identified what the minimal set of app state is. Next, we need to identify which component mutates, or *owns*, this state.

OK，我们已经确定好应用的最小 state 集合是什么。接下来，我们需要确定哪个组件可以改变，或者 *拥有* 这个state.

Remember: React is all about one-way data flow down the component hierarchy. It may not be immediately clear which component should own what state. **This is often the most challenging part for newcomers to understand,** so follow these steps to figure it out:

记住：React 总是在组件层级中单向数据流动的。可能不能立刻明白哪些组件应该拥有哪些 state。 **这对于新手在理解上经常是最具挑战的一部分，** 所以跟着这几步来弄明白它：

For each piece of state in your application:(对于您的应用程序中的每个状态)

* Identify every component that renders something based on that state.

  确定哪些组件要基于 state 来渲染内容。

* Find a common owner component (a single component above all the components that need the state in the hierarchy).

  找到多个组件的一个共同拥有者（在所有需要这个state组件的层次之上，找出共有的单一组件）。

* Either the common owner or another component higher up in the hierarchy should own the state.

  要么是共同拥有者，要么是其他在层级里更高级的组件应该拥有这个state。

* If you can't find a component where it makes sense to own the state, create a new component simply for holding the state and add it somewhere in the hierarchy above the common owner component.

  如果你找不到一个组件让其可以有意义地拥有这个 state，可以简单地创建一个新的组件 hold 住这个state，并把它添加到比共同拥有者组件更高的层级上。

Let's run through this strategy for our application:

让我们使用这个策略浏览一遍我们的应用：

* `ProductTable` needs to filter the product list based on state and `SearchBar` needs to display the search text and checked state.

  `ProductTable` 需要基于 state 过滤产品列表，`SearchBar` 需要显示搜索文本和选择状态。

* The common owner component is `FilterableProductTable`.

* 共同拥有者组件是 `FilterableProductTable`。

* It conceptually makes sense for the filter text and checked value to live in `FilterableProductTable`

  对于过滤文本和选择框值存在于 `FilterableProductTable`，从概念上讲是有意义的。

Cool, so we've decided that our state lives in `FilterableProductTable`. First, add an instance property `this.state = {filterText: '', inStockOnly: false}` to `FilterableProductTable`'s `constructor` to reflect the initial state of your application. Then, pass `filterText` and `inStockOnly` to `ProductTable` and `SearchBar` as a prop. Finally, use these props to filter the rows in `ProductTable` and set the values of the form fields in `SearchBar`.

酷，我们已经确定了我们的 state 存在于 `FilterableProductTable`。首先，向`FilterableProductTable`的构造函数添加一个实例属性`this.state = {filterText：'，inStockOnly：false}`以反映应用程序的初始状态。然后，传递`filterText` 和 `inStockOnly` 给 `ProductTable` 和 `SearchBar` 作为属性。最后，使用这些属性来过滤 `ProductTable` 中的行和设置 `SearchBar` 的表单项的值。

You can start seeing how your application will behave: set `filterText` to `"ball"` and refresh your app. You'll see that the data table is updated correctly.

你可以开始看看你的应用将有怎样的行为了: 设置 `filterText` 为 `"ball"` 并刷新你的 app。你将可以看到数据表被正确地更新。

## Step 5: Add Inverse Data Flow

## 第五步：添加反向数据流

<p data-height="265" data-theme-id="0" data-slug-hash="qRqmjd" data-default-tab="js,result" data-user="rohan10" data-embed-version="2" data-pen-title="Thinking In React: Step 5" class="codepen">See the Pen <a href="http://codepen.io/rohan10/pen/qRqmjd">Thinking In React: Step 5</a> on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

So far, we've built an app that renders correctly as a function of props and state flowing down the hierarchy. Now it's time to support data flowing the other way: the form components deep in the hierarchy need to update the state in `FilterableProductTable`.

到目前为止，我们已经构建了一个应用, 它能够使用 props 和 state的功能沿着自顶向下层级正确渲染。现在是时候支持另一种数据流了：在层级深处的表单组件需要更新 `FilterableProductTable` 里的 state。

React makes this data flow explicit to make it easy to understand how your program works, but it does require a little more typing than traditional two-way data binding.

React让数据流显式流动，使您可以轻松了解程序的工作原理，但它比传统的双向数据绑定需要写更多的代码。

If you try to type or check the box in the current version of the example, you'll see that React ignores your input. This is intentional, as we've set the `value` prop of the `input` to always be equal to the `state` passed in from `FilterableProductTable`.

如果你尝试在当前版本的示例中输入或者选中复选框，你会发现 React 忽略了你的输入。这是有意的，因为我们已经设置了 `input` 的 `value` prop 值总是与 `FilterableProductTable` 传递过来的 `state` 一致。

Let's think about what we want to happen. We want to make sure that whenever the user changes the form, we update the state to reflect the user input. Since components should only update their own state, `FilterableProductTable` will pass callbacks to `SearchBar` that will fire whenever the state should be updated. We can use the `onChange` event on the inputs to be notified of it. The callbacks passed by `FilterableProductTable` will call `setState()`, and the app will be updated.

让我们思考下希望发生什么。我们想确保每当用户改变表单，就通过更新 state 来反映用户的输入。由于组件应该只更新自己拥有的 state ， `FilterableProductTable` 将会传递一个回调函数给 `SearchBar` ，每当 state 应被更新时回调函数就会被调用。我们可以使用 input 的 `onChange` 事件来接收它的通知。 `FilterableProductTable` 传递的回调函数将会调用 `setState()` ，然后应用将会被更新。

Though this sounds complex, it's really just a few lines of code. And it's really explicit how your data is flowing throughout the app.

虽然这听起来复杂，但是实际上只有几行代码。并且这明确显示出了数据在应用中从始至终是如何流动的。

## And That's It (好了，就是这样)

Hopefully, this gives you an idea of how to think about building components and applications with React. While it may be a little more typing than you're used to, remember that code is read far more than it's written, and it's extremely easy to read this modular, explicit code. As you start to build large libraries of components, you'll appreciate this explicitness and modularity, and with code reuse, your lines of code will start to shrink. :)

希望这给了你一个怎样思考用React构建组件和应用的概念。虽然可能比你过往的习惯要多敲一点代码，但记住，读代码的时间远比写代码的时间多，并且阅读这种模块化的、显式的代码是极为容易的。当你开始构建大型组件库时，你会非常感激这种清晰性和模块化，并且随着代码的重用，你的代码行数将会开始缩减。:)