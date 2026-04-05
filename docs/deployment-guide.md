# 教学资源管理系统部署文档

适用项目：`D:\RuoYi-Vue-master`

---

## 1. 项目说明

本项目基于 **RuoYi-Vue** 深度定制，采用前后端分离架构：

- 前端：Vue 2 + Element UI
- 后端：Spring Boot + Maven 多模块
- 数据库：MySQL 8
- 缓存：Redis

关键目录：

- 项目根目录：`D:\RuoYi-Vue-master`
- 后端目录：`D:\RuoYi-Vue-master\ruoyi-admin`
- 前端目录：`D:\RuoYi-Vue-master\ruoyi-ui`
- 脚本目录：`D:\RuoYi-Vue-master\bin`
- 文档目录：`D:\RuoYi-Vue-master\docs`
- SQL/备份：`D:\RuoYi-Vue-master\sql`、`D:\RuoYi-Vue-master\backup`

---

## 2. 环境要求

建议安装：

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

如果 `mysql` 没加入环境变量，可以使用：

```bat
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --version
```

---

## 3. 当前项目默认配置

后端配置文件：`D:\RuoYi-Vue-master\ruoyi-admin\src\main\resources\application.yml`

默认值：

- 后端端口：`8080`
- Redis：`localhost:6379`
- 上传目录：`D:/ruoyi/uploadPath`
- 存储类型：`local`

数据库配置文件：`D:\RuoYi-Vue-master\ruoyi-admin\src\main\resources\application-druid.yml`

默认数据库连接：

- Host：`localhost`
- Port：`3306`
- Database：`ry-vue`
- Username：`root`
- Password：`czp123..`

> 如果你本机 MySQL 账号密码不同，请同步修改 `application-druid.yml`。

---

## 4. 数据库部署（导入到本地 MySQL）

### 4.1 检查并启动本机 MySQL

查看 MySQL 服务：

```powershell
Get-Service -Name MySQL80
```

如果没启动：

```powershell
Start-Service -Name MySQL80
```

如果你的服务名不是 `MySQL80`，先查找：

```powershell
Get-Service | Where-Object { $_.Name -match 'mysql|mysqld' -or $_.DisplayName -match 'MySQL' }
```

### 4.2 登录 MySQL 并创建数据库

```bat
mysql -u root -p
```

进入 MySQL 后执行：

```sql
CREATE DATABASE IF NOT EXISTS `ry-vue`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
SHOW DATABASES;
```

确认结果中存在：`ry-vue`

### 4.3 一键初始化数据库（推荐）

所有 bat 脚本都在：

`D:\RuoYi-Vue-master\bin`

一键初始化数据库：

```bat
cd /d D:\RuoYi-Vue-master
bin\init-db.bat
```

如需指定库名和 SQL：

```bat
cd /d D:\RuoYi-Vue-master
bin\init-db.bat ry-vue backup\2026-03-26\database\ry-vue-full-20260326.sql
```

这个脚本会自动完成：

1. 检查 `mysql.exe`
2. 检查并启动 MySQL 服务（如果存在）
3. 调用 `restore-db.bat` 导入数据库
4. 验证表是否存在
5. 验证 `sys_user` 是否可查询

本次已实际验证通过，结果为：

- `Database   : ry-vue`
- `Table count: 46`
- `sys_user rows: 10`

### 4.4 手动导入 SQL（备用）

导入全量备份：

```bat
cd /d D:\RuoYi-Vue-master
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --binary-mode=1 --default-character-set=utf8mb4 -h127.0.0.1 -P3306 -uroot -p ry-vue < backup\2026-03-26\database\ry-vue-full-20260326.sql
```

如果没有全量备份，也可以按脚本逐个导入：

```bat
cd /d D:\RuoYi-Vue-master
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h127.0.0.1 -P3306 -uroot -p ry-vue < sql\ry_20260320.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h127.0.0.1 -P3306 -uroot -p ry-vue < sql\quartz.sql
```

### 4.5 数据库测试命令（已验证）

进入 MySQL 手动检查：

```bat
mysql -u root -p
```

然后执行：

```sql
SHOW DATABASES LIKE 'ry-vue';
USE `ry-vue`;
SHOW TABLES;
SELECT COUNT(*) FROM sys_user;
```

本次实际验证结果：

- 数据库存在：`ry-vue`
- 当前表数量：`46`
- `sys_user` 行数：`10`

---

## 5. Redis 说明

后端依赖 Redis，默认地址：`localhost:6379`

推荐先启动 Redis：

```bat
cd /d D:\RuoYi-Vue-master
bin\start-redis.bat
```

如果 Redis 没有先启动，后端可能报错：

```text
Unable to connect to Redis
Connection refused: localhost/127.0.0.1:6379
```

推荐顺序：

```text
先 Redis，再后端，再前端
```

---

## 6. 后端部署

### 6.1 运行测试

```bat
cd /d D:\RuoYi-Vue-master
mvn -pl ruoyi-admin -am test
```

### 6.2 打包后端

```bat
cd /d D:\RuoYi-Vue-master
mvn -pl ruoyi-admin -am -DskipTests package
```

生成：

```text
D:\RuoYi-Vue-master\ruoyi-admin\target\ruoyi-admin.jar
```

### 6.3 启动后端

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

验证地址：

- `http://127.0.0.1:8080/swagger-ui.html`

本次已实际验证：返回 `200`

---

## 7. 前端部署

### 7.1 安装依赖

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm install
```

### 7.2 启动前端

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

### 7.3 构建前端

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm run build:prod
```

生成：

```text
D:\RuoYi-Vue-master\ruoyi-ui\dist
```

前端首页：

- `http://127.0.0.1/`

本次已实际验证：返回 `200`

### 7.4 前后端联调验证

前端代理接口：

- `http://127.0.0.1/dev-api/captchaImage`

本次已实际验证：返回 `200`

---

## 8. Bat 脚本位置说明

所有 bat 脚本都在：

`D:\RuoYi-Vue-master\bin`

当前常用脚本：

- `init-db.bat`：一键初始化数据库
- `init-all.bat`：一键导库 + 启动全部服务
- `start-all.bat`：一键启动全部服务
- `restart-all.bat`：一键重启全部服务
- `stop-all.bat`：停止全部服务
- `start-redis.bat`：启动 Redis
- `start-backend.bat`：启动后端
- `start-frontend.bat`：启动前端
- `restore-db.bat`：恢复数据库
- `package-zip.bat`：按顺序执行初始化，然后打 **clean release 包**

### 8.1 第一次部署推荐命令

```bat
cd /d D:\RuoYi-Vue-master
bin\init-all.bat
```

### 8.2 日常启动

```bat
cd /d D:\RuoYi-Vue-master
bin\start-all.bat
```

### 8.3 日常重启

```bat
cd /d D:\RuoYi-Vue-master
bin\restart-all.bat
```

### 8.4 停止全部服务

```bat
cd /d D:\RuoYi-Vue-master
bin\stop-all.bat
```

---

## 9. 打包说明

### 9.1 clean release 包

默认发布打包脚本：

```bat
cd /d D:\RuoYi-Vue-master
bin\package-zip.bat
```

它会按顺序执行：

1. `init-all.bat`
2. `stop-all.bat`
3. 后端打包
4. 前端构建
5. 组装发布目录
6. 压缩成 zip

默认只生成 **clean release 包**，不会打包这些本机环境产物：

- `node_modules`
- `logs`
- `.git`
- `release`
- 其他源码运行缓存

### 9.2 已验证的 clean 包

- 源码干净包：`C:\Users\Administrator\Desktop\RuoYi-Vue-master-source-clean-20260405-184119.zip`
- 发布干净包：`D:\RuoYi-Vue-master\release\teaching-resource-management-system-release-clean-20260405-185248.zip`

---

## 10. 默认访问地址

- 前端首页：`http://127.0.0.1/`
- 后台登录：`http://127.0.0.1/login`
- 教师登录：`http://127.0.0.1/teacher-login`
- 学生登录：`http://127.0.0.1/student-login`
- 学生注册：`http://127.0.0.1/register`
- 教师注册：`http://127.0.0.1/teacher-register`
- 后端 Swagger：`http://127.0.0.1:8080/swagger-ui.html`

---

## 11. 常见问题

### 11.1 MySQL 无法连接

优先检查：

- MySQL 服务是否启动
- 用户名密码是否正确
- `application-druid.yml` 是否已同步修改

### 11.2 后端启动失败

优先检查：

- MySQL 是否启动
- Redis 是否启动
- 上传目录 `D:/ruoyi/uploadPath` 是否可写

### 11.3 前端能打开但接口失败

优先检查：

- 后端是否已启动
- Redis 是否正常
- 前端代理 `/dev-api` 是否生效

---

## 12. 本次实际验证结论

本次已实际验证：

- 数据库导入成功
- Redis 启动成功
- 后端启动成功
- 前端启动成功
- 前后端联调成功
- `start-all.bat` / `restart-all.bat` 可用
- `init-db.bat` / `init-all.bat` 可用
- `package-zip.bat` 默认打 clean release 包