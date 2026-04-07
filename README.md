# 教学资源管理系统

> 基于 RuoYi-Vue 深度定制的教学资源管理平台。本文档面向 **Windows 小白用户**，用于说明如何在一台全新的 Windows 电脑上完成环境安装、数据库导入、项目启动、构建打包与常见问题排查。

---

## 1. 仓库说明

- GitHub 仓库：<https://github.com/ins13014778/teaching-resource-management-system-backup-20260324>
- 技术栈：
  - 后端：Spring Boot + Maven 多模块
  - 前端：Vue 2 + Element UI
  - 数据库：MySQL 8
  - 缓存：Redis
- 默认数据库名：`ry-vue`
- 当前推荐导入 SQL：`sql/ry-vue.sql`

> 说明：本文中的“你的项目目录”请替换成你自己电脑上的实际路径，例如：
>
> - `D:\RuoYi-Vue-master`
> - `E:\project\RuoYi-Vue-master`
> - `C:\work\teaching-resource-management-system`

---

## 2. 部署后可访问地址

项目启动成功后，通常可以访问：

- 前端首页：<http://127.0.0.1/>
- 后端 Swagger：<http://127.0.0.1:8080/swagger-ui.html>
- 前端代理验证码接口：<http://127.0.0.1/dev-api/captchaImage>

---

## 3. 环境要求

建议安装以下软件：

- JDK 17
- Maven 3.9+
- Node.js 18.x
- npm（随 Node.js 自动安装）
- MySQL 8.0
- Redis

快速检查命令：

```bat
java -version
mvn -v
node -v
npm -v
mysql --version
redis-server --version
```

如果 `mysql` 没有加入环境变量，也可以这样检查：

```bat
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --version
```

---

## 4. Windows 小白部署教程

### 4.1 安装 JDK 17

建议下载 **Windows x64 的 JDK 17 安装包**（例如 Temurin 17 或 Microsoft OpenJDK 17）。

安装完成后配置环境变量：

- 系统变量新增：
  - `JAVA_HOME=C:\Program Files\Java\jdk-17`
- `Path` 新增：
  - `%JAVA_HOME%\bin`

验证：

```bat
java -version
javac -version
echo %JAVA_HOME%
```

---

### 4.2 安装 Maven 3.9+

Windows 请下载：

```text
apache-maven-3.9.x-bin.zip
```

> 不要选：
>
> - `tar.gz`
> - `src`
> - `sha512`
> - `asc`

解压后建议放到固定目录，例如：

```text
D:\DevTools\apache-maven-3.9.14
```

或者：

```text
C:\Program Files\Apache\maven
```

配置环境变量：

- 系统变量新增：
  - `MAVEN_HOME=你的 Maven 根目录`
- `Path` 新增：
  - `%MAVEN_HOME%\bin`

验证：

```bat
mvn -v
echo %MAVEN_HOME%
```

---

### 4.3 安装 Node.js 18

推荐版本：

- Node.js 18.x
- Windows x64
- Installer (.msi)

> 对这个项目，**Node 18 最稳**。
> 不建议优先使用过新的 Node 24。

安装时保持默认勾选即可，尤其不要取消：

- Install Node.js runtime
- Install npm package manager
- Add to PATH

验证：

```bat
node -v
npm -v
```

---

### 4.4 安装 MySQL 8

安装 MySQL 8 后，请记住你的 root 密码。

创建项目数据库：

```sql
CREATE DATABASE IF NOT EXISTS `ry-vue`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
```

---

### 4.5 导入项目数据库

本项目当前推荐导入文件：

```text
sql\ry-vue.sql
```

#### 方式一：使用命令行导入

先进入项目目录：

```bat
cd /d 你的项目目录
```

然后执行：

```bat
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --binary-mode=1 --default-character-set=utf8mb4 -h127.0.0.1 -P3306 -uroot -p ry-vue < sql\ry-vue.sql
```

执行后输入你的 MySQL root 密码即可。

#### 方式二：使用 Navicat 导入

1. 打开 Navicat
2. 连接你的 MySQL
3. 找到数据库 `ry-vue`
4. 右键 `ry-vue`
5. 选择“运行 SQL 文件”或“导入向导”
6. 选择：

```text
你的项目目录\sql\ry-vue.sql
```

7. 执行导入

导入后验证：

```bat
mysql -u root -p
```

```sql
SHOW DATABASES LIKE 'ry-vue';
USE `ry-vue`;
SHOW TABLES;
SELECT COUNT(*) FROM sys_user;
```

---

### 4.6 安装并启动 Redis

本项目后端依赖 Redis，默认地址：

```text
localhost:6379
```

如果你已经安装 Redis，可以尝试使用项目脚本启动：

```bat
cd /d 你的项目目录
bin\start-redis.bat
```

验证：

```bat
redis-cli ping
```

如果返回：

```text
PONG
```

说明 Redis 正常。

---

## 5. 快速开始（推荐顺序）

### 5.1 一键初始化 + 一键启动

```bat
cd /d 你的项目目录
bin\init-all.bat
```

### 5.2 只初始化数据库

```bat
cd /d 你的项目目录
bin\init-db.bat
```

### 5.3 一键启动全部服务

```bat
cd /d 你的项目目录
bin\start-all.bat
```

### 5.4 一键重启全部服务

```bat
cd /d 你的项目目录
bin\restart-all.bat
```

### 5.5 打包 clean release 包

```bat
cd /d 你的项目目录
bin\package-zip.bat
```

---

## 6. Bat 脚本位置说明

所有 Windows 脚本都在：

```text
你的项目目录\bin
```

常用脚本如下：

- `init-db.bat`：一键初始化数据库
- `init-all.bat`：一键导库 + 启动全部服务
- `start-all.bat`：一键启动全部服务
- `restart-all.bat`：一键重启全部服务
- `stop-all.bat`：停止全部服务
- `start-redis.bat`：启动 Redis
- `start-backend.bat`：启动后端
- `start-frontend.bat`：启动前端
- `restore-db.bat`：恢复数据库
- `package-zip.bat`：生成 clean release 包

---

## 7. 后端启动

### 7.1 运行测试

```bat
cd /d 你的项目目录
mvn -pl ruoyi-admin -am test
```

### 7.2 打包后端

```bat
cd /d 你的项目目录
mvn -pl ruoyi-admin -am -DskipTests package
```

生成文件：

```text
你的项目目录\ruoyi-admin\target\ruoyi-admin.jar
```

### 7.3 启动后端

推荐脚本：

```bat
cd /d 你的项目目录
bin\start-backend.bat
```

备用命令：

```bat
cd /d 你的项目目录
java -jar ruoyi-admin\target\ruoyi-admin.jar
```

成功后可访问：

- <http://127.0.0.1:8080/swagger-ui.html>

---

## 8. 前端启动

### 8.1 安装依赖

```bat
cd /d 你的项目目录\ruoyi-ui
npm install
```

如果下载慢，可以使用：

```bat
npm install --registry=https://registry.npmmirror.com
```

> 不建议直接用 `cnpm`，容易引起兼容问题。

### 8.2 启动前端

推荐脚本：

```bat
cd /d 你的项目目录
bin\start-frontend.bat
```

备用命令：

```bat
cd /d 你的项目目录\ruoyi-ui
npm run dev
```

### 8.3 构建前端

```bat
cd /d 你的项目目录\ruoyi-ui
npm run build:prod
```

生成目录：

```text
你的项目目录\ruoyi-ui\dist
```

---

## 9. 打包规则（clean 默认）

`bin\package-zip.bat` 默认只会生成 **clean release 包**，不会把这些本地运行产物打进去：

- `node_modules`
- `logs`
- `.git`
- `release`
- 其他运行缓存

也就是说，默认不会生成“把本地环境全都打包进去”的大包。

---

## 10. Navicat 导出数据库说明

如果你要备份当前项目数据库，请导出：

```text
ry-vue
```

不要导出这些系统库：

- `information_schema`
- `mysql`
- `performance_schema`
- `sys`

导出步骤：

1. 找到数据库 `ry-vue`
2. 右键
3. 选择“转储 SQL 文件” / “导出向导”
4. 导出为 `.sql`

建议命名：

```text
ry-vue.sql
```

---

## 11. 常见报错与解决办法

### 11.1 `java 不是内部或外部命令`

原因：JDK 没装好，或者 `JAVA_HOME` / `Path` 没配好。

检查：

```bat
echo %JAVA_HOME%
where java
```

---

### 11.2 `mvn 不是内部或外部命令`

原因：Maven 没配好。

检查：

```bat
echo %MAVEN_HOME%
where mvn
```

---

### 11.3 `npm 不是内部或外部命令`

原因：Node.js 没装好或没加入 `Path`。

检查：

```bat
where node
where npm
```

---

### 11.4 Redis 连接失败

可能报错：

```text
Unable to connect to Redis
Connection refused: localhost/127.0.0.1:6379
```

原因：Redis 没启动。

处理：

```bat
cd /d 你的项目目录
bin\start-redis.bat
```

---

### 11.5 数据库连接失败

常见原因：

- MySQL 没启动
- `ry-vue` 库没创建
- root 密码不对
- 本机数据库账号密码和配置文件不一致

请检查：

```text
ruoyi-admin\src\main\resources\application-druid.yml
```

重点看：

```yaml
url: jdbc:mysql://localhost:3306/ry-vue
username: root
password: 你的实际密码
```

---

### 11.6 前端页面打不开

常见原因：

- 前端没真正启动成功
- 80 端口被占用
- Node 版本太新
- 依赖没装好

处理：

```bat
cd /d 你的项目目录\ruoyi-ui
npm install
npm run dev
```

---

## 12. 推荐部署顺序

建议严格按下面顺序执行：

1. 安装 JDK 17
2. 安装 Maven 3.9+
3. 安装 Node.js 18
4. 安装 MySQL 8
5. 安装 Redis
6. 配置环境变量
7. 导入 `sql\ry-vue.sql`
8. 启动 Redis
9. 启动后端
10. 启动前端

---

## 13. 最终验证清单

全部部署完成后，请按下面顺序验证：

### 13.1 检查数据库

```sql
USE `ry-vue`;
SHOW TABLES;
SELECT COUNT(*) FROM sys_user;
```

### 13.2 检查 Redis

```bat
redis-cli ping
```

返回：

```text
PONG
```

### 13.3 检查后端

访问：

- <http://127.0.0.1:8080/swagger-ui.html>

### 13.4 检查前端

访问：

- <http://127.0.0.1/>

### 13.5 检查前后端联调

访问：

- <http://127.0.0.1/dev-api/captchaImage>

如果接口返回正常数据，说明前后端联调成功。

---

## 14. 常用命令速查

### 环境检查

```bat
java -version
mvn -v
node -v
npm -v
mysql --version
redis-server --version
```

### 初始化数据库

```bat
cd /d 你的项目目录
bin\init-db.bat
```

### 启动 Redis

```bat
cd /d 你的项目目录
bin\start-redis.bat
```

### 后端打包

```bat
cd /d 你的项目目录
mvn -pl ruoyi-admin -am -DskipTests package
```

### 启动后端

```bat
cd /d 你的项目目录
bin\start-backend.bat
```

### 安装前端依赖

```bat
cd /d 你的项目目录\ruoyi-ui
npm install
```

### 启动前端

```bat
cd /d 你的项目目录\ruoyi-ui
npm run dev
```

### 前端打包

```bat
cd /d 你的项目目录\ruoyi-ui
npm run build:prod
```

### 一键启动全部

```bat
cd /d 你的项目目录
bin\start-all.bat
```
