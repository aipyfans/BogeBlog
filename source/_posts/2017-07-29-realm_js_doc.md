---
layout: post
title:  "Realm for JavaScript(1.10.1)"
date:   2017-07-29 11:11:11
categories: database
---

## 介绍

Realm JavaScript使您能够以安全，持久和快速的方式有效地编写应用程序的Model层。它的设计是可以与 [React Native](https://facebook.github.io/react-native/) 和 [Node.js](https://nodejs.org/)一起工作。

以下是使用React Native的示例：

```
// 定义您的Model及其属性
class Car {}
Car.schema = {
  name: 'Car',
  properties: {
    make:  'string',
    model: 'string',
    miles: 'int',
  }
};
class Person {}
Person.schema = {
  name: 'Person',
  properties: {
    name:    {type: 'string'},
    cars:    {type: 'list', objectType: 'Car'},
    picture: {type: 'data', optional: true}, // 可选属性
  }
};

// 获取支持我们对象的默认Realm实例
let realm = new Realm({schema: [Car, Person]});

// 创建Realm对象并写入本地存储
realm.write(() => {
  let myCar = realm.create('Car', {
    make: 'Honda',
    model: 'Civic',
    miles: 1000,
  });
  myCar.miles += 20; // 更新属性值
});

// 查询出所有具有较高里程数的车辆
let cars = realm.objects('Car').filtered('miles > 1000');

// 将返回一个结果对象(我们的1辆车)
cars.length // => 1

// 添加另一辆车
realm.write(() => {
  let myCar = realm.create('Car', {
    make: 'Ford',
    model: 'Focus',
    miles: 2000,
  });
});

// 查询结果将实时更新
cars.length // => 2
```

## 入门

### 安装

按照以下安装说明，通过[npm](https://www.npmjs.com/package/realm)安装Realm JavaScript，或者在 [GitHub](https://github.com/realm/realm-js)上查看源代码。

- [React Native](https://realm.io/docs/javascript/latest/#react-install)
- [Node.js](https://realm.io/docs/javascript/latest/#nodejs-install)

**必要条件**

- 确保您的环境设置为运行React Native应用程序。按照React Native说明开始使用。

- 使用Realm的应用程序可以同时针对iOS和Android。

- 支持React Native 0.20.0及更高版本。

- 确保React Native软件包管理器（rnpm）全局安装并且是最新的：

  ```
  npm install -g rnpm
  ```

**安装**

- 创建一个新的React Native工程:

  ```
  react-native init <project-name>
  ```

- 将目录更改为新项目(`cd <project-name>`)，并添加`realm`依赖

  ```
  npm install --save realm
  ```

- 接下来，将项目链接到`realm`原生模块。

  - React Native **>=** 0.31.0

    ```
    react-native link realm
    ```

  - React Native **<** 0.31.0

    ```
    rnpm link realm
    ```

*Android的警告*：根据版本，rnpm可能会生成无效的配置，正确更新Gradle(`android/settings.gradle` and `android/app/build.gradle`) ，但无法添加Realm模块。确认`react-native link`已添加了Realm模块;如果没有，请通过以下步骤手动链接到库：

1. 添加以下行到 `android/settings.gradle`:

   `gradle include ':realm' project(':realm').projectDir = new File(rootProject.projectDir, '../node_modules/realm/android')`

2. 将编译行添加到 `android/app/build.gradle` 中的依赖项:

   `gradle dependencies { compile project(':realm') }`

3. 在`MainApplication.java`中添加导入并链接包：:

   ```
   import io.realm.react.RealmReactPackage; // 添加导入

   public class MainApplication extends Application implements ReactApplication {
       @Override
       protected List<ReactPackage> getPackages() {
           return Arrays.<ReactPackage>asList(
               new MainReactPackage(),
               new RealmReactPackage() // 添加链接包
           );
       }
   }
   ```

你现在已经准备好了。要查看Realm中的action，请在`index.ios.js`或`index.android.js`中添加以下作为`class <project-name>`的定义：

```
const Realm = require('realm');

class <project-name> extends Component {
 render() {
   let realm = new Realm({
     schema: [{name: 'Dog', properties: {name: 'string'}}]
   });

   realm.write(() => {
     realm.create('Dog', {name: 'Rex'});
   });

   return (
     <View style={styles.container}>
       <Text style={styles.welcome}>
         Count of Dogs in Realm: {realm.objects('Dog').length}
       </Text>
     </View>
   );
 }
}
```

然后，您可以在设备和模拟器中运行应用程序！

### 安装示例

可以从Github克隆可选的示例库。

```
git clone https://github.com/realm/realm-js.git
```

更改到克隆的目录，并更新子模块：

```
cd realm-js
git submodule update --init --recursive
```

在Android上，您需要安装NDK，并且必须设置ANDROID_NDK环境变量.

```
export ANDROID_NDK=/usr/local/Cellar/android-ndk/r10e
```

React Native示例在`examples`目录中。您必须为每个示例运行`npm install`。

## 获得帮助

- **需要帮助你的代码？** [在StackOverflow上提问吧](http://stackoverflow.com/questions/ask?tags=realm). 我们积极监督并立马回答您的问题！
- **有Bug上报?** [在我们Github库上提问吧](https://github.com/realm/realm-js/issues/new). 如果可能，请包括Realm版本，完整日志，Realm文件以及显示问题的项目。
- **有功能请求吗?** [在我们Github库上提交请求吧吧](https://github.com/realm/realm-js/issues/new). 告诉我们功能应该做什么，以及为什么要这个功能.

如果您使用崩溃记录（如Crashlytics或HockeyApp），请确保启用日志收集。Realm在抛出异常和不可恢复的情况下记录元数据信息（但不包含用户数据），并且这些消息可以帮助在出现问题时进行调试。

## 模型

Realm数据模型由初始化期间传递到Realm的schema信息定义。对象的`schema`由对象的`名称(name)`和一组属性组成，每个属性由`名称(name)`和`类型(type)`以及对象和列表属性的`objectType`组成。您还可以将每个属性指定为可选的或具有默认值。

```
var Realm = require('realm');

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
    cars:     {type: 'list', objectType: 'Car'},
    picture:  {type: 'data', optional: true}, // 可选的属性
  }
};

// 使用Car和Person的模型初始化Realm实例
let realm = new Realm({schema: [CarSchema, PersonSchema]});
```

如果您希望对象继承自现有类，则只需在对象构造函数中定义schema，并在创建realm时传递构造函数：

```
class Person {
  get ageSeconds() {
    return Math.floor((Date.now() - this.birthday.getTime()));
  }
  get age() {
    return ageSeconds() / 31557600000;
  }
}

Person.schema = PersonSchema;

// Note here we are passing in the `Person` constructor
let realm = new Realm({schema: [CarSchema, Person]});
```

一旦定义了对象模型，就可以从Realm创建和获取对象：

```
realm.write(() => {
  let car = realm.create('Car', {
    make: 'Honda',
    model: 'Civic',
    miles: 750,
  });

  // 您可以访问并设置模型中定义的所有属性
  console.log('Car type is ' + car.make + ' ' + car.model);
  car.miles = 1500;
});
```

### 支持的类型

Realm支持以下基本类型: `bool`, `int`, `float`, `double`, `string`, `data`, 和 `date`.

- `bool` 属性映射到 JavaScript `Boolean` 对象
- `int`, `float`, and `double` 属性映射到 JavaScript `Number` 对象. 内部的“int”和“double”被存储为64位，而`float`以32位存储。
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

### 关系

#### 一对一关系

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

使用对象属性时，需要确保所有引用的类型都存在于用于打开Realm的schema中：

```
// CarSchema is needed since PersonSchema contains properties of type 'Car'
let realm = new Realm({schema: [CarSchema, PersonSchema]});
```

访问对象属性时，可以使用普通属性语法访问嵌套属性：

```
realm.write(() => {
  var nameString = person.car.name;
  person.car.miles = 1100;

  // 通过将属性设置为有效的JSON来创建一个新的Car
  person.van = {make: 'Ford', model: 'Transit'};

  // 将两个属性设置为同一个汽车实例
  person.car = person.van;
});
```

#### 一对多关系

对于多对多关系，您必须将属性类型指定为`列表(list)`以及`objectType`：

```
const PersonSchema = {
  name: 'Person',
  properties: {
    cars: {type: 'list', objectType: 'Car'},
  }
}
```

访问列表属性时，返回一个`List`对象。列表`(List)`具有与常规`JavaScript`数组非常相似的方法。最大的区别是，对列表进行的任何更改都会自动持续到底层的Realm。此外，列表属于从其获取的基础对象 - 您只能通过从拥有对象访问属性来获取List实例，并且不能手动创建。

```
let carList = person.cars;

// 将新车添加到列表中
realm.write(() => {
  carList.push({make: 'Honda', model: 'Accord', miles: 100});
  carList.push({make: 'Toyota', model: 'Prius', miles: 200});
});

let secondCar = carList[1].model;  // 访问使用数组索引
```

#### 多对多关系

链接是单向的。所以如果一对多的属性`Person.dogs`链接到一个`Dog`实例和一个属性`Dog.owner`链接到`Person`，这些链接是彼此独立的。将`Dog`添加到`Person`实例的 `dogs` 属性不会自动将该狗的`owner` 属性设置为此`Person`。因为手动同步对关系是容易出错的，复杂的并复制信息，所以Realm提供链接对象属性来表示这些反向关系。

使用链接对象属性，可以从特定属性获取链接到给定对象的所有对象。例如，`Dog`对象可以具有一个名为`owner`的属性，该属性包含其`dogs`属性中具有这个确切`Dog`对象的所有`Person`对象。通过`owners`属性的`linkingObjects`类型，指定它与Person对象的关系。

这样做可以通过`owners`属性指定它与Person对象的关系。

```
const PersonSchema = {
  name: 'Person',
  properties: {
    dogs: {type: 'list', objectType: 'Dog'},
  }
}

const DogSchema = {
  name:'Dog',
  properties: {
    owners: {type: 'linkingObjects', objectType: 'Person', property: 'dogs'}
  }
}
```

一个`linksObjects`属性可以指向一个`List`属性（多对多关系）或一个`Object`属性（一对一关系）：

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

访问`linksObjects`属性时，返回一个`Results`对象，因此完全支持进一步的查询和排序。`linksObject`属性属于它们从中获取的对象，不能直接设置或操作。当事务提交时，它们将自动更新。

*访问没有schema的`linkingObjects`*：如果您打开了一个Realm文件而不指定schema，例如在Realm Functions回调中，您可以通过在`Object`实例上调用 `linkingObjects(objectType, property)` 来获取`linksObjects`属性：

```
let captain = realm.objectForPrimaryKey('Captain', 1);
let ships = captain.linkingObjects('Ship', 'captain');
```

### 可选属性

属性可以通过在【属性定义】中指定【可选指示符】来声明为【可选属性 或 非可选属性】：

```
const PersonSchema = {
  name: 'Person',
  properties: {
    name:     {type: 'string'},               // 必需属性
    birthday: {type: 'date', optional: true}, // 可选属性

    // object properties are always optional
    car:      {type: 'Car'},
  }
};

let realm = new Realm({schema: [PersonSchema, CarSchema]});

realm.write(() => {
  // 可选属性可以在创建时设置为null或未定义
  let charlie = realm.create('Person', {
    name: 'Charlie',
    birthday: new Date(1995, 11, 25),
    car: null,
  });

  // 可选属性可以设置为`null`，`undefined`或新的非空值
  charlie.birthday = undefined;
  charlie.car = {make: 'Honda', model: 'Accord', miles: 10000};
});
```

如上所述，对象属性始终是可选的，不需要可选名称。列表属性不能被声明为可选或设置为null。您可以使用空数组来设置或初始化列表以将其清除。

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

您可以将索引的指示符添加到属性定义，以使该属性进行索引。 目前支持 `int`, `string`, 和 `bool` 属性类型：

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
    id:    'int',    // primary key
    title: 'string',
    price: 'float'
  }
};
```

主键属性自动编入索引。

## 写

创建，更新和删除Realm中的对象的操作必须在`write()`事务块中进行。请注意，写入事务具有不可忽略的开销;您应该尽量减少代码中写入块的数量。

### 创建对象

使用`create`方法创建对象：

```
let realm = new Realm({schema: [CarSchema]});

try {
  realm.write(() => {
    realm.create('Car', {make: 'Honda', model: 'Accord', drive: 'awd'});
  });
} catch (e) {
  console.log("Error on creation");
}
```

请注意， `write()` 中抛出的任何异常都将取消事务。所有示例中都不会显示`try/catch` 块，但这是很好的做法。

### 嵌套对象

如果对象具有对象属性，则可以通过为每个子属性指定JSON值来递归地创建这些属性的值：

```
let realm = new Realm({schema: [PersonSchema, CarSchema]});

realm.write(() => {
  realm.create('Person', {
    name: 'Joe',
    // 嵌套对象是递归创建的
    car: {make: 'Honda', model: 'Accord', drive: 'awd'},
  });
});
```

### 更新对象

#### Typed Updates 键入的更新

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
  // Create a book object
  realm.create('Book', {id: 1, title: 'Recipes', price: 35});

  // Update book with new price keyed off the id
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

## 查询

查询允许您从Realm中获取单个类型的对象，并可选择过滤和排序这些结果。所有查询（包括查询和属性访问）在Realm中都是懒加载的。仅在访问对象和属性时才读取数据。这样，您可以以高效的方式表示大量数据。

执行查询时，您将返回一个`Results`对象。`Results`只是您的数据视图，不可变。

从Realm中检索对象的最基本方法是使用Realm中的对象方法来获取给定类型的所有对象

```
let dogs = realm.objects('Dog'); // retrieves all Dogs from the Realm
```

### 过滤

您可以通过使用查询字符串调用过滤的方法来获取已过滤的结果。

例如，以下将改变我们早期的例子，以检索所有具有颜色tan的狗，以'B'开头的名字：

```
let dogs = realm.objects('Dog');
let tanDogs = dogs.filtered('color = "tan" AND name BEGINSWITH "B"');
```

目前，查询语言只支持NSPredicate语法的一部分。

数字属性支持基本比较运算符 `==`, `!=`, `>`, `>=`, `<`, 和 `<=`。

 `==`, `BEGINSWITH`, `ENDSWITH`, 和 `CONTAINS` 支持字符串属性。

字符串比较可以通过将`[c]`附加到运算符来进行区分大小写： `==[c]`, `BEGINSWITH[c]` 等。

可以通过在查询中指定关键字来完成对链接或子对象上的属性进行过滤，例如`car.color == 'blue'`。

### 排序

`Results`允许您根据单个或多个属性指定排序标准和顺序。例如，以下呼叫会从上面的例子中以几英里的速度排列返回的车辆：

```
let hondas = realm.objects('Car').filtered('make = "Honda"');

// Sort Hondas by mileage
let sortedHondas = hondas.sorted('miles');
```

请注意，仅当查询排序时，结果的顺序才能保持一致。出于性能原因，不能保证插入顺序不被保留。

### 自动更新结果集

`Results`实例是活动的，自动更新到底层数据的视图，这意味着结果不必重新获取。修改影响查询的对象将立即反映在结果中。

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

您可以订阅通知，以了解何时更新Realm数据，指出何时应该刷新应用的UI，而无需重新获取Results。

### 限制结果集

大多数其他数据库技术提供了对查询结果进行“分页”的能力（例如SQLite中的“LIMIT”关键字）。这通常是为了避免从磁盘读取太多或者一次将太多结果拖到内存中而完成的。

由于Realm中的查询是懒惰的，所以执行这种分页行为根本不是必需的，因为只有在明确访问该域后，域才会从查询结果中加载对象。

如果由于与UI相关或其他实现原因，您需要查询中的特定对象子集，那么只需要使用`Results`对象，并只读出所需的对象。

```
let cars = realm.objects('Car');

// get first 5 Car objects
let firstCars = cars.slice(0, 5);
```

## Realms

**Realm**是Realm移动数据库容器的实例。Realm可以是本地的或同步的。同步Realm使用Realm对象服务器将其内容与其他设备透明地[同步](https://realm.io/docs/javascript/latest/#opening-a-synchronized-realm)。当您的应用程序继续使用同步的Realm，就像它是本地文件一样，该Realm中的数据可能会被具有该Realm的写入权限的任何设备更新。实际上，您的应用程序可以以任何类型的Realm以同样的方式运行，尽管打开一个同步的Realm需要一个已经被对象服务器认证的[用户](https://realm.io/docs/javascript/latest/#users)，并被[授权](https://realm.io/docs/javascript/latest/#authentication)打开该Realm。

有关Realm的更详细的讨论，请阅读[Realm数据模型](https://realm.io/docs/data-model)。

### 打开Realm

打开Realm只是通过实例化一个新的Realm对象来执行。将配置对象传递给构造函数。我们已经看到这个已经在示例中使用了包含`schema`键的配置对象：

```
// Get the default Realm with support for our objects
let realm = new Realm({schema: [Car, Person]});
```

有关配置对象的完整详细信息，请参阅API参考以进行[配置](https://realm.io/docs/javascript/latest/api/Realm.html#~Configuration)。对象的一些更常见的键，除了`schema`，包括：

- `path`: 指定[另一个Realm](https://realm.io/docs/javascript/latest/#other-realms)的路径
- `migration`: [迁移功能](https://realm.io/docs/javascript/latest/#migrations)
- `sync`: [同步对象](https://realm.io/docs/javascript/latest/#sync), ，打开与Realm对象服务器同步的Realm

### 默认Realm

在以前的所有例子中可能已经注意到路径参数已被省略。在这种情况下，使用默认的Realm路径。您可以使用`Realm.defaultPath`全局属性访问和更改默认的Realm路径。

### 其它Realm

有多个Realm在多个位置持久化是有用的。例如，除了您的主Realm外，您还可能希望将一些数据与您的应用程序捆绑在Realm文件中。您可以通过在初始化Realm时指定路径参数来执行此操作。所有路径都相对于您的应用程序的可写入文档目录：

```
// Open a realm at another path
let realmAtAnotherPath = new Realm({
  path: 'anotherRealm.realm',
  schema: [CarSchema]
});
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

// schemaVersion默认是0
let realm = new Realm({schema: [PersonSchema]});

const UpdatedPersonSchema = {
  // 因为schema名称相同, 所以以前的“Person”对象在Realm将会更新
  name: 'Person',
  properties: {
    name: 'string',
    dog:  'Dog'     // 新属性
  }
};

// 这将抛出异常，因为schema已经改变和`schemaVersion`未指定
let realm = new Realm({schema: [UpdatedPersonSchema]});

// 这将成功并将Realm更新到新的schema
let realm = new Realm({schema: [UpdatedPersonSchema], schemaVersion: 1});
```

如果您想要检索当前的Realmschema版本，可以使用`Realm.schemaVersion`方法。

```
let currentVersion = Realm.schemaVersion(Realm.defaultPath);
```

### 异步打开Realm

如果打开Realm可能需要耗时的操作，例如应用[迁移](https://realm.io/docs/javascript/latest/#migrations)或下载[同步Realm](https://realm.io/docs/javascript/latest/#sync)的远程内容，则应该使用`openAsync API`执行所有需要的工作，以使Realm在后台线程上处于可用状态调度到给定的队列。您还应该使用`openAsync`设置只读的Realm。

例如:

```
Realm.openAsync({
  schema: [PersonSchema],
  schemaVersion: 42,
  migration: function(oldRealm, newRealm) {
    // 执行迁移（请参阅文档中的“迁移”）
  }
}, (error, realm) => {
  if (error) {
    return;
  }
  // 用openAsync返回的Realm对象做回调
  console.log(realm);
})
```

`openAsync`命令将配置对象作为其第一个参数，回调作为第二个参数;回调函数接收布尔错误标志和已打开的Realm实例。

### 初始下载

在某些情况下，您可能不想在所有远程数据可用之前打开领域。在这种情况下，请使用`openAsync`。当与同步Realm一起使用时，这将在调用回调之前下载所有的Realm内容。

```
var carRealm;
Realm.openAsync({
  schema: [CarSchema],
  sync: {
    user: user,
    url: 'realm://object-server-url:9080/~/cars'
  }
}, (error, realm) => {
  if (error) {
    return;
  }
  // Realm现已下载并可以使用
  carRealm = realm;
});
```

## 迁移

在数据库工作时，您的数据模型将很可能随时间而变化。

例如，假设我们有以下Person模型：

```
var PersonSchema = {
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
var PersonSchema = {
  name: 'Person',
  properties: {
    name: 'string',
    age: 'int'
  }
}
```

在这一点上，如果您使用以前的model版本保存了任何数据，新的代码和Realm已存储在磁盘上的旧数据将不匹配。发生这种情况时，当您尝试使用新的schema打开现有的Realm时，将抛出异常，除非运行迁移。

### 进行迁移

您可以通过更新[schemaVersion](https://realm.io/docs/javascript/latest/#schema-version)并定义可选的迁移函数来定义迁移和关联的schema版本。您的迁移函数提供将数据模型从以前的schema转换为新的schema所需的任何逻辑。当打开Realm时，只有在需要迁移时，才会将迁移函数应用于将Realm更新到给定的schema版本。

如果没有提供迁移函数，则当更新到新的`schemaVersion`时，任何新的属性将自动添加并且旧的属性从数据库中删除。如果您需要在升级版本时更新旧的或填充的新属性，那么可以在迁移函数中执行此操作。例如，假设我们要迁移先前声明的`Person`模型。您可以使用旧的`firstName`和`lastName`属性填充新模式的`name`属性：

```
var realm = new Realm({
  schema: [PersonSchema],
  schemaVersion: 1,
  migration: function(oldRealm, newRealm) {
    // only apply this change if upgrading to schemaVersion 1
    if (oldRealm.schemaVersion < 1) {
      var oldObjects = oldRealm.objects('Person');
      var newObjects = newRealm.objects('Person');

      // loop through all objects and set the name property in the new schema
      for (var i = 0; i < oldObjects.length; i++) {
        newObjects[i].name = oldObjects[i].firstName + ' ' + oldObjects[i].lastName;
      }
    }
  }
});

var fullName = realm.objects('Person')[0].name;
```

迁移成功完成后，您的应用程序可以像往常一样访问Realm及其所有对象。

### 线性迁移

使用上述迁移模式，您可能会在多个版本上迁移时遇到问题。如果用户跳过应用程序更新，并且在跳过的版本中属性已被更改多次，则可能会发生这种情况。在这种情况下，您可能需要编辑旧的迁移代码才能将数据从旧schema更新到最新schema。

可以通过顺序运行多个迁移来避免此问题，确保将数据库升级到每个先前版本，并运行关联的迁移代码。当遵循这种模式时，永远不需要修改旧的迁移代码，尽管您需要保留所有旧的schema和迁移模块以备将来使用。一个这样的例子：

```
var schemas = [
  { schema: schema1, schemaVersion: 1, migration: migrationFunction1 },
  { schema: schema2, schemaVersion: 2, migration: migrationFunction2 },
  ...
]

// 要更新的第一个schema是当前schema版本。
// 因为第一个schema是在我们的数组里
var nextSchemaIndex = Realm.schemaVersion(Realm.defaultPath);
while (nextSchemaIndex < schemas.length) {
  var migratedRealm = new Realm(schemas[nextSchemaIndex++]);
  migratedRealm.close();
}

// 用最新的schema打开Realm
var realm = new Realm(schemas[schemas.length-1]);
```

## 通知

Realm的 `Results`和 `List` 对象提供了`addListener`方法来注册通知回调。每当更新对象时，将调用更改通知回调。

有两种通知，“Realm通知”（提交写入事务时通知的简单回调）和“Collection通知”（更复杂的回调，它们在插入，删除和更新时接收更改元数据）。

此外，专业版和企业版提供事件处理通知。阅读“Realm移动平台”了解更多信息。

### Realm 通知

每次提交写入事务时，领域实例都会向其他实例发送通知。注册通知：

```
// 注册 Realm 通知
realm.addListener('change', () => {
  // Update UI
  ...
});

// 移除所有注册过的通知
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

## 同步

Realm移动平台（RMP）通过网络扩展了Realm移动数据库，实现了跨设备的数据自动同步。为了做到这一点，提供了一组支持这些同步Realm的类型和类;这些新类别与现有的Realm Mobile数据库相加。

### 用户

Realm对象服务器中的中心对象是与同步Realm相关联的Realm用户（Realm.Sync.User）。`User`可以通过用户名/密码方案或通过多种第三方身份验证方法对共享的Realm进行身份验证。

创建和登录用户需要两件事情：

- 要连接到的Realm对象服务器的URL。
- 用于认证机制的证书，该认证机制根据该机制描述用户（即，用户名/密码，访问密钥等）。

#### 认证

认证用于建立用户的身份并登录。请参阅我们的[身份验证文档](https://realm.io/docs/realm-object-server/#authentication)，了解Realm Mobile Platform支持的认证提供者列表。

可以通过以下几种方式之一创建给定用户的凭据信息：

- 提供有效的用户名/密码组合
- 提供从受支持的第三方身份验证服务获取的令牌
- 提供令牌和自定义验证提供程序（[请参阅自定义验证](https://realm.io/docs/realm-object-server/#custom-authentication)）

用户名和密码认证完全由Realm对象服务器管理，可以完全控制应用程序的用户管理。

对于其他身份验证方法，您的应用程序负责登录外部服务并获取身份验证令牌。

以下是与各种提供程序设置凭据的一些示例。

##### 用户名/密码

```
Realm.Sync.User.login('http://my.realm-auth-server.com:9080', 'username', 'p@s$w0rd', (error, user) => { /* ... */ });
```

在用户登录之前，必须创建该帐户。您可以使用管理控制台在服务器上提前执行此操作，也可以通过调用`register`方法：

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

##### 自定义认证

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

注意：JavaScript SDK当前不允许您发送其他数据。如果您需要发送多个单个令牌，请将附加数据编码为JSON，并通过accessToken参数传递，并对服务器端的此字符串进行解码。

##### 注销

注销同步的Realm很简单：

```
user.logout();
```

当用户注销时，同步将停止。退出的用户将无法再打开同步的Realm。

#### Working with Users

同步服务器URL可以包含波形符号（“〜”），它将被透明地扩展以表示用户的唯一标识符。这个方案很容易让您编写应用程序以满足其个人用户需求。磁盘上共享realm的位置由框架管理，但如果需要可以覆盖。

```
Realm.Sync.User.login(/* ... */, (error, user) => {
  if (!error) {
    var realm = new Realm({
      sync: {
        user: user,
        url: 'realm://object-server-url:9080/~/my-realm',
      },
      schema: [/* ... */]
    });

    realm.write(() => { 
      /* ... */
    })
  }
})
```

`Realm.Sync.User.current`可用于获取当前登录的用户。如果没有用户登录或全部已经注销，它将返回 `undefined`。如果有多个登录用户，将会抛出一个错误。

```
let user = Realm.Sync.User.current;
```

如果可能有多个用户登录，您可以通过调用`Realm.Sync.User.all`获取它们的一个集合。如果没有用户登录，这将是空的。

```
let users = Realm.Sync.User.all;

for(const key in users) {
  const user = users[key];

  // do something with the user.  
})
```

### 打开同步Realm

一旦您使用一个Realm对象服务器的URL和一个用户对象打开Realm，您可以像JavaScript中的其他Realm一样进行交互。

```
realm.write(() => {
  realm.create('MyObject', jsonData);
});

var objects = realm.object('MyObject');
```

如果Realm具有只读权限，那么您必须按照异步打开Realm的描述使用`openAsync`。在没有`openAsync`的情况下打开只读领域会导致错误。

### 同步会话

同步的Realm与Realm对象服务器的连接由`Session`对象表示。可以通过调用`realm.syncSession`来检索会话对象。

可以使用`state`属性检索基础会话的状态。这可以用于检查会话是活动的，未连接到服务器还是处于错误状态。

### 访问控制

Realm移动平台提供灵活的访问控制机制，以限制哪些用户与哪些Realm文件同步。例如，这可以用于创建多个用户写入同一个Realm的协作应用程序。它也可以用于在发布者/订阅者场景中共享数据，其中单个写入用户与具有读取权限的许多用户共享数据。

有三个权限可以控制用户给定Realm的访问级别：

- `mayRead` 示允许用户从Realm读取。
- `mayWrite` 表示允许用户写入Realm。
- `mayManage` 表示允许用户更改Realm的权限。

除非明确修改权限，否则只有领域的所有者（创建者）可以访问它。唯一的例外是管理员用户：他们总是授予服务器上所有Realm的所有权限。

**Write-only** permissions (i.e., `mayWrite` set without `mayRead`) are not currently supported.

当前不支持只写权限（即，`mayWrite`没有`mayRead`的设置）。

请参阅[访问控制](https://realm.io/docs/realm-object-server/#access-control)的通用`Realm Object Server`文档，以了解有关概念的更多信息。

#### 管理 Realm

所有访问级管理操作都是通过写入管理realm来执行的。管理realm就像一个常规的同步realm，但是Realm对象服务器是专门针对默认情况而设计的。[权限修改](https://realm.io/docs/javascript/latest/#modifying-permissions)对象可以添加到realm，以将这些更改应用于Realm文件的访问控制设置。

要获取给定用户的管理realm，请调用其`user.openManagementRealm()`方法：

```
const managementRealm = user.openManagementRealm();
```

#### 修改权限

通过向管理Realm添加权限对象实例来修改Realm文件的访问控制设置。目前，支持两个工作流程：

##### PermissionChange

`PermissionChange`对象允许您直接控制Realm的访问控制设置。当您已经知道要向其授予权限的用户的Ids或希望向每个人授予权限时，这是非常有用的。

```
managementRealm.write(() => {
  managementRealm.create('PermissionChange', {
    id: generateUniqueId(),   // 实现创建唯一ID的内容。
    createdAt: new Date(),
    updatedAt: new Date(),
    userId: '...',
    realmUrl: '...',
  });
});
```

要应用用户管理的所有Realm的权限更改，请指定一个`realmURL`值*。

要对使用对象服务器授权的所有用户应用权限更改，请指定`userId`值*。

如果您不提供`mayRead`，`mayWrite`或`mayManage`的值，或者提供`null`，`read`，`write`或`manage`权限将保持不变。这可能是有用的，例如，如果您要授予用户读取权限，但不想从已拥有该权限的用户取走写入权限：

```
managementRealm.write(() => {
  for(const userId in users) {
    managementRealm.create('PermissionChange', {
      id: generateUniqueId(),
      createdAt: new Date(),
      updatedAt: new Date(),
      userId: userId,
      realmUrl: realmUrl,
      mayRead: true
    });
  });
});
```

这样，列表中的所有用户将被授予读取权限，但是具有 `write` 和 `manage` 访问权限的用户将不会丢失它。

##### PermissionOffer/PermissionResponse

`PermissionOffer`和`PermissionOfferResponse`对类允许您设计共享方案，其中，邀请者生成令牌，然后可以由一个或多个用户使用令牌：

```
managementRealm.write(() => {
  let expirationDate = new Date();
  expirationDate.setDate(expirationDate.getDate() + 7); // 一周内过期

  managementRealm.create('PermissionOffer', {
    id: generateUniqueId(),
    createdAt: new Date(),
    updatedAt: new Date(),
    userId: userId,
    realmUrl: realmUrl,
    mayRead: true,
    mayWrite: true,
    mayManage: false,
    expiresAt: expirationDate
  });
});

/* 等待报价处理 */
var token = permissionOffer.token;
/* 将令牌发送给其他用户 */
```

与`PermissionChange`类似，在提供的`realmUrl`中有一些参数控制Realm的读取，写入和管理访问。您可以提供的另外一个参数是`expiresAt`，它控制令牌何时不再是可消耗的。如果您不传递值或通过null，则该报价永远不会过期。请注意，使用该优惠的用户在过期后不会失去访问权限。

一旦用户获得了令牌，他们就可以使用它：

```
const managementRealm = anotherUser.openManagementRealm();
let offerResponse;

managementRealm.write(() =>
{
    offerResponse = managementRealm.create('PermissionOfferResponse', {
      id: generateUniqueId(),
      createdAt: new Date(),
      token: token
    });
});

/* Wait for the offer to be processed */

const realmUrl = offerResponse.realmUrl;

// Now we can open the shared realm:

var realm = new Realm({
  sync: {
    user: anotherUser,
    url: realmUrl,
  },
  schema: [/* ... */]
});
```

请注意，通过使用`PermissionOffer`授予的权限是相加的，即如果用户已经具有`write`权限并且接受授予`read`权限的`PermissionOffer`，则它们不会丢失其`write`权限。

`PermissionOffers`可以通过从管理域中删除或将过期设置为`expiresAt`日期来撤销。这将阻止新用户接受该优惠，但不会在之前消费的用户撤销任何权限。

一旦对象服务器处理了在权限对象中编码的操作，它将设置该对象的`statusCode`和`statusMessage`属性。

## React Native ListView

如果要使用`List`或`Results`实例作为`ListView`的数据，强烈建议您使用由 `realm/react-native` 模块提供的`ListView`和`ListView.DataSource`：

```
import { ListView } from 'realm/react-native';
```

API与`React.ListView`完全相同，因此您可以参考`ListView`[文档](https://facebook.github.io/react-native/docs/listview.html)获取使用信息。

## 加密

请注意我们的许可证的出口合规部分，因为如果您位于美国出口限制或禁运的国家/地区，则会对其使用限制。

Realm支持使用`AES-256+SHA2`通过在创建Realm时提供64字节的加密密钥来加密磁盘上的数据库文件。

```
var key = new Int8Array(64);  // pupulate with a secure key
var realm = new Realm({schema: [CarObject], encryptionKey: key});

// Use the Realm as normal
var dogs = realm.objects('Car');
```

这使得所有存储在磁盘上的数据都可以根据需要使用`AES-256`进行透明加密和解密，并通过`SHA-2 HMAC`进行验证。必须在每次获得Realm实例时提供相同的加密密钥。

使用加密的Realms时，性能下降很小（通常低于10％）。

## 故障排除

### Missing Realm Constructor

如果您的应用程序崩溃，告诉您Realm构造函数未找到，您可以尝试几件事情：

首先，运行 `react-native link realm`

如果没有帮助，并且您的问题在Android上，请尝试:

在`MainApplication.java`文件中添加以下内容：`java import io.realm.react.RealmReactPackage`;

并将`RealmReactPackage`添加到软件包列表中：

```
protected List getPackages() {
    return Arrays.asList(
        new MainReactPackage(),
        new RealmReactPackage() // add this line
    );
}
```

在`settings.gradle`中添加以下两行：

```
include ':realm'
project(':realm').projectDir = new File(settingsDir, '../node_modules/realm/android')
```

如果您的问题在iOS上，请尝试：1.关闭所有模拟器/设备构建2.停止在终端中运行的软件包管理器（或更好的是，只需重新启动终端）3.在finder 4中打开应用程序根目录中的ios文件夹。Go进入构建文件夹（注意：你不会看到这个构建文件夹在原子，所以只需右键单击ios并单击打开查找器）5.删除构建文件夹内的所有内容（只是移动到垃圾桶，并保持垃圾，以防万一'担心）6.运行反应本机运行以重建整个事情

### 崩溃报告

我们建议您在应用程序中使用崩溃记录。许多Realm的操作可能会在运行时失败（像任何其他磁盘IO），因此从应用程序收集崩溃报告将有助于识别您（或我们）可以改进错误处理和修复崩溃错误的区域。

大多数商业崩溃记录者可以选择收集日志。我们强烈建议您启用此功能。Realm在抛出异常和不可恢复的情况下记录元数据信息（但不包含用户数据），并且这些消息可以帮助在出现问题时进行调试。

### 提交Realm问题

如果您发现了Realm的问题，请[在GitHub上提出问题](https://github.com/realm/realm-js/issues/new)，或者发送电子邮件至help@realm.io，尽可能多地了解和重现您的问题。

以下信息对我们非常有用：

1. Bug名称.
2. 预期结果.
3. 实际结果.
4. 重现步骤.
5. 强调问题的代码示例（我们可以自己编译的全部工作项目是比较理想的）.
6. Realm版本.
7. 崩溃日志 & 堆栈信息.有关详细信息，请参阅上述[崩溃报告](https://realm.io/docs/javascript/latest/#crash-reporting).