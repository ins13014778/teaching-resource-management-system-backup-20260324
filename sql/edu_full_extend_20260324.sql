
SET NAMES utf8mb4;
START TRANSACTION;

SET @stmt := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'edu_resource' AND COLUMN_NAME = 'like_count') = 0, "ALTER TABLE edu_resource ADD COLUMN like_count int(11) NOT NULL DEFAULT 0 COMMENT '????' AFTER favorite_count", "SELECT 1");
PREPARE alter_like_col FROM @stmt;
EXECUTE alter_like_col;
DEALLOCATE PREPARE alter_like_col;

CREATE TABLE IF NOT EXISTS edu_resource_like (
  like_id           bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '??ID',
  resource_id       bigint(20)   NOT NULL COMMENT '??ID',
  resource_title    varchar(200) NOT NULL COMMENT '????',
  user_id           bigint(20)   NOT NULL COMMENT '??ID',
  user_name         varchar(100) NOT NULL COMMENT '???',
  create_by         varchar(64)  DEFAULT '' COMMENT '???',
  create_time       datetime     DEFAULT NULL COMMENT '????',
  PRIMARY KEY (like_id),
  UNIQUE KEY uk_like_user_resource (user_id, resource_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='????';

CREATE TABLE IF NOT EXISTS edu_course_notice (
  notice_id         bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '????ID',
  course_id         bigint(20)   NOT NULL COMMENT '??ID',
  course_name       varchar(100) NOT NULL COMMENT '????',
  notice_title      varchar(200) NOT NULL COMMENT '????',
  notice_content    varchar(4000) NOT NULL COMMENT '????',
  publisher_id      bigint(20)   NOT NULL COMMENT '???ID',
  publisher_name    varchar(100) NOT NULL COMMENT '???',
  status            char(1)      DEFAULT '0' COMMENT '???0?? 1???',
  del_flag          char(1)      DEFAULT '0' COMMENT '????',
  create_by         varchar(64)  DEFAULT '' COMMENT '???',
  create_time       datetime     DEFAULT NULL COMMENT '????',
  update_by         varchar(64)  DEFAULT '' COMMENT '???',
  update_time       datetime     DEFAULT NULL COMMENT '????',
  remark            varchar(500) DEFAULT NULL COMMENT '??',
  PRIMARY KEY (notice_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='????';

CREATE TABLE IF NOT EXISTS edu_message_center (
  message_id        bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '??ID',
  user_id           bigint(20)   NOT NULL COMMENT '????ID',
  user_name         varchar(100) NOT NULL COMMENT '?????',
  message_title     varchar(200) NOT NULL COMMENT '????',
  message_content   varchar(4000) NOT NULL COMMENT '????',
  message_type      varchar(50)  DEFAULT 'system' COMMENT '????',
  biz_id            bigint(20)   DEFAULT NULL COMMENT '??ID',
  read_status       char(1)      DEFAULT '0' COMMENT '?????0?? 1???',
  del_flag          char(1)      DEFAULT '0' COMMENT '????',
  create_by         varchar(64)  DEFAULT '' COMMENT '???',
  create_time       datetime     DEFAULT NULL COMMENT '????',
  update_by         varchar(64)  DEFAULT '' COMMENT '???',
  update_time       datetime     DEFAULT NULL COMMENT '????',
  remark            varchar(500) DEFAULT NULL COMMENT '??',
  PRIMARY KEY (message_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='??????';

CREATE TABLE IF NOT EXISTS ai_task (
  task_id           bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '??ID',
  task_type         varchar(50)  NOT NULL COMMENT '????',
  resource_id       bigint(20)   DEFAULT NULL COMMENT '??ID',
  resource_title    varchar(200) DEFAULT NULL COMMENT '????',
  trigger_scene     varchar(50)  DEFAULT NULL COMMENT '????',
  task_status       varchar(20)  DEFAULT 'success' COMMENT '????',
  result_json       longtext COMMENT '??JSON',
  error_msg         varchar(1000) DEFAULT NULL COMMENT '????',
  start_time        datetime DEFAULT NULL COMMENT '????',
  finish_time       datetime DEFAULT NULL COMMENT '????',
  create_by         varchar(64)  DEFAULT '' COMMENT '???',
  create_time       datetime DEFAULT NULL COMMENT '????',
  update_by         varchar(64)  DEFAULT '' COMMENT '???',
  update_time       datetime DEFAULT NULL COMMENT '????',
  remark            varchar(500) DEFAULT NULL COMMENT '??',
  PRIMARY KEY (task_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI??';

CREATE TABLE IF NOT EXISTS ai_prompt_template (
  template_id       bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '??ID',
  template_key      varchar(100) NOT NULL COMMENT '??KEY',
  template_name     varchar(200) NOT NULL COMMENT '????',
  prompt_content    varchar(4000) NOT NULL COMMENT '?????',
  status            char(1)      DEFAULT '0' COMMENT '???0?? 1???',
  create_by         varchar(64)  DEFAULT '' COMMENT '???',
  create_time       datetime DEFAULT NULL COMMENT '????',
  update_by         varchar(64)  DEFAULT '' COMMENT '???',
  update_time       datetime DEFAULT NULL COMMENT '????',
  remark            varchar(500) DEFAULT NULL COMMENT '??',
  PRIMARY KEY (template_id),
  UNIQUE KEY uk_ai_prompt_key (template_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI?????';

CREATE TABLE IF NOT EXISTS ai_audit_result (
  result_id         bigint(20)   NOT NULL AUTO_INCREMENT COMMENT 'AI????ID',
  resource_id       bigint(20)   NOT NULL COMMENT '??ID',
  resource_title    varchar(200) NOT NULL COMMENT '????',
  risk_score        decimal(10,2) DEFAULT 0 COMMENT '???',
  duplicate_score   decimal(10,2) DEFAULT 0 COMMENT '???',
  compliance_level  varchar(50)  DEFAULT NULL COMMENT '????',
  hit_words         varchar(1000) DEFAULT NULL COMMENT '?????',
  suggestion        varchar(2000) DEFAULT NULL COMMENT '????',
  audit_summary     varchar(2000) DEFAULT NULL COMMENT '????',
  status            varchar(20)  DEFAULT 'done' COMMENT '??',
  raw_result        longtext COMMENT '????',
  create_by         varchar(64)  DEFAULT '' COMMENT '???',
  create_time       datetime DEFAULT NULL COMMENT '????',
  update_by         varchar(64)  DEFAULT '' COMMENT '???',
  update_time       datetime DEFAULT NULL COMMENT '????',
  remark            varchar(500) DEFAULT NULL COMMENT '??',
  PRIMARY KEY (result_id),
  UNIQUE KEY uk_ai_audit_resource (resource_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI????';

CREATE TABLE IF NOT EXISTS ai_embedding_index (
  index_id          bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '??ID',
  resource_id       bigint(20)   NOT NULL COMMENT '??ID',
  resource_title    varchar(200) NOT NULL COMMENT '????',
  keyword_text      varchar(4000) DEFAULT NULL COMMENT '?????',
  summary_text      varchar(2000) DEFAULT NULL COMMENT '????',
  create_by         varchar(64)  DEFAULT '' COMMENT '???',
  create_time       datetime DEFAULT NULL COMMENT '????',
  update_by         varchar(64)  DEFAULT '' COMMENT '???',
  update_time       datetime DEFAULT NULL COMMENT '????',
  remark            varchar(500) DEFAULT NULL COMMENT '??',
  PRIMARY KEY (index_id),
  UNIQUE KEY uk_ai_embedding_resource (resource_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI????';

CREATE TABLE IF NOT EXISTS ai_qa_log (
  qa_id                 bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '????ID',
  user_id               bigint(20)   DEFAULT NULL COMMENT '??ID',
  user_name             varchar(100) DEFAULT NULL COMMENT '???',
  question              varchar(2000) NOT NULL COMMENT '??',
  answer                varchar(4000) DEFAULT NULL COMMENT '??',
  reference_resource_ids varchar(1000) DEFAULT NULL COMMENT '????ID',
  reference_titles      varchar(1000) DEFAULT NULL COMMENT '??????',
  model_name            varchar(100) DEFAULT 'Local-Heuristic-AI' COMMENT '????',
  cost_millis           bigint(20) DEFAULT 0 COMMENT '????',
  create_by             varchar(64) DEFAULT '' COMMENT '???',
  create_time           datetime DEFAULT NULL COMMENT '????',
  remark                varchar(500) DEFAULT NULL COMMENT '??',
  PRIMARY KEY (qa_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI????';

INSERT INTO ai_prompt_template(template_key, template_name, prompt_content, status, create_by, create_time, remark)
SELECT 'resource.summary', '??????', '???????????????????????????????????', '0', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM ai_prompt_template WHERE template_key = 'resource.summary');

INSERT INTO ai_prompt_template(template_key, template_name, prompt_content, status, create_by, create_time, remark)
SELECT 'resource.tags', '??????', '????????????????????????????', '0', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM ai_prompt_template WHERE template_key = 'resource.tags');

INSERT INTO ai_prompt_template(template_key, template_name, prompt_content, status, create_by, create_time, remark)
SELECT 'resource.audit', '??????', '????????????????????????????', '0', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM ai_prompt_template WHERE template_key = 'resource.audit');

INSERT INTO edu_course_notice(course_id, course_name, notice_title, notice_content, publisher_id, publisher_name, status, create_by, create_time, remark)
SELECT 1, '????', '????????', '??????????????????????????', 1, 'admin', '0', 'admin', NOW(), '???????'
WHERE NOT EXISTS (SELECT 1 FROM edu_course_notice WHERE course_id = 1 AND notice_title = '????????');

INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2300, '????', 2100, 17, 'notice', 'edu/notice/index', 1, 0, 'C', '0', '0', 'edu:notice:list', 'message', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2300);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2301, '????', 2100, 18, 'message', 'edu/message/index', 1, 0, 'C', '0', '0', 'edu:message:list', 'email', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2301);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2302, '????', 2100, 19, 'search', 'edu/search/index', 1, 0, 'C', '0', '0', 'edu:search:list', 'search', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2302);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2303, '????', 2100, 20, 'like', 'edu/like/index', 1, 0, 'C', '0', '0', 'edu:like:list', 'thumb', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2303);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2310, 'AI??', 2100, 21, 'ai-task', 'ai/task/index', 1, 0, 'C', '0', '0', 'ai:task:list', 'guide', 'admin', NOW(), 'AI??'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2310);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2311, 'AI???', 2100, 22, 'ai-prompt', 'ai/prompt/index', 1, 0, 'C', '0', '0', 'ai:prompt:list', 'edit', 'admin', NOW(), 'AI???'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2311);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2312, 'AI????', 2100, 23, 'ai-audit', 'ai/audit/index', 1, 0, 'C', '0', '0', 'ai:audit:list', 'form', 'admin', NOW(), 'AI????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2312);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2313, 'AI??', 2100, 24, 'ai-qa', 'ai/qa/index', 1, 0, 'C', '0', '0', 'ai:qa:list', 'question', 'admin', NOW(), 'AI??'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2313);

INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2320, '??', 2300, 1, '#', '', 1, 0, 'F', '0', '0', 'edu:notice:query', '#', 'admin', NOW(), '??????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2320);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2321, '??', 2300, 2, '#', '', 1, 0, 'F', '0', '0', 'edu:notice:add', '#', 'admin', NOW(), '??????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2321);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2322, '??', 2300, 3, '#', '', 1, 0, 'F', '0', '0', 'edu:notice:edit', '#', 'admin', NOW(), '??????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2322);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2323, '??', 2300, 4, '#', '', 1, 0, 'F', '0', '0', 'edu:notice:remove', '#', 'admin', NOW(), '??????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2323);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2324, '??', 2301, 1, '#', '', 1, 0, 'F', '0', '0', 'edu:message:query', '#', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2324);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2325, '??', 2301, 2, '#', '', 1, 0, 'F', '0', '0', 'edu:message:add', '#', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2325);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2326, '??', 2301, 3, '#', '', 1, 0, 'F', '0', '0', 'edu:message:remove', '#', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2326);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2327, '??', 2302, 1, '#', '', 1, 0, 'F', '0', '0', 'edu:search:list', '#', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2327);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2328, '??', 2303, 1, '#', '', 1, 0, 'F', '0', '0', 'edu:like:query', '#', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2328);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2329, '??', 2303, 2, '#', '', 1, 0, 'F', '0', '0', 'edu:like:remove', '#', 'admin', NOW(), '????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2329);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2330, '??', 2310, 1, '#', '', 1, 0, 'F', '0', '0', 'ai:task:query', '#', 'admin', NOW(), 'AI????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2330);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2331, '??', 2310, 2, '#', '', 1, 0, 'F', '0', '0', 'ai:task:run', '#', 'admin', NOW(), 'AI????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2331);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2332, '??', 2310, 3, '#', '', 1, 0, 'F', '0', '0', 'ai:task:remove', '#', 'admin', NOW(), 'AI????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2332);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2333, '??', 2311, 1, '#', '', 1, 0, 'F', '0', '0', 'ai:prompt:query', '#', 'admin', NOW(), 'AI?????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2333);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2334, '??', 2311, 2, '#', '', 1, 0, 'F', '0', '0', 'ai:prompt:add', '#', 'admin', NOW(), 'AI?????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2334);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2335, '??', 2311, 3, '#', '', 1, 0, 'F', '0', '0', 'ai:prompt:edit', '#', 'admin', NOW(), 'AI?????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2335);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2336, '??', 2311, 4, '#', '', 1, 0, 'F', '0', '0', 'ai:prompt:remove', '#', 'admin', NOW(), 'AI?????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2336);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2337, '??', 2312, 1, '#', '', 1, 0, 'F', '0', '0', 'ai:audit:query', '#', 'admin', NOW(), 'AI????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2337);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2338, '??', 2312, 2, '#', '', 1, 0, 'F', '0', '0', 'ai:audit:remove', '#', 'admin', NOW(), 'AI????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2338);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2339, '??', 2313, 1, '#', '', 1, 0, 'F', '0', '0', 'ai:qa:query', '#', 'admin', NOW(), 'AI????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2339);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2340, '??', 2313, 2, '#', '', 1, 0, 'F', '0', '0', 'ai:qa:ask', '#', 'admin', NOW(), 'AI????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2340);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2341, '??', 2313, 3, '#', '', 1, 0, 'F', '0', '0', 'ai:qa:remove', '#', 'admin', NOW(), 'AI????'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2341);

INSERT INTO sys_role_menu(role_id, menu_id)
SELECT 1, m.menu_id FROM sys_menu m
WHERE m.menu_id BETWEEN 2300 AND 2341
AND NOT EXISTS (SELECT 1 FROM sys_role_menu rm WHERE rm.role_id = 1 AND rm.menu_id = m.menu_id);

COMMIT;
