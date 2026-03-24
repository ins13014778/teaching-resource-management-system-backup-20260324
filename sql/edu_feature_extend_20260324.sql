SET NAMES utf8mb4;
START TRANSACTION;

CREATE TABLE IF NOT EXISTS edu_course_chapter (
  chapter_id       bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '章节ID',
  course_id        bigint(20)   NOT NULL COMMENT '课程ID',
  course_name      varchar(100) NOT NULL COMMENT '课程名称',
  chapter_title    varchar(200) NOT NULL COMMENT '章节标题',
  chapter_intro    varchar(1000) DEFAULT NULL COMMENT '章节简介',
  order_num        int(4)       DEFAULT 1 COMMENT '排序号',
  resource_count   int(11)      DEFAULT 0 COMMENT '关联资源数',
  status           char(1)      DEFAULT '0' COMMENT '状态（0正常 1停用）',
  del_flag         char(1)      DEFAULT '0' COMMENT '删除标记（0存在 2删除）',
  create_by        varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time      datetime     DEFAULT NULL COMMENT '创建时间',
  update_by        varchar(64)  DEFAULT '' COMMENT '更新者',
  update_time      datetime     DEFAULT NULL COMMENT '更新时间',
  remark           varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (chapter_id)
) ENGINE=InnoDB COMMENT='课程章节';

CREATE TABLE IF NOT EXISTS edu_comment (
  comment_id         bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  resource_id        bigint(20)   NOT NULL COMMENT '资源ID',
  resource_title     varchar(200) NOT NULL COMMENT '资源标题',
  user_id            bigint(20)   NOT NULL COMMENT '评论用户ID',
  user_name          varchar(100) NOT NULL COMMENT '评论用户',
  parent_id          bigint(20)   DEFAULT 0 COMMENT '父评论ID',
  parent_user_name   varchar(100) DEFAULT NULL COMMENT '父级评论用户',
  content            varchar(2000) NOT NULL COMMENT '评论内容',
  audit_status       varchar(20)  DEFAULT 'pending' COMMENT '审核状态',
  like_count         int(11)      DEFAULT 0 COMMENT '点赞数',
  status             char(1)      DEFAULT '0' COMMENT '状态（0正常 1停用）',
  del_flag           char(1)      DEFAULT '0' COMMENT '删除标记',
  create_by          varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time        datetime     DEFAULT NULL COMMENT '创建时间',
  update_by          varchar(64)  DEFAULT '' COMMENT '更新者',
  update_time        datetime     DEFAULT NULL COMMENT '更新时间',
  remark             varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (comment_id)
) ENGINE=InnoDB COMMENT='资源评论';

CREATE TABLE IF NOT EXISTS edu_favorite (
  favorite_id      bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  resource_id      bigint(20)   NOT NULL COMMENT '资源ID',
  resource_title   varchar(200) NOT NULL COMMENT '资源标题',
  user_id          bigint(20)   NOT NULL COMMENT '用户ID',
  user_name        varchar(100) NOT NULL COMMENT '用户名',
  create_by        varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time      datetime     DEFAULT NULL COMMENT '创建时间',
  update_by        varchar(64)  DEFAULT '' COMMENT '更新者',
  update_time      datetime     DEFAULT NULL COMMENT '更新时间',
  remark           varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (favorite_id),
  UNIQUE KEY uk_favorite_user_resource (user_id, resource_id)
) ENGINE=InnoDB COMMENT='资源收藏';

CREATE TABLE IF NOT EXISTS edu_download_log (
  log_id           bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '下载日志ID',
  resource_id      bigint(20)   NOT NULL COMMENT '资源ID',
  resource_title   varchar(200) NOT NULL COMMENT '资源标题',
  user_id          bigint(20)   NOT NULL COMMENT '下载用户ID',
  user_name        varchar(100) NOT NULL COMMENT '下载用户名',
  file_url         varchar(500) DEFAULT NULL COMMENT '文件地址',
  create_by        varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time      datetime     DEFAULT NULL COMMENT '创建时间',
  remark           varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (log_id)
) ENGINE=InnoDB COMMENT='下载日志';

CREATE TABLE IF NOT EXISTS edu_report (
  report_id        bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '举报ID',
  report_type      varchar(30)  NOT NULL COMMENT '举报类型(resource/comment)',
  target_id        bigint(20)   NOT NULL COMMENT '目标ID',
  target_title     varchar(200) DEFAULT NULL COMMENT '目标标题',
  reporter_id      bigint(20)   NOT NULL COMMENT '举报人ID',
  reporter_name    varchar(100) NOT NULL COMMENT '举报人',
  reason_type      varchar(100) DEFAULT NULL COMMENT '举报原因类型',
  report_content   varchar(2000) DEFAULT NULL COMMENT '举报说明',
  status           varchar(20)  DEFAULT 'pending' COMMENT '状态',
  handle_result    varchar(2000) DEFAULT NULL COMMENT '处理结果',
  handler_id       bigint(20)   DEFAULT NULL COMMENT '处理人ID',
  handler_name     varchar(100) DEFAULT NULL COMMENT '处理人',
  del_flag         char(1)      DEFAULT '0' COMMENT '删除标记',
  create_by        varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time      datetime     DEFAULT NULL COMMENT '创建时间',
  update_by        varchar(64)  DEFAULT '' COMMENT '更新者',
  update_time      datetime     DEFAULT NULL COMMENT '更新时间',
  remark           varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (report_id)
) ENGINE=InnoDB COMMENT='举报处理';

CREATE TABLE IF NOT EXISTS sys_feedback (
  feedback_id      bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '反馈ID',
  user_id          bigint(20)   NOT NULL COMMENT '用户ID',
  user_name        varchar(100) NOT NULL COMMENT '用户名',
  title            varchar(200) NOT NULL COMMENT '反馈标题',
  content          varchar(2000) NOT NULL COMMENT '反馈内容',
  contact          varchar(100) DEFAULT NULL COMMENT '联系方式',
  status           varchar(20)  DEFAULT 'pending' COMMENT '状态',
  reply_content    varchar(2000) DEFAULT NULL COMMENT '回复内容',
  reply_by         varchar(64)  DEFAULT NULL COMMENT '回复人',
  reply_time       datetime     DEFAULT NULL COMMENT '回复时间',
  del_flag         char(1)      DEFAULT '0' COMMENT '删除标记',
  create_by        varchar(64)  DEFAULT '' COMMENT '创建者',
  create_time      datetime     DEFAULT NULL COMMENT '创建时间',
  update_by        varchar(64)  DEFAULT '' COMMENT '更新者',
  update_time      datetime     DEFAULT NULL COMMENT '更新时间',
  remark           varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (feedback_id)
) ENGINE=InnoDB COMMENT='意见反馈';

INSERT INTO edu_course_chapter(course_id, course_name, chapter_title, chapter_intro, order_num, resource_count, status, create_by, create_time, remark)
SELECT 1, '数据结构', '第一章 绪论', '课程目标、学习方法与评价说明', 1, 2, '0', 'admin', NOW(), '示例章节'
WHERE NOT EXISTS (SELECT 1 FROM edu_course_chapter WHERE course_id = 1 AND chapter_title = '第一章 绪论');

INSERT INTO edu_course_chapter(course_id, course_name, chapter_title, chapter_intro, order_num, resource_count, status, create_by, create_time, remark)
SELECT 2, '高等数学', '第一章 极限与连续', '极限概念、连续性及典型例题', 1, 3, '0', 'admin', NOW(), '示例章节'
WHERE NOT EXISTS (SELECT 1 FROM edu_course_chapter WHERE course_id = 2 AND chapter_title = '第一章 极限与连续');

INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2270, '课程章节', 2100, 10, 'chapter', 'edu/chapter/index', 1, 0, 'C', '0', '0', 'edu:chapter:list', 'tickets', 'admin', NOW(), '课程章节'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2270);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2271, '评论管理', 2100, 11, 'comment', 'edu/comment/index', 1, 0, 'C', '0', '0', 'edu:comment:list', 'message', 'admin', NOW(), '评论管理'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2271);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2272, '收藏记录', 2100, 12, 'favorite', 'edu/favorite/index', 1, 0, 'C', '0', '0', 'edu:favorite:list', 'star-on', 'admin', NOW(), '收藏记录'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2272);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2273, '举报处理', 2100, 13, 'report', 'edu/report/index', 1, 0, 'C', '0', '0', 'edu:report:list', 'warning-outline', 'admin', NOW(), '举报处理'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2273);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2274, '意见反馈', 2100, 14, 'feedback', 'edu/feedback/index', 1, 0, 'C', '0', '0', 'edu:feedback:list', 'chat-line-square', 'admin', NOW(), '意见反馈'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2274);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2275, '下载日志', 2100, 15, 'download', 'edu/download/index', 1, 0, 'C', '0', '0', 'edu:download:list', 'download', 'admin', NOW(), '下载日志'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2275);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2276, '统计分析', 2100, 16, 'stats', 'edu/stats/index', 1, 0, 'C', '0', '0', 'edu:stats:view', 'chart', 'admin', NOW(), '统计分析'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2276);

INSERT INTO sys_menu SELECT 2277, '查询', 2270, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:chapter:query', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2277);
INSERT INTO sys_menu SELECT 2278, '新增', 2270, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:chapter:add', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2278);
INSERT INTO sys_menu SELECT 2279, '修改', 2270, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:chapter:edit', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2279);
INSERT INTO sys_menu SELECT 2280, '删除', 2270, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:chapter:remove', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2280);

INSERT INTO sys_menu SELECT 2281, '查询', 2271, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:comment:query', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2281);
INSERT INTO sys_menu SELECT 2282, '新增', 2271, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:comment:add', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2282);
INSERT INTO sys_menu SELECT 2283, '修改', 2271, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:comment:edit', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2283);
INSERT INTO sys_menu SELECT 2284, '删除', 2271, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:comment:remove', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2284);
INSERT INTO sys_menu SELECT 2285, '审核', 2271, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:comment:audit', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2285);

INSERT INTO sys_menu SELECT 2286, '查询', 2272, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:favorite:query', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2286);
INSERT INTO sys_menu SELECT 2287, '新增', 2272, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:favorite:add', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2287);
INSERT INTO sys_menu SELECT 2288, '删除', 2272, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:favorite:remove', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2288);

INSERT INTO sys_menu SELECT 2289, '查询', 2273, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:report:query', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2289);
INSERT INTO sys_menu SELECT 2290, '新增', 2273, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:report:add', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2290);
INSERT INTO sys_menu SELECT 2291, '处理', 2273, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:report:handle', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2291);
INSERT INTO sys_menu SELECT 2292, '删除', 2273, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:report:remove', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2292);

INSERT INTO sys_menu SELECT 2293, '查询', 2274, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:feedback:query', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2293);
INSERT INTO sys_menu SELECT 2294, '新增', 2274, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:feedback:add', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2294);
INSERT INTO sys_menu SELECT 2295, '回复', 2274, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:feedback:reply', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2295);
INSERT INTO sys_menu SELECT 2296, '删除', 2274, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:feedback:remove', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2296);

INSERT INTO sys_menu SELECT 2297, '查询', 2275, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:download:query', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2297);
INSERT INTO sys_menu SELECT 2298, '删除', 2275, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:download:remove', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2298);
INSERT INTO sys_menu SELECT 2299, '查看', 2276, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:stats:view', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2299);

INSERT INTO sys_role_menu(role_id, menu_id)
SELECT 1, m.menu_id
FROM sys_menu m
WHERE m.menu_id BETWEEN 2270 AND 2299
  AND NOT EXISTS (SELECT 1 FROM sys_role_menu rm WHERE rm.role_id = 1 AND rm.menu_id = m.menu_id);

COMMIT;
