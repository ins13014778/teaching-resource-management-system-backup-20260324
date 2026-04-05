# 教学资源管理系统

> 基于 RuoYi-Vue 深度定制的教学资源管理平台。当前仓库已验证可在本机完成：数据库初始化、Redis 启动、后端启动、前端启动、前后端联调、clean 打包。

---

## 1. 仓库说明

当前项目目录：`D:\RuoYi-Vue-master`

GitHub 仓库：

[https://github.com/ins13014778/teaching-resource-management-system-backup-20260324](https://github.com/ins13014778/teaching-resource-management-system-backup-20260324)

仓库当前包含：

- 后端源码（Spring Boot + Maven 多模块）
- 前端源码（Vue 2 + Element UI）
- MySQL 备份 / SQL 脚本
- 本地部署脚本（bat）
- 部署文档

---

## 2. 已验证可访问地址

- 前端首页：`http://127.0.0.1/`
- 后端 Swagger：`http://127.0.0.1:8080/swagger-ui.html`
- 前端代理验证码接口：`http://127.0.0.1/dev-api/captchaImage`

---

## 3. 环境要求

建议安装以下软件：

- JDK 17 或 21
- Maven 3.9+
- Node.js 18+
- npm
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

如果 `mysql` 没有配置到环境变量，也可以使用：

```bat
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --version
```

---

## 4. 快速开始（已验证）

### 4.1 一键导库 + 一键启动

```bat
cd /d D:\RuoYi-Vue-master
bin\init-all.bat
```

### 4.2 只导数据库

```bat
cd /d D:\RuoYi-Vue-master
bin\init-db.bat
```

### 4.3 一键启动全部服务

```bat
cd /d D:\RuoYi-Vue-master
bin\start-all.bat
```

### 4.4 一键重启全部服务

```bat
cd /d D:\RuoYi-Vue-master
bin\restart-all.bat
```

### 4.5 打包 clean release 包

```bat
cd /d D:\RuoYi-Vue-master
bin\package-zip.bat
```

---

## 5. Bat 脚本位置说明

所有 bat 脚本都在下面这个目录：

`D:\RuoYi-Vue-master\bin`

当前常用脚本如下：

- `init-db.bat`：一键初始化数据库
- `init-all.bat`：一键导库 + 启动全部服务
- `start-all.bat`：一键启动全部服务
- `restart-all.bat`：一键重启全部服务
- `stop-all.bat`：停止全部服务
- `start-redis.bat`：启动 Redis
- `start-backend.bat`：启动后端
- `start-frontend.bat`：启动前端
- `restore-db.bat`：恢复数据库
- `package-zip.bat`：按顺序先初始化，再打 clean release 包

---

## 6. 数据库部署（本地 MySQL）

### 6.1 检查并启动本机 MySQL

查看 MySQL 服务：

```powershell
Get-Service -Name MySQL80
```

如果没有启动：

```powershell
Start-Service -Name MySQL80
```

如果你的服务名不是 `MySQL80`，可以先查找：

```powershell
Get-Service | Where-Object { $_.Name -match 'mysql|mysqld' -or $_.DisplayName -match 'MySQL' }
```

### 6.2 登录 MySQL 并创建数据库

```bat
mysql -u root -p
```

登录后执行：

```sql
CREATE DATABASE IF NOT EXISTS `ry-vue`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
SHOW DATABASES;
```

确认结果中存在：`ry-vue`

### 6.3 一键初始化数据库（推荐）

```bat
cd /d D:\RuoYi-Vue-master
bin\init-db.bat
```

如果你要指定数据库名和 SQL 文件：

```bat
cd /d D:\RuoYi-Vue-master
bin\init-db.bat ry-vue backup\2026-03-26\database\ry-vue-full-20260326.sql
```

本次已实际验证通过，结果为：

- `Database   : ry-vue`
- `Table count: 46`
- `sys_user rows: 10`

### 6.4 手动导入 SQL（备用）

```bat
cd /d D:\RuoYi-Vue-master
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --binary-mode=1 --default-character-set=utf8mb4 -h127.0.0.1 -P3306 -uroot -p ry-vue < backup\2026-03-26\database\ry-vue-full-20260326.sql
```

### 6.5 数据库测试命令（已验证）

进入 MySQL：

```bat
mysql -u root -p
```

执行：

```sql
SHOW DATABASES LIKE 'ry-vue';
USE `ry-vue`;
SHOW TABLES;
SELECT COUNT(*) FROM sys_user;
```

---

## 7. Redis 说明

后端依赖 Redis，默认地址：`localhost:6379`

建议先启动 Redis：

```bat
cd /d D:\RuoYi-Vue-master
bin\start-redis.bat
```

如果 Redis 没有启动，后端可能报：

```text
Unable to connect to Redis
Connection refused: localhost/127.0.0.1:6379
```

推荐顺序：

```text
先 Redis，再后端，再前端
```

---

## 8. 后端启动

### 8.1 运行测试

```bat
cd /d D:\RuoYi-Vue-master
mvn -pl ruoyi-admin -am test
```

### 8.2 打包后端

```bat
cd /d D:\RuoYi-Vue-master
mvn -pl ruoyi-admin -am -DskipTests package
```

生成：

```text
D:\RuoYi-Vue-master\ruoyi-admin\target\ruoyi-admin.jar
```

### 8.3 启动后端

推荐脚本：

```bat
cd /d D:\RuoYi-Vue-master
bin\start-backend.bat
```

备用直接命令：

```bat
cd /d D:\RuoYi-Vue-master
java -jar ruoyi-admin\target\ruoyi-admin.jar
```

本次已验证 Swagger 返回 `200`：

- `http://127.0.0.1:8080/swagger-ui.html`

---

## 9. 前端启动

### 9.1 安装依赖

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm install
```

### 9.2 启动前端

推荐脚本：

```bat
cd /d D:\RuoYi-Vue-master
bin\start-frontend.bat
```

备用直接命令：

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm run dev
```

### 9.3 构建前端

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm run build:prod
```

生成：

```text
D:\RuoYi-Vue-master\ruoyi-ui\dist
```

本次已验证：

- 前端首页 `http://127.0.0.1/` 返回 `200`
- 前端代理接口 `http://127.0.0.1/dev-api/captchaImage` 返回 `200`

---

## 10. 打包规则（clean 默认）

`bin\package-zip.bat` 默认只生成 **clean release 包**，不会把这些本机环境产物打进去：

- `node_modules`
- `logs`
- `.git`
- `release`
- 其他源码运行缓存

也就是说，后续默认不再生成“把环境一起打进去”的大包。

---

## 11. 部署文档

完整部署说明见：

- `docs/deployment-guide.md`
- `C:\Users\Administrator\Desktop\教学资源管理系统部署教程.md`

---

## 12. 当前验证结论

本仓库当前已经实际验证通过：

- 数据库初始化成功
- Redis 启动成功
- 后端启动成功
- 前端启动成功
- 前后端联调成功
- `start-all.bat` / `restart-all.bat` 可用
- `init-db.bat` / `init-all.bat` 可用
- `package-zip.bat` 默认打 clean 包
