---
layout: post
title:  "自动更新集合"
date:   2018-05-02 09:12:51
categories: database
---

# 集合的自动更新功能

可以通过构造函数选项`autoupdate：true`在每个集合的基础上启用自动更新。该功能需要`Object.observe`（目前在`Chrome 36+`, `io.js` 和 `Node.js 0.12+`中实现）。如果观察者不可用，则该选项将被忽略。

无论何时修改文档，自动更新(`Autoupdate`)都会自动调用 `update(doc)`，这对索引更新和脏标记（用于确定数据库是否已被修改并应该保留）是必需的。

启用此功能基本上意味着，所有手动`update`呼叫都可以省略。

## 示例

```javascript
var doc = collection.by("name", "John");

doc.name = "Peter";
doc.age = 32;
doc.gender = "male";

collection.update(doc); // 这行代码可以安全地删除。
```

自动更新(`Autoupdate`)将在当前事件循环结束时调用 `update` ，因此即使在进行多项更改时也只会调用 `update` 一次。

## 错误处理

自动更新和手动更新之间有一个重要区别。例如，如果文档更改违反了唯一键约束，`update`将同步抛出一个可以同步捕获的错误：

```
var collection = db.addCollection("test", {
  unique: ["name"]
});

collection.insert({ name: "Peter" });

var doc = collection.insert({ name: "Jack" });
doc.name = "Peter";

try {
  collection.update(doc);
} catch(err) {
  doc.name = "Jack";
}
```

由于自动更新(`Autoupdate`)异步调用更新，因此无法通过`try-catch`捕获错误。相反，你必须使用事件监听器：

```
var collection = db.addCollection("test", {
  unique: ["name"],
  autoupdate: true
});

collection.insert({ name: "Peter" });

var doc = collection.insert({ name: "Jack" });
doc.name = "Peter";

collection.on("error", function(errDoc) {
  if(errDoc === doc) {
    doc.name = "Jack";
  }
});
```

这可能会变得非常繁琐，因此您应该考虑在更新文档之前进行检查。