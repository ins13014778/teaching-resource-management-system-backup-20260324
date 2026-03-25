SET NAMES utf8mb4;
START TRANSACTION;

SET @stmt := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'edu_resource' AND COLUMN_NAME = 'like_count') = 0, "ALTER TABLE edu_resource ADD COLUMN like_count int(11) NOT NULL DEFAULT 0 COMMENT '点赞数' AFTER favorite_count", "SELECT 1");
PREPARE alter_like_col FROM @stmt;
EXECUTE alter_like_col;
DEALLOCATE PREPARE alter_like_col;

CREATE TABLE IF NOT EXISTS edu_resource_like (
  like_id           bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  resource_id       bigint(20)   NOT NULL COMMENT '资源ID',
  resource_title    varchar(200) NOT NULL COMMENT '资源标题',
  user_id           bigint(20)   NOT NULL COMMENT '用户ID',
  user_name         varchar(100) NOT NULL COMMENT '用户名',
  create_by         varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time       datetime     DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (like_id),
  UNIQUE KEY uk_like_user_resource (user_id, resource_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资源点赞';

CREATE TABLE IF NOT EXISTS edu_course_notice (
  notice_id         bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  course_id         bigint(20)   NOT NULL COMMENT '课程ID',
  course_name       varchar(100) NOT NULL COMMENT '课程名称',
  notice_title      varchar(200) NOT NULL COMMENT '公告标题',
  notice_content    varchar(4000) NOT NULL COMMENT '公告内容',
  publisher_id      bigint(20)   NOT NULL COMMENT '发布人ID',
  publisher_name    varchar(100) NOT NULL COMMENT '发布人名称',
  status            char(1)      DEFAULT '0' COMMENT '状态（0正常 1停用）',
  del_flag          char(1)      DEFAULT '0' COMMENT '删除标志',
  create_by         varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time       datetime     DEFAULT NULL COMMENT '创建时间',
  update_by         varchar(64)  DEFAULT '' COMMENT '更新者',
  update_time       datetime     DEFAULT NULL COMMENT '更新时间',
  remark            varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (notice_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程公告';

CREATE TABLE IF NOT EXISTS edu_message_center (
  message_id        bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  user_id           bigint(20)   NOT NULL COMMENT '接收用户ID',
  user_name         varchar(100) NOT NULL COMMENT '接收用户名',
  message_title     varchar(200) NOT NULL COMMENT '消息标题',
  message_content   varchar(4000) NOT NULL COMMENT '消息内容',
  message_type      varchar(50)  DEFAULT 'system' COMMENT '消息类型',
  biz_id            bigint(20)   DEFAULT NULL COMMENT '业务ID',
  read_status       char(1)      DEFAULT '0' COMMENT '读取状态（0未读 1已读）',
  del_flag          char(1)      DEFAULT '0' COMMENT '删除标志',
  create_by         varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time       datetime     DEFAULT NULL COMMENT '创建时间',
  update_by         varchar(64)  DEFAULT '' COMMENT '更新者',
  update_time       datetime     DEFAULT NULL COMMENT '更新时间',
  remark            varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (message_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='消息中心';

CREATE TABLE IF NOT EXISTS ai_task (
  task_id           bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  task_type         varchar(50)  NOT NULL COMMENT '任务类型',
  resource_id       bigint(20)   DEFAULT NULL COMMENT '资源ID',
  resource_title    varchar(200) DEFAULT NULL COMMENT '资源标题',
  trigger_scene     varchar(50)  DEFAULT NULL COMMENT '触发场景',
  task_status       varchar(20)  DEFAULT 'success' COMMENT '任务状态',
  result_json       longtext COMMENT '结果JSON',
  error_msg         varchar(1000) DEFAULT NULL COMMENT '错误信息',
  start_time        datetime DEFAULT NULL COMMENT '开始时间',
  finish_time       datetime DEFAULT NULL COMMENT '完成时间',
  create_by         varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time       datetime DEFAULT NULL COMMENT '创建时间',
  update_by         varchar(64)  DEFAULT '' COMMENT '更新者',
  update_time       datetime DEFAULT NULL COMMENT '更新时间',
  remark            varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (task_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI任务';

CREATE TABLE IF NOT EXISTS ai_prompt_template (
  template_id       bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  template_key      varchar(100) NOT NULL COMMENT '模板KEY',
  template_name     varchar(200) NOT NULL COMMENT '模板名称',
  prompt_content    varchar(4000) NOT NULL COMMENT '提示词内容',
  status            char(1)      DEFAULT '0' COMMENT '状态（0正常 1停用）',
  create_by         varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time       datetime DEFAULT NULL COMMENT '创建时间',
  update_by         varchar(64)  DEFAULT '' COMMENT '更新者',
  update_time       datetime DEFAULT NULL COMMENT '更新时间',
  remark            varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (template_id),
  UNIQUE KEY uk_ai_prompt_key (template_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI提示词模板';

CREATE TABLE IF NOT EXISTS ai_audit_result (
  result_id         bigint(20)   NOT NULL AUTO_INCREMENT COMMENT 'AI审核结果ID',
  resource_id       bigint(20)   NOT NULL COMMENT '资源ID',
  resource_title    varchar(200) NOT NULL COMMENT '资源标题',
  risk_score        decimal(10,2) DEFAULT 0 COMMENT '风险分',
  duplicate_score   decimal(10,2) DEFAULT 0 COMMENT '重复分',
  compliance_level  varchar(50)  DEFAULT NULL COMMENT '合规等级',
  hit_words         varchar(1000) DEFAULT NULL COMMENT '命中词汇',
  suggestion        varchar(2000) DEFAULT NULL COMMENT '处理建议',
  audit_summary     varchar(2000) DEFAULT NULL COMMENT '审核摘要',
  status            varchar(20)  DEFAULT 'done' COMMENT '状态',
  raw_result        longtext COMMENT '原始结果',
  create_by         varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time       datetime DEFAULT NULL COMMENT '创建时间',
  update_by         varchar(64)  DEFAULT '' COMMENT '更新者',
  update_time       datetime DEFAULT NULL COMMENT '更新时间',
  remark            varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (result_id),
  UNIQUE KEY uk_ai_audit_resource (resource_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI审核结果';

CREATE TABLE IF NOT EXISTS ai_embedding_index (
  index_id          bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  resource_id       bigint(20)   NOT NULL COMMENT '资源ID',
  resource_title    varchar(200) NOT NULL COMMENT '资源标题',
  keyword_text      varchar(4000) DEFAULT NULL COMMENT '关键词文本',
  summary_text      varchar(2000) DEFAULT NULL COMMENT '摘要文本',
  create_by         varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time       datetime DEFAULT NULL COMMENT '创建时间',
  update_by         varchar(64)  DEFAULT '' COMMENT '更新者',
  update_time       datetime DEFAULT NULL COMMENT '更新时间',
  remark            varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (index_id),
  UNIQUE KEY uk_ai_embedding_resource (resource_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI向量索引';

CREATE TABLE IF NOT EXISTS ai_qa_log (
  qa_id                 bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '问答ID',
  user_id               bigint(20)   DEFAULT NULL COMMENT '用户ID',
  user_name             varchar(100) DEFAULT NULL COMMENT '用户名',
  question              varchar(2000) NOT NULL COMMENT '问题',
  answer                varchar(4000) DEFAULT NULL COMMENT '答案',
  reference_resource_ids varchar(1000) DEFAULT NULL COMMENT '参考资源ID',
  reference_titles      varchar(1000) DEFAULT NULL COMMENT '参考资源标题',
  model_name            varchar(100) DEFAULT 'Local-Heuristic-AI' COMMENT '模型名称',
  cost_millis           bigint(20) DEFAULT 0 COMMENT '耗时毫秒',
  create_by             varchar(64) DEFAULT '' COMMENT '创建者',
  create_time           datetime DEFAULT NULL COMMENT '创建时间',
  remark                varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (qa_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI问答记录';

INSERT INTO ai_prompt_template(template_key, template_name, prompt_content, status, create_by, create_time, remark)
SELECT 'resource.summary', '资源摘要生成', '请根据资源标题、课程、分类和简介生成一段适用于教学资源管理系统的中文摘要，突出适用场景、资源类型和教学用途。', '0', 'admin', NOW(), '系统默认模板'
WHERE NOT EXISTS (SELECT 1 FROM ai_prompt_template WHERE template_key = 'resource.summary');

INSERT INTO ai_prompt_template(template_key, template_name, prompt_content, status, create_by, create_time, remark)
SELECT 'resource.tags', '资源标签生成', '请从资源标题、简介、课程和分类中提取 3-8 个中文标签，优先输出课程名称、知识点、资源类型和适用对象。', '0', 'admin', NOW(), '系统默认模板'
WHERE NOT EXISTS (SELECT 1 FROM ai_prompt_template WHERE template_key = 'resource.tags');

INSERT INTO ai_prompt_template(template_key, template_name, prompt_content, status, create_by, create_time, remark)
SELECT 'resource.audit', '资源内容审核', '请结合资源标题、简介、文件信息与教学场景，对资源进行合规审核，输出风险点、重复风险和处理建议。', '0', 'admin', NOW(), '系统默认模板'
WHERE NOT EXISTS (SELECT 1 FROM ai_prompt_template WHERE template_key = 'resource.audit');

INSERT INTO edu_course_notice(course_id, course_name, notice_title, notice_content, publisher_id, publisher_name, status, create_by, create_time, remark)
SELECT 1, '高等数学', '课程资源上新通知', '本周已更新高等数学课程课件、教案与习题资料，请同学们及时查看下载。', 1, 'admin', '0', 'admin', NOW(), '系统初始化公告'
WHERE NOT EXISTS (SELECT 1 FROM edu_course_notice WHERE course_id = 1 AND notice_title = '课程资源上新通知');

INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2300, '课程公告', 2100, 17, 'notice', 'edu/notice/index', 1, 0, 'C', '0', '0', 'edu:notice:list', 'message', 'admin', NOW(), '课程公告管理'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2300);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2301, '消息中心', 2100, 18, 'message', 'edu/message/index', 1, 0, 'C', '0', '0', 'edu:message:list', 'email', 'admin', NOW(), '系统消息管理'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2301);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2302, '资源搜索', 2100, 19, 'search', 'edu/search/index', 1, 0, 'C', '0', '0', 'edu:search:list', 'search', 'admin', NOW(), '教学资源搜索'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2302);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2303, '资源点赞', 2100, 20, 'like', 'edu/like/index', 1, 0, 'C', '0', '0', 'edu:like:list', 'thumb', 'admin', NOW(), '资源点赞管理'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2303);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2310, 'AI任务', 2100, 21, 'ai-task', 'ai/task/index', 1, 0, 'C', '0', '0', 'ai:task:list', 'guide', 'admin', NOW(), 'AI任务管理'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2310);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2311, 'AI提示词', 2100, 22, 'ai-prompt', 'ai/prompt/index', 1, 0, 'C', '0', '0', 'ai:prompt:list', 'edit', 'admin', NOW(), 'AI提示词模板'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2311);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2312, 'AI审核结果', 2100, 23, 'ai-audit', 'ai/audit/index', 1, 0, 'C', '0', '0', 'ai:audit:list', 'form', 'admin', NOW(), 'AI审核结果管理'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2312);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2313, 'AI问答', 2100, 24, 'ai-qa', 'ai/qa/index', 1, 0, 'C', '0', '0', 'ai:qa:list', 'question', 'admin', NOW(), 'AI问答记录'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2313);

INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2320, '查询', 2300, 1, '#', '', 1, 0, 'F', '0', '0', 'edu:notice:query', '#', 'admin', NOW(), '课程公告按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2320);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2321, '新增', 2300, 2, '#', '', 1, 0, 'F', '0', '0', 'edu:notice:add', '#', 'admin', NOW(), '课程公告按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2321);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2322, '修改', 2300, 3, '#', '', 1, 0, 'F', '0', '0', 'edu:notice:edit', '#', 'admin', NOW(), '课程公告按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2322);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2323, '删除', 2300, 4, '#', '', 1, 0, 'F', '0', '0', 'edu:notice:remove', '#', 'admin', NOW(), '课程公告按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2323);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2324, '查询', 2301, 1, '#', '', 1, 0, 'F', '0', '0', 'edu:message:query', '#', 'admin', NOW(), '消息中心按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2324);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2325, '新增', 2301, 2, '#', '', 1, 0, 'F', '0', '0', 'edu:message:add', '#', 'admin', NOW(), '消息中心按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2325);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2326, '删除', 2301, 3, '#', '', 1, 0, 'F', '0', '0', 'edu:message:remove', '#', 'admin', NOW(), '消息中心按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2326);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2327, '搜索', 2302, 1, '#', '', 1, 0, 'F', '0', '0', 'edu:search:list', '#', 'admin', NOW(), '资源搜索按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2327);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2328, '查询', 2303, 1, '#', '', 1, 0, 'F', '0', '0', 'edu:like:query', '#', 'admin', NOW(), '资源点赞按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2328);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2329, '删除', 2303, 2, '#', '', 1, 0, 'F', '0', '0', 'edu:like:remove', '#', 'admin', NOW(), '资源点赞按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2329);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2330, '查询', 2310, 1, '#', '', 1, 0, 'F', '0', '0', 'ai:task:query', '#', 'admin', NOW(), 'AI任务按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2330);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2331, '执行', 2310, 2, '#', '', 1, 0, 'F', '0', '0', 'ai:task:run', '#', 'admin', NOW(), 'AI任务按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2331);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2332, '删除', 2310, 3, '#', '', 1, 0, 'F', '0', '0', 'ai:task:remove', '#', 'admin', NOW(), 'AI任务按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2332);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2333, '查询', 2311, 1, '#', '', 1, 0, 'F', '0', '0', 'ai:prompt:query', '#', 'admin', NOW(), 'AI提示词按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2333);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2334, '新增', 2311, 2, '#', '', 1, 0, 'F', '0', '0', 'ai:prompt:add', '#', 'admin', NOW(), 'AI提示词按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2334);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2335, '修改', 2311, 3, '#', '', 1, 0, 'F', '0', '0', 'ai:prompt:edit', '#', 'admin', NOW(), 'AI提示词按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2335);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2336, '删除', 2311, 4, '#', '', 1, 0, 'F', '0', '0', 'ai:prompt:remove', '#', 'admin', NOW(), 'AI提示词按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2336);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2337, '查询', 2312, 1, '#', '', 1, 0, 'F', '0', '0', 'ai:audit:query', '#', 'admin', NOW(), 'AI审核按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2337);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2338, '删除', 2312, 2, '#', '', 1, 0, 'F', '0', '0', 'ai:audit:remove', '#', 'admin', NOW(), 'AI审核按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2338);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2339, '查询', 2313, 1, '#', '', 1, 0, 'F', '0', '0', 'ai:qa:query', '#', 'admin', NOW(), 'AI问答按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2339);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2340, '执行', 2313, 2, '#', '', 1, 0, 'F', '0', '0', 'ai:qa:ask', '#', 'admin', NOW(), 'AI问答按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2340);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2341, '删除', 2313, 3, '#', '', 1, 0, 'F', '0', '0', 'ai:qa:remove', '#', 'admin', NOW(), 'AI问答按钮'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2341);

UPDATE sys_menu SET route_name = 'SystemConfig' WHERE menu_id = 106;
UPDATE sys_menu SET route_name = 'SystemNotice' WHERE menu_id = 107;
UPDATE sys_menu SET route_name = 'EduConfig', remark = '全局策略配置' WHERE menu_id = 2105;
UPDATE sys_menu SET route_name = 'EduShare', remark = '空间分享管理' WHERE menu_id = 2106;
UPDATE sys_menu SET route_name = 'EduNotice' WHERE menu_id = 2300;
UPDATE sys_menu SET route_name = 'EduMessage' WHERE menu_id = 2301;
UPDATE sys_menu SET route_name = 'EduSearch' WHERE menu_id = 2302;
UPDATE sys_menu SET route_name = 'EduLike' WHERE menu_id = 2303;
UPDATE sys_menu SET route_name = 'AiTask' WHERE menu_id = 2310;
UPDATE sys_menu SET route_name = 'AiPrompt' WHERE menu_id = 2311;
UPDATE sys_menu SET route_name = 'AiAudit' WHERE menu_id = 2312;
UPDATE sys_menu SET route_name = 'AiQa' WHERE menu_id = 2313;
UPDATE sys_menu SET remark = '空间分享按钮' WHERE menu_id BETWEEN 2260 AND 2263;

UPDATE sys_config
SET config_name = '账号自助-教师注册开关', remark = 'true 开启，false 关闭'
WHERE config_key = 'sys.account.registerTeacher';

UPDATE sys_config
SET config_name = '账号自助-学生注册开关', remark = 'true 开启，false 关闭'
WHERE config_key = 'sys.account.registerStudent';

INSERT INTO sys_role_menu(role_id, menu_id)
SELECT 1, m.menu_id FROM sys_menu m
WHERE m.menu_id BETWEEN 2300 AND 2341
AND NOT EXISTS (SELECT 1 FROM sys_role_menu rm WHERE rm.role_id = 1 AND rm.menu_id = m.menu_id);

COMMIT;
