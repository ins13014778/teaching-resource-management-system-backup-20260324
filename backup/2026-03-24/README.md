# 教学资源管理系统备份说明

## 1. 目录内容

- `database/ry-vue-full-20260324.sql`：MySQL 全量备份
- `database/ry-vue-table-summary-20260324.tsv`：数据库表与行数汇总
- `docs/full-backup-environment-20260324.md`：环境、依赖、恢复说明
- `project/teaching-resource-management-system-backup-20260324.bundle`：离线 Git 备份

## 2. 使用建议

- GitHub 仓库建议设为 **Private**
- 恢复环境时优先执行根目录的 `bin/restore-db.bat`
- 启动环境时优先执行根目录的 `bin/start-all.bat`
- 换机器后先检查 `bin/env.cmd` 中的本机路径是否正确
