---
layout: post
title:  "LokiJS快速入门"
date:   2018-05-02 09:12:51
categories: database
---

[LokiJS.org web site](http://lokijs.org) 
[LokiJS GitHub page](https://github.com/techfort/LokiJS) 
[Sandbox / Playground](https://rawgit.com/techfort/LokiJS/master/examples/sandbox/LokiSandbox.htm)

## 概况

LokiJS是一个面向文档的JavaScript数据库，与MongoDB有些相似。这只是一个概述，有关完整的文档，请参阅 [lokijs.org](http://lokijs.org/).

它支持数据集合的索引，查询和过滤。LokiJS还支持更高级的功能，例如`mapReduce`，事务，并允许您实现自定义远程同步以将数据保存到服务器（或移动设备上的本地文件）。持久化到磁盘已经为`CommonJS`环境（如`nodejs`）实现，在移动设备上，您只需要请求文件系统并将`lokijs`的`serialize()` 作为内容传递。

在浏览器或移动环境中，您只需要包含`build/lokijs.min.js`

## 功能

### 1. 面向文档

数据存储为JavaScript对象，并序列化为JSON以用于磁盘持久化。

### 2. 索引

您可以指定索引以加快对某些对象属性的搜索。'id'字段自动编入索引，并使用二进制搜索算法来避免`for(;;)`循环变慢

### 3. 视图

您可以声明自定义视图函数用以返回基于复杂逻辑的结果集。

### 4. Map reduce

您可以声明`map`和`reduce`函数以检索数据库中的聚合数据。

## 用法示例

如果您在`node.js`环境中工作，请运行 `npm install lokijs` 并确保调用 `var loki = require('lokijs')`

创建数据库:

```javascript
var db = new loki('Example');
```

创建一个集合，指定名称，类型，索引字段以及集合是否是事务性的：

```javascript
var users = db.addCollection('users', { indices: ['email'] });
// 请注意，索引可以是单个字符串或字符串数组
```

请注意，索引和事务标志是可选参数。`LokiJS`中的事务只是允许您运行操作并自动将数据库恢复到事务开始之前的阶段（如果发生错误）。

在数据库中添加一些用户：

```
var odin = users.insert( { name : 'odin', email: 'odin.soap@lokijs.org', age: 38 } );
var thor = users.insert( { name : 'thor', email : 'thor.soap@lokijs.org', age: 25 } );
var stan = users.insert( { name : 'stan', email : 'stan.soap@lokijs.org', age: 29 } );
var oliver = users.insert( { name : 'oliver', email : 'oliver.soap@lokijs.org', age: 31 } );
var hector = users.insert( { name : 'hector', email : 'hector.soap@lokijs.org', age: 15} );
var achilles = users.insert( { name : 'achilles', email : 'achilles.soap@lokijs.org', age: 31 } );
```

操作更新：

```
stan.name = 'Stan Laurel';
// 更新对象（这实际上只是同步索引）
users.update(stan);
```

动态视图 (DynamicViews) - 推荐方法:

```
var dv = users.addDynamicView('a_complex_view');
dv.applyWhere(function aCustomFilter(obj){
  return obj.name.length  < 5 && obj.age > 30;
});
// 查看数据
console.log(dv.data());

// 应用一些更改
users.insert({ name: 'ratatosk', email: 'rata@tosk.r', age: 10320 });

// 看看动态视图通过检查数据来更新自己
console.log(dv.data());
```

'Where' 过滤函数:

```
function ageView(obj){
  return obj.age > 30;
}
// 更复杂一些，名字长于3个字符，年龄超过30岁的用户
function aCustomFilter(obj){
  return obj.name.length  < 5 && obj.age > 30;
}

//测试过滤器
var result = users.where(ageView);
var anotherResult = users.where(aCustomFilter);
```

Map Reduce (实时演示示例在 [lokijs.org](http://lokijs.org/#/demo) 上):

```
function getDuration( obj ){
  return obj.complete ? null : obj.duration;
}

function getAverage( array ){
  var cumulator = 0;
  var i = array.length >>> 0;
  var actual = 0;
  while(i--){
    if(array[i] != null){
      cumulator += array[i];
      actual++;
    }
  }
  return ( cumulator / actual).toFixed(2);
}

var avgDuration = todos.mapReduce( getDuration, getAverage );
```

通过方法链查询 :

```
users.chain()
  .find({'age':{'$gt': 25}})
  .where(function(obj){ return obj.name.indexOf("in") != -1 })
  .simplesort("age")
  .offset(50)
  .limit(10)
  .data()
```

简单的命名变换 :

```
users.addTransform('progeny', [
  {
    type: 'find',
    value: {
      'age': {'$lte': 40}
    }
  },
  {
    type: 'simplesort',
    property: 'age',
    desc: true
  }
]);

var results = users.chain('progeny').data();
```

更多信息:

- 访问 : [www.lokijs.org](http://www.lokijs.org/)
- 示例 : <https://github.com/techfort/LokiJS/tree/master/examples>
- StackOverflow : https://stackoverflow.com/questions/tagged/lokijs

