---
layout: post
title:  "索引和查询性能"
date:   2018-05-02 09:12:51
categories: database
---

`Loki.js`一直是快速的内存数据库解决方案。事实上，最近的基准测试表明，在`node.js`下运行的终端`Core i5`中，其主要的`get()`操作速度约为每秒140万次。`get()` 操作利用一个自动生成的 `'$loki` id 列和自己生成的二进制索引。如果您希望提供您自己的`unique key`，则可以添加单个唯一的索引到集合中，便可使用`collection.by()`方法进行获取。这种方法比使用内置的`$loki`  id快得多。因此，如果您打算进行单一对象查找，就可以获得此优化的性能。

### 使用自动生成的`$loki`列查找示例 :

```javascript
var users = db.addCollection("users");
var resultObj = users.insert({username:"Heimdallr"});

// 现在我们的对象已经被插入，它将会添加一个`$loki`属性
var heimdallr = users.get(resultObj.$loki);
```

### 示例对象查找指定您自己的唯一索引 :

```javascript
var users = db.addCollection("users", {
    unique: ['username']
});

// 插入记录后，您可能会使用coll.by()检索记录
var result = users.by("username", "Heimdallr");
```

### 'Find' 过滤

更通用的查询方式是使用接受`mongo`风格查询对象的`collection.find()`。如果您没有为正在搜索的列添加索引，可以在`node.js`下获得预期约 `20k ops/sec` (浏览器性能可能会有所不同，但这是一个很好的数量级)。对于大多数情况下，性能可能比需要的更高，但现在可以在对象属性上应用`loki.js`二进制索引。使用` collection.ensureIndex(propertyName) `方法，您可以创建一个可以被各种`find()`操作使用的索引，例如`collection.find()`。对于我们的测试基准，这会将性能提高到大约`500k ops/sec`。

二进制索引可以与范围操作符一起使用，返回给定`属性/范围`的多个文档结果。**如果您已将二进制索引应用于属性，则可以通过使用包含该属性的查询对象调用`collection.find()`来利用该索引。**能够使用二进制索引的`find()`操作符包括` $eq, $aeq, $lt, $lte, $gt, $gte, $between, $in.`

> 默认情况下，如果您在属性上应用了二进制索引，并且将包含JavaScript Date对象的文档作为该属性的值插入，则 `loki` 将用可序列化安全的历元时间格式日期（整数）替换它。这是为了防止索引变得不可维护，如果我们将它保存为Date并将其作为字符串加载（它们就可以不同的顺序排序）。如果你不打算保存你的数据库（完全在内存中使用），你可以在创建集合时传递一个`'serializableIndices：false'`选项，我们不会改变你的日期。

### 二进制索引示例 :

```javascript
var coll = db.addCollection('users', {
  indices: ['location']
});

// 插入记录后，您可以使用相等或范围操作符,如这种隐式 (strict) $eq op :
var results = users.find({ location:  'Himinbjörg' });
```

### Loki 的排序和范围

> Native JavaScript提供 `==`（abstract）相等，`===`（strict）相等，`<`（abstract）小于，`>`（abstract）大于等等。JavaScript处理很多混合类型，所以你可能想要一个数字4（abstract）等于字符串'4'。如果你想测试'小于'4，它会默认转换为字符串，所以如果你不想要字符串，你将不得不使用`'typeof'`或其他类型检测来手动过滤掉其他类型。Loki倾向于处理纯数据，但必须动态变化以支持额外发现的各种“脏”数据。因此，我们试图调整“范围”的概念，因为它涉及属性上的混合类型，以便它们适应混合类型，并提供类似的` find() `结果，而不管您是否使用二进制索引。

- `loki`中的所有值都被我们的`find() `操作解释为“小于”，“大于” 或 “等于” 任何其他值。这与JavaScript不同，所以`loki`在两个值之间建立了统一的范围排序。
- 4 是 `$aeq` (非严格等于) `'4'`, 正如 `'3' $lt(小于) 4`, 和 `4 is $gte(大于) '3'`, 所以混合数字和'数字'字符串范围在`loki`中查找数字。
- '数字'字符串与'非数字'字符串保持在不同的范围（数字），所以`9999`将会是`$lt '111asdf"`。
- 对象都是平等的（除非使用点符号来查询对象属性）。
- 日期按照他们的纪元时间排序为数字......这些数字很大，一般在数字范围的顶端。
- `$type op`可用于过滤不符合特定`JavaScript`类型的结果。
- `$finite op` 可用于过滤出“数字”或“非数字”的结果。

### 'Where' 过滤器

**如果性能受到关注，应该谨慎使用'Where'过滤器（JavaScript过滤器函数）。他们无法使用索引，因此性能不会比未索引查找更好，并且取决于过滤器函数的复杂性，甚至更少。**Unindex查询以及过滤器始终需要完整阵列扫描的位置，但如果数千ops/sec足够用，或稍后在查询链或动态视图过滤器管道中使用，并且惩罚更少，则它们可能非常有用。

### 在查询链中进行索引

`Resultset`类引入了`方法链`作为查询选项。您可以使用`方法链`来连续应用几个查找操作，或者将`find()`，`where()`和`sort()`操作混合到`顺序链式`管道中。为了简单起见，这个例子可能是（其中用户是一个集合对象）：

```
    users.chain().find(queryObj).where(queryFunc).simplesort('name').data();
```

检查这个语句，如果`queryObj`（一个mongo风格的查询对象）是`{'age'：{'$ gt'：30}}`，那么这个年龄段列表最好应用一个索引，并且`find()`链操作应该在`方法链`中排名第一。**在链式操作中，只有第一个链式过滤器可以利用索引进行过滤。**如果它筛选出足够数量的记录，那么（where）查询函数的影响会更小。保留过滤结果集的开销比`collection.find`降低了20％左右，但是它们的功能更强大。在我们的基准测试中，这仍然大约是 **400k  ops/sec**。

### 索引和排序

如果没有应用过滤器，并且（例如）'name'属性上存在二进制索引，则可以充分利用二进制索引：

```
coll.chain().simplesort('name').data();
```

如果发生了过滤，我们将检测我们是否可以利用`'索引相交'`算法中的索引来加速对典型`loki`排序的排序。只有在结果集中的结果集总数超过10％的情况下，才会启用此'索引相交'算法，否则标准loki排序将被确定为更快的方法。“索引相交”的性能优势与过滤质量有些成反比，因此它利用二进制索引来帮助减少“最坏情况”的分类处罚。

**`Loki sorting` 不仅用于排序，还用于构建二进制索引**，但如果您不需要在混合类型中进行更加统一的排序，则可以通过调用以下方法将额外的毫秒数排除在排序调用之外：

```
coll.chain().simplesort('name', { useJavascriptSorting: true }).data();
```

如果在`'name'`属性中存在二进制索引，我们将使用索引相交算法，除非`resultset`具有10％或更少的文档总数，此时我们将回退到传递给`simplesort`的属性上的JavaScript排序。如果您没有在该属性上应用二进制索引，那么如果该选项已通过，我们将始终使用JavaScript排序。

## 动态视图管道

动态视图的行为与结果集[resultsets]相似，因为您要使用索引，必须使用第一个过滤器

```javascript
  var userview = users.addDynamicView("over30");
  userview.applyFind({'Age': {'$gte':30}});

  // 可以随时获取最新的视图结果
  var results = userview.data();

  // 或对结果集进一步过滤
  results = userview.branchResultset().find({'Country': 'JP'}).data();
```

该查找过滤器理想情况下应引用您已应用索引（在此情况下为“年龄”）的字段。但是，动态视图运行一次它们的过滤器，因此即使是非高性能查询管道在建立之后也是快速的。这是由于在插入，更新或从集合中删除单个对象时重新评估这些过滤器。作为单个对象评估，在第一次评估期间不存在阵列扫描损失。动态视图的开销占据了结果集的顶部，将第一次评估的性能降低了大约40％，但后续查询得到了高度优化（比collection.find更快）。即使有这样的开销，我们的基准测试显示初始评估大约为30万[ops/sec]性能。根据更新频率的不同，后续评估可以扩展至每秒100万次以上。

在`loki.js`中，动态视图目前有两个选项，`'persistent'（默认为false`）和`'sortPriority'（默认为'passive'）`。

`'persistent'`选项表示结果将保存在内部数组中（除了正常的结果集）。这个`'resultdata'`数组会根据您的规范进行过滤和排序。将结果复制到内部数组发生在第一次`data()`评估期间，或者一旦过滤器或排序将结果集污染（文档插入，更新，从视图中删除）。此选项会增加内存开销，但可能会优化`data()`调用。

`'sortPriority'`选项可以是`'passive'或'active'`。默认情况下，当调用`data()`并将这些排序标记污染时，会进行懒惰`（'passive'）`。如果您希望排序成本为`“up-front”`，您可以指定`“active” sortPriority`。使用`active`的`sortPriority`，一旦插入/更新/删除将排序标记为脏，我们将排队并限制异步排序以在线程产生时运行。因此，如果更新频率较低或单独批量修改，则可以预先支付性能成本，以确保稍后获得最佳`data()`检索速度。如果您的数据修改频繁且零星，如果没有人读取数据，则有效的`sortPriority`可能会浪费计算排序。