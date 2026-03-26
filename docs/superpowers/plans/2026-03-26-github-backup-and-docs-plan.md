# GitHub Backup, Database Export, and Deployment Docs Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Export the current MySQL database, update project documentation with API and Windows deployment details, and push the full repository backup to GitHub.

**Architecture:** Keep the repo as the source of truth. Store database exports under `backup/`, write deployment and API docs in Markdown, and push the current working tree to the existing GitHub remote after verification.

**Tech Stack:** Git, GitHub CLI, MySQL 8.0 (`mysqldump`), Maven, Node.js/Vue, Spring Boot, PowerShell.

---

### Task 1: Inventory current environment and repo state

**Files:**
- Create: `docs/superpowers/plans/2026-03-26-github-backup-and-docs-plan.md`
- Inspect: `README.md`
- Inspect: `ruoyi-admin/src/main/java/com/ruoyi/web/controller/**/*.java`

- [ ] Capture current git status and remote.
- [ ] Confirm GitHub auth and target remote are available.
- [ ] Confirm MySQL dump tool path and key runtime tools.

### Task 2: Export current MySQL database

**Files:**
- Create: `backup/2026-03-26/database/ry-vue-full-20260326.sql`
- Create: `backup/2026-03-26/database/ry-vue-schema-20260326.sql`
- Create: `backup/2026-03-26/database/ry-vue-table-summary-20260326.tsv`

- [ ] Run full database export with UTF-8 and routines/events/triggers.
- [ ] Run schema-only export.
- [ ] Generate table summary from MySQL metadata for quick review.

### Task 3: Write clean deployment and API documentation

**Files:**
- Modify: `README.md`
- Create: `docs/API接口清单.md`
- Create: `docs/Windows部署使用说明.md`

- [ ] Rewrite README in clean Chinese with project intro, startup, API base URLs, and doc links.
- [ ] Generate/organize API endpoint list from admin controllers into a readable Markdown document.
- [ ] Write a beginner-friendly Windows deployment guide with required software, install commands, environment variables, startup commands, restore commands, and official download URLs.

### Task 4: Verify artifacts and push to GitHub

**Files:**
- Modify/Create: files from Tasks 2-3

- [ ] Verify docs and backup files exist.
- [ ] Run git status review.
- [ ] Commit all changes with one backup/docs commit.
- [ ] Push to the configured GitHub remote.