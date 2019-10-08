---
layout: post
title:  "集合变换"
date:   2018-05-02 09:12:51
categories: database
---

## 集合变换

***

**集换背后的基本思想是允许将结果集的“链”式调用过程转换为该过程的对象定义。这个数据定义可以随意命名，并与集合一起保存在数据库中。**

这可能对以下方面有用：

- 编写在loki数据库上运行的工具
- 创建'存储过程'的命名查询
- 转换您的数据以便提取
- 可以通过自定义`meta`进行扩展

变换是在集合链上执行的(有序)“步骤(step)”对象数组。这些步骤可能包括以下类型：

- 'find'
- 'where'
- 'simplesort'
- 'compoundsort'
- 'sort'
- 'limit'
- 'offset'
- 'update'
- 'remove'
- 'map'
- 'mapReduce'
- 'eqJoin'

这些转换步骤可以硬编码它们的参数，或者为`loki变换`添加参数替换机制。

一个简单的示例，只有一个步骤的`loki变换`可能如下所示：

```
var tx = [
  {
    type: 'find',
    value: {
      'owner': 'odin'
    }
  }
];
```

然后可以使用以下命令将其选择性地保存到集合中：

```
userCollection.addTransform('OwnerFilter', tx);
```

这种转换可以通过以下任一方式执行

```
userCollection.chain('OwnerFilter').data();
```

或

```
userCollection.chain(tx).data();
```

参数化在任何对象属性的右侧的值上得到处理，该值在变换中表示为以`'[％lktxp]'`开头的字符串。示例如下：

```
var tx = [
  {
    type: 'find',
    value: {
      'owner': '[%lktxp]OwnerName'
    }
  }
];
```

要执行此链式调用，您需要在执行时传递包含该参数值的参数对象。一个例子可能是：

```
var params = {
  OwnerName: 'odin'
};

userCollection.chain(tx, params).data();
```

或

```
userCollection.chain("OwnerFilter", params).data();
```

**过滤功能无法保存到数据库中**，但是如果您仍然需要它们，可以利用`转换和参数化`可以实现清晰的结构化并且可以执行保存的转换。一个例子可能是：

```
var tx = [
  {
    type: 'where',
    value: '[%lktxp]NameFilter'
  }
];

items.addTransform('ByFilteredName', tx);

// 那么可能会立即发生以下情况，甚至可能在`保存/加载`周期中发生
// 这个例子使用匿名函数，但也可以将其命名为函数引用
var params = {
  NameFilter: function(obj) {
    return (obj.name.indexOf("nir") !== -1);
  }
};

var results = items.chain("ByFilteredName", params).data();
```

转换可以包含多个要连续执行的步骤。在幕后，链命令将实例化一个`Resultset`并将其作为独立的链操作调用，最终在完成时返回结果。一些内置的“步骤(step)”，如`'mapReduce'`实际上通过返回一个数据数组来终止变换/链(transform/chain)，所以在这些情况下，`chain()`结果就是实际的数据，而不是你需要调用`data()`获取结果集。

更复杂的转换示例可能如下所示：

```
var tx = [
  {
    type: 'find',
    value: {
      owner: {
        '$eq': '[%lktxp]customOwner'
      }
    }
  },
  {
    type: 'where',
    value: '[%lktxp]customFilter'
  },
  {
    type: 'limit',
    value: '[%lktxp]customLimit'
  }
];

function myFilter(obj) {
  return (obj.name.indexOf("nir") !== -1);
}

var params = {
  customOwner: 'odin',
  customFilter: myFilter,
  customLimit: 100
}

users.chain(tx, params);
```

如上例所示，我们将扫描对象层次结构（深达10层），并对右边的参数进行参数替换，这些值看起来是参数，然后我们将尝试从您的参数对象中查找。参数替换将用与您的`params`中包含的值相同的值替换该字符串，该参数可以是任何数据类型。

某些具有多个参数的步骤需要特定的步骤属性（除了类型和值）。这些在下面被演示为单独的步骤，这些步骤在单个变换中不一定有意义：

```
var step1 = {
  type: 'simplesort',
  property: 'name',
  desc: true
};

var step2 = {
  type: 'mapReduce',
  mapFunction: myMap,
  reduceFunction: myReduce
};

var step3 = {
  type: 'eqJoin',
  joinData: jd,
  leftJoinKey: ljk,
  rightJoinKey: rjk,
  mapFun: myMapFun
};

var step4 = {
  type: 'remove'
}
```

## 支持 DynamicViews

您现在可以使用转换作为`DynamicView`的提取方法。某些应用程序可能会使用它创建一个包含广泛结果集的`DynamicView`，这些结果可以从用户定义的转换中快速提取。此功能在`DynamicView`的`branchResultset()`方法中提供。它可以接受存储在集合级别的原始转换或命名转换。

一个例子可能如下所示：

```
var db = new loki('test');
var coll = db.addCollection('mydocs');
var dv = coll.addDynamicView('myview');
var tx = [
  {
    type: 'offset',
    value: '[%lktxp]pageStart'
  },
  {
    type: 'limit',
    value: '[%lktxp]pageSize'
  }
];
coll.addTransform('viewPaging', tx);

// add some records

var results = dv.branchResultset('viewPaging', { pageStart: 10, pageSize: 10 }).data();
```

重要的区别在于分支（以及因此您的转换结果）仅反映了您分支时的视图。这些转换是提取而不是内部用于视图。

## 为定制解决方案添加元数据

一种用于转换的用途可能是在用户界面构建，管理和执行这些转换时使用用户驱动的解决方案。在这种情况下，您可能需要将自己的元数据添加到变换中以进一步描述变换，步骤或参数。

- 任何具有`Loki变换`未知类型的步骤都将被忽略。您可能会决定始终将第一步作为具有包含有关作者，描述或所需参数描述元数据信息的属性的“元”类型。
- 每个步骤还可以包含额外的属性，超出了我们所定义的要求，因此您可能会在步骤中嵌入步骤描述，上次更改的日期等。

## 总结

Loki转换可以建立一个自动化数据转换的过程（只需很少的额外占用空间）。这不是必需的功能，也不是要取代方法链接，但它允许您抽象和组织重复的查询以实现清洁或动态目的。