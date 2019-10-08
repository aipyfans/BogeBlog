---
layout: post
title:  "查询示例"
date:   2018-05-02 09:12:51
categories: database
---

### 注意：我们现在在这个库的'examples'子文件夹中有几个快速入门示例。

> <https://github.com/techfort/LokiJS/blob/master/examples/quickstart-core.js>
>
>  <https://github.com/techfort/LokiJS/blob/master/examples/quickstart-chaining.js>
>
> <https://github.com/techfort/LokiJS/blob/master/examples/quickstart-transforms.js>
>
> <https://github.com/techfort/LokiJS/blob/master/examples/quickstart-dynview.js>
>
> 对于持久性示例，我们在 [Loki Sandbox ](https://rawgit.com/techfort/LokiJS/master/examples/sandbox/LokiSandbox.htm)中的 [示例文件夹](https://github.com/techfort/LokiJS/tree/master/examples) 和Web快速入门要点中编号了节点快速入门。

### 设计查询

LokiJS衍生出了多种查询数据库的机制。在最高抽象层次上，让我们将这些方法分为以下几类：

- 核心方法 - 直接应用于集合的查询的简单而强大的方法。
- 链（通过Resultset） - 允许按顺序排序(sorting)，限制(limiting)，偏移(offsets)和多个查询(multiple queries)。
- 链变换 - 类似于上面的方法链，但在可以序列化的对象结构中定义。
- 动态视图  - 允许具有可能较大结果集的常用查询以获得最佳性能和可用性。

在每种方法中，您的查询通常属于`find`和`where`类别。

### 'Where' 查询

这些查询利用`JavaScript函数`来过滤数据。**这是用于过滤集合中文档的最慢但最通用的方法。**从本质上讲，我们将在集合中的每个文档上应用过滤器，以查看它是否应该放在结果集中。

```javascript
// 简单的匿名过滤器
var results = coll.where(function(obj) {
  return obj.legs === 8;
});

// -或- 设置命名过滤器函数
function sleipnirFilter(obj) {
  return obj.legs === 8;
}

// 然后传递给where函数
results = coll.where(sleipnirFunction);
```

### 'Find' 查询

**`Find查询`基于`mongo查询`语法的子集，并且能够使用`索引`来加速查询。**<u>与`集合变换(Collection Transforms)`或`动态视图(Dynamic Views)`一起使用时，这些过滤器可以保存到数据库本身中。</u>**这是查询Loki数据库的首选方法。**<u>使用`Find`查询所有内容（或尽可能多地过滤），如果发现不支持的边界情况，则使用`'where'`过滤。</u>

### 'Find' 操作符示例 :

**[目前增加和审查几个操作符的功能...我们可能应该用更好的例子来扩展本节的更多细节]**

目前支持的主要操作符：

**$eq-(equal)** - 过滤具有(严格)`相等`属性的文档

```javascript
// 隐式（假设已经使用了$eq运算符）
var results = coll.find({'Name': 'Odin'});

// 显式 $eq
results = coll.find({'Name': { '$eq' : 'Odin' }});
```

**$ne-(not equal**) -对属性`不等于`提供值的文档进行过滤

```javascript
// 不等于测试
var results = coll.find({'legs': { '$ne' : 8 }});
```

**$aeq-(abstract equal)** - 过滤具有抽象（非严格）`等同`性质的文档

```javascript
// 将匹配20岁或20岁的文档
var results = coll.find(age: {$aeq: 20});
```

**$dteq-(date equal)** - 过滤`日期属性等于`提供日期值的文档

```javascript
var dt1 = new Date("1/1/2017");
var dt2 = new Date("1/1/2017");

items.insert({ name : 'mjolnir', created: dt1 });
items.insert({ name : 'gungnir', created: dt2 });

//返回上述两个插入的文档
var results = items.find({ created: { $dteq: new Date("1/1/2017") } });
```

**$gt-(greater than)** - 过滤属性`大于`提供值的文档

```javascript
var results = coll.find({'age': {'$gt': 40}});
```

**$gte-(greater than equal)** -过滤具有`大于或等于`提供值的属性的文档

```javascript
var results = coll.find({'age': {'$gte': 40}});
```

**$lt-(less than)** - 过滤属性`小于`提供值的文档

```javascript
var results = coll.find({'age': {'$lt': 40}});
```

**$lte-(less than equal)** - 过滤属性`小于或等于`提供值的文档

```javascript
var results = coll.find({'age': {'$lte': 40}});
```

**$between** - 通过提供的属性过滤出在提供的值`之间`的文档

```javascript
// 匹配50至75之间的计数值的用户
var results = users.find({ count : { '$between': [50, 75] }});
```

> 注意：上面的`$gt，$gte，$lt，$lte`和`$ops`之间使用`'loki'`排序，它提供了一个统一范围的`actoss`混合类型，并返回相同的结果，无论属性是否被索引。这对二进制索引和保证索引和非索引比较结果相等是必需的。
>
> 如果您不希望利用二进制索引，并且您希望简单的JavaScript比较可以接受，那么我们提供以下操作（由于它们的简化比较）可以提供更优化的执行速度。
>
> **$jgt-(javascipt greater than)** - 过滤(使用简化的JavaScript比较)出具有`大于`给定值的属性的文档
>
> ```javascript
> var results = coll.find({'age': {'$jgt': 40}});
> ```
>
> **$jgte-(javascipt greater than equal)** - 过滤(使用简化的JavaScript比较)出具有`大于等于`给定值的属性的文档
>
> ```javascript
> var results = coll.find({'age': {'$jgte': 40}});
> ```
>
> **$jlt-(javascipt less than)** - 过滤(使用简化的JavaScript比较)出具有`小于`给定值的属性的文档
>
> ```javascript
> var results = coll.find({'age': {'$jlt': 40}});
> ```
>
> **$jlte-(javascipt less than equal)** - 过滤(使用简化的JavaScript比较)出具有`小于等于`给定值的属性的文档
>
> ```javascript
> var results = coll.find({'age': {'$jlte': 40}});
> ```
>
> **$jbetween**- 通过提供的属性过滤(使用简化的JavaScript比较)出在提供的值`之间`的文档
>
> ```javascript
> var results = users.find({ count : { '$jbetween': [50, 75] }});
> ```

**$regex** - 根据提供的正则表达式过滤出具有属性匹配的文档

> 如果在`命名转换`或`动态视图`过滤器中使用正则表达式操作符，最好使用`后两个示例`，因为原始正则表达式好像没有`序列化/反序列化`。

```javascript
// 传入原始正则表达式
var results = coll.find({'Name': { '$regex' : /din/ }});

//或仅传递字符串模式
results = coll.find({'Name': { '$regex': 'din' }});

// 或传入[pattern，options]字符串数组
results = coll.find({'Name': { '$regex': ['din', 'i'] }});
```

**$in** - 过滤具有与所提供的数组值`相匹配`的属性的文档。你的属性不应该是一个数组，但你的比较值应该是。

```javascript
users.insert({ name : 'odin' });
users.insert({ name : 'thor' });
users.insert({ name : 'svafrlami' });

// 在数组集合['odin'，'thor']中将用户与名称进行匹配
var results = users.find({ 'name' : { '$in' : ['odin', 'thor'] } });
```

**$nin** -  过滤具有与所提供的数组值`不匹配`的属性的文档。

```javascript
users.insert({ name : 'odin' });
users.insert({ name : 'thor' });
users.insert({ name : 'svafrlami' });

// 将用户与名称不匹配的用户匹配['odin'，'thor']（仅svafrlami文档符合）
var results = users.find({ 'name' : { '$nin' : ['odin', 'thor'] } }); 
```

**$keyin** - filter for document(s) whose property value is defined in the provided hash object keys.*(Equivalent to $in: Object.keys(hashObject))* ( [#362](https://github.com/techfort/LokiJS/issues/362), [#365](https://github.com/techfort/LokiJS/issues/365) )

```javascript
categories.insert({ name: 'Title', column: 'title'})

// since the op doesn't use the title value, this is most effective with existing objects
var result = categories.find({column: { $keyin: { title: 'anything'} }});
```

**$nkeyin** - filter for document(s) whose property value is not defined in the provided hash object keys. **(Equivalent to $nin: Object.keys(hashObject))** ( [#362](https://github.com/techfort/LokiJS/issues/362), [#365](https://github.com/techfort/LokiJS/issues/365) )

```javascript
var result = categories.find({column: { $nkeyin: { title: 'anything'} }});
```

**$definedin** - filter for document(s) whose property value is defined in the provided hash object as a value other than **undefined**. [#285](https://github.com/techfort/LokiJS/issues/285)

```javascript
items.insert({ name : 'mjolnir', owner: 'thor', maker: 'dwarves' });
items.insert({ name : 'gungnir', owner: 'odin', maker: 'elves' });
items.insert({ name : 'tyrfing', owner: 'Svafrlami', maker: 'dwarves' });
items.insert({ name : 'draupnir', owner: 'odin', maker: 'elves' });

// returns gungnir and draupnir.  similar to $keyin, the value ('rule') is not used by the op
var results = items.find({maker: { $efinedin: { elves: 'rule' } } });
```

**$undefinedin** - filter for document(s) whose property value is not defined in the provided hash object or defined but is **undefined**. [#285](https://github.com/techfort/LokiJS/issues/285)

```javascript
items.insert({ name : 'mjolnir', owner: 'thor', maker: 'dwarves' });
items.insert({ name : 'gungnir', owner: 'odin', maker: 'elves' });
items.insert({ name : 'tyrfing', owner: 'Svafrlami', maker: 'dwarves' });
items.insert({ name : 'draupnir', owner: 'odin', maker: 'elves' });

// returns mjolnir and tyrfing where the 'dwarves' val is not a property on our passed object
var results = items.find({maker: { $undefinedin: { elves: 'rule' } } });
```

**$contains** - 过滤包含提供值的属性的文档. ( [commit](https://github.com/techfort/LokiJS/pull/120/commits/1f08433203554ccf00b381cbea4e72e25e62d5da), [#205](https://github.com/techfort/LokiJS/issues/205) ). 当你的属性包含一个数组，但你的比较值不是一个数组时，请使用它。.

> 当`typeof`属性是：
>
> - string: 它会为你的字符串做一个子字符串匹配(indexOf)
> - array: 它会检查该数组中是否存在“value”(indexOf)
> - object: 它会检查你的'值'是否是该对象的一个定义的属性

```javascript
users.insert({ name : 'odin', weapons : ['gungnir', 'draupnir']});
users.insert({ name : 'thor', weapons : ['mjolnir']});
users.insert({ name : 'svafrlami', weapons : ['tyrfing']});
users.insert({ name : 'arngrim', weapons : ['tyrfing']});

// returns 'svafrlami' and 'arngrim' documents
var results = users.find({ 'weapons' : { '$contains' : 'tyrfing' } });
```

**$containsAny** - 过滤包含任何提供值的属性的文档。当你的属性包含一个数组时，使用这个 - 并且你的比较值是一个数组。

> When typeof property is :
>
> - string: 它会为你的字符串做一个子字符串匹配(indexOf)
> - array: 它会检查该数组中是否存在“value”(indexOf)
> - object: 它会检查你的'值'是否是该对象的一个​定义的属性

```javascript
users.insert({ name : 'odin', weapons : ['gungnir', 'draupnir']});
users.insert({ name : 'thor', weapons : ['mjolnir']});
users.insert({ name : 'svafrlami', weapons : ['tyrfing']});
users.insert({ name : 'arngrim', weapons : ['tyrfing']});

// returns 'svafrlami', 'arngrim', and 'thor' documents
results = users.find({ 'weapons' : { '$containsAny' : ['tyrfing', 'mjolnir'] } });
```

**$containsNone** - 过滤具有不包含所提供的值的属性的文档

```javascript
users.insert({ name : 'odin', weapons : ['gungnir', 'draupnir']});
users.insert({ name : 'thor', weapons : ['mjolnir']});
users.insert({ name : 'svafrlami', weapons : ['tyrfing']});
users.insert({ name : 'arngrim', weapons : ['tyrfing']});

// returns 'svafrlami' and 'arngrim'
results = users.find({ 'weapons' : { '$containsNone' : ['gungnir', 'mjolnir'] } });
```

**$type** - 过滤具有指定类型属性的文档

```javascript
users.insert([
  { name: 'odin', weapons: ['gungnir', 'draupnir'] },
  { name: 'thor', weapons: 'mjolnir' },
  { name: 'svafrlami', weapons: ['tyrfing'] },
  { name: 'arngrim', weapons: ['tyrfing'] }
]);

// 返回docs（非数组）字符串值为'weapons'（mjolnir）
var results = users.find({ 'weapons' : { '$type' : 'string' } });
```

**$finite** - 过滤具有数字或非数字属性的文档。

```javascript
// 返回所有文档，其中isFinite（doc.age）=== true
var results = users.find({ age: { $finite: true }});
```

**$size** - 筛选具有指定大小的数组属性的文档。（不适用于字符串）

```javascript
users.insert([
  { name: 'odin', weapons: ['gungnir', 'draupnir'] },
  { name: 'thor', weapons: 'mjolnir' },
  { name: 'svafrlami', weapons: ['tyrfing'] },
  { name: 'arngrim', weapons: ['tyrfing'] }
]);

// 返回docs'weapons'是2个元素数组（odin）
var results = users.find({ 'weapons' : { '$size' : 2 } });
```

**$len** - 筛选具有指定长度的字符串属性的文档。

```javascript
users.insert([
  { name: 'odin', weapons: ['gungnir', 'draupnir'] },
  { name: 'thor', weapons: 'mjolnir' },
  { name: 'svafrlami', weapons: ['tyrfing'] },
  { name: 'arngrim', weapons: ['tyrfing'] }
]);

// returns docs where 'name' is a 9 character string (svafrllami)
var results = users.find({ 'name' : { '$len' : 9 } });
```

**$and** - 筛选符合所有嵌套子表达式的文档

```javascript
// 获取匹配两个子表达式的文档
var results = coll.find({
  '$and': [{ 
      'age' : {
        '$gt': 30
      }
    },{
      'name' : 'Thor'
    }]
});

// alternative 'implicit' syntax :
results = coll.find({
  age: { $gt: 30 },
  name: 'Thor'
});
```

**$or** - 筛选符合任何嵌套子表达式的文档

```javascript
// 获取匹配任何子表达式的文档
var results = coll.find({
  '$or': [{ 
      'age' : {
        '$gte': '40'
      }
    },{
      'name' : 'Thor'
    }]
});
```

### 支持“find”查询的功能

这些`操作符`可用于组合查找过滤对象，可用于以下内容中：

- Collection find()
- Collection findOne()
- (chained) Resultset find()
- Collection Transforms
- DynamicView applyFind()

### 程序化查询示例

以下查询返回相同的结果：

```javascript
// Core collection 'find' method
var results = coll.find({'Age': {'$gte': 40}});

// Resultset chaining
results = coll.chain().find({'Age': {'$gte': 40}}).data();

// Core collection 'where' method
results = coll.where(function(obj) {
	return obj.Age >= 40;
});
```

### Resultset 链

核心`find`和`where`功能是`Resultset链`允许您构建的两个主要构建块。其他可用的方法包括：

- limit - 允许将结果集限制为指定数量的文档。
- offset - 允许从结果集中跳过第一批数据文档。
- branch - 用于将查询路径分成多个分支。
- simplesort - 只需传递一个属性名称，你的`resulset`就会按这个排序。
- sort - 允许您提供自己的`比较函数`来对结果集进行排序。
- compoundsort - 允许您`根据多个属性按升序或降序`排序。
- update - 用于对当前结果集中的所有文档运行更新操作（JavaScript函数）。
- remove - 从集合中删除当前处于结果集中的所有文档对象（以及结果集）
- map - 映射到一个新的匿名集合中，提供一个映射函数
- mapReduce - 允许您在当前结果集数据上指定map函数和reduce函数。
- eqJoin - 左连接两组数据。连接键可以被定义或计算属性
- transform - 在结果集级别，这需要一个原始转换数组。当开始一个链时，一个命名或原始的转换可能被传入链式方法。 (See the ['Collection Transforms'](https://github.com/techfort/LokiJS/wiki/Collection-Transforms) wiki page for more details.)

更好地使用`方法链`的例子可能如下：

```javascript
var results = coll.chain()
                  .find({'Age': {'$gt':20}})
                  .where(function(obj) {
                     return obj.Country.indexOf('FR') === 0;
                   })
                  .simplesort('Name')
                  .offset(100)
                  .limit(25)
                  .data();
```

### 结果集分支(Resultset branching)

结果集及其结果并不意味着被“持有”。这些情况通常涉及利用动态视图来保持结果最新。但是，只要您想在发生任何插入/更新/删除之前，立即使用结果集，您可以随时临时分支`Resulset`。动态视图还允许分支结果集，而结果集又取其内部的结果集，并使用此分支来允许您进一步查询和转换其结果，而不会受到已执行过的过滤器的初始化时的影响。

集合分支的一个简单示例，如下所示：

```javascript
var baseResulset = coll.chain().find({'Age': {'$gte': 40}});
var branchedResulset = baseResultset.branch();

var usResults = baseResultset.find({'Country': 'US'}).data();
var ieResults = branchedResulset.find({'Country': 'IE'}).data();
```

如果基础查询耗费时间，则您的后续分支无需承担该通用成本，这样做的好处是。在大型集合或对时间敏感的应用程序中，分支通常更有用。

如果您需要检查链中各个阶段的`data()`或文档计数，则可以保留结果集（即使未分支时）以将链分成几个部分。

### 总结

**尽可能在'Where'查询之前使用'Find'查询。**如果它们被应用并与您的查询有关，则**“Find”查询能够使用索引**。

**核心（Collection）的查询方法（`Collection.where(), Collection.find(), Collection.findOne(), Collection.by()`）是学习`lokijs`的最佳方法。对于许多应用程序来说，这可能足以满足您的查询需求。**不可用的功能(尚未提供)是排序(sorting)，限制(limiting)，偏移(offsets)和其他更高级别的转换。

---

**链查询通过调用`collection.chain()`方法返回的`Resultset`类来完成。**

这样做，为我们的查询建立一个`state`。您可以将多个`查找(find)`，`过滤(where)`，`排序(sorts)`，`限制(limit)`，`偏移(offset)`等操作串在一起，逐步过滤和转换结果。

您也可以建立查询分支，尽可能高效地将查询分解为多个方向。通过结果集进行`链调用`仍然用于即时评估。

如果您将结果集保留在内存中，则不保证底层数据发生更改时保持最新状态。

只有第一个链的操作可能会使用数据库过滤器，因此优先考虑最昂贵的`find()`过滤器（其中应用了索引）作为第一个链接操作。

---

**通过`链变换`允许在对象中定义与方法链相同的功能，其功能类似于`存储过程`。**

由于它是对象表示，因此可以（可选）命名并与数据库一起保存。此方法也用于即时评估。

---

**`DynamicViews`旨在让`fresh`的数据库视图随时可用。**

您可以应用`find`和`where`过滤器，并指定排序。

<u>随着文档的插入，更新或删除，您查看的内容将立即保持最新状态。</u>

这可以确保您的视图具有最佳的读取性能，因为它始终处于最新状态。

如果您的视图需要进一步过滤，则可以将结果集从其中分离出来。

在分支`DynamicView`的时候，您可以在该时刻捕获`DynamicView`内部结果集的快照，从而可以执行各种各样的链接操作以进行即时评估。

因此，如果您执行`DynamicView`分支，请将视图视为保证`fresh`，并将分支视为快速一次性分支进行评估。