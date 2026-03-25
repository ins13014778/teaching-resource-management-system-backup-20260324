SET NAMES utf8mb4;
START TRANSACTION;

DELETE FROM sys_role_menu WHERE menu_id = 4;
DELETE FROM sys_menu WHERE menu_id = 4;

UPDATE sys_menu SET route_name = 'SystemConfig' WHERE menu_id = 106;
UPDATE sys_menu SET route_name = 'SystemNotice' WHERE menu_id = 107;
UPDATE sys_menu SET route_name = 'EduConfig', remark = '全局策略配置' WHERE menu_id = 2105;
UPDATE sys_menu SET route_name = 'EduShare', remark = '空间分享管理' WHERE menu_id = 2106;
UPDATE sys_menu SET route_name = 'EduNotice', remark = '课程公告管理' WHERE menu_id = 2300;
UPDATE sys_menu SET route_name = 'EduMessage', remark = '系统消息管理' WHERE menu_id = 2301;
UPDATE sys_menu SET route_name = 'EduSearch', remark = '教学资源搜索' WHERE menu_id = 2302;
UPDATE sys_menu SET route_name = 'EduLike', remark = '资源点赞管理' WHERE menu_id = 2303;
UPDATE sys_menu SET route_name = 'AiTask', remark = 'AI任务管理' WHERE menu_id = 2310;
UPDATE sys_menu SET route_name = 'AiPrompt', remark = 'AI提示词模板' WHERE menu_id = 2311;
UPDATE sys_menu SET route_name = 'AiAudit', remark = 'AI审核结果管理' WHERE menu_id = 2312;
UPDATE sys_menu SET route_name = 'AiQa', remark = 'AI问答记录' WHERE menu_id = 2313;
UPDATE sys_menu SET remark = '课程公告按钮' WHERE menu_id BETWEEN 2320 AND 2323;
UPDATE sys_menu SET remark = '消息中心按钮' WHERE menu_id BETWEEN 2324 AND 2326;
UPDATE sys_menu SET remark = '资源搜索按钮' WHERE menu_id = 2327;
UPDATE sys_menu SET remark = '资源点赞按钮' WHERE menu_id BETWEEN 2328 AND 2329;
UPDATE sys_menu SET remark = 'AI任务按钮' WHERE menu_id BETWEEN 2330 AND 2332;
UPDATE sys_menu SET remark = 'AI提示词按钮' WHERE menu_id BETWEEN 2333 AND 2336;
UPDATE sys_menu SET remark = 'AI审核按钮' WHERE menu_id BETWEEN 2337 AND 2338;
UPDATE sys_menu SET remark = 'AI问答按钮' WHERE menu_id BETWEEN 2339 AND 2341;
UPDATE sys_menu SET remark = '空间分享按钮' WHERE menu_id BETWEEN 2260 AND 2263;

UPDATE sys_config
SET config_name = '账号自助-教师注册开关',
    remark = 'true 开启，false 关闭'
WHERE config_key = 'sys.account.registerTeacher';

UPDATE sys_config
SET config_name = '账号自助-学生注册开关',
    remark = 'true 开启，false 关闭'
WHERE config_key = 'sys.account.registerStudent';

UPDATE ai_prompt_template SET remark = '系统默认模板' WHERE template_key IN ('resource.summary', 'resource.tags', 'resource.audit');
UPDATE edu_course_notice SET remark = '系统初始化公告' WHERE notice_id = 1;

ALTER TABLE edu_resource MODIFY like_count int(11) NOT NULL DEFAULT 0 COMMENT '点赞数';

ALTER TABLE edu_resource_like COMMENT = '资源点赞';
ALTER TABLE edu_resource_like
  MODIFY like_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  MODIFY resource_id bigint(20) NOT NULL COMMENT '资源ID',
  MODIFY resource_title varchar(200) NOT NULL COMMENT '资源标题',
  MODIFY user_id bigint(20) NOT NULL COMMENT '用户ID',
  MODIFY user_name varchar(100) NOT NULL COMMENT '用户名',
  MODIFY create_by varchar(64) DEFAULT '' COMMENT '创建者',
  MODIFY create_time datetime DEFAULT NULL COMMENT '创建时间';

ALTER TABLE edu_course_notice COMMENT = '课程公告';
ALTER TABLE edu_course_notice
  MODIFY notice_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  MODIFY course_id bigint(20) NOT NULL COMMENT '课程ID',
  MODIFY course_name varchar(100) NOT NULL COMMENT '课程名称',
  MODIFY notice_title varchar(200) NOT NULL COMMENT '公告标题',
  MODIFY notice_content varchar(4000) NOT NULL COMMENT '公告内容',
  MODIFY publisher_id bigint(20) NOT NULL COMMENT '发布人ID',
  MODIFY publisher_name varchar(100) NOT NULL COMMENT '发布人名称',
  MODIFY status char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  MODIFY del_flag char(1) DEFAULT '0' COMMENT '删除标志',
  MODIFY create_by varchar(64) DEFAULT '' COMMENT '创建者',
  MODIFY create_time datetime DEFAULT NULL COMMENT '创建时间',
  MODIFY update_by varchar(64) DEFAULT '' COMMENT '更新者',
  MODIFY update_time datetime DEFAULT NULL COMMENT '更新时间',
  MODIFY remark varchar(500) DEFAULT NULL COMMENT '备注';

ALTER TABLE edu_message_center COMMENT = '消息中心';
ALTER TABLE edu_message_center
  MODIFY message_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  MODIFY user_id bigint(20) NOT NULL COMMENT '接收用户ID',
  MODIFY user_name varchar(100) NOT NULL COMMENT '接收用户名',
  MODIFY message_title varchar(200) NOT NULL COMMENT '消息标题',
  MODIFY message_content varchar(4000) NOT NULL COMMENT '消息内容',
  MODIFY message_type varchar(50) DEFAULT 'system' COMMENT '消息类型',
  MODIFY biz_id bigint(20) DEFAULT NULL COMMENT '业务ID',
  MODIFY read_status char(1) DEFAULT '0' COMMENT '读取状态（0未读 1已读）',
  MODIFY del_flag char(1) DEFAULT '0' COMMENT '删除标志',
  MODIFY create_by varchar(64) DEFAULT '' COMMENT '创建者',
  MODIFY create_time datetime DEFAULT NULL COMMENT '创建时间',
  MODIFY update_by varchar(64) DEFAULT '' COMMENT '更新者',
  MODIFY update_time datetime DEFAULT NULL COMMENT '更新时间',
  MODIFY remark varchar(500) DEFAULT NULL COMMENT '备注';

ALTER TABLE ai_task COMMENT = 'AI任务';
ALTER TABLE ai_task
  MODIFY task_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  MODIFY task_type varchar(50) NOT NULL COMMENT '任务类型',
  MODIFY resource_id bigint(20) DEFAULT NULL COMMENT '资源ID',
  MODIFY resource_title varchar(200) DEFAULT NULL COMMENT '资源标题',
  MODIFY trigger_scene varchar(50) DEFAULT NULL COMMENT '触发场景',
  MODIFY task_status varchar(20) DEFAULT 'success' COMMENT '任务状态',
  MODIFY result_json longtext COMMENT '结果JSON',
  MODIFY error_msg varchar(1000) DEFAULT NULL COMMENT '错误信息',
  MODIFY start_time datetime DEFAULT NULL COMMENT '开始时间',
  MODIFY finish_time datetime DEFAULT NULL COMMENT '完成时间',
  MODIFY create_by varchar(64) DEFAULT '' COMMENT '创建者',
  MODIFY create_time datetime DEFAULT NULL COMMENT '创建时间',
  MODIFY update_by varchar(64) DEFAULT '' COMMENT '更新者',
  MODIFY update_time datetime DEFAULT NULL COMMENT '更新时间',
  MODIFY remark varchar(500) DEFAULT NULL COMMENT '备注';

ALTER TABLE ai_prompt_template COMMENT = 'AI提示词模板';
ALTER TABLE ai_prompt_template
  MODIFY template_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  MODIFY template_key varchar(100) NOT NULL COMMENT '模板KEY',
  MODIFY template_name varchar(200) NOT NULL COMMENT '模板名称',
  MODIFY prompt_content varchar(4000) NOT NULL COMMENT '提示词内容',
  MODIFY status char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  MODIFY create_by varchar(64) DEFAULT '' COMMENT '创建者',
  MODIFY create_time datetime DEFAULT NULL COMMENT '创建时间',
  MODIFY update_by varchar(64) DEFAULT '' COMMENT '更新者',
  MODIFY update_time datetime DEFAULT NULL COMMENT '更新时间',
  MODIFY remark varchar(500) DEFAULT NULL COMMENT '备注';

ALTER TABLE ai_audit_result COMMENT = 'AI审核结果';
ALTER TABLE ai_audit_result
  MODIFY result_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'AI审核结果ID',
  MODIFY resource_id bigint(20) NOT NULL COMMENT '资源ID',
  MODIFY resource_title varchar(200) NOT NULL COMMENT '资源标题',
  MODIFY risk_score decimal(10,2) DEFAULT 0 COMMENT '风险分',
  MODIFY duplicate_score decimal(10,2) DEFAULT 0 COMMENT '重复分',
  MODIFY compliance_level varchar(50) DEFAULT NULL COMMENT '合规等级',
  MODIFY hit_words varchar(1000) DEFAULT NULL COMMENT '命中词汇',
  MODIFY suggestion varchar(2000) DEFAULT NULL COMMENT '处理建议',
  MODIFY audit_summary varchar(2000) DEFAULT NULL COMMENT '审核摘要',
  MODIFY status varchar(20) DEFAULT 'done' COMMENT '状态',
  MODIFY raw_result longtext COMMENT '原始结果',
  MODIFY create_by varchar(64) DEFAULT '' COMMENT '创建者',
  MODIFY create_time datetime DEFAULT NULL COMMENT '创建时间',
  MODIFY update_by varchar(64) DEFAULT '' COMMENT '更新者',
  MODIFY update_time datetime DEFAULT NULL COMMENT '更新时间',
  MODIFY remark varchar(500) DEFAULT NULL COMMENT '备注';

ALTER TABLE ai_embedding_index COMMENT = 'AI向量索引';
ALTER TABLE ai_embedding_index
  MODIFY index_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  MODIFY resource_id bigint(20) NOT NULL COMMENT '资源ID',
  MODIFY resource_title varchar(200) NOT NULL COMMENT '资源标题',
  MODIFY keyword_text varchar(4000) DEFAULT NULL COMMENT '关键词文本',
  MODIFY summary_text varchar(2000) DEFAULT NULL COMMENT '摘要文本',
  MODIFY create_by varchar(64) DEFAULT '' COMMENT '创建者',
  MODIFY create_time datetime DEFAULT NULL COMMENT '创建时间',
  MODIFY update_by varchar(64) DEFAULT '' COMMENT '更新者',
  MODIFY update_time datetime DEFAULT NULL COMMENT '更新时间',
  MODIFY remark varchar(500) DEFAULT NULL COMMENT '备注';

ALTER TABLE ai_qa_log COMMENT = 'AI问答记录';
ALTER TABLE ai_qa_log
  MODIFY qa_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '问答ID',
  MODIFY user_id bigint(20) DEFAULT NULL COMMENT '用户ID',
  MODIFY user_name varchar(100) DEFAULT NULL COMMENT '用户名',
  MODIFY question varchar(2000) NOT NULL COMMENT '问题',
  MODIFY answer varchar(4000) DEFAULT NULL COMMENT '答案',
  MODIFY reference_resource_ids varchar(1000) DEFAULT NULL COMMENT '参考资源ID',
  MODIFY reference_titles varchar(1000) DEFAULT NULL COMMENT '参考资源标题',
  MODIFY model_name varchar(100) DEFAULT 'Local-Heuristic-AI' COMMENT '模型名称',
  MODIFY cost_millis bigint(20) DEFAULT 0 COMMENT '耗时毫秒',
  MODIFY create_by varchar(64) DEFAULT '' COMMENT '创建者',
  MODIFY create_time datetime DEFAULT NULL COMMENT '创建时间',
  MODIFY remark varchar(500) DEFAULT NULL COMMENT '备注';

ALTER TABLE edu_space_share COMMENT = '空间分享';
ALTER TABLE edu_space_share
  MODIFY share_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分享ID',
  MODIFY owner_user_id bigint(20) NOT NULL COMMENT '拥有者ID',
  MODIFY owner_name varchar(100) DEFAULT '' COMMENT '拥有者名称',
  MODIFY share_name varchar(100) NOT NULL COMMENT '分享名称',
  MODIFY target_type varchar(20) NOT NULL DEFAULT 'folder' COMMENT '目标类型（folder/file）',
  MODIFY target_name varchar(200) NOT NULL COMMENT '目标名称',
  MODIFY target_path varchar(500) DEFAULT '' COMMENT '目标路径',
  MODIFY share_mode varchar(20) NOT NULL DEFAULT 'password' COMMENT '分享方式（public/password/internal）',
  MODIFY share_password varchar(50) DEFAULT '' COMMENT '分享密码',
  MODIFY expire_time datetime DEFAULT NULL COMMENT '过期时间',
  MODIFY download_limit int(11) NOT NULL DEFAULT 0 COMMENT '下载限制（0不限）',
  MODIFY download_count int(11) NOT NULL DEFAULT 0 COMMENT '下载次数',
  MODIFY view_count int(11) NOT NULL DEFAULT 0 COMMENT '查看次数',
  MODIFY status char(1) NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  MODIFY create_by varchar(64) DEFAULT '' COMMENT '创建者',
  MODIFY create_time datetime DEFAULT NULL COMMENT '创建时间',
  MODIFY update_by varchar(64) DEFAULT '' COMMENT '更新者',
  MODIFY update_time datetime DEFAULT NULL COMMENT '更新时间',
  MODIFY remark varchar(500) DEFAULT NULL COMMENT '备注';

ALTER TABLE edu_global_config
  MODIFY share_default_days int(11) NOT NULL DEFAULT 7 COMMENT '默认分享有效天数',
  MODIFY share_max_days int(11) NOT NULL DEFAULT 30 COMMENT '最大分享有效天数',
  MODIFY password_share_enable char(1) NOT NULL DEFAULT '0' COMMENT '允许密码分享（0否 1是）',
  MODIFY teacher_share_enable char(1) NOT NULL DEFAULT '0' COMMENT '教师允许分享（0否 1是）',
  MODIFY student_share_enable char(1) NOT NULL DEFAULT '1' COMMENT '学生允许分享（0否 1是）',
  MODIFY recycle_keep_days int(11) NOT NULL DEFAULT 15 COMMENT '回收站保留天数',
  MODIFY storage_warn_percent int(11) NOT NULL DEFAULT 85 COMMENT '空间预警百分比';

ALTER TABLE edu_user_quota
  MODIFY used_storage_mb decimal(10,2) NOT NULL DEFAULT 0 COMMENT '已使用空间MB',
  MODIFY allow_share char(1) NOT NULL DEFAULT '0' COMMENT '允许分享（0是 1否）',
  MODIFY allow_password_share char(1) NOT NULL DEFAULT '0' COMMENT '允许密码分享（0是 1否）',
  MODIFY max_share_days int(11) NOT NULL DEFAULT 30 COMMENT '最大分享天数',
  MODIFY ban_reason varchar(255) DEFAULT NULL COMMENT '封禁原因';

COMMIT;
