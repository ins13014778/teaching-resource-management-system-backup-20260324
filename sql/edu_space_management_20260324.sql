-- 教学资源管理系统空间与基础数据修复脚本
SET NAMES utf8mb4;
START TRANSACTION;

-- 开启学生自助注册，可通过 sys_config.sys.account.registerUser 控制开关
UPDATE sys_config
SET config_value = 'true',
    config_name = '账号自助-是否开启用户注册功能',
    remark = '是否开启学生注册功能（true开启，false关闭）',
    update_by = 'admin',
    update_time = NOW()
WHERE config_key = 'sys.account.registerUser';

INSERT INTO sys_config(config_name, config_key, config_value, config_type, create_by, create_time, remark)
SELECT '账号自助-是否开启教师注册功能', 'sys.account.registerTeacher', 'true', 'Y', 'admin', NOW(), '是否开启教师注册功能（true开启，false关闭）'
WHERE NOT EXISTS (SELECT 1 FROM sys_config WHERE config_key = 'sys.account.registerTeacher');

INSERT INTO sys_config(config_name, config_key, config_value, config_type, create_by, create_time, remark)
SELECT '账号自助-是否开启学生注册功能', 'sys.account.registerStudent', 'true', 'Y', 'admin', NOW(), '是否开启学生注册功能（true开启，false关闭）'
WHERE NOT EXISTS (SELECT 1 FROM sys_config WHERE config_key = 'sys.account.registerStudent');

UPDATE sys_config
SET config_value = 'true',
    config_name = '账号自助-是否开启教师注册功能',
    remark = '是否开启教师注册功能（true开启，false关闭）',
    update_by = 'admin',
    update_time = NOW()
WHERE config_key = 'sys.account.registerTeacher';

UPDATE sys_config
SET config_value = 'true',
    config_name = '账号自助-是否开启学生注册功能',
    remark = '是否开启学生注册功能（true开启，false关闭）',
    update_by = 'admin',
    update_time = NOW()
WHERE config_key = 'sys.account.registerStudent';

-- 组织与岗位
UPDATE sys_dept SET dept_name='教学资源中心', leader='平台管理员' WHERE dept_id=100;
UPDATE sys_dept SET dept_name='教务管理中心', leader='李主任' WHERE dept_id=101;
UPDATE sys_dept SET dept_name='继续教育中心', leader='周主任' WHERE dept_id=102;
UPDATE sys_dept SET dept_name='课程资源组', leader='张老师' WHERE dept_id=103;
UPDATE sys_dept SET dept_name='教学运营组', leader='王老师' WHERE dept_id=104;
UPDATE sys_dept SET dept_name='质量审核组', leader='审核老师' WHERE dept_id=105;
UPDATE sys_dept SET dept_name='学习服务组', leader='刘老师' WHERE dept_id=106;
UPDATE sys_dept SET dept_name='平台运维组', leader='平台管理员' WHERE dept_id=107;
UPDATE sys_dept SET dept_name='学生发展组', leader='王同学' WHERE dept_id=108;
UPDATE sys_dept SET dept_name='实训支持组', leader='赵老师' WHERE dept_id=109;

UPDATE sys_post SET post_code='platform_director', post_name='平台负责人' WHERE post_id=1;
UPDATE sys_post SET post_code='teaching_manager', post_name='教学主管' WHERE post_id=2;
UPDATE sys_post SET post_code='resource_auditor', post_name='资源审核员' WHERE post_id=3;
UPDATE sys_post SET post_code='course_assistant', post_name='课程助理' WHERE post_id=4;

-- 用户基础资料
UPDATE sys_user SET nick_name='平台管理员', email='admin@school.local', phonenumber='13900001000', dept_id=107 WHERE user_name='admin';
UPDATE sys_user SET user_name='demo', nick_name='教学演示账号', email='demo@school.local', phonenumber='13900001001', dept_id=100 WHERE user_id=2;
UPDATE sys_user SET nick_name='张老师', email='teacher01@school.local', phonenumber='13900001011', dept_id=103 WHERE user_name='teacher01';
UPDATE sys_user SET nick_name='王同学', email='student01@school.local', phonenumber='13900001021', dept_id=108 WHERE user_name='student01';
UPDATE sys_user SET nick_name='审核老师', email='auditor01@school.local', phonenumber='13900001031', dept_id=105 WHERE user_name='auditor01';

-- 教学分类
UPDATE edu_category SET category_name='教学资源库', remark='教学资源分类根目录' WHERE category_id=1;
UPDATE edu_category SET category_name='课件资料', remark='教学课件与讲义资料' WHERE category_id=2;
UPDATE edu_category SET category_name='试题题库', remark='章节测试与期末题库' WHERE category_id=3;
UPDATE edu_category SET category_name='实验实践', remark='实验指导与实践项目' WHERE category_id=4;
UPDATE edu_category SET category_name='课程专区', remark='按课程维度组织资源' WHERE category_id=5;
UPDATE edu_category SET category_name='公共基础课', remark='通识与基础课程资源' WHERE category_id=6;
UPDATE edu_category SET category_name='专业核心课', remark='专业核心课程资源' WHERE category_id=7;
UPDATE edu_category SET category_name='素质拓展课', remark='素养与拓展课程资源' WHERE category_id=8;

-- 标签与课程
UPDATE edu_tag SET tag_name='精品资源', tag_type='推荐', color='#67C23A', remark='精品课程与重点推荐资源' WHERE tag_id=1;
UPDATE edu_tag SET tag_name='教师推荐', tag_type='推荐', color='#E6A23C', remark='教师优先推荐学习资料' WHERE tag_id=2;
UPDATE edu_tag SET tag_name='期中复习', tag_type='阶段', color='#409EFF', remark='适用于期中阶段复习' WHERE tag_id=3;
UPDATE edu_tag SET tag_name='期末冲刺', tag_type='阶段', color='#F56C6C', remark='适用于期末阶段冲刺' WHERE tag_id=4;
UPDATE edu_tag SET tag_name='最新上传', tag_type='时效', color='#909399', remark='近期上传的最新资料' WHERE tag_id=5;

UPDATE edu_course SET course_name='数据结构', course_code='KJ001', teacher_name='张老师', course_intro='围绕数据结构与算法设计，提供课件、实验和练习资料。', remark='专业核心课程', update_by='admin', update_time=NOW() WHERE course_id=1;
UPDATE edu_course SET course_name='高等数学', course_code='SX201', teacher_name='张老师', course_intro='提供高等数学课堂讲义、习题解析与复习资料。', remark='公共基础课程', update_by='admin', update_time=NOW() WHERE course_id=2;
UPDATE edu_course SET course_name='大学英语', course_code='YY301', teacher_name='李老师', course_intro='涵盖听说读写训练资料与课堂配套课件。', remark='公共基础课程', update_by='admin', update_time=NOW() WHERE course_id=3;
UPDATE edu_course SET course_name='教学设计基础', course_code='JX101', teacher_name='王老师', course_intro='面向师范与教学类专业的教学设计基础资源。', remark='教学能力课程', update_by='admin', update_time=NOW() WHERE course_id=4;

-- 空间配置与额度
UPDATE edu_global_config
SET remark='教学资源空间与分享统一配置',
    update_by='admin',
    update_time=NOW()
WHERE config_id=1;

INSERT INTO edu_user_quota (user_id, storage_gb, upload_mb, used_storage_mb, status, allow_share, allow_password_share, max_share_days, ban_reason, create_by, create_time, remark)
SELECT 1, 50, 1024, 1280.00, '0', '0', '0', 30, '', 'admin', NOW(), '管理员空间额度'
WHERE NOT EXISTS (SELECT 1 FROM edu_user_quota WHERE user_id=1);
INSERT INTO edu_user_quota (user_id, storage_gb, upload_mb, used_storage_mb, status, allow_share, allow_password_share, max_share_days, ban_reason, create_by, create_time, remark)
SELECT 100, 30, 512, 860.00, '0', '0', '0', 30, '', 'admin', NOW(), '教师默认空间'
WHERE NOT EXISTS (SELECT 1 FROM edu_user_quota WHERE user_id=100);
INSERT INTO edu_user_quota (user_id, storage_gb, upload_mb, used_storage_mb, status, allow_share, allow_password_share, max_share_days, ban_reason, create_by, create_time, remark)
SELECT 101, 8, 200, 320.00, '0', '1', '0', 7, '', 'admin', NOW(), '学生默认空间'
WHERE NOT EXISTS (SELECT 1 FROM edu_user_quota WHERE user_id=101);
INSERT INTO edu_user_quota (user_id, storage_gb, upload_mb, used_storage_mb, status, allow_share, allow_password_share, max_share_days, ban_reason, create_by, create_time, remark)
SELECT 102, 10, 200, 120.00, '0', '1', '0', 7, '', 'admin', NOW(), '审核账号空间'
WHERE NOT EXISTS (SELECT 1 FROM edu_user_quota WHERE user_id=102);

UPDATE edu_user_quota SET storage_gb=50, upload_mb=1024, used_storage_mb=1280.00, status='0', allow_share='0', allow_password_share='0', max_share_days=30, ban_reason='', update_by='admin', update_time=NOW(), remark='管理员空间额度' WHERE user_id=1;
UPDATE edu_user_quota SET storage_gb=30, upload_mb=512, used_storage_mb=860.00, status='0', allow_share='0', allow_password_share='0', max_share_days=30, ban_reason='', update_by='admin', update_time=NOW(), remark='教师默认空间' WHERE user_id=100;
UPDATE edu_user_quota SET storage_gb=8, upload_mb=200, used_storage_mb=320.00, status='0', allow_share='1', allow_password_share='0', max_share_days=7, ban_reason='', update_by='admin', update_time=NOW(), remark='学生默认空间' WHERE user_id=101;
UPDATE edu_user_quota SET storage_gb=10, upload_mb=200, used_storage_mb=120.00, status='0', allow_share='1', allow_password_share='0', max_share_days=7, ban_reason='', update_by='admin', update_time=NOW(), remark='审核账号空间' WHERE user_id=102;

-- 清理重复示例数据
DELETE FROM edu_teacher_student_grant WHERE grant_id > 1;
DELETE FROM edu_space_share WHERE share_id > 2;

INSERT INTO edu_teacher_student_grant (teacher_user_id, teacher_name, student_user_id, student_name, course_name, grant_preset, grant_perms, status, expires_at, create_by, create_time, remark)
SELECT 100, '张老师', 101, '王同学', '数据结构', 'read', '课件浏览,作业下载', '0', DATE_ADD(NOW(), INTERVAL 180 DAY), 'admin', NOW(), '课程资料查阅授权'
WHERE NOT EXISTS (SELECT 1 FROM edu_teacher_student_grant WHERE teacher_user_id=100 AND student_user_id=101 AND course_name='数据结构');

UPDATE edu_teacher_student_grant
SET teacher_name='张老师', student_name='王同学', course_name='数据结构', grant_preset='read', grant_perms='课件浏览,作业下载', status='0', remark='课程资料查阅授权', update_by='admin', update_time=NOW()
WHERE grant_id=1;

INSERT INTO edu_space_share (owner_user_id, owner_name, share_name, target_type, target_name, target_path, share_mode, share_password, expire_time, download_limit, download_count, view_count, status, create_by, create_time, remark)
SELECT 100, '张老师', '数据结构课程资料夹', 'folder', '数据结构-第一章', '/教师空间/张老师/数据结构-第一章', 'password', 'A1234', DATE_ADD(NOW(), INTERVAL 7 DAY), 50, 8, 26, '0', 'admin', NOW(), '学生课后复习分享'
WHERE NOT EXISTS (SELECT 1 FROM edu_space_share WHERE share_name='数据结构课程资料夹');
INSERT INTO edu_space_share (owner_user_id, owner_name, share_name, target_type, target_name, target_path, share_mode, share_password, expire_time, download_limit, download_count, view_count, status, create_by, create_time, remark)
SELECT 1, '平台管理员', '新生指引课件', 'file', '平台使用指南.pptx', '/公共资源/平台使用指南.pptx', 'public', '', DATE_ADD(NOW(), INTERVAL 30 DAY), 0, 12, 46, '0', 'admin', NOW(), '新生入学指导文件'
WHERE NOT EXISTS (SELECT 1 FROM edu_space_share WHERE share_name='新生指引课件');

UPDATE edu_space_share SET owner_name='张老师', share_name='数据结构课程资料夹', target_name='数据结构-第一章', target_path='/教师空间/张老师/数据结构-第一章', share_mode='password', share_password='A1234', status='0', remark='学生课后复习分享', update_by='admin', update_time=NOW() WHERE share_id=1;
UPDATE edu_space_share SET owner_name='平台管理员', share_name='新生指引课件', target_name='平台使用指南.pptx', target_path='/公共资源/平台使用指南.pptx', share_mode='public', share_password='', status='0', remark='新生入学指导文件', update_by='admin', update_time=NOW() WHERE share_id=2;

-- 菜单与按钮
UPDATE sys_menu SET menu_name='教学资源', visible='0', update_by='admin', update_time=NOW() WHERE menu_id=2100;
UPDATE sys_menu SET menu_name='分类管理', order_num=1, visible='0', update_by='admin', update_time=NOW() WHERE menu_id=2201;
UPDATE sys_menu SET menu_name='标签管理', order_num=2, visible='0', update_by='admin', update_time=NOW() WHERE menu_id=2202;
UPDATE sys_menu SET menu_name='课程管理', order_num=3, visible='0', update_by='admin', update_time=NOW() WHERE menu_id=2203;
UPDATE sys_menu SET menu_name='资源管理', order_num=4, visible='0', update_by='admin', update_time=NOW() WHERE menu_id=2101;
UPDATE sys_menu SET menu_name='资源审核', order_num=5, visible='0', update_by='admin', update_time=NOW() WHERE menu_id=2102;
UPDATE sys_menu SET menu_name='资源授权', path='grant', component='edu/grant/index', perms='edu:grant:list', order_num=6, visible='0', update_by='admin', update_time=NOW() WHERE menu_id=2103;
UPDATE sys_menu SET menu_name='空间分享', path='share', component='edu/share/index', perms='edu:share:list', order_num=7, visible='0', update_by='admin', update_time=NOW() WHERE menu_id=2106;
UPDATE sys_menu SET menu_name='空间配额', path='quota', component='edu/quota/index', perms='edu:quota:list', order_num=8, visible='0', update_by='admin', update_time=NOW() WHERE menu_id=2104;
UPDATE sys_menu SET menu_name='空间策略', path='config', component='edu/config/index', perms='edu:config:query', order_num=9, visible='0', update_by='admin', update_time=NOW() WHERE menu_id=2105;
UPDATE sys_menu SET menu_name='查询', update_by='admin', update_time=NOW() WHERE menu_id=2260;
UPDATE sys_menu SET menu_name='新增', update_by='admin', update_time=NOW() WHERE menu_id=2261;
UPDATE sys_menu SET menu_name='修改', update_by='admin', update_time=NOW() WHERE menu_id=2262;
UPDATE sys_menu SET menu_name='删除', update_by='admin', update_time=NOW() WHERE menu_id=2263;

COMMIT;
