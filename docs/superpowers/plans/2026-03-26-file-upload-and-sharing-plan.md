# 教学资源上传与空间分享实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为教学资源管理系统补齐真实文件上传、课程附件、空间文件库与分享能力，并同步输出完整部署/API/开发文档。

**Architecture:** 在现有若依教学资源系统上新增统一文件存储抽象层，底层同时支持本地磁盘与 MinIO。业务层拆分为资源文件、课程附件、空间文件与分享四块，后台通过配额与权限策略统一管控，前端页面改为真实上传交互。

**Tech Stack:** Spring Boot, MyBatis, MySQL, Vue2, Element UI, FileUpload/ImageUpload, Maven, Node.js

---

## 文件结构规划

### 后端将修改/新增
- Modify: `ruoyi-common/src/main/java/com/ruoyi/common/config/RuoYiConfig.java`
- Modify: `ruoyi-admin/src/main/resources/application-druid.yml`
- Modify: `ruoyi-admin/src/main/java/com/ruoyi/web/controller/edu/EduResourceController.java`
- Modify: `ruoyi-admin/src/main/java/com/ruoyi/web/controller/edu/EduCourseController.java`
- Modify: `ruoyi-admin/src/main/java/com/ruoyi/web/controller/edu/EduCourseChapterController.java`
- Modify: `ruoyi-admin/src/main/java/com/ruoyi/web/controller/edu/EduSpaceShareController.java`
- Create: `ruoyi-admin/src/main/java/com/ruoyi/web/controller/edu/EduStorageController.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/domain/edu/EduCourseAttachment.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/domain/edu/EduSpaceFile.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/storage/StorageService.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/storage/LocalStorageServiceImpl.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/storage/MinioStorageServiceImpl.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/storage/StorageFacade.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/IEduCourseAttachmentService.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/IEduSpaceFileService.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduCourseAttachmentServiceImpl.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduSpaceFileServiceImpl.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/mapper/EduCourseAttachmentMapper.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/mapper/EduSpaceFileMapper.java`
- Modify: `ruoyi-system/src/main/resources/mapper/edu/EduResourceMapper.xml`
- Create: `ruoyi-system/src/main/resources/mapper/edu/EduCourseAttachmentMapper.xml`
- Create: `ruoyi-system/src/main/resources/mapper/edu/EduSpaceFileMapper.xml`
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/domain/edu/EduResource.java`
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/domain/edu/EduSpaceShare.java`
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduResourceServiceImpl.java`
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduSpaceShareServiceImpl.java`
- Test: `ruoyi-admin/src/test/java/com/ruoyi/web/controller/edu/EduResourceUploadControllerTest.java`
- Test: `ruoyi-admin/src/test/java/com/ruoyi/web/controller/edu/EduSpaceShareControllerTest.java`

### 前端将修改/新增
- Modify: `ruoyi-ui/src/views/edu/resource/index.vue`
- Modify: `ruoyi-ui/src/views/edu/course/index.vue`
- Modify: `ruoyi-ui/src/views/edu/chapter/index.vue`
- Modify: `ruoyi-ui/src/views/edu/share/index.vue`
- Modify: `ruoyi-ui/src/views/edu/quota/index.vue`
- Create: `ruoyi-ui/src/views/edu/space/index.vue`
- Modify: `ruoyi-ui/src/api/edu/resource.js`
- Create: `ruoyi-ui/src/api/edu/courseAttachment.js`
- Modify: `ruoyi-ui/src/api/edu/share.js`
- Create: `ruoyi-ui/src/api/edu/storage.js`

### SQL / 文档 / 脚本
- Create: `sql/edu_file_storage_20260326.sql`
- Modify: `README.md`
- Create: `docs/Windows部署与接口文档.md`
- Modify/Create: `bin/start-backend.bat`, `bin/start-frontend.bat`, `bin/start-all.bat`, `bin/stop-backend.bat`

---

## Task 1: 存储抽象层与数据库结构

**Files:**
- Create: `sql/edu_file_storage_20260326.sql`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/storage/StorageService.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/storage/LocalStorageServiceImpl.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/storage/MinioStorageServiceImpl.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/storage/StorageFacade.java`
- Modify: `ruoyi-common/src/main/java/com/ruoyi/common/config/RuoYiConfig.java`
- Modify: `ruoyi-admin/src/main/resources/application-druid.yml`
- Test: `ruoyi-admin/src/test/java/com/ruoyi/web/controller/edu/EduResourceUploadControllerTest.java`

- [ ] Step 1: 写存储配置与本地上传失败测试
- [ ] Step 2: 运行测试确认失败
- [ ] Step 3: 实现存储接口、本地存储实现、MinIO 占位实现与配置项
- [ ] Step 4: 编写并执行 SQL，补齐资源字段、课程附件表、空间文件表
- [ ] Step 5: 再跑测试确认通过

## Task 2: 资源管理真实文件上传

**Files:**
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/domain/edu/EduResource.java`
- Modify: `ruoyi-system/src/main/resources/mapper/edu/EduResourceMapper.xml`
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduResourceServiceImpl.java`
- Modify: `ruoyi-admin/src/main/java/com/ruoyi/web/controller/edu/EduResourceController.java`
- Modify: `ruoyi-ui/src/views/edu/resource/index.vue`
- Modify: `ruoyi-ui/src/api/edu/resource.js`
- Test: `ruoyi-admin/src/test/java/com/ruoyi/web/controller/edu/EduResourceUploadControllerTest.java`

- [ ] Step 1: 为资源上传接口写失败测试（文件上传、封面上传、字段回填）
- [ ] Step 2: 运行测试确认失败
- [ ] Step 3: 实现资源文件/封面上传接口与保存逻辑
- [ ] Step 4: 改造资源管理页面，接入 FileUpload / ImageUpload
- [ ] Step 5: 跑后端测试与前端构建确认通过

## Task 3: 课程章节附件上传

**Files:**
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/domain/edu/EduCourseAttachment.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/mapper/EduCourseAttachmentMapper.java`
- Create: `ruoyi-system/src/main/resources/mapper/edu/EduCourseAttachmentMapper.xml`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/IEduCourseAttachmentService.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduCourseAttachmentServiceImpl.java`
- Modify: `ruoyi-admin/src/main/java/com/ruoyi/web/controller/edu/EduCourseChapterController.java`
- Modify: `ruoyi-ui/src/views/edu/chapter/index.vue`
- Create: `ruoyi-ui/src/api/edu/courseAttachment.js`
- Test: `ruoyi-admin/src/test/java/com/ruoyi/web/controller/edu/EduResourceUploadControllerTest.java`

- [ ] Step 1: 写章节附件接口失败测试
- [ ] Step 2: 运行测试确认失败
- [ ] Step 3: 实现课程附件表、服务、上传/列表/删除接口
- [ ] Step 4: 改造章节页面加入附件上传列表
- [ ] Step 5: 测试和构建验证

## Task 4: 空间文件库与分享改造

**Files:**
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/domain/edu/EduSpaceFile.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/mapper/EduSpaceFileMapper.java`
- Create: `ruoyi-system/src/main/resources/mapper/edu/EduSpaceFileMapper.xml`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/IEduSpaceFileService.java`
- Create: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduSpaceFileServiceImpl.java`
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/domain/edu/EduSpaceShare.java`
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduSpaceShareServiceImpl.java`
- Modify: `ruoyi-admin/src/main/java/com/ruoyi/web/controller/edu/EduSpaceShareController.java`
- Create: `ruoyi-admin/src/main/java/com/ruoyi/web/controller/edu/EduStorageController.java`
- Modify: `ruoyi-ui/src/views/edu/share/index.vue`
- Create: `ruoyi-ui/src/views/edu/space/index.vue`
- Modify: `ruoyi-ui/src/api/edu/share.js`
- Create: `ruoyi-ui/src/api/edu/storage.js`
- Test: `ruoyi-admin/src/test/java/com/ruoyi/web/controller/edu/EduSpaceShareControllerTest.java`

- [ ] Step 1: 写空间文件与分享失败测试
- [ ] Step 2: 运行测试确认失败
- [ ] Step 3: 实现文件夹/文件上传/分享/密码/有效期/限制逻辑
- [ ] Step 4: 改造空间分享页并新增空间文件库页
- [ ] Step 5: 测试和构建验证

## Task 5: 配额联动与规则校验

**Files:**
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduResourceServiceImpl.java`
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduCourseAttachmentServiceImpl.java`
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduSpaceFileServiceImpl.java`
- Modify: `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/EduSpaceShareServiceImpl.java`
- Modify: `ruoyi-ui/src/views/edu/quota/index.vue`
- Test: `ruoyi-admin/src/test/java/com/ruoyi/web/controller/edu/EduSpaceShareControllerTest.java`

- [ ] Step 1: 写超配额/超大小/封禁/禁止分享失败测试
- [ ] Step 2: 运行测试确认失败
- [ ] Step 3: 实现统一校验逻辑并串联配额规则
- [ ] Step 4: 调整配额页文案与联动字段
- [ ] Step 5: 验证通过

## Task 6: 文档、脚本、GitHub 交付

**Files:**
- Modify: `README.md`
- Create: `docs/Windows部署与接口文档.md`
- Modify/Create: `bin/start-backend.bat`
- Modify/Create: `bin/start-frontend.bat`
- Create: `bin/start-all.bat`
- Create: `bin/stop-backend.bat`

- [ ] Step 1: 梳理当前实际环境与启动命令
- [ ] Step 2: 补齐 README 安装依赖、环境变量、启动命令
- [ ] Step 3: 编写完整 Windows 部署/API/功能文档
- [ ] Step 4: 完善一键启动/停止脚本
- [ ] Step 5: 最终验证后提交并推送 GitHub
