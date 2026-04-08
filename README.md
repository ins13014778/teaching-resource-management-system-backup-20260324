# 教学资源管理系统

基于 `RuoYi-Vue` 深度定制的教学资源管理系统，提供后端管理、前端页面、数据库初始化、环境检测和 Windows 一键脚本支持。

## 项目地址

- GitHub：<https://github.com/ins13014778/teaching-resource-management-system-backup-20260324>

## 技术栈

- 后端：Spring Boot + Maven
- 前端：Vue 2 + Element UI
- 数据库：MySQL 8
- 缓存：Redis

## 运行环境

建议使用以下版本：

- JDK 17 或更高
- Maven 3.9.x
- Node.js 18.x
- npm
- MySQL 8
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

## Windows 脚本入口

所有脚本都在 `bin` 目录下。

推荐入口：

```bat
bin\menu.bat
```

脚本菜单功能：

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

详细说明见 [docs/windows-bat-guide.md](docs/windows-bat-guide.md)。

## 首次部署推荐顺序

1. 安装 JDK、Maven、Node.js、MySQL、Redis
2. 运行 `bin\check-env.bat`
3. 如有需要，运行 `bin\setup-env.bat`
4. 运行 `bin\install-deps.bat`
5. 导入数据库 SQL
6. 运行 `bin\init-db.bat`
7. 运行 `bin\start-all.bat`

## 访问地址

启动成功后，通常可访问：

- 前端：<http://127.0.0.1/>
- 后端 Swagger：<http://127.0.0.1:8080/swagger-ui.html>

## 数据库说明

- 默认数据库名：`ry-vue`
- 默认优先使用的 SQL 文件：
  - `sql\ry-vue.sql`
  - 如果不存在，则按 `bin\env.cmd` 中的回退规则查找 `backup` 目录下的 SQL 文件

## 注意事项

- `bin\env.local.cmd` 是本机私有配置文件，不应提交到 Git。
- 如果你要自定义 Java、Maven、MySQL、Redis 安装目录，请复制 `bin\env.local.example.cmd` 为 `bin\env.local.cmd` 后再修改。
- `bin\clone-project.bat` 只针对当前项目仓库，不是通用拉取器。
- `bin\install-deps.bat --dry-run` 和 `bin\clone-project.bat --dry-run` 可用于先检查命令，不会真正执行安装或拉取。
- 若菜单在你的终端里出现中文乱码，通常是终端字体或代码页问题，不影响脚本逻辑。
