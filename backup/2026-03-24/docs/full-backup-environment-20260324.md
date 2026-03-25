# 全量备份环境说明

## 1. 备份信息

- 备份日期：2026-03-24
- 项目路径：`D:\RuoYi-Vue-master`
- 数据库名：`ry-vue`

## 2. 备份范围

### 2.1 项目代码

- 已包含完整 Git 项目代码
- 位置：`backup/2026-03-24/`

### 2.2 数据库备份

- 文件：`backup/2026-03-24/database/ry-vue-full-20260324.sql`
- 类型：MySQL 全量导出（UTF-8 / utf8mb4）

### 2.3 数据库汇总

- 文件：`backup/2026-03-24/database/ry-vue-table-summary-20260324.tsv`

## 3. 当前机器环境

### 3.1 软件版本

- Java：`21.0.9`
- Maven：`3.9.11`
- Node.js：`v22.22.0`
- npm：`11.11.0`
- Git：`2.52.0.windows.1`
- GitHub CLI：`2.87.3`
- MySQL：`8.0.17`
- Redis：`8.6.1`

### 3.2 数据库连接

- Host：`127.0.0.1`
- Port：`3306`
- Database：`ry-vue`
- Username：`root`
- Password：`czp123..`

### 3.3 Redis

- Redis 路径：`C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service`
- 端口：`6379`
- 正确启动方式：`redis-server.exe redis.conf`

### 3.4 默认端口

- 前端：`80`
- 后端：`8080`
- Redis：`6379`
- MySQL：`3306`

## 4. 常用命令

### 4.1 启动 Redis

```bat
cd /d C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service
redis-server.exe redis.conf
```

### 4.2 启动后端

```bat
cd /d D:\RuoYi-Vue-master
bin\start-backend.bat
```

### 4.3 启动前端

```bat
cd /d D:\RuoYi-Vue-master
bin\start-frontend.bat
```

### 4.4 打包后端与前端

```bat
cd /d D:\RuoYi-Vue-master
"C:\Program Files\JetBrains\IntelliJ IDEA 2025.3.1.1\plugins\maven\lib\maven3\bin\mvn.cmd" -pl ruoyi-admin -am -DskipTests package
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm run build:prod
```

## 5. 避坑说明

1. PowerShell 手动导库容易受编码影响，优先使用 `bin/restore-db.bat`。
2. Redis 为 Cygwin 版，必须在 Redis 安装目录中使用相对 `redis.conf` 启动。
3. 8080 如果被其他程序占用，后端不会自动顶掉该进程。
4. 80 端口如果被占用，前端开发服务无法启动。
5. 新增 SQL、Markdown、Vue、Java、YAML 文件时统一保存为 UTF-8。

## 6. 恢复建议

### 6.1 恢复数据库

```bat
cd /d D:\RuoYi-Vue-master
bin\restore-db.bat
```

### 6.2 恢复项目

- 克隆或下载当前 GitHub 仓库
- 保持项目目录为 `D:\RuoYi-Vue-master`
- 检查 `bin/env.cmd` 中的本机路径

## 7. 备注

- 当前备份已去除默认若依官网菜单，并修正了教学菜单重复路由名。
- 登录、注册、首页、README、恢复文档与核心 SQL 已统一修复乱码。
