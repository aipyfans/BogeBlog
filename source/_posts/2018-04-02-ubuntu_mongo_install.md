---
layout: post
title:  "在Ubuntu上安装MongoDB社区版"
date:   2018-04-02 15:21:47
categories: CST
tags:
  - Software
  - Server
---

## 概览

使用本教程在使用`.deb`软件包的LTS Ubuntu Linux 系统上安装MongoDB社区版。

> **重要的**
>
> 由Ubuntu提供的非官方`mongodb`包不是由MongoDB维护的。您应该始终使用官方的MongoDB `mongodb-org`软件包，它们随时与最新的MongoDB的主版本和次要版本保持同步。



> **支持平台**
>
> MongoDB仅提供64位 LTS(长期支持) Ubuntu 发行版的软件包。
>
> 例如，12.04 LTS (precise)，14.04 LTS (trusty)，16.04 LTS (xenial)等等。
>
> 这些软件包可能与其他Ubuntu发行版一起使用，但是，它们不受支持。
>
> MongoDB 3.6 放弃了对 Ubuntu 12.04 LTS (precise) 的支持。



> **在IBM电脑系统上，Ubuntu 16.04需要更新软件包**
>
> 由于Ubuntu 16.04的旧版`glibc`软件包存在锁定漏洞问题，因此在运行MongoDB之前，必须将`glibc`软件包升级至`glibc 2.23-0ubuntu5`。
>
> 具有旧版本`glibc`软件包的系统将由于随机内存损坏而遇到数据库服务器崩溃和不正常行为，并且不适合MongoDB的生产部署

## 包

MongoDB在他们自己的仓库中提供官方支持的软件包。此库包含以下软件包：

| 包名                 | 描述                                                         |
| -------------------- | ------------------------------------------------------------ |
| `mongodb-org`        | 一个元数据包，将自动安装下面列出的四个组件包。               |
| `mongodb-org-server` | 包含`mongod`守护进程和相关的配置以及init脚本。               |
| `mongodb-org-mongos` | 包含`mongos`守护进程。                                       |
| `mongodb-org-shell`  | 包含`mongo` shell。                                          |
| `mongodb-org-tools`  | 包含以下MongoDB工具: [`mongoimport`](https://docs.mongodb.com/master/reference/program/mongoimport/#bin.mongoimport) [`bsondump`](https://docs.mongodb.com/master/reference/program/bsondump/#bin.bsondump), [`mongodump`](https://docs.mongodb.com/master/reference/program/mongodump/#bin.mongodump), [`mongoexport`](https://docs.mongodb.com/master/reference/program/mongoexport/#bin.mongoexport), [`mongofiles`](https://docs.mongodb.com/master/reference/program/mongofiles/#bin.mongofiles), [`mongoperf`](https://docs.mongodb.com/master/reference/program/mongoperf/#bin.mongoperf), [`mongorestore`](https://docs.mongodb.com/master/reference/program/mongorestore/#bin.mongorestore), [`mongostat`](https://docs.mongodb.com/master/reference/program/mongostat/#bin.mongostat), 和 [`mongotop`](https://docs.mongodb.com/master/reference/program/mongotop/#bin.mongotop). |

`mongodb-org-server`软件包提供了一个初始化脚本，它使用`/etc/mongod.conf`配置文件启动`mongod`。

有关使用此初始化脚本的详细信息，请参阅[运行MongoDB社区版](https://docs.mongodb.com/master/tutorial/install-mongodb-on-ubuntu/#run-mongodb-community-edition) 。

这些软件包与Ubuntu提供的`mongodb`，`mongodb-server`和`mongodb-clients`软件包相冲突。

默认情况下，软件包提供的默认`/etc/mongod.conf`配置文件的`bind_ip`设置为127.0.0.1。在[初始化副本集](https://docs.mongodb.com/master/reference/glossary/#term-replica-set)之前根据您的环境需要修改此设置。

## 安装 MongoDB 社区版

> 注意
>
> 要安装不同版本的MongoDB，请参阅该版本的文档。例如，参见[3.4](https://docs.mongodb.com/v3.4/tutorial/install-mongodb-on-ubuntu/)版。

### 1. 导入包管理系统使用的公钥.

Ubuntu软件包管理工具（即`dpkg`和`apt`）通过要求分销商使用`gpg`密钥对软件包进行签名来确保软件包的一致性和真实性。发出以下命令来导入[MongoDB 公共 GPG 密钥](https://www.mongodb.org/static/pgp/server-3.6.asc)：

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
```

### 2. 为MongoDB创建软件源list文件.

使用适合您的Ubuntu版本的命令创建`/etc/apt/sources.list.d/mongodb-org-3.6.list`软件源list文件：

- Ubuntu 12.04 (deprecated)

  ```
  echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu precise/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
  ```

- Ubuntu 14.04

  ```
  echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
  ```

- Ubuntu 16.04

  ```
  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
  ```

### 3. 重新加载本地包数据库.

发出以下命令以重新加载本地包数据库

```
sudo apt-get update
```

### 4. 安装 MongoDB 包.

#### 安装最新的稳定版本的MongoDB.

发出以下命令:

```
sudo apt-get install -y mongodb-org
```

#### 安装指定版本的MongoDB.

要安装特定版本，必须单独指定每个组件包以及版本号，如下例所示：

```
sudo apt-get install -y mongodb-org=3.6.3 mongodb-org-server=3.6.3 mongodb-org-shell=3.6.3 mongodb-org-mongos=3.6.3 mongodb-org-tools=3.6.3
```

如果您只安装`mongodb-org = 3.6.3`并且不包含组件软件包，则无论您指定了哪个版本，都会安装每个`mongodb`软件包的最新版本。

#### 固定一个特定版本的MongoDB.

尽管您可以指定任何可用的MongoDB版本，但`apt-get`会在新版本可用时升级软件包。以防止意外升级，固定包装。要在当前安装的版本上固定MongoDB的版本，请发出以下命令序列：

```
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections
```

## 运行 MongoDB 社区版

大多数类Unix操作系统会限制会话可能使用的系统资源。这些限制可能会对MongoDB操作产生负面影响。有关更多信息，请参阅 [UNIX ulimit](https://docs.mongodb.com/master/reference/ulimit/) 设置。

MongoDB实例默认将其数据文件存储在 `/var/lib/mongodb` 及其日志文件 `/var/log/mongodb`中，并使用`mongodb`用户帐户运行。您可以在`/etc/mongod.conf`中指定备用日志和数据文件目录。有关其他信息，请参阅 [`systemLog.path`](https://docs.mongodb.com/master/reference/configuration-options/#systemLog.path) 和 [`storage.dbPath`](https://docs.mongodb.com/master/reference/configuration-options/#storage.dbPath) 。

如果更改运行MongoDB进程的用户，则必须修改`/var/lib/mongodb` 和 `/var/log/mongodb` 目录的访问控制权限，以使该用户可以访问这些目录。

### 1. 启动 MongoDB.

发出以下命令:

```
sudo service mongod start
```

### 2. 验证MongoDB已成功启动

通过在`/var/log/mongodb/mongod.log`中检查日志文件的内容以确认`mongod`进程已成功启动。

```
[initandlisten] waiting for connections on port 27017
```

`<port>`是 [`mongod`](https://docs.mongodb.com/master/reference/program/mongod/#bin.mongod) 侦听的端口。如果您修改了`/etc/mongod.conf`配置文件中的 [`net.port`](https://docs.mongodb.com/master/reference/configuration-options/#net.port) 设置，则端口可能会有所不同。

如果您修改了 [`systemLog.path`](https://docs.mongodb.com/master/reference/configuration-options/#systemLog.path) 配置文件选项，请在您为该设置指定的位置查找日志文件。

您可能会在 [`mongod`](https://docs.mongodb.com/master/reference/program/mongod/#bin.mongod) 输出中看到非严重警告。只要您看到上面显示的日志行，就可以在您对MongoDB进行初始评估期间安全地忽略这些警告。

### 3. 停止 MongoDB.

根据需要，您可以通过发出以下命令来停止 [`mongod`](https://docs.mongodb.com/master/reference/program/mongod/#bin.mongod) 进程：

```
sudo service mongod stop
```

### 4. 重新启动 MongoDB.

发出以下命令重新启动 [`mongod`](https://docs.mongodb.com/master/reference/program/mongod/#bin.mongod) :

```
sudo service mongod restart
```

### 5. 开始使用 MongoDB.

在与 [`mongod`](https://docs.mongodb.com/master/reference/program/mongod/#bin.mongod) 相同的主机上启动一个 [`mongo`](https://docs.mongodb.com/master/reference/program/mongo/#bin.mongo)  shell。使用 [`--host`](https://docs.mongodb.com/master/reference/program/mongo/#cmdoption-mongo-host) 命令行选项来指定 [`mongod`](https://docs.mongodb.com/master/reference/program/mongod/#bin.mongod) 侦听的本地主机地址和端口

```
mongo --host 127.0.0.1:27017
```

之后，要停止MongoDB，请在运行`mongod`实例的终端中按下**Control+C**。

## 卸载 MongoDB 社区版

要从系统中完全删除MongoDB，您必须自行删除MongoDB应用程序，配置文件以及包含数据和日志的任何目录。以下部分将指导您完成必要的步骤。

> **警告**
>
> 这个过程将完全删除MongoDB以及它的配置和所有数据库。此过程不可逆，因此请确保在继续之前备份所有配置和数据。

### 1. 停止 MongoDB 服务.

使用以下的命令停止mongod进程：

```
sudo service mongod stop
```

### 2. 移除软件包.

删除以前安装的任何MongoDB软件包。

```
sudo apt-get purge mongodb-org*
```

### 3. 删除数据目录.

删除MongoDB数据库和日志文件

```
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongodb
```

