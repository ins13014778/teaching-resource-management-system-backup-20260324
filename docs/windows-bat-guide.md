# Windows Bat 脚本使用说明

本文档说明当前项目在 Windows 下的脚本入口、功能、使用方式和注意事项。

## 一、脚本目录

脚本目录：

```text
bin\
```

主要文件：

- `menu.bat`：中文菜单入口
- `check-env.bat`：检测本机环境
- `setup-env.bat`：生成本机私有环境配置
- `clone-project.bat`：拉取或更新当前项目
- `install-deps.bat`：安装前后端依赖
- `init-db.bat`：初始化数据库
- `start-redis.bat`：启动 Redis
- `start-backend.bat`：启动后端
- `start-frontend.bat`：启动前端
- `start-all.bat`：一键启动 Redis、后端、前端
- `restart-all.bat`：重启全部服务
- `stop-all.bat`：停止全部服务

## 二、推荐入口

直接运行：

```bat
bin\menu.bat
```

菜单功能如下：

1. 检测环境
2. 配置本地环境
3. 拉取或更新项目
4. 安装项目依赖
5. 初始化数据库
6. 启动 Redis
7. 启动后端
8. 启动前端
9. 一键启动全部
10. 重启全部
11. 停止全部
12. 退出

如果你只是想快速验证菜单可打开：

```bat
bin\menu.bat 12
```

## 三、各脚本说明

### 1. `check-env.bat`

作用：

- 检测 Git、Java、Maven、Node.js、npm、MySQL、Redis 是否可用
- 输出当前实际命中的版本
- 判断是否存在 `bin\env.local.cmd`

运行方式：

```bat
bin\check-env.bat
```

适合场景：

- 新机器首次部署前
- 修改环境变量后重新确认

### 2. `setup-env.bat`

作用：

- 引导你输入本机的 Java、Maven、Node、MySQL、Redis 路径
- 引导你输入数据库连接配置
- 生成 `bin\env.local.cmd`

运行方式：

```bat
bin\setup-env.bat
```

注意：

- `bin\env.local.cmd` 是本机私有配置
- 不要提交到 GitHub

### 3. `clone-project.bat`

作用：

- 拉取当前项目仓库
- 如果目标目录已是 Git 仓库，则执行 `fetch + pull`

运行方式：

```bat
bin\clone-project.bat
```

指定目录：

```bat
bin\clone-project.bat D:\project\teaching-resource-management-system
```

只看命令不实际执行：

```bat
bin\clone-project.bat --dry-run D:\project\teaching-resource-management-system
```

注意：

- 这个脚本固定只支持当前项目仓库
- 不适合作为通用 Git 拉取脚本

### 4. `install-deps.bat`

作用：

- 执行后端 Maven 编译，预下载依赖
- 执行前端 `npm install`

运行方式：

```bat
bin\install-deps.bat
```

只看命令：

```bat
bin\install-deps.bat --dry-run
```

### 5. `init-db.bat`

作用：

- 检查 MySQL 连接
- 调用 `restore-db.bat` 导入 SQL
- 导入完成后验证表数量和 `sys_user` 记录数

运行方式：

```bat
bin\init-db.bat
```

也可指定数据库名和 SQL 文件：

```bat
bin\init-db.bat ry-vue sql\ry-vue.sql
```

### 6. `start-redis.bat`

作用：

- 启动 Redis
- 如果 Redis 已在运行，则直接返回

运行方式：

```bat
bin\start-redis.bat
```

### 7. `start-backend.bat`

作用：

- 检查 8080 端口
- 如果需要则触发 Maven 构建
- 启动后端 Jar

运行方式：

```bat
bin\start-backend.bat
```

### 8. `start-frontend.bat`

作用：

- 检查前端端口
- 如无 `node_modules` 则先安装依赖
- 启动前端开发服务

运行方式：

```bat
bin\start-frontend.bat
```

### 9. `start-all.bat`

作用：

- 按顺序启动 Redis、后端、前端

运行方式：

```bat
bin\start-all.bat
```

### 10. `restart-all.bat`

作用：

- 停止全部服务
- 清理日志
- 重新启动全部服务

运行方式：

```bat
bin\restart-all.bat
```

### 11. `stop-all.bat`

作用：

- 停止当前项目相关的 Redis、后端、前端进程

运行方式：

```bat
bin\stop-all.bat
```

## 四、推荐使用顺序

首次部署：

1. `bin\check-env.bat`
2. `bin\setup-env.bat`
3. `bin\install-deps.bat`
4. `bin\init-db.bat`
5. `bin\start-all.bat`

日常启动：

1. `bin\start-all.bat`

日常停止：

1. `bin\stop-all.bat`

## 五、注意事项

- `env.local.cmd` 只用于本机，不要上传。
- 脚本已尽量做成通用 Windows 方案，但数据库账号、端口、安装路径仍需结合你的机器配置。
- 当前菜单、环境检测等脚本是中文界面；如果你使用的终端字体不支持中文，可能会出现显示异常，但不影响逻辑执行。
- 如果 `mvn` 命中的是 IntelliJ 自带 Maven，也可以使用，但更建议单独安装一份 Maven 并在 `env.local.cmd` 里显式指定。
- 如果 `JAVA_HOME` 未配置，脚本也会尝试从系统可执行路径里自动找到 `java.exe`。
