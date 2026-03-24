# 教学资源管理系统（基于 RuoYi-Vue 二次开发）

> 当前仓库为 **2026-03-24** 的完整备份仓库，已包含：
>
> - 当前项目源码
> - MySQL 数据库备份
> - 环境依赖说明
> - 数据库恢复脚本
> - Windows 一键启动脚本

## 一、GitHub 备份仓库

- 仓库地址：<https://github.com/ins13014778/teaching-resource-management-system-backup-20260324>

## 二、关键备份文件

### 1）数据库备份

- 全量 SQL：
  - `/backup/2026-03-24/database/ry-vue-full-20260324.sql`
- 数据库表汇总：
  - `/backup/2026-03-24/database/ry-vue-table-summary-20260324.tsv`

### 2）环境说明

- 环境依赖与避坑：
  - `/backup/2026-03-24/docs/full-backup-environment-20260324.md`

### 3）本地离线 Git 备份

- bundle 文件：
  - `/backup/2026-03-24/project/teaching-resource-management-system-backup-20260324.bundle`

## 三、已新增的恢复/启动脚本

仓库根目录 `/bin` 下：

- `restore-db.bat`：恢复 MySQL 数据库
- `start-redis.bat`：启动 Redis
- `start-backend.bat`：启动后端
- `start-frontend.bat`：启动前端
- `start-all.bat`：一键拉起 Redis + 后端 + 前端
- `stop-all.bat`：关闭前端/后端常用进程

详细说明见：

- `/doc/数据库恢复与一键启动说明.md`

## 四、默认本机环境

当前仓库脚本优先适配本机下面这些路径：

- Java：
  - `C:\Program Files\Microsoft\jdk-21.0.9.10-hotspot\bin\java.exe`
- Maven：
  - `C:\Program Files\JetBrains\IntelliJ IDEA 2025.3.1.1\plugins\maven\lib\maven3\bin\mvn.cmd`
- MySQL：
  - `C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe`
- Redis：
  - `C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-server.exe`

如果以后换机器，优先修改：

- `bin\env.cmd`

## 五、快速使用

### 1）恢复数据库

双击或命令行执行：

```bat
bin\restore-db.bat
```

### 2）一键启动

```bat
bin\start-all.bat
```

### 3）关闭主要进程

```bat
bin\stop-all.bat
```

## 六、默认数据库配置

当前项目默认使用：

- Host：`127.0.0.1`
- Port：`3306`
- Database：`ry-vue`
- Username：`root`
- Password：`czp123..`

对应配置文件：

- `/ruoyi-admin/src/main/resources/application-druid.yml`

## 七、说明

这个仓库当前主要用于：

1. 完整留档
2. 项目恢复
3. 环境复现
4. 后续继续开发

如果后续还要继续补：

- 历史 SQL 乱码清理
- 配置注释乱码清理
- 自动化发布包
- 数据库一键备份脚本

可以在这个仓库基础上继续做。
