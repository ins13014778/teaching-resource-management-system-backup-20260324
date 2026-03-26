# 教学资源管理系统

> 基于 RuoYi-Vue 深度定制的教学资源管理平台，覆盖后台管理、教师端/学生端注册登录、教学资源上传审核、课程与章节、公告、官网门户、网盘空间与分享、AI 辅助能力等场景。

## 1. 仓库与备份信息

- 当前项目目录：`D:\RuoYi-Vue-master`
- GitHub 仓库：[teaching-resource-management-system-backup-20260324](https://github.com/ins13014778/teaching-resource-management-system-backup-20260324)
- 本次全量数据库备份：`backup/2026-03-26/database/ry-vue-full-20260326.sql`
- 本次结构备份：`backup/2026-03-26/database/ry-vue-schema-20260326.sql`
- 本次表摘要：`backup/2026-03-26/database/ry-vue-table-summary-20260326.tsv`
- API 接口文档：`docs/api-endpoints.md`
- Windows 部署文档：`docs/windows-deployment-guide.md`
- 历史恢复说明：`doc/数据库恢复与一键启动说明.md`

## 2. 系统访问地址

### 2.1 前端地址

- 官网首页：`http://127.0.0.1:80/`
- 后台登录：`http://127.0.0.1:80/login`
- 教师登录：`http://127.0.0.1:80/teacher-login`
- 学生登录：`http://127.0.0.1:80/student-login`
- 教师注册：`http://127.0.0.1:80/teacher-register`
- 学生注册：`http://127.0.0.1:80/register`

### 2.2 后端地址

- 后端 API：`http://127.0.0.1:8080`
- Swagger：`http://127.0.0.1:8080/swagger-ui.html`
- OpenAPI JSON：`http://127.0.0.1:8080/v3/api-docs`

## 3. 当前核心功能

- 系统用户、角色、菜单、部门、通知、参数、字典管理
- 教师端 / 学生端注册登录与权限隔离
- 教学资源上传、编辑、审核、推荐、下载、收藏、点赞、评论、举报
- 课程、章节、章节附件、课程公告、师生授权
- 空间文件库、文件夹、文件上传、空间配额、分享、分享密码
- 官网门户配置、官网 Logo/标题、轮播图、公告、重要资讯展示
- AI 能力：摘要、标签、分类、OCR、相似度分析、审核、问答、任务记录
- 统计分析、反馈、站内消息

## 4. API 地址与作用

### 4.1 基础约定

- 后端 API 根地址：`http://127.0.0.1:8080`
- 前端代理前缀：`/dev-api`
- 登录后的鉴权头：`Authorization: Bearer <token>`

### 4.2 重点接口

#### 认证与注册
- `POST /login`：后台/教师/学生登录
- `POST /register`：学生注册
- `POST /teacher/register`：教师注册
- `GET /captchaImage`：获取验证码

#### 官网门户
- `GET /portal/home/overview`：官网首页概览数据
- `GET /portal/home/config`：官网配置（Logo、标题、简介等）
- `GET /portal/notices`：官网公告列表
- `GET /portal/notices/{noticeId}`：官网公告详情
- `GET /portal/admin/banner/list`：官网轮播图后台列表
- `PUT /portal/admin/config/`：更新官网配置

#### 文件与资源
- `POST /common/upload`：单文件上传
- `POST /common/uploads`：多文件上传
- `GET /edu/resource/list`：资源列表
- `POST /edu/resource/`：新增资源
- `PUT /edu/resource/`：修改资源
- `POST /edu/resource/download/{resourceId}`：下载资源并记录日志
- `GET /edu/space/list`：空间文件列表
- `POST /edu/space/`：新增空间文件/文件夹
- `GET /edu/share/list`：分享记录列表
- `POST /edu/share/`：创建分享

#### 统计分析
- `GET /edu/stats/dashboard`：教学资源统计分析看板

> 全量接口请查看：`docs/api-endpoints.md`

## 5. Windows 运行环境

### 5.1 已验证版本

- Windows 11 x64
- Java：OpenJDK 21.0.9（Microsoft Build of OpenJDK）
- Maven：3.9.11
- Node.js：v22.22.0
- npm：11.11.0
- MySQL：8.0.x
- Redis：`C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service`
- Git：2.52.0.windows.1
- GitHub CLI：2.87.3

### 5.2 官方下载地址

- JDK 21（Microsoft Build of OpenJDK）：https://learn.microsoft.com/java/openjdk/download#openjdk-21
- Maven：https://maven.apache.org/download.cgi
- Node.js：https://nodejs.org/en/download
- MySQL：https://dev.mysql.com/downloads/mysql/
- Git for Windows：https://git-scm.com/download/win
- GitHub CLI：https://cli.github.com/
- Redis for Windows 说明：https://redis.io/docs/latest/operate/oss_and_stack/install/archive/install-redis/install-redis-on-windows/

### 5.3 环境变量参考

```text
JAVA_HOME=C:\Program Files\Microsoft\jdk-21.0.9.10-hotspot
MAVEN_HOME=C:\Program Files\Apache\Maven
REDIS_HOME=C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service
Path=%JAVA_HOME%\bin;%MAVEN_HOME%\bin;%REDIS_HOME%
```

## 6. 当前本机数据库配置

```properties
Host=127.0.0.1
Port=3306
Database=ry-vue
Username=root
Password=czp123..
```

## 7. 安装依赖与运行命令

### 7.1 前端依赖安装

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm install
```

### 7.2 后端依赖下载与打包

```bat
cd /d D:\RuoYi-Vue-master
mvn -U clean package -DskipTests
```

### 7.3 数据库恢复

```bat
cd /d D:\RuoYi-Vue-master
bin\restore-db.bat ry-vue backup\2026-03-26\database\ry-vue-full-20260326.sql
```

### 7.4 一键启动全部服务

```bat
cd /d D:\RuoYi-Vue-master
bin\start-all.bat
```

### 7.5 分别启动

```bat
cd /d D:\RuoYi-Vue-master
bin\start-redis.bat
bin\start-backend.bat
bin\start-frontend.bat
```

### 7.6 停止全部服务

```bat
cd /d D:\RuoYi-Vue-master
bin\stop-all.bat
```

## 8. 构建与校验命令

### 8.1 后端测试

```bat
cd /d D:\RuoYi-Vue-master
mvn -pl ruoyi-admin -am test
```

### 8.2 前端构建

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm run build:prod
```

### 8.3 后端打包

```bat
cd /d D:\RuoYi-Vue-master
mvn -pl ruoyi-admin -am -DskipTests package
```

### 8.4 直接运行后端 Jar

```bat
cd /d D:\RuoYi-Vue-master
java -jar ruoyi-admin\target\ruoyi-admin.jar
```

## 9. 常见问题

### 9.1 页面乱码
- 所有 `.java/.vue/.xml/.sql/.md` 文件统一建议保存为 UTF-8。
- PowerShell 写文件时建议显式使用 UTF-8，避免中文文档乱码。

### 9.2 资源上传后一直提示“数据正在处理，请勿重复提交”
- 先强制刷新浏览器缓存：`Ctrl + F5`
- 再确认前端 `http://127.0.0.1:80` 和后端 `http://127.0.0.1:8080` 都正常运行

### 9.3 Maven 打包时 Jar 无法覆盖
- 说明旧的 `ruoyi-admin.jar` 仍在运行
- 先停止旧 Java 进程，再重新打包

## 10. 本次更新内容

- 导出最新 MySQL 全量备份、结构备份、表摘要
- 补充并重写 README
- 新增完整 API 接口文档
- 新增 Windows 小白部署文档
- 准备全量推送到 GitHub 远程仓库
