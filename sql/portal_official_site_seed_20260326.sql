INSERT INTO sys_notice (notice_title, notice_type, notice_content, status, remark, create_by, create_time)
SELECT '教学资源管理系统官网试运行公告', '2',
       '<p>教学资源管理系统官网现已进入试运行阶段，平台将统一展示学校教学资源门户、公告通知、教师入口与学生入口。</p><p>后续可继续在后台发布更多通知公告，官网页面将自动同步展示。</p>',
       '0', '官网初始化公告', 'system', NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM sys_notice WHERE notice_title = '教学资源管理系统官网试运行公告'
);

INSERT INTO sys_notice (notice_title, notice_type, notice_content, status, remark, create_by, create_time)
SELECT '教师端与学生端入口已开放', '1',
       '<p>教师可通过教师端入口上传课件、维护课程资料与共享教学文件；学生可通过学生端入口查看公告、访问课程资料与进入个人学习空间。</p><p>如遇账号权限问题，请联系管理员统一分配角色。</p>',
       '0', '官网初始化公告', 'system', NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM sys_notice WHERE notice_title = '教师端与学生端入口已开放'
);

INSERT INTO sys_notice (notice_title, notice_type, notice_content, status, remark, create_by, create_time)
SELECT '资源上传与空间共享规范说明', '2',
       '<p>为保障教学资源质量与共享安全，请教师在上传资源时补充课程名称、分类标签、资源简介与共享范围说明。</p><p>管理员可在后台统一配置空间容量、上传大小限制、分享密码与账号封禁策略。</p>',
       '0', '官网初始化公告', 'system', NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM sys_notice WHERE notice_title = '资源上传与空间共享规范说明'
);
