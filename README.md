# 教学资源管理系统（基于 RuoYi-Vue 二次开发）

> 当前仓库是 **2026-03-24** 的完整备份仓库，已包含：
>
> - 项目源码
> - MySQL 数据库全量备份
> - 环境依赖说明
> - 数据库恢复脚本
> - Windows 一键启动脚本

## 1. 仓库地址

- GitHub：<https://github.com/ins13014778/teaching-resource-management-system-backup-20260324>

## 2. 备份内容

### 2.1 数据库备份

- 全量 SQL：
  - `/backup/2026-03-24/database/ry-vue-full-20260324.sql`
- 表清单汇总：
  - `/backup/2026-03-24/database/ry-vue-table-summary-20260324.tsv`

### 2.2 环境说明

- 环境依赖与避坑：
  - `/backup/2026-03-24/docs/full-backup-environment-20260324.md`

### 2.3 本地离线 Git 备份

- bundle 文件：
  - `/backup/2026-03-24/project/teaching-resource-management-system-backup-20260324.bundle`

### 2.4 恢复与启动脚本

仓库根目录 `/bin` 下：

- `env.cmd`：统一环境变量与本机路径
- `restore-db.bat`：恢复 MySQL 数据库
- `start-redis.bat`：启动 Redis
- `start-backend.bat`：启动后端
- `start-frontend.bat`：启动前端
- `start-all.bat`：一键启动 Redis + 后端 + 前端
- `stop-all.bat`：关闭常见运行进程

详细文档：

- `/doc/数据库恢复与一键启动说明.md`

---

## 3. 环境要求

建议使用以下环境：

- Windows 10 / Windows 11
- JDK 21
- Maven 3.9+
- Node.js 22+
- npm 11+
- MySQL 8.0
- Redis 8.x
- Git

当前备份机器实际环境如下：

- Java：`21.0.9`
- Maven：`3.9.11`
- Node.js：`v22.22.0`
- npm：`11.11.0`
- MySQL：`8.0.17`
- Redis：`8.6.1`
- Git：`2.52.0.windows.1`

---

## 4. 所需依赖安装说明

以下给出 **推荐安装项** 和 **安装后检查命令**。

### 4.1 安装 Git

安装完成后检查：

```bat
git --version
```

### 4.2 安装 JDK 21

安装完成后检查：

```bat
java -version
```

如果需要配置环境变量：

- `JAVA_HOME` 例子：

```text
C:\Program Files\Microsoft\jdk-21.0.9.10-hotspot
```

- `Path` 增加：

```text
%JAVA_HOME%\bin
```

### 4.3 安装 Maven

安装完成后检查：

```bat
mvn -v
```

如果没有全局 Maven，也可以直接使用本机已存在的 Maven：

```text
C:\Program Files\JetBrains\IntelliJ IDEA 2025.3.1.1\plugins\maven\lib\maven3\bin\mvn.cmd
```

如果需要配置环境变量：

- `MAVEN_HOME` 例子：

```text
C:\Program Files\Apache\maven
```

- `Path` 增加：

```text
%MAVEN_HOME%\bin
```

### 4.4 安装 Node.js / npm

安装完成后检查：

```bat
node -v
npm -v
```

### 4.5 安装 MySQL 8.0

安装完成后检查：

```bat
mysql --version
```

当前项目默认数据库账号配置：

- Host：`127.0.0.1`
- Port：`3306`
- Database：`ry-vue`
- Username：`root`
- Password：`czp123..`

当前本机 MySQL 程序路径：

```text
C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe
```

### 4.6 安装 Redis

当前本机 Redis 路径：

```text
C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service
```

Redis 主程序：

```text
C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-server.exe
```

Redis 启动检查：

```bat
"C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-server.exe" --version
```

如果想加入环境变量，可把下面目录加入 `Path`：

```text
C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service
```

---

## 5. 项目目录

项目根目录：

```text
D:\RuoYi-Vue-master
```

进入项目根目录：

```bat
cd /d D:\RuoYi-Vue-master
```

---

## 6. 环境变量与本机路径配置

### 6.1 建议配置的环境变量

建议至少配置以下环境变量：

- `JAVA_HOME`
- `MAVEN_HOME`
- `Path`

示例：

```text
JAVA_HOME=C:\Program Files\Microsoft\jdk-21.0.9.10-hotspot
MAVEN_HOME=C:\Program Files\Apache\maven
Path=%JAVA_HOME%\bin;%MAVEN_HOME%\bin;C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service
```

### 6.2 本项目脚本读取的统一配置文件

项目脚本优先读取：

```text
bin\env.cmd
```

如果换机器后路径不同，优先修改这个文件。

### 6.3 当前脚本默认适配的本机路径

- Java：
  - `C:\Program Files\Microsoft\jdk-21.0.9.10-hotspot\bin\java.exe`
- Maven：
  - `C:\Program Files\JetBrains\IntelliJ IDEA 2025.3.1.1\plugins\maven\lib\maven3\bin\mvn.cmd`
- MySQL：
  - `C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe`
- Redis：
  - `C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-server.exe`

---

## 7. 项目配置文件说明

### 7.1 后端数据库配置

配置文件：

```text
ruoyi-admin\src\main\resources\application-druid.yml
```

当前核心配置对应关系：

- 数据库：`ry-vue`
- 用户名：`root`
- 密码：`czp123..`
- JDBC：`jdbc:mysql://localhost:3306/ry-vue?...`

### 7.2 后端基础配置

配置文件：

```text
ruoyi-admin\src\main\resources\application.yml
```

当前重要配置：

- 后端端口：`8080`
- 文件上传目录：`D:/ruoyi/uploadPath`
- Redis：`localhost:6379`
- 单文件上传限制：`10MB`
- 总上传限制：`20MB`

### 7.3 前端配置

配置文件：

```text
ruoyi-ui\.env.development
ruoyi-ui\vue.config.js
```

当前重要配置：

- 页面标题：`教学资源管理系统`
- 前端开发代理：`/dev-api`
- 后端代理地址：`http://localhost:8080`
- 前端开发端口：默认 `80`

---

## 8. 环境校验命令

在开始部署前，先执行：

```bat
cd /d D:\RuoYi-Vue-master
java -version
mvn -v
node -v
npm -v
mysql --version
git --version
```

Redis 校验：

```bat
"C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-server.exe" --version
```

---

## 9. 安装项目依赖包

### 9.1 安装前端依赖包

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm install
```

### 9.2 安装 / 构建后端依赖

```bat
cd /d D:\RuoYi-Vue-master
mvn clean package -DskipTests
```

如果 `mvn` 未加入环境变量，可直接执行：

```bat
"C:\Program Files\JetBrains\IntelliJ IDEA 2025.3.1.1\plugins\maven\lib\maven3\bin\mvn.cmd" clean package -DskipTests
```

---

## 10. 数据库恢复命令

### 10.1 使用仓库内恢复脚本

```bat
cd /d D:\RuoYi-Vue-master
bin\restore-db.bat
```

### 10.2 手动恢复数据库

先创建数据库：

```bat
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --default-character-set=utf8mb4 --host=127.0.0.1 --user=root --password=czp123.. -e "CREATE DATABASE IF NOT EXISTS `ry-vue` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
```

再导入 SQL：

```bat
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --default-character-set=utf8mb4 --host=127.0.0.1 --user=root --password=czp123.. ry-vue < backup\2026-03-24\database\ry-vue-full-20260324.sql
```

---

## 11. 启动命令

### 11.1 启动 Redis

使用仓库脚本：

```bat
cd /d D:\RuoYi-Vue-master
bin\start-redis.bat
```

直接启动 Redis：

```bat
"C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-server.exe" "C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis.conf"
```

### 11.2 启动后端

如果已有 `jar`：

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-admin\target
java -jar ruoyi-admin.jar
```

如果需要先重新打包：

```bat
cd /d D:\RuoYi-Vue-master
mvn -T 1C -DskipTests package
cd /d D:\RuoYi-Vue-master\ruoyi-admin\target
java -jar ruoyi-admin.jar
```

### 11.3 启动前端

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm run dev
```

### 11.4 一键启动

```bat
cd /d D:\RuoYi-Vue-master
bin\start-all.bat
```

### 11.5 一键关闭

```bat
cd /d D:\RuoYi-Vue-master
bin\stop-all.bat
```

---

## 12. 推荐部署顺序

### 12.1 最快恢复方式

```bat
cd /d D:\RuoYi-Vue-master
bin\restore-db.bat
bin\start-all.bat
```

### 12.2 手动完整部署顺序

```bat
cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm install

cd /d D:\RuoYi-Vue-master
mvn clean package -DskipTests

cd /d D:\RuoYi-Vue-master
bin\restore-db.bat
bin\start-redis.bat

cd /d D:\RuoYi-Vue-master\ruoyi-admin\target
java -jar ruoyi-admin.jar

cd /d D:\RuoYi-Vue-master\ruoyi-ui
npm run dev
```

---

## 13. 默认访问地址

- 前端：<http://127.0.0.1/>
- 后端：<http://127.0.0.1:8080/>

---

## 14. 常见问题 / 避坑

### 14.1 MySQL 导入失败

重点检查：

- MySQL 服务是否已启动
- root 密码是否仍为 `czp123..`
- SQL 文件路径是否正确
- PowerShell / CMD 中命令参数是否写完整

### 14.2 Redis 未启动导致后端报错

后端依赖 Redis，Redis 没起来时常见报错类似：

- `Unable to connect to Redis`

因此建议先启动 Redis，再启动后端。

### 14.3 Maven 未加入环境变量

如果直接执行 `mvn` 报错，就使用 README 里给出的完整 Maven 路径执行。

### 14.4 前端端口被占用

前端开发默认使用 80 端口，如果被占用，请先释放端口，或改 `ruoyi-ui\vue.config.js` 中的端口。

### 14.5 乱码问题

项目历史上处理过数据库、页面、配置文件等乱码问题。

如果新机器再次出现乱码，优先检查：

- 文件编码是否为 UTF-8
- 数据库连接是否启用 `useUnicode=true&characterEncoding=utf8`
- SQL 导入时是否使用 `utf8mb4`

---

## 15. 说明

这个仓库当前主要用于：

1. 完整留档
2. 项目恢复
3. 环境复现
4. 后续继续开发

如果后续还要继续补：

- 数据库一键备份脚本
- 前后端生产包打包脚本
- Nginx + Jar + MySQL + Redis 生产部署说明
- 进一步清理历史乱码文件

可以继续在这个仓库基础上完善。
