# 教学资源管理系统

> 当前仓库是 **2026-03-24** 的完整项目备份，包含源代码、数据库备份、环境说明、恢复脚本与一键启动脚本。

## 1. 仓库与备份内容

- 项目根目录：`D:\RuoYi-Vue-master`
- GitHub 仓库：[teaching-resource-management-system-backup-20260324](https://github.com/ins13014778/teaching-resource-management-system-backup-20260324)
- 数据库全量备份：`backup/2026-03-24/database/ry-vue-full-20260324.sql`
- 表结构与行数汇总：`backup/2026-03-24/database/ry-vue-table-summary-20260324.tsv`
- 环境说明：`backup/2026-03-24/docs/full-backup-environment-20260324.md`
- 恢复与启动说明：`doc/数据库恢复与一键启动说明.md`
- 启动脚本目录：`bin/`

## 2. 环境要求

建议使用以下版本：

- Windows 10 / Windows 11
- JDK 21
- Maven 3.9+
- Node.js 22+
- npm 11+
- MySQL 8.0
- Redis 8.x
- Git

当前机器已验证路径：

- Java：`C:\Program Files\Microsoft\jdk-21.0.9.10-hotspot\bin\java.exe`
- Maven：`C:\Program Files\JetBrains\IntelliJ IDEA 2025.3.1.1\plugins\maven\lib\maven3\bin\mvn.cmd`
- MySQL：`C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe`
- Redis：`C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-server.exe`

## 3. 依赖安装与检查命令

### 3.1 Git

```bat
git --version
```

### 3.2 JDK 21

```bat
java -version
```

如需配置环境变量：

```text
JAVA_HOME=C:\Program Files\Microsoft\jdk-21.0.9.10-hotspot
Path=%JAVA_HOME%\bin
```

### 3.3 Maven

```bat
mvn -v
```

如未单独安装 Maven，可直接使用 IDEA 自带 Maven：

```text
C:\Program Files\JetBrains\IntelliJ IDEA 2025.3.1.1\plugins\maven\lib\maven3\bin\mvn.cmd
```

如需配置环境变量：

```text
MAVEN_HOME=C:\Program Files\Apache\maven
Path=%MAVEN_HOME%\bin
```

### 3.4 Node.js / npm

```bat
node -v
npm -v
```

### 3.5 MySQL

```bat
mysql --version
```

当前数据库连接信息：

```text
Host=127.0.0.1
Port=3306
Database=ry-vue
Username=root
Password=czp123..
```

### 3.6 Redis

```bat
"C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-server.exe" --version
```

建议把以下目录加入 `Path`：

```text
C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service
```

## 4. 环境变量与脚本配置

项目统一从 `bin/env.cmd` 读取本机路径与数据库信息。

```bat
bin\env.cmd
```

如果换电脑、换 Java / Maven / MySQL / Redis 路径，优先修改这个文件。

## 5. 数据库恢复

### 5.1 推荐方式：直接执行脚本

```bat
cd /d D:\RuoYi-Vue-master
bin\restore-db.bat
```

### 5.2 指定数据库名或 SQL 文件

```bat
cd /d D:\RuoYi-Vue-master
bin\restore-db.bat ry-vue backup\2026-03-24\database\ry-vue-full-20260324.sql
```

### 5.3 手动恢复（CMD 推荐）

```bat
cd /d D:\RuoYi-Vue-master
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --default-character-set=utf8mb4 --host=127.0.0.1 --user=root --password=czp123.. -e "CREATE DATABASE IF NOT EXISTS `ry-vue` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --binary-mode=1 --default-character-set=utf8mb4 --host=127.0.0.1 --user=root --password=czp123.. ry-vue < backup\2026-03-24\database\ry-vue-full-20260324.sql
```

### 5.4 PowerShell 注意事项

PowerShell 下不建议直接用 `<` 导入历史备份文件，因为不同编码文件容易出现乱码。

**最稳妥方式仍然是执行：**

```powershell
Set-Location 'D:\RuoYi-Vue-master'
cmd /c bin\restore-db.bat
```

## 6. 启动命令

### 6.1 一键启动

```bat
cd /d D:\RuoYi-Vue-master
bin\start-all.bat
```

### 6.2 分步启动

#### Redis

```bat
cd /d D:\RuoYi-Vue-master
bin\start-redis.bat
```

#### 后端

```bat
cd /d D:\RuoYi-Vue-master
bin\start-backend.bat
```

#### 前端

```bat
cd /d D:\RuoYi-Vue-master
bin\start-frontend.bat
```

### 6.3 停止当前项目相关进程

```bat
cd /d D:\RuoYi-Vue-master
bin\stop-all.bat
```

## 7. 默认访问地址

- 前端首页：[http://127.0.0.1/](http://127.0.0.1/)
- 后端接口：[http://127.0.0.1:8080/](http://127.0.0.1:8080/)
- Swagger 文档：[http://127.0.0.1:8080/swagger-ui.html](http://127.0.0.1:8080/swagger-ui.html)

## 8. 默认账号与入口

- 管理端登录：`/login`
- 教师端登录：`/teacher-login`
- 学生端登录：`/student-login`
- 教师端注册：`/teacher-register`
- 学生端注册：`/register`

管理员默认账号：

```text
账号：admin
密码：admin123
```

## 9. 常见避坑说明

1. **Redis 必须在安装目录中启动。**  
   当前 Redis 为 Cygwin 版，正确方式是进入 Redis 安装目录再执行：
   ```bat
   cd /d C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service
   redis-server.exe redis.conf
   ```

2. **`start-backend.bat` 会先检查 8080 是否被其它程序占用。**  
   如果 8080 不是当前项目的 `ruoyi-admin.jar` 占用，脚本会直接报错，不会误判为“已启动”。

3. **`stop-all.bat` 只停止当前项目相关的 Java / Node / Redis 监听进程。**  
   不再全局强杀本机所有 `java.exe`、`node.exe`、`redis-server.exe`。

4. **前端默认占用 80 端口。**  
   如果被其他程序占用，请先释放端口，或修改 `ruoyi-ui/vue.config.js` 中的端口配置。

5. **数据库乱码优先检查文件编码。**  
   现在仓库中的脚本与核心 SQL 已统一修正为 UTF-8；如果你自己新增 SQL，请保持 `utf8mb4`。

6. **当前数据库已去除默认若依官网菜单，并修正了教学菜单重复路由名。**  
   恢复数据库后不会再出现 `Config` / `Notice` 路由重复告警，也不会再跳出 `ruoyi.vip` 外链。

## 10. 备份建议

如需再次做全量备份，建议至少同步以下内容：

- 项目源代码
- `backup/2026-03-24/database/ry-vue-full-20260324.sql`
- `backup/2026-03-24/database/ry-vue-table-summary-20260324.tsv`
- `bin/env.cmd`
- `doc/数据库恢复与一键启动说明.md`

---

如果还要继续扩展功能，可直接在当前仓库基础上开发。
