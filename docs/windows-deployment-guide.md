# Windows 部署使用说明

## 1. 目标

本文档用于在 Windows 10 / Windows 11 上从零部署当前教学资源管理系统，包含：

- 运行环境安装
- 环境变量配置
- 数据库恢复
- 前后端依赖安装
- 项目启动与验证
- API 访问地址说明
- 常见问题排查

## 2. 项目与仓库信息

- 项目目录：`D:\RuoYi-Vue-master`
- GitHub 仓库：`https://github.com/ins13014778/teaching-resource-management-system-backup-20260324.git`
- 最新数据库全量备份：`backup/2026-03-26/database/ry-vue-full-20260326.sql`

## 3. 必装软件、下载地址、安装后检查命令

### 3.1 Java 21

- 下载地址：https://learn.microsoft.com/java/openjdk/download#openjdk-21
- 当前已验证版本：`21.0.9`
- 安装后检查：

```bat
java -version
```

- 环境变量：

```text
JAVA_HOME=C:\Program Files\Microsoft\jdk-21.0.9.10-hotspot
Path=%JAVA_HOME%\bin
```

### 3.2 Maven 3.9+

- 下载地址：https://maven.apache.org/download.cgi
- 当前已验证版本：`3.9.11`
- 安装后检查：

```bat
mvn -v
```

- 环境变量：

```text
MAVEN_HOME=C:\Program Files\Apache\Maven
Path=%MAVEN_HOME%\bin
```

### 3.3 Node.js 22

- 下载地址：https://nodejs.org/en/download
- 当前已验证版本：`v22.22.0`
- 安装后检查：

```bat
node -v
npm -v
```

### 3.4 MySQL 8.0

- 下载地址：https://dev.mysql.com/downloads/mysql/
- 当前工具路径：`C:\Program Files\MySQL\MySQL Server 8.0\bin`
- 安装后检查：

```bat
mysql --version
mysqldump --version
```

### 3.5 Git

- 下载地址：https://git-scm.com/download/win
- 安装后检查：

```bat
git --version
```

### 3.6 GitHub CLI（推荐）

- 下载地址：https://cli.github.com/
- 安装后检查：

```bat
gh --version
```

### 3.7 Redis

- 说明地址：https://redis.io/docs/latest/operate/oss_and_stack/install/archive/install-redis/install-redis-on-windows/
- 当前本机实际目录：`C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service`
- 安装后检查：

```bat
C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-server.exe --version
```

## 4. 建议的系统环境变量

```text
JAVA_HOME=C:\Program Files\Microsoft\jdk-21.0.9.10-hotspot
MAVEN_HOME=C:\Program Files\Apache\Maven
REDIS_HOME=C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service
Path=%JAVA_HOME%\bin;%MAVEN_HOME%\bin;%REDIS_HOME%
```

## 5. 获取项目代码

### 5.1 克隆仓库

```bat
git clone https://github.com/ins13014778/teaching-resource-management-system-backup-20260324.git
cd /d teaching-resource-management-system-backup-20260324
```

### 5.2 或直接使用本机目录

```text
D:\RuoYi-Vue-master
```

## 6. 数据库配置与恢复

### 6.1 当前数据库配置

```properties
Host=127.0.0.1
Port=3306
Database=ry-vue
Username=root
Password=czp123..
```

### 6.2 创建数据库

```bat
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --default-character-set=utf8mb4 --host=127.0.0.1 --user=root --password=czp123.. -e "CREATE DATABASE IF NOT EXISTS `ry-vue` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
```

### 6.3 使用项目脚本恢复数据库

```bat
cd /d D:\RuoYi-Vue-master
bin\restore-db.bat ry-vue backup\2026-03-26\database\ry-vue-full-20260326.sql
```

### 6.4 手动导入 SQL

```bat
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --binary-mode=1 --default-character-set=utf8mb4 --host=127.0.0.1 --user=root --password=czp123.. ry-vue < backup\2026-03-26\database\ry-vue-full-20260326.sql
```

## 7. 安装项目依赖

### 7.1 前端依赖

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm install
```

### 7.2 后端依赖与初次构建

```bat
cd /d D:\RuoYi-Vue-master
mvn -U clean package -DskipTests
```

## 8. 启动项目

### 8.1 一键启动

```bat
cd /d D:\RuoYi-Vue-master
bin\start-all.bat
```

### 8.2 分步启动

#### 启动 Redis

```bat
cd /d D:\RuoYi-Vue-master
bin\start-redis.bat
```

#### 启动后端

```bat
cd /d D:\RuoYi-Vue-master
bin\start-backend.bat
```

#### 启动前端

```bat
cd /d D:\RuoYi-Vue-master
bin\start-frontend.bat
```

### 8.3 停止全部服务

```bat
cd /d D:\RuoYi-Vue-master
bin\stop-all.bat
```

## 9. 访问地址

- 官网首页：`http://127.0.0.1:80/`
- 后台登录：`http://127.0.0.1:80/login`
- 教师登录：`http://127.0.0.1:80/teacher-login`
- 学生登录：`http://127.0.0.1:80/student-login`
- 教师注册：`http://127.0.0.1:80/teacher-register`
- 学生注册：`http://127.0.0.1:80/register`
- 后端 API：`http://127.0.0.1:8080`
- Swagger：`http://127.0.0.1:8080/swagger-ui.html`
- OpenAPI：`http://127.0.0.1:8080/v3/api-docs`

## 10. API 快速说明

- 登录注册：`/login`、`/register`、`/captchaImage`
- 教学资源：`/edu/resource/*`
- 课程章节：`/edu/course/*`、`/edu/chapter/*`
- 评论举报收藏点赞：`/edu/comment/*`、`/edu/report/*`、`/edu/favorite/*`、`/edu/like/*`
- 空间文件与分享：`/edu/space/*`、`/edu/share/*`
- 官网门户：`/portal/*`
- AI 能力：`/ai/*`

完整列表见：`docs/api-endpoints.md`

## 11. 验证命令

### 11.1 后端测试

```bat
cd /d D:\RuoYi-Vue-master
mvn -pl ruoyi-admin -am test
```

### 11.2 前端构建

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm run build:prod
```

### 11.3 后端打包

```bat
cd /d D:\RuoYi-Vue-master
mvn -pl ruoyi-admin -am -DskipTests package
```

## 12. 常见问题

### 12.1 页面乱码

- 项目文件统一保存为 UTF-8
- PowerShell 写文件时建议显式指定 UTF-8

### 12.2 80、8080、3306、6379 端口被占用

- 前端默认端口：`80`
- 后端默认端口：`8080`
- MySQL 默认端口：`3306`
- Redis 默认端口：`6379`

### 12.3 Maven 打包时 Jar 被占用

说明旧的 `ruoyi-admin.jar` 还在运行，先停止旧 Java 进程再重新打包。

### 12.4 资源上传无响应或一直提示“数据正在处理，请勿重复提交”

- 浏览器执行 `Ctrl + F5` 强制刷新
- 确认前后端服务均正常
- 再看浏览器 F12 和后端日志定位具体报错
