---
layout: post
title:  "Realm for JavaScript(2.2.0)"
date:   2018-03-07 11:11:11
categories: database
---

## 介绍 ![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

Realm JavaScript 使您能够以安全，持久和快速的方式有效编写应用程序的模型层。它旨在与 [React Native](https://facebook.github.io/react-native/) 与 [Node.js](https://nodejs.org/)一起工作。

这里有个简单的例子:

```
const Realm = require('realm');

// 定义你的模型和它们的属性
const CarSchema = {
  name: 'Car',
  properties: {
    make:  'string',
    model: 'string',
    miles: {type: 'int', default: 0},
  }
};
const PersonSchema = {
  name: 'Person',
  properties: {
    name:     'string',
    birthday: 'date',
    cars:     'Car[]',
    picture:  'data?' // 可选属性
  }
};

Realm.open({schema: [CarSchema, PersonSchema]})
  .then(realm => {
    // 创建Realm对象并写入本地存储
    realm.write(() => {
      const myCar = realm.create('Car', {
        make: 'Honda',
        model: 'Civic',
        miles: 1000,
      });
      myCar.miles += 20; // 更新属性值
    });

    // 通过Realm实例查询所有高于1000里程车
    const cars = realm.objects('Car').filtered('miles > 1000');

    // 将返回一个结果对象(1辆车)
    cars.length // => 1

    // 添加另一辆车
    realm.write(() => {
      const myCar = realm.create('Car', {
        make: 'Ford',
        model: 'Focus',
        miles: 2000,
      });
    });

    // 查看结果:已经实时更新了
    cars.length // => 2
  })
  .catch(error => {
    console.log(error);
  });
```

请注意，如果要将Realm用于服务器端或者Node环境，则在[Realm对象服务器文档](https://realm.io/docs/realm-object-server/latest/)中可找到相关信息。

##  入门![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

### 安装

按照下面的安装说明通过npm安装Realm JavaScript，或者在github上查看源代码。

**必要条件**

- 确保您的环境设置为运行React Native应用程序。按照[React Native说明](https://facebook.github.io/react-native/docs/getting-started.html)开始使用。
- 使用Realm的应用程序可以同时针对iOS和Android。
- 支持React Native 0.31.0及更高版本。


- **安装**

  - 创建一个新的React Native工程:

    ```
    react-native init <project-name>
    ```

  - 将目录更改为新项目(`cd <project-name>`)，并添加`realm`依赖

    ```
    npm install --save realm
    ```

  - 接下来，将项目链接到`realm`原生模块。

    ```
    react-native link realm
    ```

*Android的警告*：根据版本， `react-native link`可能会生成无效的配置，正确更新Gradle(`android/settings.gradle` and `android/app/build.gradle`) ，但无法添加Realm模块。确认`react-native link`已添加了Realm模块;如果没有，请通过以下步骤手动链接到库：

1. 添加以下行到 `android/settings.gradle`:

   ```
   include ':realm'
   project(':realm').projectDir = new File(rootProject.projectDir, '../node_modules/realm/android')
   ```

2. 将编译行添加到 `android/app/build.gradle` 中的依赖项:

   ```
   dependencies {
       compile project(':realm')
   }
   ```

3. 在`MainApplication.java`中添加导入并链接包:

   ```
   import io.realm.react.RealmReactPackage; // add this import

   public class MainApplication extends Application implements ReactApplication {
       @Override
       protected List<ReactPackage> getPackages() {
           return Arrays.<ReactPackage>asList(
               new MainReactPackage(),
               new RealmReactPackage() // 添加这行
           );
       }
   }
   ```

现在已经准备好了。要查看Realm中的action，请在`index.ios.js`或`index.android.js`中添加以下作为`class <project-name>`的定义：

```
const Realm = require('realm');

class <project-name> extends Component {
  constructor(props) {
    super(props);
    this.state = { realm: null };
  }

  componentWillMount() {
    Realm.open({
      schema: [{name: 'Dog', properties: {name: 'string'}}]
    }).then(realm => {
      realm.write(() => {
        realm.create('Dog', {name: 'Rex'});
      });
      this.setState({ realm });
    });
  }

  render() {
    const info = this.state.realm
      ? 'Number of dogs in this Realm: ' + this.state.realm.objects('Dog').length
      : 'Loading...';

    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          {info}
        </Text>
      </View>
    );
  }
}
```

然后，您可以在设备和模拟器中运行应用程序.

### 例子

例子可以在[realm-js仓库](https://github.com/realm/realm-js/tree/master/examples)的github上找到。

请注意，在Android上，您需要安装ndk，并且必须设置android_ndk环境变量。

```
export ANDROID_NDK=/usr/local/Cellar/android-ndk/r10e
```

### Realm Studio

Realm Studio 是我们的首选开发工具，可以轻松管理Realm数据库和Realm平台。使用Realm Studio，您可以打开和编辑本地和同步Realm，并管理任何Realm对象服务器实例。它支持Mac, Windows 和 Linux 系统。

![Realm Studio](https://realm.io/assets/img/docs/realm-studio.png)

[![img](https://realm.io/assets/svg/products/realm-studio/apple.svg)下载 Mac 版](https://studio-releases.realm.io/latest/download/mac-dmg)

[![img](https://realm.io/assets/svg/products/realm-studio/linux.svg)下载 Linux 版](https://studio-releases.realm.io/latest/download/linux-appimage)

[![img](https://realm.io/assets/svg/products/realm-studio/windows.svg)下载 Windows 版](https://studio-releases.realm.io/latest/download/win-setup)

## 获得帮助![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

- **需要帮助你的代码？** [在StackOverflow上提问吧](http://stackoverflow.com/questions/ask?tags=realm). 我们积极监督并立马回答您的问题！
- **有Bug上报?** [在我们Github库上提问吧](https://github.com/realm/realm-js/issues/new). 如果可能，请包括Realm版本，完整日志，Realm文件以及显示问题的项目。
- **有功能请求吗?** [在我们Github库上提交请求吧吧](https://github.com/realm/realm-js/issues/new). 告诉我们功能应该做什么，以及为什么要这个功能.

如果您使用崩溃记录（如Crashlytics或HockeyApp），请确保启用日志收集。Realm在抛出异常和不可恢复的情况下记录元数据信息（但不包含用户数据），并且这些消息可以帮助在出现问题时进行调试。

## 模型![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

Realm数据模型由初始化期间传递到Realm的schema信息定义。对象的`schema`由对象的`名称(name)`和一组属性组成，每个属性由`名称(name)`和`类型(type)`以及对象和列表属性的`objectType`组成。您还可以将每个属性指定为`可选optional`的或具有`默认default`的值,以及`索引indexed`。

```
const Realm = require('realm');

const CarSchema = {
  name: 'Car',
  properties: {
    make:  'string',
    model: 'string',
    miles: {type: 'int', default: 0},
  }
};
const PersonSchema = {
  name: 'Person',
  properties: {
    name:     'string',
    birthday: 'date',
    cars:     'Car[]'
    picture:  'data?', // 可选的属性
  }
};

// 使用Car和Person的模型初始化Realm实例
Realm.open({schema: [CarSchema, PersonSchema]})
  .then(realm => {
    // ... 使用Realm实力来读取和修改数据
  })
```

### 类

> 在这一点上，支持通过类定义模型是有限制的。它能在React Native中运行，但不能在Node环境中。

如果你想使用ES2015类（也许想继承现有的功能），你只需要在构造函数中定义模式：

```
class Person {
  get fullName() {
    return this.firstName + ' ' + this.lastName;
  }
}

Person.schema = {
  name: 'Person',
  properties: {
    firstName: 'string',
    lastName: 'string'
  }
};
```

您现在可以将该类本身传递给打开的配置的`schema`属性：

```
Realm.open({schema: [Person]})
  .then( /* ... */ );
```

或者像往常一样访问属性:

```
realm.write(() => {
  const john = realm.create('Person', {
    firstName: 'John',
    lastName: 'Smith'
  });
  john.lastName = 'Peterson';
  console.log(john.fullName); // -> 'John Peterson'
});
```

### Supported types

Realm支持以下基本类型: `bool`, `int`, `float`, `double`, `string`, `data`, 和 `date`.

- `bool` 属性映射到 JavaScript `Boolean` 对象
- `int`, `float`, and `double` 属性映射到 JavaScript `Number` 对象. 内部的`int`和`double`被存储为64位，而`float`以32位存储。
- `string` 属性映射到 `String`
- `data` 属性映射到 `ArrayBuffer`
- `date` 属性映射到 `Date`

将基本属性指定为简写时，您可以仅指定类型，而不必指定具有单个条目的字典：

```
const CarSchema = {
  name: 'Car',
  properties: {
    // 以下属性类型是等效的 
    make:   {type: 'string'},
    model: 'string',
  }
}
```

#### 可选属性

默认情况下，基本类型是非可选的，不支持存储`null`或`undefined`。属性可以通过在属性定义中指定`optional`指示符或使用简写语法，通过附加一个`?`到类型名称后面：

```
const PersonSchema = {
  name: 'Person',
  properties: {
    realName:    'string', // 要求属性
    displayName: 'string?', // 可选属性
    birthday:    {type: 'date', optional: true}, // 可选属性
  }
};

let realm = new Realm({schema: [PersonSchema, CarSchema]});

realm.write(() => {
  // 可选属性可以在创建时设置为null或未定义
  let charlie = realm.create('Person', {
    realName: 'Charlie',
    displayName: null, // 也可以完全省略
    birthday: new Date(1995, 11, 25),
  });

  // 可选属性可以设置为`null`, `undefined`,
  // 或新的非空值
  charlie.birthday = undefined;
  charlie.displayName = 'Charles';

  // 将非可选属性设置为null会抛出`TypeError`
  // charlie.realName = null;
});
```

#### 列表属性

除了存储单个值之外，还可以将属性声明为任何支持的基本类型的列表。这是通过将`[]`附加到类型名称来完成的：

```
const PersonSchema = {
  name: 'Person',
  properties: {
    name: 'string',
    testScores: 'double?[]'
  }
};

let realm = new Realm({schema: [PersonSchema, CarSchema]});

realm.write(() => {
  let charlie = realm.create('Person', {
    name: 'Charlie',
    testScores: [100.0]
  });

  // 查理在第二次考试中缺席了并且被允许跳过它
  charlie.testScores.push(null);

  // 然后他在第三次测试中表现不佳
  charlie.testScores.push(70.0);
});
```

访问列表属性时会返回一个`列表List`对象。`列表List`的方法非常类似于常规的JavaScript数组。最大的区别是对`列表List`所做的任何更改都会自动保存到底层Realm，因此只能在[写入事务](https://realm.io/docs/javascript/latest/#writes)中进行修改。此外，`列表List`属于它们从中获取的底层对象 - 您只能通过访问拥有对象中的属性来获取列表实例，并且不能手动创建它们。

虽然list属性中的值可以是可选的，但list属性本身不可以。使用longhand语法 (`values: {type: 'int[]', optional: true}`)指定list属性为可选项，将使列表中的值成为可选项。

### 关系

#### 一对一的关系

对于一对一的关系，您可以将引用的对象`schema`的`name`属性指定为属性的`类型(type)`：

```
const PersonSchema = {
  name: 'Person',
  properties: {
    // 所有以下属性定义是等效的
    car: {type: 'Car'},
    van: 'Car',
  }
};
```

使用对象属性时，需要确保所有引用的类型都存在于用于打开`Realm`的`schema`中：

```
// CarSchema是必需的，因为PersonSchema包含'car'类型的属性，
Realm.open({schema: [CarSchema, PersonSchema]}).then(/* ... */);
```

访问对象属性时，可以使用普通属性语法访问嵌套属性:

```
realm.write(() => {
  const nameString = person.car.name;
  person.car.miles = 1100;
  
  // 通过将属性设置为具有所有必填字段的对象来创建Car实例
  person.van = {make: 'Ford', model: 'Transit'};

  // 将两个属性设置为同一个汽车实例
  person.car = person.van;
});
```

Realm中的对象属性始终是可选的，不必像这样明确指定，并且不能使其成为必需。

#### 一对多的关系

就像基本属性一样，你也可以有一个对象列表来形成一对多的关系。这可以通过将`[]`添加到目标对象`schema`的名称或通过将属性类型设置为`列表list`并指定`objectType`来完成：

```
const PersonSchema = {
  name: 'Person',
  properties: {
    // 以下属性定义是等效的
    cars: {type: 'list', objectType: 'Car'},
    vans: 'Car[]'
  }
}

let carList = person.cars;

// 将新车添加到列表`List`中
realm.write(() => {
  carList.push({make: 'Honda', model: 'Accord', miles: 100});
  carList.push({make: 'Toyota', model: 'Prius', miles: 200});
});

let secondCar = carList[1].model;  // access using an array index
```

与其他列表和一对一关系不同，一对多关系不能作为可选项。

#### 多对多关系

链接是单向的。所以如果一对多的属性`Person.dogs`链接到一个`Dog`实例和一个属性`Dog.owner`链接到`Person`，这些链接是彼此独立的。将`Dog`添加到`Person`实例的 `dogs` 属性不会自动将该狗的`owner` 属性设置为此`Person`。因为手动同步`成对`关系很容易出错，并且比较复杂和容易生成重复信息，所以Realm提供链接对象属性来表示这些反向关系。

使用链接对象属性，可以从特定属性获取链接到给定对象的所有对象。例如，`Dog`对象可以具有一个名为`owner`的属性，该属性包含其`dogs`属性中具有这个确切`Dog`对象的所有`Person`对象。通过`owners`属性的`linkingObjects`类型，指定它与Person对象的关系。

这样做可以通过`owners`属性指定它与Person对象的关系。

```
const PersonSchema = {
  name: 'Person',
  properties: {
    dogs: 'Dog[]'
  }
}

const DogSchema = {
  name:'Dog',
  properties: {
    // ``对象属性没有简写语法
    owners: {type: 'linkingObjects', objectType: 'Person', property: 'dogs'}
  }
}
```

一个`linksObjects`属性可以指向一个`List`属性（多对多关系）或一个`Object`属性（一对一关系）:

```
const ShipSchema = {
  name: 'Ship',
  properties: {
    captain: 'Captain'
  }
}

const CaptainSchema = {
  name: 'Captain',
  properties: {
    ships: {type: 'linkingObjects', objectType: 'Ship', property: 'captain'}
  }
}
```

访问`linksObjects`属性时，返回一个`Results`对象，因此完全支持进一步的[查询和排序](https://realm.io/docs/javascript/latest/#queries)。`linksObject`属性属于它们从中获取的对象，不能直接设置或操作。当事务提交时，它们将自动更新。

*访问不带schema的linkingObjects*：如果您打开了一个Realm文件而不指定schema，例如在Realm Functions回调中，您可以通过在`Object`实例上调用 `linkingObjects(objectType, property)` 来获取`linksObjects`属性：

```
let captain = realm.objectForPrimaryKey('Captain', 1);
let ships = captain.linkingObjects('Ship', 'captain');
```

链接对象属性不能作为可选项。

### 默认属性值

可以通过在属性定义中设置默认指示符来指定默认属性值。要使用默认值，请在创建对象期间保留未指定的属性。

```
const CarSchema = {
  name: 'Car',
  properties: {
    make:  {type: 'string'},
    model: {type: 'string'},
    drive: {type: 'string', default: 'fwd'},
    miles: {type: 'int',    default: 0}
  }
};

realm.write(() => {
  // 由于`miles`被遗漏，它默认为“0”，而`drive`被指定，它会覆盖默认值
  realm.create('Car', {make: 'Honda', model: 'Accord', drive: 'awd'});
});
```

### 索引属性

您可以将索引的指示符添加到属性定义，以使该属性进行索引。 目前支持 `int`, `string`,  `bool` 和`date`属性类型：

```
var BookSchema = {
  name: 'Book',
  properties: {
    name: { type: 'string', indexed: true },
    price: 'float'
  }
};
```

索引属性将极大地加快查询的属性进行比较，但是以较慢的插入为代价。

### 主键

您可以在对象模型中为`string`和`int`属性指定`primaryKey`属性。声明一个主键可以对对象进行高效查找和更新，并强制执行每个值的唯一性。一旦有一个主键的对象被添加到Realm，主键就不能被改变了。

```
const BookSchema = {
  name: 'Book',
  primaryKey: 'id',
  properties: {
    id:    'int',    // 主键
    title: 'string',
    price: 'float'
  }
};
```

主键属性自动编入索引.

## 写![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

创建，更新和删除Realm中的对象的操作必须在`write()`事务块中进行。请注意，写入事务具有不可忽略的开销;您应该尽量减少代码中写入块的数量。

### 创建对象

使用`create`方法创建对象：

```
try {
  realm.write(() => {
    realm.create('Car', {make: 'Honda', model: 'Accord', drive: 'awd'});
  });
} catch (e) {
  console.log("Error on creation");
}
```

请注意， `write()`方法中抛出的任何异常都将取消事务。所有示例中都不会显示`try/catch` 块，但这是很好的做法。

### 嵌套对象

如果对象具有对象属性，则可以通过为每个子属性指定JSON值来递归地创建这些属性的值：

```
realm.write(() => {
  realm.create('Person', {
    name: 'Joe',
    // 嵌套对象是递归创建的
    car: {make: 'Honda', model: 'Accord', drive: 'awd'},
  });
});
```

### 更新对象

####  键入的更新

您可以通过在写事务中设置其属性来更新任何对象。

```
realm.write(() => {
  car.miles = 1100;
});
```

#### 使用主键创建和更新对象

如果您的模型类包含主键，则可以根据主键值智能地更新或添加对象。这是通过将`true`作为第三个参数传递给`create`方法：

```
realm.write(() => {
  // 创建一个book对象
  realm.create('Book', {id: 1, title: 'Recipes', price: 35});

  // 通过ID,用新的价格更新book对象
  realm.create('Book', {id: 1, price: 55}, true);
});
```

在上面的例子中，由于一个对象已经存在，`id`值为`1`，并且我们已经为第三个参数传递了`true`，所以`price`属性被更新，而不是尝试创建一个新的对象。由于`name`属性被省略，对象保留此属性的原始值。请注意，当使用主键属性创建或更新对象时，必须指定主键。

### 删除对象

可以通过在写事务中调用`delete`方法来删除对象。

```
realm.write(() => {
  // Create a book object
  let book = realm.create('Book', {id: 1, title: 'Recipes', price: 35});

  // Delete the book
  realm.delete(book);

  // Delete multiple books by passing in a `Results`, `List`, or JavaScript `Array`
  let allBooks = realm.objects('Book');
  realm.delete(allBooks); // Deletes all books
});
```

## 查询![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

查询允许您从Realm中获取单个类型的对象，并可选择过滤和排序这些结果。所有查询（包括查询和属性访问）在Realm中都是懒加载的。仅在访问对象和属性时才读取数据。这样，您可以以高效的方式表示大量数据。

执行查询时，您将返回一个`Results`对象。`Results`只是您的数据视图，不可变。

从Realm中检索对象的最基本方法是使用Realm中的`objects`方法来获取给定类型的所有对象

```
let dogs = realm.objects('Dog'); // retrieves all Dogs from the Realm
```

### 过滤

您可以通过使用查询字符串调用过滤的方法来获取已过滤的结果。

例如，以下将改变我们早期的例子，以检索所有具有颜色tan的狗，以’B’开头的名字：

```
let dogs = realm.objects('Dog');
let tanDogs = dogs.filtered('color = "tan" AND name BEGINSWITH "B"');
```

目前，查询语言只支持NSPredicate语法的一部分,让我们简要总结一下支持的功能和语法：

Realm支持的查询语言受到了苹果公司的 [Apple’s NSPredicate](https://developer.apple.com/documentation/foundation/nspredicate)启发。让我们简要总结一下支持的功能和语法：

- 比较操作数可以是属性名称或常量。至少有一个操作数必须是属性名称。特殊常量为`false`, `true`, 和 `null`.
- 时间戳可以以“YYYY-MM-DD@HH:MM:SS:NANOSECONDS” 格式指定，其中纳秒可以省略。
- 比较运算符 `=`/`==`, `<=`, `<`, `>=`, `>`, `!=`/`<>`,以及 `BETWEEN` 的比较运算符支持 `int`, `float`, `double`, 和 `Date` 属性类型。 e.g. `age = 45`.
- boolean (`bool`)属性支持比较运算符`=`/`==` and `!=`/`<>` 
- 对于字符串和数据（`ArrayBuffer`）属性，支持 `=` (and `==`), `!=` (and `<>`), `BEGINSWITH`, `CONTAINS`, and `ENDSWITH` 运算符。e.g. `name CONTAINS 'Ja'`.
- 通配符比较对于具有相似运算符的字符串是可能的， e.g. `name LIKE '*an?'` 匹配 “Jane”, “Dan”, “Shane”, 等等.
- 使用`[c]`的字符串不区分大小写的比较，e.g. , `CONTAINS[c] 'Ja'`. 注意只有字符“A-Z” 和 “a-z” 会被忽略。
- Realm支持以下复合运算符：`AND`/`&&`, `OR`/ `||`, 和 `NOT`/`!`, e.g. `name BEGINSWITH 'J' AND age >= 32`.
- 在列表属性上支持聚合表达式 `@count`/`@size`, `@min`, `@max`, `@sum` 和 `@avg` 。eg:`employees.@count > 5 `查找多于5个元素的员工列表。
- 字符串和二进制属性的聚合表达式 `@count`/`@size` ，e.g. `name.@size = 5` 查找所有名称均为5个字母的名称。
- 关键路径可以遵循列表属性关系，e.g. `child.age >= 13` and `cars.@avg.milage > 1000`.
- `$`运算符可以用来替换参数, e.g. `child.age >= $0` 请参阅下面的示例）。

An non-trivial example on how to query a Realm is:

一个关于如何查询Realm的特殊例子：

```
const Realm = require('realm');

const CarSchema = {
  name: 'Car',
  properties: {
    make:  'string',
    model: 'string',
    miles: {type: 'int', default: 0},
  }
};

const PersonSchema = {
  name: 'Person',
  properties: {
    name:     'string',
    cars:     {type: 'list', objectType: 'Car'},
  }
};

// Initialize a Realm with Car and Person models
Realm.open({schema: [CarSchema, PersonSchema]})
    .then(realm => {

        // Add persons and their cars
        realm.write(() => {
            let john = realm.create('Person', {name: 'John', cars: []});
            john.cars.push({make: 'Honda',  model: 'Accord', miles: 1500});
            john.cars.push({make: 'Toyota', model: 'Prius',  miles: 2780});

            let joan = realm.create('Person', {name: 'Joan', cars: []});
            joan.cars.push({make: 'Skoda', model: 'Octavia', miles: 1120});
            joan.cars.push({make: 'Ford',  model: 'Fiesta',  miles: 95});
            joan.cars.push({make: 'VW',    model: 'Golf',    miles: 1270});

            let jill = realm.create('Person', {name: 'Jill', cars: []});

            let jack = realm.create('Person', {name: 'Jack', cars: []});
            jack.cars.push({make: 'Porche', model: '911',    miles: 965});
        });

        // Find car owners
        let carOwners = realm.objects('Person').filtered('cars.@size > 0');
        console.log('Car owners')
        for (let p of carOwners) {
            console.log(`  ${p.name}`);
        }

        // Find who has been driver longer than average
        let average = realm.objects('Car').avg('miles');
        let longerThanAverage = realm.objects('Person').filtered('cars.@sum.miles > $0', average);
        console.log(`Longer than average (${average})`)
        for (let p of longerThanAverage) {
            console.log(`  ${p.name}: ${p.cars.sum('miles')}`);
        }

        realm.close();
});
```

The output of the code snippet is:

```
Car owners
  John
  Joan
  Jack
Longer than average (1288.3333333333333)
  John: 4280
  Joan: 2485
```

### Sorting

`Results`允许您根据单个或多个属性指定排序标准和顺序。

例如，以下是上述示例中查询结果返回的汽车结果集,按照数英里进行排序：

```
let hondas = realm.objects('Car').filtered('make = "Honda"');

// 按`miles`排序hondas结果集(默认升序)
let sortedHondas = hondas.sorted('miles');

// 按`miles`的降序hondas结果集
sortedHondas = hondas.sorted('miles', true);

// 按`price`降序排序，然后按`miles`升序排序
sortedHondas = hondas.sorted([['price', true], ['miles', false]]);
```

`Results`也可以按照您正在排序的对象链接到的对象的值进行排序：

```
let people = realm.objects('Person');

// 按他们的汽车的里程(`miles`)排序
let sortedPeople = people.sorted('car.miles');
```

基本类型`List`可以通过调用`sorted()`而不指定属性来按其值排序：

```
let person = realm.objects('Person')[0];
let sortedTestScores = person.testScores.sorted();
```

> 请注意，`Results`的顺序只有在查询排序后才能保证一致。出于性能原因，不保证插入顺序。

### 自动更新结果集

`Results`实例是实时的，自动更新视图到底层数据中，这意味着结果集永远不需要重新获取。修改影响查询的对象将立即反映在结果集中。这是一个例外，当使用 `for...in` 或 `for...of`,时，即使其中一些被删除或修改为被排除，它将始终遍历迭代开始时与查询匹配的对象迭代期间的过滤器。

```
let hondas = realm.objects('Car').filtered('make = "Honda"');
// hondas.length == 0

realm.write(() => {
  realm.create('Car', {make: 'Honda', model: 'RSX'});
});
// hondas.length == 1
```

这适用于所有`Results`实例，包括由`objects`,`filtered`,`sorted`方法返回的结果集。

`Results`的这个属性不仅使Realm快速和高效，它允许您的代码更简单，更有灵活性。例如，如果您的视图依赖于查询的结果，则可以将结果存储在属性中并访问它，而无需在每次访问之前刷新其数据。

您可以订阅[通知](#notifications)，以了解何时更新Realm数据，指出何时应该刷新应用的UI，而无需重新获取Results。

### 限制结果集

大多数其他数据库技术提供了对查询结果进行“分页”的能力（例如SQLite中的“LIMIT”关键字）。这通常是为了避免从磁盘读取太多或者一次将太多结果拖到内存中而完成的。

由于Realm中的查询是懒惰的，所以执行这种分页行为根本不是必需的，因为只有在明确访问该域后，域才会从查询结果中加载对象。

如果由于与UI相关或其他实现原因，您需要查询中的特定对象子集，那么只需要使用`Results`对象，并只读出所需的对象。

```
let cars = realm.objects('Car');

// get first 5 Car objects
let firstCars = cars.slice(0, 5);
```

## Realms![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

### 打开Realm实例

打开Realm只是通过实例化一个新的Realm对象来执行。将`配置对象`传递给构造函数。我们已经看到这个已经在示例中使用了包含`schema`键的配置对象：

```
// 获得支持我们对象的默认的Realm实例
Realm.open({schema: [Car, Person]})
  .then(realm => {
    // ...在这里使用Realm实例
  })
  .catch(error => {
    // 如果发生任何错误,将在这里进行捕获处理
  });
```

有关配置对象的完整详细信息，请参阅API参考以进行[配置](https://realm.io/docs/javascript/latest/api/Realm.html#~Configuration)。对象的一些更常见的键，除了`schema`，包括：

- `path`: 指定[另一个Realm](https://realm.io/docs/javascript/latest/#other-realms)的路径
- `migration`: [迁移功能](https://realm.io/docs/javascript/latest/#migrations)
- `sync`: [同步对象](https://realm.io/docs/javascript/latest/#sync), ，打开与Realm对象服务器同步的Realm
- `inMemory`:Realm将在内存中打开，并且对象不会持久化;一旦最后一个Realm实例关闭，所有对象都会销毁.
- `deleteRealmIfMigrationNeeded`:如果需要迁移，则删除领域;这在开发中很有用，因为数据模型可能经常变化

### 默认Realm实例

在以前的所有例子中可能已经注意到路径参数已被省略。在这种情况下，使用默认的Realm路径。您可以使用`Realm.defaultPath`全局属性访问和更改默认的Realm路径。

### 其他Realm实例

有多个Realm在多个位置持久化是有用的。例如，除了您的主Realm外，您还可能希望将一些数据与您的应用程序捆绑在Realm文件中。您可以通过在初始化Realm时指定`路径path`参数来执行此操作。所有路径都相对于您的应用程序的可写入文档目录：

```
// Open a realm at another path
Realm.open({
  path: 'anotherRealm.realm',
  schema: [CarSchema]
}).then(/* ... */);
```

### Schema版本

打开Realm时可用的另一个选项是`schemaVersion`属性。当省略时，`schemaVersion`属性默认为0.在使用包含与之前规范不同的对象的Schema初始化现有Realm时，需要指定`schemaVersion`。如果Schema被更新并且`schemaVersion`不是之前的结构，将抛出异常。

```
const PersonSchema = {
  name: 'Person',
  properties: {
    name: 'string'
  }
};

// schemaVersion defaults to 0
Realm.open({schema: [PersonSchema]});
```

如果你后来做这样的操作：

```
const UpdatedPersonSchema = {
  // 因为schema名称相同, 所以以前的“Person”对象在Realm将会更新
  name: 'Person',
  properties: {
    name: 'string',
    dog:  'Dog'     // 新属性
  }
};

// 这将抛出异常，因为schema已经改变和`schemaVersion`还没有指定
Realm.open({schema: [UpdatedPersonSchema]});

// 这将成功并将Realm更新到新的schema
Realm.open({schema: [UpdatedPersonSchema], schemaVersion: 1});
```

如果您想要检索当前的`Realm` 的 `schema` 的版本，可以使用`Realm.schemaVersion`方法。

```
const currentVersion = Realm.schemaVersion(Realm.defaultPath);
```

### 异步打开Realm

您可以通过简单地调用构造函数并将`配置对象`传递给它来创建Realm实例。通常不推荐这样做，因为它会阻止并且可能是一项耗时的操作，尤其是在要[迁移](#迁移)的情况下运行,或者Realm已[同步](#同步),并且您不希望在数据完全下载之前修改数据。

如果你仍然想这样做，模式很简单：

```
const realm = new Realm({schema: [PersonSchema]});

// You can now access the realm instance.
realm.write(/* ... */);
```

> 如果Realm具有只读[权限](https://realm.io/docs/javascript/latest/#access-control)，那么您必须使用异步API来打开它。用上述模式打开只读领域将导致错误。

## 迁移![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

在使用数据库时，您的数据模型很可能随时间而改变。例如，假设我们有以下`Person`模型：

```
const PersonSchema = {
  name: 'Person',
  properties: {
    firstName: 'string',
    lastName: 'string',
    age: 'int'
  }
}
```

我们要更新数据模型，用来添加一个`name`属性，而不是单独的名字和姓氏。为此，我们只需将schema更改为以下内容：

```
const PersonSchema = {
  name: 'Person',
  properties: {
    name: 'string',
    age: 'int'
  }
}
```

在这一点上，如果您使用以前的`model`版本保存了任何数据，新的代码和Realm已存储在磁盘上的旧数据将不匹配。发生这种情况时，当您尝试使用新的`schema`打开现有的Realm时，将抛出异常，除非运行迁移。

### 进行迁移

您可以通过更新[schemaVersion](https://realm.io/docs/javascript/latest/#schema-version)并定义可选的迁移函数来定义迁移和关联的schema版本。您的迁移函数提供将数据模型从以前的schema转换为新的schema所需的任何逻辑。当打开Realm时，只有在需要迁移时，才会将迁移函数应用于将Realm更新到给定的schema版本。

如果没有提供迁移函数，则当更新到新的`schemaVersion`时，任何新的属性将自动添加并且旧的属性从数据库中删除。如果您需要在升级版本时更新旧的或填充的新属性，那么可以在迁移函数中执行此操作。例如，假设我们要迁移先前声明的`Person`模型。您可以使用旧的`firstName`和`lastName`属性填充新模式的`name`属性：

```
Realm.open({
  schema: [PersonSchema],
  schemaVersion: 1,
  migration: (oldRealm, newRealm) => {
    // only apply this change if upgrading to schemaVersion 1
    if (oldRealm.schemaVersion < 1) {
      const oldObjects = oldRealm.objects('Person');
      const newObjects = newRealm.objects('Person');

      // loop through all objects and set the name property in the new schema
      for (let i = 0; i < oldObjects.length; i++) {
        newObjects[i].name = oldObjects[i].firstName + ' ' + oldObjects[i].lastName;
      }
    }
  }
}).then(realm => {
  const fullName = realm.objects('Person')[0].name;
});
```

迁移成功完成后，您的应用程序可以像往常一样访问Realm及其所有对象。

### 线性迁移

使用上述迁移模式，您可能会在多个版本上迁移时遇到问题。如果用户跳过应用程序更新，并且在跳过的版本中属性已被更改多次，则可能会发生这种情况。在这种情况下，您可能需要编辑旧的迁移代码才能将数据从旧schema更新到最新schema。

可以通过顺序运行多个迁移来避免此问题，确保将数据库升级到每个先前版本，并运行关联的迁移代码。当遵循这种模式时，永远不需要修改旧的迁移代码，尽管您需要保留所有旧的schema和迁移模块以备将来使用。一个这样的例子：

```
const schemas = [
  { schema: schema1, schemaVersion: 1, migration: migrationFunction1 },
  { schema: schema2, schemaVersion: 2, migration: migrationFunction2 },
  ...
]

// 要更新的第一个schema是当前schema版本。
// 因为第一个schema是在我们的数组里
let nextSchemaIndex = Realm.schemaVersion(Realm.defaultPath);
while (nextSchemaIndex < schemas.length) {
  const migratedRealm = new Realm(schemas[nextSchemaIndex++]);
  migratedRealm.close();
}

// 用最新的schema打开Realm
Realm.open(schemas[schemas.length-1]);
```

## Notifications![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

Realm的 `Results`和 `List` 对象提供了`addListener`方法来注册通知回调。每当更新对象时，将调用更改通知回调。

有两种通知，“Realm通知”（提交写入事务时通知的简单回调）和“Collection通知”（更复杂的回调，它们在插入，删除和更新时接收更改元数据）。

此外，专业版和企业版提供事件处理通知。阅读“Realm移动平台”了解更多信息。

如果Realm升级到了最新版本, 在某些情况下，可以在事务开始时调用监听器 ，或者观察到的Realm实体以触发通知的方式被修改或删除。在这些情况下，监听器在当前写入事务的上下文中运行，因此尝试在通知处理程序中开始新的写入事务将引发异常。您可以使用`Realm.isInTransaction`属性来确定您的代码是否在写入事务中执行。

### Realm通知

每次提交写入事务时，Realm实例都会向其他实例发送通知。注册通知：

```
function updateUI() {
  // ...
}

// 注册 Realm 通知
realm.addListener('change', updateUI);

// ..之后移除Realm通知
realm.removeListener('change', updateUI);

// .或者将所有通知取消注册
realm.removeAllListeners();
```

### Collection 通知

Collection通知包含描述在细粒度级别发生了哪些更改的信息。这包括自上次通知以来插入，删除或修改的对象的索引。Collection通知异步传递：首先使用初始结果，然后在任何修改Collection中的任何对象的写入事务之后，从集合中删除对象，或向集合中添加新对象。

当这些变化发生时，`addListener`通知回调函数会收到两个参数。第一个是更改的collection，第二个是具有关于由删除，插入和修改影响的集合索引的信息的`changes`对象。

前两项，**删除**和**插入**，每当对象开始和停止作为collection的一部分时，记录索引。当您将对象添加到realm或将其从realm中删除时，这将考虑在内。对于`Results`，当您过滤特定值并且对象已更改，以使其现在与查询匹配或不匹配时，此操作也适用。对于基于`List`的collection，这适用于从关系中添加或删除对象时。

当对象的属性发生更改时，您的应用程序将被通知有关修改，该属性以前是collection的一部分，并且仍然是其中的一部分。当一对多关系发生变化时，也会发生这种情况，但不考虑反向关系的变化。

```
class Dog {}
Dog.schema = {
  name: 'Dog',
  properties: {
    name:  'string',
    age: 'int',
  }
};
class Person {}
Person.schema = {
  name: 'Person',
  properties: {
    name:    {type: 'string'},
    dogs:    {type: 'list', objectType: 'Dog'},
  }
};
```

让我们假设您正在观察上面的模型代码给出的狗主人列表。当以下情况下，您将收到关于匹配的`Person`对象的修改的通知：

- 您修改`Person`的`name`属性。
- 你添加或删除`Dog`给`Person`的`dogs`属性。
- 您修改属于该`Person`的 `Dog`的 `age` 属性。

这使得可以离散地控制对UI内的内容进行的动画和视觉更新，而不是在每次发生通知时任意重新加载所有内容。

```
// 注册通知
realm.objects('Dog').filtered('age < 2').addListener((puppies, changes) => {

  // 更新UI以响应插入的对象
  changes.insertions.forEach((index) => {
    let insertedDog = puppies[index];
    ...
  });

  // 更新UI以响应修改的对象
  changes.modifications.forEach((index) => {
    let modifiedDog = puppies[index];
    ...
  });

  // 更新UI以响应已删除的对象
  changes.deletions.forEach((index) => {
    // 已删除的对象无法直接访问
    // 支持即将访问已删除的对象...
    ...
  });

});

// 取消注册所有的通知
realm.removeAllListeners();
```

## 同步![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

在Node.js环境中进行同步，对于Linux系统来说是专业版功能，且必须在有许可的情况下才能执行。

在Linux系统中使用Node.js，需要指定访问许可获取token启动Sync功能。这样做：

```
const token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...";

// Unlock Professional Edition APIs
Realm.Sync.setFeatureToken(token);
```

Realm平台跨网络扩展数据库可以实现跨设备数据同步。为了实现这种同步，Realm提供一组新的类型和类支持被同步的Realm；这些新的类型和类与现存的Realm移动数据库是协同关系。

### 用户

Realm对象服务器中的中心对象是与被同步的Realm相关联的Realm用户 (`Realm.Sync.User`) 。 `User` 访问共享Realm可以通过用户名/密码的方式进行验证，或者通过第三方验证数字验证。

创建及注册用户需要两个东西：

- 可以连接到Realm对象服务器的URL
- 表明该用户适用于该验证机制的凭据（例如：用户名/密码，权限密码，等等）

#### 认证

创建用户id及用户登录需要用到验证。请参考我们的[认证文件](https://realm.io/docs/realm-object-server/#authentication)查找Realm移动平台支持的验证提供者。

指定用户的凭据信息可以通过以下几种方式建立:

- 提供一个有效的用户名/密码组合
- 提供一个从Realm支持的第三方验证服务商处获得的token
- 提供一个token和一个自定义认证提供程序（参见 [自定义身份验证](https://realm.io/docs/realm-object-server/#custom-authentication)）

用户名和密码验证完全由Realm对象服务器管理，允许你完全控制自己的应用程序用户管理。对于其他的验证方法，你的应用程序会登录外部服务器并获取验证token.

下面是一些不同的提供者设置凭证示例.

##### 用户名/密码

```
Realm.Sync.User.login('http://my.realm-auth-server.com:9080', 'username', 'p@s$w0rd').then(user => {
  // user is logged in
  // do stuff ...
}).catch(error => {
  // an auth error has occurred
});
```

用户登录之前，必须先创建账户。你可以使用`Admin Dashboard`提前在服务器上创建，或者通过调用`注册（register）`方法

```
Realm.Sync.User.register('http://my.realm-auth-server.com:9080', 'username', 'p@s$w0rd', (error, user) => { /* ... */ });
```

##### Google

```
const googleAccessToken = 'acc3ssT0ken...';
Realm.Sync.User.registerWithProvider('http://my.realm-auth-server.com:9080', 'google', googleAccessToken, (error, user) => { /* ... */ });
```

##### Facebook

```
const fbAccessToken = 'acc3ssT0ken...';
Realm.Sync.User.registerWithProvider('http://my.realm-auth-server.com:9080', 'facebook', fbAccessToken, (error, user) => { /* ... */ });
```

##### Custom Auth

```
// The user token provided by your authentication server
const accessToken = 'acc3ssT0ken...';

const user = Realm.Sync.User.registerWithProvider(
  'http://my.realm-auth-server.com:9080',
  'custom/fooauth',
  accessToken,
  (error, user) => { /* ... */ }
);
```

*注*：JavaScript软件工具开发包目前不允许发送额外数据。如需要发送不止一个token，请将额外数据加密成JSON并通过accessToken参数传输，再在服务器端解码字符串。

##### Logging Out

Logging out of a synced Realm is simple:

```
user.logout();
```

When a user is logged out, the synchronization will stop. A logged out user can no longer open a synced Realm.

#### Working with Users

The sync server URL may contain the tilde character (“~”) which will be transparently expanded to represent the user’s unique identifier. This scheme easily allows you to write your app to cater to its individual users. The location on disk for shared Realms is managed by the framework, but can be overridden if desired.

```
Realm.Sync.User.login(/* ... */, (error, user) => {
  if (!error) {
    Realm.open({
      sync: {
        user: user,
        url: 'realm://object-server-url:9080/~/my-realm',
      },
      schema: [/* ... */]
    }).then(realm => {
      /* ... */
    });
  }
});
```

`Realm.Sync.User.current` can be used to obtain the currently logged in user. If no users have logged in or all have logged out, it will return `undefined`. If there are more than one logged in users, an error will be thrown.

```
const user = Realm.Sync.User.current;
```

If there are likely to be multiple users logged in, you can get a collection of them by calling `Realm.Sync.User.all`. This will be empty if no users have logged in.

```
let users = Realm.Sync.User.all;

for(const key in users) {
  const user = users[key];

  // do something with the user object.
}
```

### Opening a Synchronized Realm

You open a synchroized Realm the same say as you open any other Realm. The [configuration](https://realm.io/docs/javascript/latest/api/Realm.html#~Configuration) can be extended with a `sync` property if you need to configure the synchronization. The optional properties of `sync` include:

- `error` - a callback for error handling/reporting
- `validate_ssl` - indicating if SSL certificates must be validated
- `ssl_trust_certificate_path` - a path where to find trusted SSL certificates

The error handling is set up by registering a callback (`error`) as part of the configuration:

```
const config = {
  sync: { user: userA,
          url: realmUrl,
          error: err => console.log(err)
        },
  schema: [{ name: 'Dog', properties: { name: 'string' } }]
};

var realm = new Realm(config);
```

#### Partially synchronized Realms

This feature is included as a tech preview. It is likely to change!

Instead of synchronized every object, it is possible to synchronize a subset. This partially synchronized Realm is based on a query, and your client will only receive the objects which fulfil the query. A simple example is:

```
const config = {
  sync: { user: userA,
          url: realmUrl,
          partial: true,  // <-- this enables a partially synced Realm
        },
  schema: [{ name: 'Person', properties: { name: 'string', age: 'int' } }]
};

var realm = new Realm(config);
var partialResults = realm.subscribeToObjects('Integer', 'age > 5').then((results, error) => {
    return results;
});

// partialResults is updated with objects matching the query
```

You may modify objects within the results collection, and these changes will be synced up to the Realm Object Server. Note that conflicts may be resolved differently than if the writes had been made to a fully-synchronized copy of the Realm.

### Working with a Synchronized Realm

Once you have opened a Realm using a URL to a Realm Object Server and a `User`object, you can interact with it as you would any other Realm in JavaScript.

```
realm.write(() => {
  realm.create('MyObject', jsonData);
});

var objects = realm.objects('MyObject');
```

### Sync Sessions

A synced Realm’s connection to the Realm Object Server is represented by a `Session`object. Session objects can be retrieved by calling `realm.syncSession`.

The state of the underlying session can be retrieved using the `state` property. This can be used to check whether the session is active, not connected to the server, or in an error state.

#### Progress notifications

Session objects allow your app to monitor the status of a session’s uploads to and downloads from the Realm Object Server by registering a progress notification callback on a session object by calling [realm.syncSession.addProgressNotification(direction, mode, callback)] or one of the asynchronous methods `Realm.open` and `Realm.openAsync`. (*these methods support only a subset of the progress notifications modes*)

Progress notification callbacks will be invoked periodically by the synchronization subsystem. As many callbacks as needed can be registered on a session object simultaneously. Callbacks can either be configured to report upload progress or download progress.

Each time a callback is called, it will receive the current number of bytes already transferred, as well as the total number of transferable bytes (defined as the number of bytes already transferred plus the number of bytes pending transfer).

To stop receiving progress notifications a callback can be unregistered using [realm.syncSession.removeProgressNotification(callback)]. Calling the function a second time with the same callback is ignored.

There are two [progress notification modes](https://realm.io/docs/javascript/latest/api/reference/Realms.Sync.ProgressMode.html#fields) for the progress notifications:

- `reportIndefinitely` - the registration will stay active until the callback is unregistered and will always report the most up-to-date number of transferable bytes. This type of callback could be used to control a network indicator UI that, for example, changes color or appears only when uploads or downloads are actively taking place.

```
let realm = new Realm(config);
const progressCallback = (transferred, transferables) => {
    if (transferred < transferables) {
        // Show progress indicator
    } else {
        // Hide the progress indicator
    }
};

realm.syncSession.addProgressNotification('upload', 'reportIndefinitely', progressCallback);
// ...
realm.syncSession.removeProgressNotification(progressCallback);
```

- `forCurrentlyOutstandingWork` - the registration will capture the number of transferable bytes at the moment it is registered and always report progress relative to that value. Once the number of transferred bytes reaches or exceeds that initial value, the callback will be automatically unregistered. This type of progress notification could, for example, be used to control a progress bar that tracks the progress of an initial download of a synced Realm when a user signs in, letting them know how long it is before their local copy is up-to-date.

```
let realm = new Realm(config);
const progressCallback = (transferred, transferable) => {
    const progressPercentage = transferred / transferable;
};

realm.syncSession.addProgressNotification('download', 'forCurrentlyOutstandingWork', progressCallback);
// ...
realm.syncSession.removeProgressNotification(progressCallback);
```

The asynchronous methods `Realm.open` and `Realm.openAsync` for opening a Realm can also be used to register a callback for sync progress notifications. In this case only ‘download’ direction and ‘forCurrentlyOutstandingWork’ mode are supported. Additional callbacks can be registered after the initial open is completed by using the newly created Realm instance

```
Realm.open(config)
      .progress((transferred, transferable) => {
          // update UI
      })
      .then(realm => {
          // use the Realm
      })
      .catch((e) => reject(e));

Realm.openAsync(config,
          (error, realm) => {
             // use the Realm or report an error
          },
          (transferred, transferable) => {
            // update UI
          }, );
```

### Access Control

The Realm Mobile Platform provides flexible access control mechanisms to restrict which users are allowed to sync against which Realm files. This can be used, for example, to create collaborative apps where multiple users write to the same Realm. It can also be used to share data in a publisher/subscriber scenario where a single writing user shares data with many users with read permissions.

There are three permissions that control the access level of a given Realm for a User:

- `mayRead` indicates that the user is allowed to read from the Realm.
- `mayWrite` indicates that the user is allowed to write to the Realm.
- `mayManage` indicates that the user is allowed to change the permissions for the Realm.

Unless permissions are explicitly modified, only the owner (creator) of a Realm can access it. The only exception is admin users: They are always granted all permissions to all Realms on the server.

**Write-only** permissions (i.e., `mayWrite` set without `mayRead`) are not currently supported.

Please refer to the general Realm Object Server documentation on [Access Control](https://realm.io/docs/realm-object-server/latest/#access-control) to learn more about the concept.

#### Retrieving Permissions

To get a collection of all the Permissions a user has been granted, use the `User.getGrantedPermissions` method:

```
const permissions = user.getGrantedPermissions("currentUser");

// Permissions is a regular query
const writePermissions = permissions.filtered("mayWrite = true");

// Queries are live and emit notifications
writePermissions.addListener((collection, changes) => {
    // handle permission changes
});
```

To get permissions granted **by** a user, pass in `"otherUser"`.

#### Modifying Permissions

Modifying the access control settings for a Realm file is performed by either applying permissions directly or offering them.

##### Granting Permissions

Permission changes can be applied (i.e. granted or revoked) via the `User.applyPermissions` method in order to directly increase or decrease other users’ access level to a Realm.

```
const condition = { userId: 'some-user-id' };
const realmUrl = "realm://my-server.com/~/myRealm";
user.applyPermissions(condition, realmUrl, 'read');
```

The `condition` parameter must be an object containing either

- `userId` - use this to apply permissions based on a user’s identity (the internal Id that Realm generates).
- `metadataKey` and `metadataValue` - use the key `'email'` and an email address as the value to specify a user via the Username/Password provider.

The last argument controls the access level that the user will be granted. Higher access implies all lower tiers, e.g. `write` implies `read`, `admin` implies `read` and `write`. If `none` is passed, this will revoke the user’s permissions for this Realm.

##### Offer/Response

A user can offer permissions to their Realm by sharing the opaque token returned by `offerPermissionsAsync`:

```
const realmUrl = 'realm://my-server.com/~/myRealm';
const oneDay = 1000 * 60 * 60 * 24;
const expiration = new Date(Date.now() + 7 * oneDay);
userA.offerPermissions(realmUrl, 'write', expiration)
  .then(token => { /* ... */ });
```

The optional `expiresAt` argument controls when the offer expires - i.e. using the token after that date will no longer grant permissions to that Realm. Users who have already consumed the token to obtain permissions will not lose their access after that date. If you want to revoke permissions, use `applyPermissionsAsync`.

Once a user has received a token, e.g. by sharing it via messaging app, or scanning a QR code, they can consume it to obtain the permissions offered:

```
const token = "...";
userB.acceptPermissionOffer(token)
  .then(realmUrl => Realm.open({ schema: [/* ... */], sync: { user: userB, url: realmUrl }}))
  .then(realm => {
    // ..use the realm
  });
```

### Migrating from Realm Object Server 1.x to 2.x

If you upgrade Realm Object Server from version 1.x to 2.x, your Realms **must** be migrated. The new file format is incompatible, and Realms have to be re-downloaded.

When a synchronized Realm requiring migration is opened, the Realm file will be copied to a backup location and then deleted so that it can be re-downloaded from the Realm Object Server. An exception will be thrown, and you can choose to migrate your objects from the old Realm.

```
Realm.open(config)
  .then(realm => {
    // you have probably already migrated
  })
  .catch(e => {
    if (e.name == "IncompatibleSyncedRealmError") {
      const backupRealm = new Realm(e.configuration);
      // copy objects from backupRealm
      return;
    }
  });
```

## Encryption![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

Please take note of the Export Compliance section of our LICENSE, as it places restrictions against the usage of Realm if you are located in countries with an export restriction or embargo from the United States.

Realm supports encrypting the database file on disk with AES-256+SHA2 by supplying a 64-byte encryption key when creating a Realm.

```
var key = new Int8Array(64);  // pupulate with a secure key
Realm.open({schema: [CarObject], encryptionKey: key})
  .then(realm => {
    // Use the Realm as normal
    var dogs = realm.objects('Car');
  });
```

This makes it so that all of the data stored on disk is transparently encrypted and decrypted with AES-256 as needed, and verified with a SHA-2 HMAC. The same encryption key must be supplied every time you obtain a Realm instance.

There is a small performance hit (typically less than 10% slower) when using encrypted Realms.

## Troubleshooting![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

### Missing Realm Constructor

If your app crashes, telling you that the Realm constructor was not found, there are a few things you can try:

First of all, run `react-native link realm`

If that doesn’t help, and your problem is on Android, try:

Add the following in your `MainApplication.java` file: `java import io.realm.react.RealmReactPackage;`

And add the `RealmReactPackage` to the list of packages:

```
protected List getPackages() {
    return Arrays.asList(
        new MainReactPackage(),
        new RealmReactPackage() // add this line
    );
}
```

add following two lines in `settings.gradle`:

```
include ':realm'
project(':realm').projectDir = new File(settingsDir, '../node_modules/realm/android')
```

If your problem is on iOS, try: 1. Close all simulators/device builds 2. Stop the package manager running in terminal (or better yet, just restart terminal) 3. Open the ios folder in your app root in finder 4. Go into the build folder (note: you won’t see this build folder in atom, so just right click ios and click open in finder) 5. Delete everything inside of the build folder (just move to trash and keep trash around in case you’re worried) 6. Run `react-native run-ios` to rebuild the whole thing

### Chrome Debugging is slow

We are aware of this. The reason for this is that since Realm is written in C++ and runs native code, it has to run on the device/simulator. But given the zero-copy architecture, we need to send values in realm objects over the RPC wire every time you inspect an object that is stored in a Realm.

We are investigating various potential solutions for this problem. If you want to keep track of it, you can follow the [GitHub issue](https://github.com/realm/realm-js/issues/491).

### Crash Reporting

We encourage you to use a crash reporter in your application. Many Realm operations could potentially fail at runtime (like any other disk IO), so collecting crash reports from your application will help identify areas where either you (or us) can improve error handling and fix crashing bugs.

Most commercial crash reporters have the option of collecting logs. We strongly encourage you to enable this feature. Realm logs metadata information (but no user data) when throwing exceptions and in irrecoverable situations, and these messages can help debug when things go wrong.

## Getting help![img](https://realm.io/assets/svg/docs/thumbs-up.svg)![img](https://realm.io/assets/svg/docs/thumbs-down.svg)

- **Need help with your code?** [Ask on StackOverflow](http://stackoverflow.com/questions/ask?tags=realm). We actively monitor & answer questions on SO!
- **Have a bug to report?** [Open an issue on our repo](https://github.com/realm/realm-js/issues/new). If possible, include the version of Realm, a full log, the Realm file, and a project that shows the issue.
- **Have a feature request?** [Open an issue on our repo](https://github.com/realm/realm-js/issues/new). Tell us what the feature should do, and why you want the feature.
- **Love to follow what comes up next?** [Look at our changelog](https://github.com/realm/realm-js/blob/master/CHANGELOG.md). The log shows the latest additions and changes we plan to release soon, and the history of how Realm has evolved.[ ![Two‑way data sync, real‑time collaboration, offline‑first applications, API bridge, data push](https://realm.io/assets/img/home/features/radar.jpg) ](https://realm.io/cn/products/realm-platform)