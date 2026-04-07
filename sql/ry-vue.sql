/*
 Navicat Premium Data Transfer

 Source Server         : 小曹主机
 Source Server Type    : MySQL
 Source Server Version : 80017 (8.0.17)
 Source Host           : localhost:3306
 Source Schema         : ry-vue

 Target Server Type    : MySQL
 Target Server Version : 80017 (8.0.17)
 File Encoding         : 65001

 Date: 07/04/2026 17:36:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ai_audit_result
-- ----------------------------
DROP TABLE IF EXISTS `ai_audit_result`;
CREATE TABLE `ai_audit_result`  (
  `result_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'AI审核结果ID',
  `resource_id` bigint(20) NOT NULL COMMENT '资源ID',
  `resource_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资源标题',
  `risk_score` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '风险分',
  `duplicate_score` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '重复分',
  `compliance_level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '合规等级',
  `hit_words` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '命中词汇',
  `suggestion` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理建议',
  `audit_summary` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核摘要',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'done' COMMENT '状态',
  `raw_result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '原始结果',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`result_id`) USING BTREE,
  UNIQUE INDEX `uk_ai_audit_resource`(`resource_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI审核结果' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ai_audit_result
-- ----------------------------
INSERT INTO `ai_audit_result` VALUES (1, 1, '112', 10.00, 0.00, 'safe', '', '资源整体风险较低，可继续进入人工复核或发布流程。', 'AI审核：风险分=10.00，重复分=0.00，等级=safe', 'done', '{\"riskScore\":10.00,\"duplicateScore\":0.00,\"complianceLevel\":\"safe\",\"hitWords\":\"\",\"suggestion\":\"资源整体风险较低，可继续进入人工复核或发布流程。\"}', 'admin', '2026-03-26 19:12:11', '', NULL, NULL);
INSERT INTO `ai_audit_result` VALUES (2, 2, '112', 10.00, 99.00, 'warning', '', '检测到较高重复风险，建议核对资源内容并避免重复上传。', 'AI审核：风险分=10.00，重复分=99.00，等级=warning', 'done', '{\"riskScore\":10.00,\"duplicateScore\":99.00,\"complianceLevel\":\"warning\",\"hitWords\":\"\",\"suggestion\":\"检测到较高重复风险，建议核对资源内容并避免重复上传。\"}', 'admin', '2026-03-26 19:12:17', '', NULL, NULL);
INSERT INTO `ai_audit_result` VALUES (3, 3, '112', 10.00, 99.00, 'warning', '', '检测到较高重复风险，建议核对资源内容并避免重复上传。', 'AI审核：风险分=10.00，重复分=99.00，等级=warning', 'done', '{\"riskScore\":10.00,\"duplicateScore\":99.00,\"complianceLevel\":\"warning\",\"hitWords\":\"\",\"suggestion\":\"检测到较高重复风险，建议核对资源内容并避免重复上传。\"}', 'admin', '2026-03-26 19:12:18', '', NULL, NULL);
INSERT INTO `ai_audit_result` VALUES (4, 4, '112', 10.00, 99.00, 'warning', '', '检测到较高重复风险，建议核对资源内容并避免重复上传。', 'AI审核：风险分=10.00，重复分=99.00，等级=warning', 'done', '{\"riskScore\":10.00,\"duplicateScore\":99.00,\"complianceLevel\":\"warning\",\"hitWords\":\"\",\"suggestion\":\"检测到较高重复风险，建议核对资源内容并避免重复上传。\"}', 'admin', '2026-03-26 19:12:35', '', NULL, NULL);
INSERT INTO `ai_audit_result` VALUES (5, 5, '112', 10.00, 99.00, 'warning', '', '检测到较高重复风险，建议核对资源内容并避免重复上传。', 'AI审核：风险分=10.00，重复分=99.00，等级=warning', 'done', '{\"riskScore\":10.00,\"duplicateScore\":99.00,\"complianceLevel\":\"warning\",\"hitWords\":\"\",\"suggestion\":\"检测到较高重复风险，建议核对资源内容并避免重复上传。\"}', 'admin', '2026-03-26 19:13:48', '', NULL, NULL);
INSERT INTO `ai_audit_result` VALUES (6, 6, '112', 10.00, 99.00, 'warning', '', '检测到较高重复风险，建议核对资源内容并避免重复上传。', 'AI审核：风险分=10.00，重复分=99.00，等级=warning', 'done', '{\"riskScore\":10.00,\"duplicateScore\":99.00,\"complianceLevel\":\"warning\",\"hitWords\":\"\",\"suggestion\":\"检测到较高重复风险，建议核对资源内容并避免重复上传。\"}', 'admin', '2026-03-26 19:13:50', 'admin', '2026-03-26 19:15:50', NULL);
INSERT INTO `ai_audit_result` VALUES (7, 7, '666', 10.00, 56.43, 'safe', '', '资源整体风险较低，可继续进入人工复核或发布流程。', 'AI审核：风险分=10.00，重复分=56.43，等级=safe', 'done', '{\"riskScore\":10.00,\"duplicateScore\":56.43,\"complianceLevel\":\"safe\",\"hitWords\":\"\",\"suggestion\":\"资源整体风险较低，可继续进入人工复核或发布流程。\"}', 'admin', '2026-03-26 19:21:14', 'admin', '2026-03-26 19:21:19', NULL);

-- ----------------------------
-- Table structure for ai_embedding_index
-- ----------------------------
DROP TABLE IF EXISTS `ai_embedding_index`;
CREATE TABLE `ai_embedding_index`  (
  `index_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `resource_id` bigint(20) NOT NULL COMMENT '资源ID',
  `resource_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资源标题',
  `keyword_text` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关键词文本',
  `summary_text` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '摘要文本',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`index_id`) USING BTREE,
  UNIQUE INDEX `uk_ai_embedding_resource`(`resource_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI向量索引' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ai_embedding_index
-- ----------------------------
INSERT INTO `ai_embedding_index` VALUES (1, 1, '112', '最新上传,教学设计基础,教学资源库,PDF,教学,文档,资源', '资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 ', 'admin', '2026-03-26 19:12:11', '', NULL, NULL);
INSERT INTO `ai_embedding_index` VALUES (2, 2, '112', '最新上传,教学设计基础,教学资源库,PDF,教学,文档,资源', '资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 ', 'admin', '2026-03-26 19:12:17', '', NULL, NULL);
INSERT INTO `ai_embedding_index` VALUES (3, 3, '112', '最新上传,教学设计基础,教学资源库,PDF,教学,文档,资源', '资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 ', 'admin', '2026-03-26 19:12:18', '', NULL, NULL);
INSERT INTO `ai_embedding_index` VALUES (4, 4, '112', '最新上传,教学设计基础,教学资源库,PDF,教学,文档,资源', '资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 ', 'admin', '2026-03-26 19:12:35', '', NULL, NULL);
INSERT INTO `ai_embedding_index` VALUES (5, 5, '112', '最新上传,教学设计基础,教学资源库,PDF,教学,文档,资源', '资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 ', 'admin', '2026-03-26 19:13:48', '', NULL, NULL);
INSERT INTO `ai_embedding_index` VALUES (6, 6, '112', '最新上传,教学设计基础,教学资源库,PDF,教学,文档,资源', '资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 ', 'admin', '2026-03-26 19:13:50', 'admin', '2026-03-26 19:15:50', NULL);
INSERT INTO `ai_embedding_index` VALUES (7, 7, '666', '最新上传,期末冲刺,教学设计基础,教学资源库,PDF,教学,资源,PPT,课堂课件', '资源《666》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：666666666。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 ', 'admin', '2026-03-26 19:21:14', 'admin', '2026-03-26 19:21:19', NULL);

-- ----------------------------
-- Table structure for ai_prompt_template
-- ----------------------------
DROP TABLE IF EXISTS `ai_prompt_template`;
CREATE TABLE `ai_prompt_template`  (
  `template_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `template_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模板KEY',
  `template_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模板名称',
  `prompt_content` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '提示词内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`template_id`) USING BTREE,
  UNIQUE INDEX `uk_ai_prompt_key`(`template_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI提示词模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ai_prompt_template
-- ----------------------------
INSERT INTO `ai_prompt_template` VALUES (1, 'resource.summary', '资源摘要生成', '请根据资源标题、课程、分类和简介生成一段适用于教学资源管理系统的中文摘要，突出适用场景、资源类型和教学用途。', '0', 'admin', '2026-03-24 17:41:36', 'admin', '2026-03-24 19:34:15', '系统默认模板');
INSERT INTO `ai_prompt_template` VALUES (2, 'resource.tags', '资源标签生成', '请从资源标题、简介、课程和分类中提取 3-8 个中文标签，优先输出课程名称、知识点、资源类型和适用对象。', '0', 'admin', '2026-03-24 17:41:36', 'admin', '2026-03-24 19:34:15', '系统默认模板');
INSERT INTO `ai_prompt_template` VALUES (3, 'resource.audit', '资源内容审核', '请结合资源标题、简介、文件信息与教学场晭，对资源进行合规审核，输出风险点、重复风险和处理建议。', '0', 'admin', '2026-03-24 17:41:36', 'admin', '2026-03-24 19:34:15', '系统默认模板');

-- ----------------------------
-- Table structure for ai_qa_log
-- ----------------------------
DROP TABLE IF EXISTS `ai_qa_log`;
CREATE TABLE `ai_qa_log`  (
  `qa_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '问答ID',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `question` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '问题',
  `answer` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '答案',
  `reference_resource_ids` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '参考资源ID',
  `reference_titles` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '参考资源标题',
  `model_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'Local-Heuristic-AI' COMMENT '模型名称',
  `cost_millis` bigint(20) NULL DEFAULT 0 COMMENT '耗时毫秒',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`qa_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI问答记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ai_qa_log
-- ----------------------------

-- ----------------------------
-- Table structure for ai_task
-- ----------------------------
DROP TABLE IF EXISTS `ai_task`;
CREATE TABLE `ai_task`  (
  `task_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `task_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务类型',
  `resource_id` bigint(20) NULL DEFAULT NULL COMMENT '资源ID',
  `resource_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '资源标题',
  `trigger_scene` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '触发场景',
  `task_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'success' COMMENT '任务状态',
  `result_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '结果JSON',
  `error_msg` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '错误信息',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `finish_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`task_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ai_task
-- ----------------------------
INSERT INTO `ai_task` VALUES (1, 'summary', 1, '112', 'upload', 'success', '{\"resourceId\":1,\"summary\":\"资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 \",\"applicable\":\"教学设计基础\"}', NULL, '2026-03-26 19:12:11', '2026-03-26 19:12:11', 'admin', '2026-03-26 19:12:11', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (2, 'tags', 1, '112', 'upload', 'success', '{\"resourceId\":1,\"tags\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"]}', NULL, '2026-03-26 19:12:11', '2026-03-26 19:12:11', 'admin', '2026-03-26 19:12:11', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (3, 'classify', 1, '112', 'upload', 'success', '{\"resourceId\":1,\"courseName\":\"教学设计基础\",\"categoryName\":\"教学资源库\",\"resourceType\":\"PDF\",\"grade\":\"通用\"}', NULL, '2026-03-26 19:12:11', '2026-03-26 19:12:11', 'admin', '2026-03-26 19:12:11', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (4, 'ocr', 1, '112', 'upload', 'success', '{\"resourceId\":1,\"title\":\"112\",\"catalog\":[\"12121\"],\"keywords\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"],\"keyContent\":\"12121\",\"source\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\"}', NULL, '2026-03-26 19:12:11', '2026-03-26 19:12:11', 'admin', '2026-03-26 19:12:11', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (5, 'audit', 1, '112', 'upload', 'success', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-26 11:12:11\",\"updateBy\":\"\",\"updateTime\":null,\"remark\":null,\"resultId\":1,\"resourceId\":1,\"resourceTitle\":\"112\",\"riskScore\":10.00,\"duplicateScore\":0.00,\"complianceLevel\":\"safe\",\"hitWords\":\"\",\"suggestion\":\"资源整体风险较低，可继续进入人工复核或发布流程。\",\"auditSummary\":\"AI审核：风险分=10.00，重复分=0.00，等级=safe\",\"status\":\"done\",\"rawResult\":\"{\\\"riskScore\\\":10.00,\\\"duplicateScore\\\":0.00,\\\"complianceLevel\\\":\\\"safe\\\",\\\"hitWords\\\":\\\"\\\",\\\"suggestion\\\":\\\"资源整体风险较低，可继续进入人工复核或发布流程。\\\"}\"}', NULL, '2026-03-26 19:12:11', '2026-03-26 19:12:11', 'admin', '2026-03-26 19:12:11', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (6, 'summary', 2, '112', 'upload', 'success', '{\"resourceId\":2,\"summary\":\"资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 \",\"applicable\":\"教学设计基础\"}', NULL, '2026-03-26 19:12:17', '2026-03-26 19:12:17', 'admin', '2026-03-26 19:12:17', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (7, 'tags', 2, '112', 'upload', 'success', '{\"resourceId\":2,\"tags\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"]}', NULL, '2026-03-26 19:12:17', '2026-03-26 19:12:17', 'admin', '2026-03-26 19:12:17', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (8, 'classify', 2, '112', 'upload', 'success', '{\"resourceId\":2,\"courseName\":\"教学设计基础\",\"categoryName\":\"教学资源库\",\"resourceType\":\"PDF\",\"grade\":\"通用\"}', NULL, '2026-03-26 19:12:17', '2026-03-26 19:12:17', 'admin', '2026-03-26 19:12:17', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (9, 'ocr', 2, '112', 'upload', 'success', '{\"resourceId\":2,\"title\":\"112\",\"catalog\":[\"12121\"],\"keywords\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"],\"keyContent\":\"12121\",\"source\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\"}', NULL, '2026-03-26 19:12:17', '2026-03-26 19:12:17', 'admin', '2026-03-26 19:12:17', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (10, 'audit', 2, '112', 'upload', 'success', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-26 11:12:17\",\"updateBy\":\"\",\"updateTime\":null,\"remark\":null,\"resultId\":2,\"resourceId\":2,\"resourceTitle\":\"112\",\"riskScore\":10.00,\"duplicateScore\":99.00,\"complianceLevel\":\"warning\",\"hitWords\":\"\",\"suggestion\":\"检测到较高重复风险，建议核对资源内容并避免重复上传。\",\"auditSummary\":\"AI审核：风险分=10.00，重复分=99.00，等级=warning\",\"status\":\"done\",\"rawResult\":\"{\\\"riskScore\\\":10.00,\\\"duplicateScore\\\":99.00,\\\"complianceLevel\\\":\\\"warning\\\",\\\"hitWords\\\":\\\"\\\",\\\"suggestion\\\":\\\"检测到较高重复风险，建议核对资源内容并避免重复上传。\\\"}\"}', NULL, '2026-03-26 19:12:17', '2026-03-26 19:12:17', 'admin', '2026-03-26 19:12:17', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (11, 'summary', 3, '112', 'upload', 'success', '{\"resourceId\":3,\"summary\":\"资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 \",\"applicable\":\"教学设计基础\"}', NULL, '2026-03-26 19:12:19', '2026-03-26 19:12:19', 'admin', '2026-03-26 19:12:18', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (12, 'tags', 3, '112', 'upload', 'success', '{\"resourceId\":3,\"tags\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"]}', NULL, '2026-03-26 19:12:19', '2026-03-26 19:12:19', 'admin', '2026-03-26 19:12:18', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (13, 'classify', 3, '112', 'upload', 'success', '{\"resourceId\":3,\"courseName\":\"教学设计基础\",\"categoryName\":\"教学资源库\",\"resourceType\":\"PDF\",\"grade\":\"通用\"}', NULL, '2026-03-26 19:12:19', '2026-03-26 19:12:19', 'admin', '2026-03-26 19:12:18', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (14, 'ocr', 3, '112', 'upload', 'success', '{\"resourceId\":3,\"title\":\"112\",\"catalog\":[\"12121\"],\"keywords\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"],\"keyContent\":\"12121\",\"source\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\"}', NULL, '2026-03-26 19:12:19', '2026-03-26 19:12:19', 'admin', '2026-03-26 19:12:18', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (15, 'audit', 3, '112', 'upload', 'success', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-26 11:12:18\",\"updateBy\":\"\",\"updateTime\":null,\"remark\":null,\"resultId\":3,\"resourceId\":3,\"resourceTitle\":\"112\",\"riskScore\":10.00,\"duplicateScore\":99.00,\"complianceLevel\":\"warning\",\"hitWords\":\"\",\"suggestion\":\"检测到较高重复风险，建议核对资源内容并避免重复上传。\",\"auditSummary\":\"AI审核：风险分=10.00，重复分=99.00，等级=warning\",\"status\":\"done\",\"rawResult\":\"{\\\"riskScore\\\":10.00,\\\"duplicateScore\\\":99.00,\\\"complianceLevel\\\":\\\"warning\\\",\\\"hitWords\\\":\\\"\\\",\\\"suggestion\\\":\\\"检测到较高重复风险，建议核对资源内容并避免重复上传。\\\"}\"}', NULL, '2026-03-26 19:12:19', '2026-03-26 19:12:19', 'admin', '2026-03-26 19:12:18', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (16, 'summary', 4, '112', 'upload', 'success', '{\"resourceId\":4,\"summary\":\"资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 \",\"applicable\":\"教学设计基础\"}', NULL, '2026-03-26 19:12:35', '2026-03-26 19:12:35', 'admin', '2026-03-26 19:12:35', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (17, 'tags', 4, '112', 'upload', 'success', '{\"resourceId\":4,\"tags\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"]}', NULL, '2026-03-26 19:12:35', '2026-03-26 19:12:35', 'admin', '2026-03-26 19:12:35', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (18, 'classify', 4, '112', 'upload', 'success', '{\"resourceId\":4,\"courseName\":\"教学设计基础\",\"categoryName\":\"教学资源库\",\"resourceType\":\"PDF\",\"grade\":\"通用\"}', NULL, '2026-03-26 19:12:35', '2026-03-26 19:12:35', 'admin', '2026-03-26 19:12:35', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (19, 'ocr', 4, '112', 'upload', 'success', '{\"resourceId\":4,\"title\":\"112\",\"catalog\":[\"12121\"],\"keywords\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"],\"keyContent\":\"12121\",\"source\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\"}', NULL, '2026-03-26 19:12:35', '2026-03-26 19:12:35', 'admin', '2026-03-26 19:12:35', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (20, 'audit', 4, '112', 'upload', 'success', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-26 11:12:35\",\"updateBy\":\"\",\"updateTime\":null,\"remark\":null,\"resultId\":4,\"resourceId\":4,\"resourceTitle\":\"112\",\"riskScore\":10.00,\"duplicateScore\":99.00,\"complianceLevel\":\"warning\",\"hitWords\":\"\",\"suggestion\":\"检测到较高重复风险，建议核对资源内容并避免重复上传。\",\"auditSummary\":\"AI审核：风险分=10.00，重复分=99.00，等级=warning\",\"status\":\"done\",\"rawResult\":\"{\\\"riskScore\\\":10.00,\\\"duplicateScore\\\":99.00,\\\"complianceLevel\\\":\\\"warning\\\",\\\"hitWords\\\":\\\"\\\",\\\"suggestion\\\":\\\"检测到较高重复风险，建议核对资源内容并避免重复上传。\\\"}\"}', NULL, '2026-03-26 19:12:35', '2026-03-26 19:12:35', 'admin', '2026-03-26 19:12:35', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (21, 'summary', 5, '112', 'upload', 'success', '{\"resourceId\":5,\"summary\":\"资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 \",\"applicable\":\"教学设计基础\"}', NULL, '2026-03-26 19:13:49', '2026-03-26 19:13:49', 'admin', '2026-03-26 19:13:48', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (22, 'tags', 5, '112', 'upload', 'success', '{\"resourceId\":5,\"tags\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"]}', NULL, '2026-03-26 19:13:49', '2026-03-26 19:13:49', 'admin', '2026-03-26 19:13:48', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (23, 'classify', 5, '112', 'upload', 'success', '{\"resourceId\":5,\"courseName\":\"教学设计基础\",\"categoryName\":\"教学资源库\",\"resourceType\":\"PDF\",\"grade\":\"通用\"}', NULL, '2026-03-26 19:13:49', '2026-03-26 19:13:49', 'admin', '2026-03-26 19:13:48', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (24, 'ocr', 5, '112', 'upload', 'success', '{\"resourceId\":5,\"title\":\"112\",\"catalog\":[\"12121\"],\"keywords\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"],\"keyContent\":\"12121\",\"source\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\"}', NULL, '2026-03-26 19:13:49', '2026-03-26 19:13:49', 'admin', '2026-03-26 19:13:48', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (25, 'audit', 5, '112', 'upload', 'success', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-26 11:13:48\",\"updateBy\":\"\",\"updateTime\":null,\"remark\":null,\"resultId\":5,\"resourceId\":5,\"resourceTitle\":\"112\",\"riskScore\":10.00,\"duplicateScore\":99.00,\"complianceLevel\":\"warning\",\"hitWords\":\"\",\"suggestion\":\"检测到较高重复风险，建议核对资源内容并避免重复上传。\",\"auditSummary\":\"AI审核：风险分=10.00，重复分=99.00，等级=warning\",\"status\":\"done\",\"rawResult\":\"{\\\"riskScore\\\":10.00,\\\"duplicateScore\\\":99.00,\\\"complianceLevel\\\":\\\"warning\\\",\\\"hitWords\\\":\\\"\\\",\\\"suggestion\\\":\\\"检测到较高重复风险，建议核对资源内容并避免重复上传。\\\"}\"}', NULL, '2026-03-26 19:13:49', '2026-03-26 19:13:49', 'admin', '2026-03-26 19:13:48', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (26, 'summary', 6, '112', 'upload', 'success', '{\"resourceId\":6,\"summary\":\"资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 \",\"applicable\":\"教学设计基础\"}', NULL, '2026-03-26 19:13:50', '2026-03-26 19:13:50', 'admin', '2026-03-26 19:13:50', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (27, 'tags', 6, '112', 'upload', 'success', '{\"resourceId\":6,\"tags\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"]}', NULL, '2026-03-26 19:13:50', '2026-03-26 19:13:50', 'admin', '2026-03-26 19:13:50', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (28, 'classify', 6, '112', 'upload', 'success', '{\"resourceId\":6,\"courseName\":\"教学设计基础\",\"categoryName\":\"教学资源库\",\"resourceType\":\"PDF\",\"grade\":\"通用\"}', NULL, '2026-03-26 19:13:50', '2026-03-26 19:13:50', 'admin', '2026-03-26 19:13:50', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (29, 'ocr', 6, '112', 'upload', 'success', '{\"resourceId\":6,\"title\":\"112\",\"catalog\":[\"12121\"],\"keywords\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"],\"keyContent\":\"12121\",\"source\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\"}', NULL, '2026-03-26 19:13:50', '2026-03-26 19:13:50', 'admin', '2026-03-26 19:13:50', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (30, 'audit', 6, '112', 'upload', 'success', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-26 11:13:50\",\"updateBy\":\"\",\"updateTime\":null,\"remark\":null,\"resultId\":6,\"resourceId\":6,\"resourceTitle\":\"112\",\"riskScore\":10.00,\"duplicateScore\":99.00,\"complianceLevel\":\"warning\",\"hitWords\":\"\",\"suggestion\":\"检测到较高重复风险，建议核对资源内容并避免重复上传。\",\"auditSummary\":\"AI审核：风险分=10.00，重复分=99.00，等级=warning\",\"status\":\"done\",\"rawResult\":\"{\\\"riskScore\\\":10.00,\\\"duplicateScore\\\":99.00,\\\"complianceLevel\\\":\\\"warning\\\",\\\"hitWords\\\":\\\"\\\",\\\"suggestion\\\":\\\"检测到较高重复风险，建议核对资源内容并避免重复上传。\\\"}\"}', NULL, '2026-03-26 19:13:50', '2026-03-26 19:13:50', 'admin', '2026-03-26 19:13:50', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (31, 'summary', 6, '112', 'pre_audit', 'success', '{\"resourceId\":6,\"summary\":\"资源《112》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：12121。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 \",\"applicable\":\"教学设计基础\"}', NULL, '2026-03-26 19:15:51', '2026-03-26 19:15:51', 'admin', '2026-03-26 19:15:50', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (32, 'tags', 6, '112', 'pre_audit', 'success', '{\"resourceId\":6,\"tags\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"]}', NULL, '2026-03-26 19:15:51', '2026-03-26 19:15:51', 'admin', '2026-03-26 19:15:50', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (33, 'classify', 6, '112', 'pre_audit', 'success', '{\"resourceId\":6,\"courseName\":\"教学设计基础\",\"categoryName\":\"教学资源库\",\"resourceType\":\"PDF\",\"grade\":\"通用\"}', NULL, '2026-03-26 19:15:51', '2026-03-26 19:15:51', 'admin', '2026-03-26 19:15:50', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (34, 'ocr', 6, '112', 'pre_audit', 'success', '{\"resourceId\":6,\"title\":\"112\",\"catalog\":[\"12121\"],\"keywords\":[\"最新上传\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"文档\",\"资源\"],\"keyContent\":\"12121\",\"source\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\"}', NULL, '2026-03-26 19:15:51', '2026-03-26 19:15:51', 'admin', '2026-03-26 19:15:50', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (35, 'audit', 6, '112', 'pre_audit', 'success', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-26 11:13:50\",\"updateBy\":\"admin\",\"updateTime\":\"2026-03-26 11:15:50\",\"remark\":null,\"resultId\":6,\"resourceId\":6,\"resourceTitle\":\"112\",\"riskScore\":10.00,\"duplicateScore\":99.00,\"complianceLevel\":\"warning\",\"hitWords\":\"\",\"suggestion\":\"检测到较高重复风险，建议核对资源内容并避免重复上传。\",\"auditSummary\":\"AI审核：风险分=10.00，重复分=99.00，等级=warning\",\"status\":\"done\",\"rawResult\":\"{\\\"riskScore\\\":10.00,\\\"duplicateScore\\\":99.00,\\\"complianceLevel\\\":\\\"warning\\\",\\\"hitWords\\\":\\\"\\\",\\\"suggestion\\\":\\\"检测到较高重复风险，建议核对资源内容并避免重复上传。\\\"}\"}', NULL, '2026-03-26 19:15:51', '2026-03-26 19:15:51', 'admin', '2026-03-26 19:15:50', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (36, 'summary', 7, '666', 'upload', 'success', '{\"resourceId\":7,\"summary\":\"资源《666》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：666666666。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 \",\"applicable\":\"教学设计基础\"}', NULL, '2026-03-26 19:21:14', '2026-03-26 19:21:14', 'admin', '2026-03-26 19:21:14', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (37, 'tags', 7, '666', 'upload', 'success', '{\"resourceId\":7,\"tags\":[\"最新上传\",\"期末冲刺\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"资源\",\"PPT\",\"课堂课件\"]}', NULL, '2026-03-26 19:21:14', '2026-03-26 19:21:14', 'admin', '2026-03-26 19:21:14', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (38, 'classify', 7, '666', 'upload', 'success', '{\"resourceId\":7,\"courseName\":\"教学设计基础\",\"categoryName\":\"教学资源库\",\"resourceType\":\"PDF\",\"grade\":\"通用\"}', NULL, '2026-03-26 19:21:14', '2026-03-26 19:21:14', 'admin', '2026-03-26 19:21:14', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (39, 'ocr', 7, '666', 'upload', 'success', '{\"resourceId\":7,\"title\":\"666\",\"catalog\":[\"666666666\"],\"keywords\":[\"最新上传\",\"期末冲刺\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"资源\",\"PPT\",\"课堂课件\"],\"keyContent\":\"666666666\",\"source\":\"/profile/upload/resource/2026/03/26/人体解剖知识在美术中的应用历程_20260326192103A002.pptx\"}', NULL, '2026-03-26 19:21:14', '2026-03-26 19:21:14', 'admin', '2026-03-26 19:21:14', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (40, 'audit', 7, '666', 'upload', 'success', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-26 11:21:14\",\"updateBy\":\"\",\"updateTime\":null,\"remark\":null,\"resultId\":7,\"resourceId\":7,\"resourceTitle\":\"666\",\"riskScore\":10.00,\"duplicateScore\":56.43,\"complianceLevel\":\"safe\",\"hitWords\":\"\",\"suggestion\":\"资源整体风险较低，可继续进入人工复核或发布流程。\",\"auditSummary\":\"AI审核：风险分=10.00，重复分=56.43，等级=safe\",\"status\":\"done\",\"rawResult\":\"{\\\"riskScore\\\":10.00,\\\"duplicateScore\\\":56.43,\\\"complianceLevel\\\":\\\"safe\\\",\\\"hitWords\\\":\\\"\\\",\\\"suggestion\\\":\\\"资源整体风险较低，可继续进入人工复核或发布流程。\\\"}\"}', NULL, '2026-03-26 19:21:14', '2026-03-26 19:21:14', 'admin', '2026-03-26 19:21:14', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (41, 'summary', 7, '666', 'pre_audit', 'success', '{\"resourceId\":7,\"summary\":\"资源《666》属于课程：教学设计基础。 分类为：教学资源库。 资源类型：PDF。 资源简介：666666666。 适合用于教学设计基础的备课、授课或学习参考。 系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 \",\"applicable\":\"教学设计基础\"}', NULL, '2026-03-26 19:21:20', '2026-03-26 19:21:20', 'admin', '2026-03-26 19:21:19', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (42, 'tags', 7, '666', 'pre_audit', 'success', '{\"resourceId\":7,\"tags\":[\"最新上传\",\"期末冲刺\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"资源\",\"PPT\",\"课堂课件\"]}', NULL, '2026-03-26 19:21:20', '2026-03-26 19:21:20', 'admin', '2026-03-26 19:21:19', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (43, 'classify', 7, '666', 'pre_audit', 'success', '{\"resourceId\":7,\"courseName\":\"教学设计基础\",\"categoryName\":\"教学资源库\",\"resourceType\":\"PDF\",\"grade\":\"通用\"}', NULL, '2026-03-26 19:21:20', '2026-03-26 19:21:20', 'admin', '2026-03-26 19:21:19', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (44, 'ocr', 7, '666', 'pre_audit', 'success', '{\"resourceId\":7,\"title\":\"666\",\"catalog\":[\"666666666\"],\"keywords\":[\"最新上传\",\"期末冲刺\",\"教学设计基础\",\"教学资源库\",\"PDF\",\"教学\",\"资源\",\"PPT\",\"课堂课件\"],\"keyContent\":\"666666666\",\"source\":\"/profile/upload/resource/2026/03/26/人体解剖知识在美术中的应用历程_20260326192103A002.pptx\"}', NULL, '2026-03-26 19:21:20', '2026-03-26 19:21:20', 'admin', '2026-03-26 19:21:19', '', NULL, NULL);
INSERT INTO `ai_task` VALUES (45, 'audit', 7, '666', 'pre_audit', 'success', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-26 11:21:14\",\"updateBy\":\"admin\",\"updateTime\":\"2026-03-26 11:21:19\",\"remark\":null,\"resultId\":7,\"resourceId\":7,\"resourceTitle\":\"666\",\"riskScore\":10.00,\"duplicateScore\":56.43,\"complianceLevel\":\"safe\",\"hitWords\":\"\",\"suggestion\":\"资源整体风险较低，可继续进入人工复核或发布流程。\",\"auditSummary\":\"AI审核：风险分=10.00，重复分=56.43，等级=safe\",\"status\":\"done\",\"rawResult\":\"{\\\"riskScore\\\":10.00,\\\"duplicateScore\\\":56.43,\\\"complianceLevel\\\":\\\"safe\\\",\\\"hitWords\\\":\\\"\\\",\\\"suggestion\\\":\\\"资源整体风险较低，可继续进入人工复核或发布流程。\\\"}\"}', NULL, '2026-03-26 19:21:20', '2026-03-26 19:21:20', 'admin', '2026-03-26 19:21:19', '', NULL, NULL);

-- ----------------------------
-- Table structure for edu_category
-- ----------------------------
DROP TABLE IF EXISTS `edu_category`;
CREATE TABLE `edu_category`  (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'category id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT 'parent id',
  `ancestors` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'ancestor list',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'category name',
  `order_num` int(4) NULL DEFAULT 0 COMMENT 'order num',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT 'status',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT 'delete flag',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'create by',
  `create_time` datetime NULL DEFAULT NULL COMMENT 'create time',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'update by',
  `update_time` datetime NULL DEFAULT NULL COMMENT 'update time',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'edu category' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_category
-- ----------------------------
INSERT INTO `edu_category` VALUES (1, 0, '0', '教学资源库', 0, '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '教学资源分类根目录');
INSERT INTO `edu_category` VALUES (2, 1, '0,1', '课件资料', 1, '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '教学课件与讲义资料');
INSERT INTO `edu_category` VALUES (3, 1, '0,1', '试题题库', 2, '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '章节测试与期末题库');
INSERT INTO `edu_category` VALUES (4, 1, '0,1', '实验实践', 3, '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '实验指导与实践项目');
INSERT INTO `edu_category` VALUES (5, 1, '0,1', '课程专区', 4, '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '按课程维度组织资源');
INSERT INTO `edu_category` VALUES (6, 5, '0,1,5', '公共基础课', 1, '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '通识与基础课程资源');
INSERT INTO `edu_category` VALUES (7, 5, '0,1,5', '专业核心课', 2, '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '专业核心课程资源');
INSERT INTO `edu_category` VALUES (8, 5, '0,1,5', '素质拓展课', 3, '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '素养与拓展课程资源');

-- ----------------------------
-- Table structure for edu_comment
-- ----------------------------
DROP TABLE IF EXISTS `edu_comment`;
CREATE TABLE `edu_comment`  (
  `comment_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `resource_id` bigint(20) NOT NULL COMMENT '资源ID',
  `resource_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源标题',
  `user_id` bigint(20) NOT NULL COMMENT '评论用户ID',
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论用户',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父评论ID',
  `parent_user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父级评论用户',
  `content` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论内容',
  `audit_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'pending' COMMENT '审核状态',
  `like_count` int(11) NULL DEFAULT 0 COMMENT '点赞数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标记',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '资源评论' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_comment
-- ----------------------------

-- ----------------------------
-- Table structure for edu_course
-- ----------------------------
DROP TABLE IF EXISTS `edu_course`;
CREATE TABLE `edu_course`  (
  `course_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'course id',
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'course name',
  `course_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'course code',
  `teacher_user_id` bigint(20) NULL DEFAULT NULL COMMENT 'teacher user id',
  `teacher_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'teacher name',
  `course_intro` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'course intro',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT 'status',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT 'delete flag',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'create by',
  `create_time` datetime NULL DEFAULT NULL COMMENT 'create time',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'update by',
  `update_time` datetime NULL DEFAULT NULL COMMENT 'update time',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`course_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'edu course' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_course
-- ----------------------------
INSERT INTO `edu_course` VALUES (1, '数据结构', 'KJ001', 1, '张老师', '围绕数据结构与算法设计，提供课件、实验和练习资料。', '0', '0', 'admin', '2026-03-24 12:31:01', 'admin', '2026-03-24 15:25:58', '专业核心课程');
INSERT INTO `edu_course` VALUES (2, '高等数学', 'SX201', 1, '张老师', '提供高等数学课堂讲义、习题解析与复习资料。', '0', '0', 'admin', '2026-03-24 12:31:01', 'admin', '2026-03-24 15:25:58', '公共基础课程');
INSERT INTO `edu_course` VALUES (3, '大学英语', 'YY301', 1, '李老师', '涵盖听说读写训练资料与课堂配套课件。', '0', '0', 'admin', '2026-03-24 12:31:01', 'admin', '2026-03-24 15:25:58', '公共基础课程');
INSERT INTO `edu_course` VALUES (4, '教学设计基础', 'JX101', 1, '王老师', '面向师范与教学类专业的教学设计基础资源。', '0', '0', 'admin', '2026-03-24 13:33:54', 'admin', '2026-03-24 15:25:58', '教学能力课程');

-- ----------------------------
-- Table structure for edu_course_chapter
-- ----------------------------
DROP TABLE IF EXISTS `edu_course_chapter`;
CREATE TABLE `edu_course_chapter`  (
  `chapter_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '章节ID',
  `course_id` bigint(20) NOT NULL COMMENT '课程ID',
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程名称',
  `chapter_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '章节标题',
  `chapter_intro` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '章节简介',
  `order_num` int(4) NULL DEFAULT 1 COMMENT '排序号',
  `resource_count` int(11) NULL DEFAULT 0 COMMENT '关联资源数',
  `attachment_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '章节附件地址',
  `attachment_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '章节附件名称',
  `attachment_size_mb` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '章节附件大小MB',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标记（0存在 2删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`chapter_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '课程章节' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_course_chapter
-- ----------------------------
INSERT INTO `edu_course_chapter` VALUES (1, 1, '数据结构', '第一章 绪论', '课程目标、学习方法与评价说明', 1, 2, NULL, NULL, 0.00, '0', '0', 'admin', '2026-03-24 16:58:39', '', NULL, '示例章节');
INSERT INTO `edu_course_chapter` VALUES (2, 2, '高等数学', '第一章 极限与连续', '极限概念、连续性及典型例题', 1, 3, NULL, NULL, 0.00, '0', '0', 'admin', '2026-03-24 16:58:39', '', NULL, '示例章节');

-- ----------------------------
-- Table structure for edu_course_notice
-- ----------------------------
DROP TABLE IF EXISTS `edu_course_notice`;
CREATE TABLE `edu_course_notice`  (
  `notice_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `course_id` bigint(20) NOT NULL COMMENT '课程ID',
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程名称',
  `notice_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_content` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告内容',
  `publisher_id` bigint(20) NOT NULL COMMENT '发布人ID',
  `publisher_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发布人名称',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程公告' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_course_notice
-- ----------------------------
INSERT INTO `edu_course_notice` VALUES (1, 1, '高等数学', '课程资源上新通知', '本周已更新高等数学课程课件、教案与习题资料，请同学们及时查看下载。', 1, 'admin', '0', '0', 'admin', '2026-03-24 17:41:36', 'admin', '2026-03-24 19:34:15', '系统初始化公告');

-- ----------------------------
-- Table structure for edu_download_log
-- ----------------------------
DROP TABLE IF EXISTS `edu_download_log`;
CREATE TABLE `edu_download_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '下载日志ID',
  `resource_id` bigint(20) NOT NULL COMMENT '资源ID',
  `resource_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源标题',
  `user_id` bigint(20) NOT NULL COMMENT '下载用户ID',
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '下载用户名',
  `file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件地址',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '下载日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_download_log
-- ----------------------------

-- ----------------------------
-- Table structure for edu_favorite
-- ----------------------------
DROP TABLE IF EXISTS `edu_favorite`;
CREATE TABLE `edu_favorite`  (
  `favorite_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `resource_id` bigint(20) NOT NULL COMMENT '资源ID',
  `resource_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源标题',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`favorite_id`) USING BTREE,
  UNIQUE INDEX `uk_favorite_user_resource`(`user_id` ASC, `resource_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '资源收藏' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_favorite
-- ----------------------------

-- ----------------------------
-- Table structure for edu_global_config
-- ----------------------------
DROP TABLE IF EXISTS `edu_global_config`;
CREATE TABLE `edu_global_config`  (
  `config_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `global_upload_mb` int(11) NOT NULL DEFAULT 500 COMMENT '全局文件上传限制MB',
  `video_upload_mb` int(11) NOT NULL DEFAULT 1024 COMMENT '视频上传限制MB',
  `design_upload_mb` int(11) NOT NULL DEFAULT 300 COMMENT '设计文件上传限制MB',
  `teacher_default_storage_gb` int(11) NOT NULL DEFAULT 20 COMMENT '教师默认空间GB',
  `teacher_default_upload_mb` int(11) NOT NULL DEFAULT 500 COMMENT '教师默认上传MB',
  `student_default_storage_gb` int(11) NOT NULL DEFAULT 5 COMMENT '学生默认空间GB',
  `student_default_upload_mb` int(11) NOT NULL DEFAULT 100 COMMENT '学生默认上传MB',
  `share_default_days` int(11) NOT NULL DEFAULT 7 COMMENT '默认分享有效天数',
  `share_max_days` int(11) NOT NULL DEFAULT 30 COMMENT '最大分享有效天数',
  `password_share_enable` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '允许密码分享（0否 1是）',
  `teacher_share_enable` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '教师允许分享（0否 1是）',
  `student_share_enable` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '学生允许分享（0否 1是）',
  `recycle_keep_days` int(11) NOT NULL DEFAULT 15 COMMENT '回收站保留天数',
  `storage_warn_percent` int(11) NOT NULL DEFAULT 85 COMMENT '空间预警百分比',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '教学资源全局配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_global_config
-- ----------------------------
INSERT INTO `edu_global_config` VALUES (1, 500, 1024, 300, 20, 500, 5, 100, 7, 30, '0', '0', '1', 15, 85, 'admin', '2026-03-23 22:57:48', 'admin', '2026-03-24 15:25:58', '教学资源空间与分享统一配置');

-- ----------------------------
-- Table structure for edu_message_center
-- ----------------------------
DROP TABLE IF EXISTS `edu_message_center`;
CREATE TABLE `edu_message_center`  (
  `message_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `user_id` bigint(20) NOT NULL COMMENT '接收用户ID',
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '接收用户名',
  `message_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息标题',
  `message_content` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息内容',
  `message_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'system' COMMENT '消息类型',
  `biz_id` bigint(20) NULL DEFAULT NULL COMMENT '业务ID',
  `read_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '读取状态（0未读 1已读）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息中心' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_message_center
-- ----------------------------
INSERT INTO `edu_message_center` VALUES (1, 1, 'admin', '资源审核通知', '您上传的资源《112》已审核通过并成功上架。', 'audit', 6, '0', '0', 'admin', '2026-03-26 19:16:04', '', NULL, NULL);
INSERT INTO `edu_message_center` VALUES (2, 1, 'admin', '资源审核通知', '您上传的资源《666》已审核通过并成功上架。', 'audit', 7, '0', '0', 'admin', '2026-03-26 19:21:31', '', NULL, NULL);

-- ----------------------------
-- Table structure for edu_report
-- ----------------------------
DROP TABLE IF EXISTS `edu_report`;
CREATE TABLE `edu_report`  (
  `report_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '举报ID',
  `report_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '举报类型(resource/comment)',
  `target_id` bigint(20) NOT NULL COMMENT '目标ID',
  `target_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '目标标题',
  `reporter_id` bigint(20) NOT NULL COMMENT '举报人ID',
  `reporter_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '举报人',
  `reason_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '举报原因类型',
  `report_content` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '举报说明',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'pending' COMMENT '状态',
  `handle_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理结果',
  `handler_id` bigint(20) NULL DEFAULT NULL COMMENT '处理人ID',
  `handler_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理人',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标记',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`report_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '举报处理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_report
-- ----------------------------

-- ----------------------------
-- Table structure for edu_resource
-- ----------------------------
DROP TABLE IF EXISTS `edu_resource`;
CREATE TABLE `edu_resource`  (
  `resource_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '资源ID',
  `resource_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资源标题',
  `resource_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资源类型',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '分类名称',
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '课程名称',
  `tag_names` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'tag names',
  `file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '文件地址',
  `original_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '原始文件名',
  `storage_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'local' COMMENT '存储类型(local/minio)',
  `storage_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '存储路径',
  `preview_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预览地址',
  `cover_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'cover url',
  `resource_version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'v1.0' COMMENT 'resource version',
  `file_size_mb` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '文件大小MB',
  `uploader_id` bigint(20) NULL DEFAULT NULL COMMENT '上传人ID',
  `uploader_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '上传人姓名',
  `audit_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending' COMMENT '审核状态(pending/approved/rejected)',
  `publish_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'draft' COMMENT '发布状态(draft/published/review/rejected)',
  `recommend_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT 'recommend flag',
  `download_count` int(11) NOT NULL DEFAULT 0 COMMENT '下载次数',
  `favorite_count` int(11) NOT NULL DEFAULT 0 COMMENT '收藏次数',
  `like_count` int(11) NOT NULL DEFAULT 0 COMMENT '点赞数',
  `resource_desc` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '资源说明',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '删除标识（0存在 2删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '教学资源表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_resource
-- ----------------------------
INSERT INTO `edu_resource` VALUES (1, '112', 'PDF', '教学资源库', '教学设计基础', '最新上传', '/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', '教学资源管理系统详细开发文档_AI版.txt', 'local', 'resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', 'http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', NULL, 'v1.0', 0.03, 1, 'admin', 'draft', 'draft', '0', 0, 0, 0, '12121', '0', 'admin', '2026-03-26 19:12:11', '', NULL, '21212');
INSERT INTO `edu_resource` VALUES (2, '112', 'PDF', '教学资源库', '教学设计基础', '最新上传', '/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', '教学资源管理系统详细开发文档_AI版.txt', 'local', 'resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', 'http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', NULL, 'v1.0', 0.03, 1, 'admin', 'draft', 'draft', '0', 0, 0, 0, '12121', '0', 'admin', '2026-03-26 19:12:17', '', NULL, '21212');
INSERT INTO `edu_resource` VALUES (3, '112', 'PDF', '教学资源库', '教学设计基础', '最新上传', '/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', '教学资源管理系统详细开发文档_AI版.txt', 'local', 'resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', 'http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', NULL, 'v1.0', 0.03, 1, 'admin', 'draft', 'draft', '0', 0, 0, 0, '12121', '0', 'admin', '2026-03-26 19:12:18', '', NULL, '21212');
INSERT INTO `edu_resource` VALUES (4, '112', 'PDF', '教学资源库', '教学设计基础', '最新上传', '/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', '教学资源管理系统详细开发文档_AI版.txt', 'local', 'resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', 'http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', NULL, 'v1.0', 0.03, 1, 'admin', 'draft', 'draft', '0', 0, 0, 0, '12121', '0', 'admin', '2026-03-26 19:12:35', '', NULL, '21212');
INSERT INTO `edu_resource` VALUES (5, '112', 'PDF', '教学资源库', '教学设计基础', '最新上传', '/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', '教学资源管理系统详细开发文档_AI版.txt', 'local', 'resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', 'http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', NULL, 'v1.0', 0.03, 1, 'admin', 'draft', 'draft', '0', 0, 0, 0, '12121', '0', 'admin', '2026-03-26 19:13:48', '', NULL, '21212');
INSERT INTO `edu_resource` VALUES (6, '112', 'PDF', '教学资源库', '教学设计基础', '最新上传', '/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', '教学资源管理系统详细开发文档_AI版.txt', 'local', 'resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', 'http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt', NULL, 'v1.0', 0.03, 1, 'admin', 'approved', 'published', '0', 0, 0, 0, '12121', '0', 'admin', '2026-03-26 19:13:50', '', '2026-03-26 19:16:04', '21212');
INSERT INTO `edu_resource` VALUES (7, '666', 'PDF', '教学资源库', '教学设计基础', '最新上传,期末冲刺', '/profile/upload/resource/2026/03/26/人体解剖知识在美术中的应用历程_20260326192103A002.pptx', '人体解剖知识在美术中的应用历程.pptx', 'local', 'resource/人体解剖知识在美术中的应用历程_20260326192103A002.pptx', 'http://localhost:8080/profile/upload/resource/2026/03/26/人体解剖知识在美术中的应用历程_20260326192103A002.pptx', NULL, 'v1.0', 3.36, 1, 'admin', 'approved', 'published', '0', 0, 0, 0, '666666666', '0', 'admin', '2026-03-26 19:21:14', '', '2026-03-26 19:21:31', '6666666666666666666');

-- ----------------------------
-- Table structure for edu_resource_audit
-- ----------------------------
DROP TABLE IF EXISTS `edu_resource_audit`;
CREATE TABLE `edu_resource_audit`  (
  `audit_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '审核ID',
  `resource_id` bigint(20) NOT NULL COMMENT '资源ID',
  `resource_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '资源标题',
  `audit_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '审核结果',
  `audit_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '审核意见',
  `auditor_id` bigint(20) NULL DEFAULT NULL COMMENT '审核人ID',
  `auditor_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '审核人姓名',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标识(0存在 2删除)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`audit_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '教学资源审核记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_resource_audit
-- ----------------------------
INSERT INTO `edu_resource_audit` VALUES (1, 6, '112', 'approved', '审核通过', 1, 'admin', '2026-03-26 19:16:04', '0', 'admin', '2026-03-26 19:15:50', 'admin', '2026-03-26 19:16:04', NULL);
INSERT INTO `edu_resource_audit` VALUES (2, 7, '666', 'approved', '审核通过', 1, 'admin', '2026-03-26 19:21:32', '0', 'admin', '2026-03-26 19:21:19', 'admin', '2026-03-26 19:21:31', NULL);

-- ----------------------------
-- Table structure for edu_resource_like
-- ----------------------------
DROP TABLE IF EXISTS `edu_resource_like`;
CREATE TABLE `edu_resource_like`  (
  `like_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `resource_id` bigint(20) NOT NULL COMMENT '资源ID',
  `resource_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资源标题',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`like_id`) USING BTREE,
  UNIQUE INDEX `uk_like_user_resource`(`user_id` ASC, `resource_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资源点赞' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_resource_like
-- ----------------------------

-- ----------------------------
-- Table structure for edu_space_file
-- ----------------------------
DROP TABLE IF EXISTS `edu_space_file`;
CREATE TABLE `edu_space_file`  (
  `file_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '空间文件ID',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父级ID',
  `owner_user_id` bigint(20) NOT NULL COMMENT '所属用户ID',
  `owner_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '所属用户名',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '逻辑文件名',
  `original_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '原始文件名',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'file' COMMENT '类型(folder/file)',
  `file_ext` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件后缀',
  `file_size_mb` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '文件大小MB',
  `storage_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'local' COMMENT '存储类型',
  `storage_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '存储路径',
  `file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '访问地址',
  `preview_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预览地址',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态(0正常 1停用)',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标识(0存在 2删除)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '空间文件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_space_file
-- ----------------------------
INSERT INTO `edu_space_file` VALUES (1, 0, 1, 'admin', '1111', NULL, 'folder', NULL, 0.00, NULL, NULL, NULL, NULL, '0', '0', 'admin', '2026-03-26 19:26:33', '', NULL, '');
INSERT INTO `edu_space_file` VALUES (2, 1, 1, 'admin', '人体解剖知识在美术中的应用历程.pptx', '人体解剖知识在美术中的应用历程.pptx', 'file', 'pptx', 3.36, 'local', 'space/人体解剖知识在美术中的应用历程_20260326192642A003.pptx', 'http://localhost:8080/profile/upload/space/2026/03/26/人体解剖知识在美术中的应用历程_20260326192642A003.pptx', 'http://localhost:8080/profile/upload/space/2026/03/26/人体解剖知识在美术中的应用历程_20260326192642A003.pptx', '0', '0', 'admin', '2026-03-26 19:26:42', '', NULL, NULL);

-- ----------------------------
-- Table structure for edu_space_share
-- ----------------------------
DROP TABLE IF EXISTS `edu_space_share`;
CREATE TABLE `edu_space_share`  (
  `share_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分享ID',
  `owner_user_id` bigint(20) NOT NULL COMMENT '拥有者ID',
  `owner_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '拥有者名称',
  `share_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分享名称',
  `file_id` bigint(20) NULL DEFAULT NULL COMMENT '关联空间文件ID',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'folder' COMMENT '目标类型（folder/file）',
  `target_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '目标名称',
  `target_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '目标路径',
  `share_mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'password' COMMENT '分享方式（public/password/internal）',
  `share_password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '分享密码',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
  `download_limit` int(11) NOT NULL DEFAULT 0 COMMENT '下载限制（0不限）',
  `download_count` int(11) NOT NULL DEFAULT 0 COMMENT '下载次数',
  `view_count` int(11) NOT NULL DEFAULT 0 COMMENT '查看次数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标识(0存在 2删除)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`share_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '空间分享' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_space_share
-- ----------------------------
INSERT INTO `edu_space_share` VALUES (1, 100, '张老师', '数据结构课程资料夹', NULL, 'folder', '数据结构-第一章', '/教师空间/张老师/数据结构-第一章', 'password', 'A1234', '2026-03-31 13:56:44', 50, 8, 26, '0', '0', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-24 15:25:58', '学生课后复习分享');
INSERT INTO `edu_space_share` VALUES (2, 1, '平台管理员', '新生指引课件', NULL, 'file', '平台使用指南.pptx', '/公共资源/平台使用指南.pptx', 'public', '', '2026-04-23 13:56:44', 0, 12, 46, '0', '0', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-24 15:25:58', '新生入学指导文件');
INSERT INTO `edu_space_share` VALUES (6, 1, 'admin', '人体解剖知识在美术中的应用历程.pptx 分享', 2, 'file', '人体解剖知识在美术中的应用历程.pptx', 'space/人体解剖知识在美术中的应用历程_20260326192642A003.pptx', 'public', NULL, '2026-04-02 19:26:44', 0, 0, 0, '0', '0', 'admin', '2026-03-26 19:26:45', '', NULL, '');
INSERT INTO `edu_space_share` VALUES (7, 1, 'admin', '人体解剖知识在美术中的应用历程.pptx 分享', 2, 'file', '人体解剖知识在美术中的应用历程.pptx', 'space/人体解剖知识在美术中的应用历程_20260326192642A003.pptx', 'public', NULL, '2026-04-02 19:26:44', 0, 0, 0, '0', '0', 'admin', '2026-03-26 19:27:23', '', NULL, '');

-- ----------------------------
-- Table structure for edu_tag
-- ----------------------------
DROP TABLE IF EXISTS `edu_tag`;
CREATE TABLE `edu_tag`  (
  `tag_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'tag id',
  `tag_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'tag name',
  `tag_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'general' COMMENT 'tag type',
  `color` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#409EFF' COMMENT 'tag color',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT 'status',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT 'delete flag',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'create by',
  `create_time` datetime NULL DEFAULT NULL COMMENT 'create time',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'update by',
  `update_time` datetime NULL DEFAULT NULL COMMENT 'update time',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'edu tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_tag
-- ----------------------------
INSERT INTO `edu_tag` VALUES (1, '精品资源', '推荐', '#67C23A', '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '精品课程与重点推荐资源');
INSERT INTO `edu_tag` VALUES (2, '教师推荐', '推荐', '#E6A23C', '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '教师优先推荐学习资料');
INSERT INTO `edu_tag` VALUES (3, '期中复习', '阶段', '#409EFF', '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '适用于期中阶段复习');
INSERT INTO `edu_tag` VALUES (4, '期末冲刺', '阶段', '#F56C6C', '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '适用于期末阶段冲刺');
INSERT INTO `edu_tag` VALUES (5, '最新上传', '时效', '#909399', '0', '0', 'admin', '2026-03-24 12:31:01', '', NULL, '近期上传的最新资料');

-- ----------------------------
-- Table structure for edu_teacher_student_grant
-- ----------------------------
DROP TABLE IF EXISTS `edu_teacher_student_grant`;
CREATE TABLE `edu_teacher_student_grant`  (
  `grant_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '授权ID',
  `teacher_user_id` bigint(20) NOT NULL COMMENT '教师ID',
  `teacher_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '教师姓名',
  `student_user_id` bigint(20) NOT NULL COMMENT '学生ID',
  `student_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '学生姓名',
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程名称',
  `grant_preset` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'read' COMMENT '授权模板',
  `grant_perms` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '授权内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `expires_at` datetime NULL DEFAULT NULL COMMENT '过期时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`grant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '教师学生授权表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_teacher_student_grant
-- ----------------------------
INSERT INTO `edu_teacher_student_grant` VALUES (1, 100, '张老师', 101, '王同学', '数据结构', 'read', '课件浏览,作业下载', '0', '2026-09-20 13:56:44', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-24 15:25:58', '课程资料查阅授权');

-- ----------------------------
-- Table structure for edu_user_quota
-- ----------------------------
DROP TABLE IF EXISTS `edu_user_quota`;
CREATE TABLE `edu_user_quota`  (
  `quota_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '额度ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `storage_gb` int(11) NOT NULL DEFAULT 0 COMMENT '存储空间GB',
  `upload_mb` int(11) NOT NULL DEFAULT 0 COMMENT '单文件上传限制MB',
  `used_storage_mb` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '已使用空间MB',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `allow_share` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '允许分享（0是 1否）',
  `allow_password_share` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '允许密码分享（0是 1否）',
  `max_share_days` int(11) NOT NULL DEFAULT 30 COMMENT '最大分享天数',
  `ban_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封禁原因',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`quota_id`) USING BTREE,
  UNIQUE INDEX `uk_edu_user_quota_user`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '教学资源用户额度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of edu_user_quota
-- ----------------------------
INSERT INTO `edu_user_quota` VALUES (1, 1, 50, 1024, 1283.36, '0', '0', '0', 30, '', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-26 19:26:42', '管理员空间额度');
INSERT INTO `edu_user_quota` VALUES (2, 100, 30, 512, 860.00, '0', '0', '0', 30, '', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-24 15:25:58', '教师默认空间');
INSERT INTO `edu_user_quota` VALUES (3, 101, 8, 200, 320.00, '0', '1', '0', 7, '', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-24 15:25:58', '学生默认空间');
INSERT INTO `edu_user_quota` VALUES (4, 102, 10, 200, 120.00, '0', '1', '0', 7, '', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-24 15:25:58', '审核账号空间');
INSERT INTO `edu_user_quota` VALUES (6, 104, 5, 100, 0.00, '0', '1', '0', 7, '', 'self-register', '2026-03-24 15:58:00', 'self-register', '2026-03-24 15:58:00', '学生注册默认空间');
INSERT INTO `edu_user_quota` VALUES (9, 108, 20, 500, 0.00, '0', '0', '0', 30, '', 'self-register', '2026-03-25 23:06:33', 'self-register', '2026-03-25 23:06:33', '教师注册默认空间');
INSERT INTO `edu_user_quota` VALUES (10, 109, 5, 100, 0.00, '0', '1', '0', 7, '', 'self-register', '2026-03-25 23:06:33', 'self-register', '2026-03-25 23:06:33', '学生注册默认空间');
INSERT INTO `edu_user_quota` VALUES (11, 110, 20, 500, 0.00, '0', '0', '0', 30, '', 'self-register', '2026-03-26 14:20:21', 'self-register', '2026-03-26 14:20:21', '教师注册默认空间');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for portal_banner
-- ----------------------------
DROP TABLE IF EXISTS `portal_banner`;
CREATE TABLE `portal_banner`  (
  `banner_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
  `banner_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '轮播标题',
  `banner_subtitle` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '轮播副标题',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片地址',
  `target_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转链接',
  `button_text` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '按钮文案',
  `sort_num` int(11) NULL DEFAULT 10 COMMENT '排序号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0启用 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`banner_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '官网轮播图' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of portal_banner
-- ----------------------------
INSERT INTO `portal_banner` VALUES (1, '重要通知统一发布', '系统公告、教学通知、校园资讯均可在后台发布后实时同步到官网首页与公告中心。', '/profile/upload/2026/03/26/屏幕截图 2026-01-13 195826_20260326170001A002.png', '/announcements', '查看公告', 1, '0', 'admin', '2026-03-26 16:36:41', 'admin', '2026-03-26 17:00:02', '官网默认轮播图');
INSERT INTO `portal_banner` VALUES (2, '重要资讯首页展示', '支持首页轮播展示学校重点活动、资源专题、精品课程与最新建设成果。', '/profile/upload/2026/03/26/屏幕截图 2026-01-12 184021_20260326170007A003.png', '/announcements', '查看资讯', 2, '0', 'admin', '2026-03-26 16:36:41', 'admin', '2026-03-26 17:00:09', '官网默认轮播图');

-- ----------------------------
-- Table structure for portal_site_config
-- ----------------------------
DROP TABLE IF EXISTS `portal_site_config`;
CREATE TABLE `portal_site_config`  (
  `config_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '官网配置ID',
  `site_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '站点中文名',
  `site_en_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '站点英文名',
  `logo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Logo地址',
  `home_nav_text` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '首页' COMMENT '首页导航名称',
  `notice_nav_text` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '公告中心' COMMENT '公告导航名称',
  `teacher_nav_text` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '教师端' COMMENT '教师端导航名称',
  `student_nav_text` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '学生端' COMMENT '学生端导航名称',
  `login_button_text` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '进入后台' COMMENT '后台按钮名称',
  `hero_badge` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '首页角标',
  `hero_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '首页主标题',
  `hero_subtitle` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '首页副标题',
  `hero_primary_text` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主按钮文案',
  `hero_primary_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主按钮链接',
  `hero_secondary_text` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '次按钮文案',
  `hero_secondary_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '次按钮链接',
  `notice_panel_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '最新公告' COMMENT '公告面板标题',
  `notice_panel_more_text` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '全部公告' COMMENT '公告更多文案',
  `footer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '页脚名称',
  `footer_desc` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '页脚简介',
  `footer_copyright` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '版权信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0启用 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '官网配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of portal_site_config
-- ----------------------------
INSERT INTO `portal_site_config` VALUES (1, '教学资源管理系统', 'Teaching Resource Management System', '/profile/upload/2026/03/26/屏幕截图 2026-01-12 210854_20260326165753A001.png', '首页', '公告中心', '教师端', '学生端', '进入后台', '统一教学资源门户', '面向学校与院系的教学资源官网', '统一展示公告、重要资讯与教学资源动态，让学校和访客可以在官网首页快速获取核心信息。', '查看公告中心', '/announcements', '了解官网能力', '#capability', '最新公告', '全部公告', '教学资源管理系统', '统一发布学校通知、教学公告、资源动态与重要资讯。', '© 2026 教学资源管理系统', '0', 'admin', '2026-03-26 16:36:41', 'admin', '2026-03-26 16:57:56', '官网默认配置');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-03-23 22:57:48', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-03-23 22:57:48', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-03-23 22:57:48', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2026-03-23 22:57:48', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2026-03-23 22:57:48', 'admin', '2026-03-24 15:25:58', '是否开启学生注册功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-03-23 22:57:48', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-03-23 22:57:48', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-03-23 22:57:48', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (100, '账号自助-教师注册开关', 'sys.account.registerTeacher', 'true', 'Y', 'admin', '2026-03-24 15:50:25', 'admin', '2026-03-24 15:50:25', 'true 开启，false 关闭');
INSERT INTO `sys_config` VALUES (101, '账号自助-学生注册开关', 'sys.account.registerStudent', 'true', 'Y', 'admin', '2026-03-24 15:50:25', 'admin', '2026-03-24 15:50:25', 'true 开启，false 关闭');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '教学资源中心', 0, '平台管理员', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-23 22:57:46', 'admin', '2026-03-24 13:35:38');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '教务管理中心', 1, '李主任', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-23 22:57:46', 'admin', '2026-03-24 13:35:45');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '继续教育中心', 2, '周主任', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-23 22:57:46', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '课程资源组', 1, '张老师', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-23 22:57:46', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '教学运营组', 2, '王老师', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-23 22:57:46', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '质量审核组', 3, '审核老师', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-23 22:57:46', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '学习服务组', 4, '刘老师', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-23 22:57:46', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '平台运维组', 5, '平台管理员', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-23 22:57:46', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '学生发展组', 1, '王同学', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-23 22:57:46', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '实训支持组', 2, '赵老师', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-23 22:57:46', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_feedback
-- ----------------------------
DROP TABLE IF EXISTS `sys_feedback`;
CREATE TABLE `sys_feedback`  (
  `feedback_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '反馈ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '反馈标题',
  `content` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '反馈内容',
  `contact` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'pending' COMMENT '状态',
  `reply_content` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回复内容',
  `reply_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回复人',
  `reply_time` datetime NULL DEFAULT NULL COMMENT '回复时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标记',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`feedback_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '意见反馈' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-03-23 22:57:48', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-03-23 22:57:48', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-03-23 22:57:48', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `start_time` datetime NULL DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '执行结束时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 153 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 11:58:10');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '1', '验证码错误', '2026-03-24 12:07:54');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '1', '验证码错误', '2026-03-24 12:07:54');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '1', '验证码错误', '2026-03-24 12:07:55');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 12:08:01');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', '2026-03-24 13:06:36');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 13:06:37');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '0', '登录成功', '2026-03-24 14:17:20');
INSERT INTO `sys_logininfor` VALUES (108, 'student_tmp_0324', '127.0.0.1', '内网IP', 'Python-Requests 2.32.5', '', '0', '注册成功', '2026-03-24 15:39:09');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 15:47:53');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', '2026-03-24 15:50:26');
INSERT INTO `sys_logininfor` VALUES (111, '478201690', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '注册成功', '2026-03-24 15:58:05');
INSERT INTO `sys_logininfor` VALUES (112, '478201690', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 15:58:21');
INSERT INTO `sys_logininfor` VALUES (113, 'teacher_reg_tcjkkz', '127.0.0.1', '内网IP', 'Python-Requests 2.32.5', '', '0', '注册成功', '2026-03-24 15:59:27');
INSERT INTO `sys_logininfor` VALUES (114, 'student_reg_pz7b10', '127.0.0.1', '内网IP', 'Python-Requests 2.32.5', '', '0', '注册成功', '2026-03-24 15:59:27');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 17:03:26');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 17:42:48');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 19:42:17');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', '2026-03-24 19:42:48');
INSERT INTO `sys_logininfor` VALUES (119, '478201690', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 19:43:05');
INSERT INTO `sys_logininfor` VALUES (120, '478201690', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', '2026-03-24 19:43:44');
INSERT INTO `sys_logininfor` VALUES (121, '478201690', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 19:43:50');
INSERT INTO `sys_logininfor` VALUES (122, '478201690', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', '2026-03-24 19:43:57');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '1', '用户不存在/密码错误', '2026-03-24 19:44:08');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 19:44:20');
INSERT INTO `sys_logininfor` VALUES (125, '478201690', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 22:30:22');
INSERT INTO `sys_logininfor` VALUES (126, '478201690', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', '2026-03-24 22:30:36');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 22:30:53');
INSERT INTO `sys_logininfor` VALUES (128, '13037687601', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-24 22:34:13');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '1', '用户不存在/密码错误', '2026-03-25 22:54:25');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '1', '用户不存在/密码错误', '2026-03-25 22:54:33');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-25 22:54:55');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '0', '登录成功', '2026-03-25 23:05:03');
INSERT INTO `sys_logininfor` VALUES (133, 'teacher01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '1', '用户不存在/密码错误', '2026-03-25 23:05:03');
INSERT INTO `sys_logininfor` VALUES (134, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '1', '用户不存在/密码错误', '2026-03-25 23:05:03');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '0', '登录成功', '2026-03-25 23:05:24');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '0', '登录成功', '2026-03-25 23:05:24');
INSERT INTO `sys_logininfor` VALUES (137, 'stu1774451193', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '0', '注册成功', '2026-03-25 23:06:33');
INSERT INTO `sys_logininfor` VALUES (138, 'tea1774451193', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '0', '注册成功', '2026-03-25 23:06:33');
INSERT INTO `sys_logininfor` VALUES (139, 'stu1774451193', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '0', '登录成功', '2026-03-25 23:06:34');
INSERT INTO `sys_logininfor` VALUES (140, 'tea1774451193', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '0', '登录成功', '2026-03-25 23:06:53');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '0', '登录成功', '2026-03-25 23:08:44');
INSERT INTO `sys_logininfor` VALUES (142, 'tea1774451193', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '0', '登录成功', '2026-03-25 23:11:49');
INSERT INTO `sys_logininfor` VALUES (143, 'stu1774451193', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.26100.7920', 'Windows 10.0', '0', '登录成功', '2026-03-25 23:11:49');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-26 01:06:16');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '1', '验证码已失效', '2026-03-26 14:06:52');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-26 14:08:02');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '退出成功', '2026-03-26 14:19:54');
INSERT INTO `sys_logininfor` VALUES (148, '1741065057', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '注册成功', '2026-03-26 14:20:21');
INSERT INTO `sys_logininfor` VALUES (149, '1741065057', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-26 14:20:37');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-26 16:52:40');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-26 18:16:19');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome 146', 'Windows10', '0', '登录成功', '2026-03-26 19:05:53');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2350 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-03-23 22:57:46', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-03-23 22:57:46', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-03-23 22:57:46', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-03-23 22:57:47', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-03-23 22:57:47', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-03-23 22:57:47', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-03-23 22:57:47', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-03-23 22:57:47', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-03-23 22:57:47', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 'SystemConfig', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-03-23 22:57:47', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 'SystemNotice', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-03-23 22:57:47', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-03-23 22:57:47', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-03-23 22:57:47', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-03-23 22:57:47', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-03-23 22:57:47', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-03-23 22:57:47', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-03-23 22:57:47', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-03-23 22:57:47', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-03-23 22:57:47', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-03-23 22:57:47', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-03-23 22:57:47', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-03-23 22:57:47', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-03-23 22:57:47', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-03-23 22:57:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2100, '教学资源', 0, 5, 'edu', NULL, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', '2026-03-23 22:57:49', 'admin', '2026-03-24 15:25:58', '教学资源目录');
INSERT INTO `sys_menu` VALUES (2101, '资源管理', 2100, 4, 'resource', 'edu/resource/index', '', '', 1, 0, 'C', '0', '0', 'edu:resource:list', 'documentation', 'admin', '2026-03-23 22:57:49', 'admin', '2026-03-24 15:25:58', '教学资源管理');
INSERT INTO `sys_menu` VALUES (2102, '资源审核', 2100, 5, 'audit', 'edu/audit/index', '', '', 1, 0, 'C', '0', '0', 'edu:audit:list', 'validCode', 'admin', '2026-03-23 22:57:49', 'admin', '2026-03-24 15:25:58', '教学资源审核');
INSERT INTO `sys_menu` VALUES (2103, '资源授权', 2100, 6, 'grant', 'edu/grant/index', '', '', 1, 0, 'C', '0', '0', 'edu:grant:list', 'peoples', 'admin', '2026-03-23 22:57:49', 'admin', '2026-03-24 15:25:58', '教师对学生授权');
INSERT INTO `sys_menu` VALUES (2104, '空间配额', 2100, 8, 'quota', 'edu/quota/index', '', '', 1, 0, 'C', '0', '0', 'edu:quota:list', 'size', 'admin', '2026-03-23 22:57:49', 'admin', '2026-03-24 15:25:58', '教师学生额度管理');
INSERT INTO `sys_menu` VALUES (2105, '空间策略', 2100, 9, 'config', 'edu/config/index', '', 'EduConfig', 1, 0, 'C', '0', '0', 'edu:config:query', 'edit', 'admin', '2026-03-23 22:57:49', 'admin', '2026-03-24 15:25:58', '全局策略配置');
INSERT INTO `sys_menu` VALUES (2106, '空间分享', 2100, 7, 'share', 'edu/share/index', '', 'EduShare', 1, 0, 'C', '0', '0', 'edu:share:list', 'share', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-24 15:25:58', '空间分享管理');
INSERT INTO `sys_menu` VALUES (2110, '资源查询', 2101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:query', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2111, '资源新增', 2101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:add', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2112, '资源修改', 2101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:edit', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2113, '资源删除', 2101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:remove', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2120, '审核查询', 2102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:audit:query', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2121, '审核通过', 2102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:audit:approve', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2122, '审核驳回', 2102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:audit:reject', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2130, '授权查询', 2103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:grant:query', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2131, '授权新增', 2103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:grant:add', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2132, '授权修改', 2103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:grant:edit', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2133, '授权删除', 2103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:grant:remove', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2140, '额度查询', 2104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:quota:query', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2141, '额度修改', 2104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:quota:edit', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2142, '配置查询', 2105, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:config:query', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2143, '配置修改', 2105, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'edu:config:edit', '#', 'admin', '2026-03-23 22:57:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2201, '分类管理', 2100, 1, 'category', 'edu/category/index', '', '', 1, 0, 'C', '0', '0', 'edu:category:list', 'tree', 'admin', '2026-03-24 12:31:01', 'admin', '2026-03-24 15:25:58', 'category');
INSERT INTO `sys_menu` VALUES (2202, '标签管理', 2100, 2, 'tag', 'edu/tag/index', '', '', 1, 0, 'C', '0', '0', 'edu:tag:list', 'dict', 'admin', '2026-03-24 12:31:01', 'admin', '2026-03-24 15:25:58', 'tag');
INSERT INTO `sys_menu` VALUES (2203, '课程管理', 2100, 3, 'course', 'edu/course/index', '', '', 1, 0, 'C', '0', '0', 'edu:course:list', 'form', 'admin', '2026-03-24 12:31:01', 'admin', '2026-03-24 15:25:58', 'course');
INSERT INTO `sys_menu` VALUES (2210, '查询', 2201, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:category:query', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2211, '新增', 2201, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:category:add', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2212, '修改', 2201, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:category:edit', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2213, '删除', 2201, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:category:remove', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2220, '查询', 2202, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:tag:query', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2221, '新增', 2202, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:tag:add', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2222, '修改', 2202, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:tag:edit', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2223, '删除', 2202, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:tag:remove', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2230, '查询', 2203, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:course:query', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2231, '新增', 2203, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:course:add', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2232, '修改', 2203, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:course:edit', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2233, '删除', 2203, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:course:remove', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2240, '查询', 2101, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:query', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2241, '新增', 2101, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:add', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2242, '修改', 2101, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:edit', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2243, '删除', 2101, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:remove', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2244, '审核', 2101, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:audit', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2245, '推荐', 2101, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:recommend', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2250, '查询', 2102, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:audit:query', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2251, '通过', 2102, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:audit:pass', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2252, '驳回', 2102, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:audit:reject', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2253, '下线', 2102, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:audit:offline', '#', 'admin', '2026-03-24 12:31:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2260, '查询', 2106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:share:query', '#', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-24 15:25:58', '空间分享按钮');
INSERT INTO `sys_menu` VALUES (2261, '新增', 2106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:share:add', '#', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-24 15:25:58', '空间分享按钮');
INSERT INTO `sys_menu` VALUES (2262, '修改', 2106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:share:edit', '#', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-24 15:25:58', '空间分享按钮');
INSERT INTO `sys_menu` VALUES (2263, '删除', 2106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:share:remove', '#', 'admin', '2026-03-24 13:56:44', 'admin', '2026-03-24 15:25:58', '空间分享按钮');
INSERT INTO `sys_menu` VALUES (2270, '课程章节', 2100, 10, 'chapter', 'edu/chapter/index', NULL, '', 1, 0, 'C', '0', '0', 'edu:chapter:list', 'tickets', 'admin', '2026-03-24 16:58:39', '', NULL, '课程章节');
INSERT INTO `sys_menu` VALUES (2271, '评论管理', 2100, 11, 'comment', 'edu/comment/index', NULL, '', 1, 0, 'C', '0', '0', 'edu:comment:list', 'message', 'admin', '2026-03-24 16:58:39', '', NULL, '评论管理');
INSERT INTO `sys_menu` VALUES (2272, '收藏记录', 2100, 12, 'favorite', 'edu/favorite/index', NULL, '', 1, 0, 'C', '0', '0', 'edu:favorite:list', 'star-on', 'admin', '2026-03-24 16:58:39', '', NULL, '收藏记录');
INSERT INTO `sys_menu` VALUES (2273, '举报处理', 2100, 13, 'report', 'edu/report/index', NULL, '', 1, 0, 'C', '0', '0', 'edu:report:list', 'warning-outline', 'admin', '2026-03-24 16:58:39', '', NULL, '举报处理');
INSERT INTO `sys_menu` VALUES (2274, '意见反馈', 2100, 14, 'feedback', 'edu/feedback/index', NULL, '', 1, 0, 'C', '0', '0', 'edu:feedback:list', 'chat-line-square', 'admin', '2026-03-24 16:58:39', '', NULL, '意见反馈');
INSERT INTO `sys_menu` VALUES (2275, '下载日志', 2100, 15, 'download', 'edu/download/index', NULL, '', 1, 0, 'C', '0', '0', 'edu:download:list', 'download', 'admin', '2026-03-24 16:58:39', '', NULL, '下载日志');
INSERT INTO `sys_menu` VALUES (2276, '统计分析', 2100, 16, 'stats', 'edu/stats/index', NULL, '', 1, 0, 'C', '0', '0', 'edu:stats:view', 'chart', 'admin', '2026-03-24 16:58:39', '', NULL, '统计分析');
INSERT INTO `sys_menu` VALUES (2277, '查询', 2270, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:chapter:query', '#', 'admin', '2026-03-24 16:58:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2278, '新增', 2270, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:chapter:add', '#', 'admin', '2026-03-24 16:58:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2279, '修改', 2270, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:chapter:edit', '#', 'admin', '2026-03-24 16:58:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2280, '删除', 2270, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:chapter:remove', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2281, '查询', 2271, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:comment:query', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2282, '新增', 2271, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:comment:add', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2283, '修改', 2271, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:comment:edit', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2284, '删除', 2271, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:comment:remove', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2285, '审核', 2271, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:comment:audit', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2286, '查询', 2272, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:favorite:query', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2287, '新增', 2272, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:favorite:add', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2288, '删除', 2272, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:favorite:remove', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2289, '查询', 2273, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:report:query', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2290, '新增', 2273, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:report:add', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2291, '处理', 2273, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:report:handle', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2292, '删除', 2273, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:report:remove', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2293, '查询', 2274, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:feedback:query', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2294, '新增', 2274, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:feedback:add', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2295, '回复', 2274, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:feedback:reply', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2296, '删除', 2274, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:feedback:remove', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2297, '查询', 2275, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:download:query', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2298, '删除', 2275, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:download:remove', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2299, '查看', 2276, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:stats:view', '#', 'admin', '2026-03-24 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2300, '课程公告', 2100, 17, 'notice', 'edu/notice/index', NULL, 'EduNotice', 1, 0, 'C', '0', '0', 'edu:notice:list', 'message', 'admin', '2026-03-24 17:41:36', '', NULL, '课程公告管理');
INSERT INTO `sys_menu` VALUES (2301, '消息中心', 2100, 18, 'message', 'edu/message/index', NULL, 'EduMessage', 1, 0, 'C', '0', '0', 'edu:message:list', 'email', 'admin', '2026-03-24 17:41:36', '', NULL, '系统消息管理');
INSERT INTO `sys_menu` VALUES (2302, '资源搜索', 2100, 19, 'search', 'edu/search/index', NULL, 'EduSearch', 1, 0, 'C', '0', '0', 'edu:search:list', 'search', 'admin', '2026-03-24 17:41:36', '', NULL, '教学资源搜索');
INSERT INTO `sys_menu` VALUES (2303, '资源点赞', 2100, 20, 'like', 'edu/like/index', NULL, 'EduLike', 1, 0, 'C', '0', '0', 'edu:like:list', 'thumb', 'admin', '2026-03-24 17:41:36', '', NULL, '资源点赞管理');
INSERT INTO `sys_menu` VALUES (2310, 'AI任务', 2100, 21, 'ai-task', 'ai/task/index', NULL, 'AiTask', 1, 0, 'C', '0', '0', 'ai:task:list', 'guide', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI任务管理');
INSERT INTO `sys_menu` VALUES (2311, 'AI提示词', 2100, 22, 'ai-prompt', 'ai/prompt/index', NULL, 'AiPrompt', 1, 0, 'C', '0', '0', 'ai:prompt:list', 'edit', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI提示词模板');
INSERT INTO `sys_menu` VALUES (2312, 'AI审核结果', 2100, 23, 'ai-audit', 'ai/audit/index', NULL, 'AiAudit', 1, 0, 'C', '0', '0', 'ai:audit:list', 'form', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI审核结果管理');
INSERT INTO `sys_menu` VALUES (2313, 'AI问答', 2100, 24, 'ai-qa', 'ai/qa/index', NULL, 'AiQa', 1, 0, 'C', '0', '0', 'ai:qa:list', 'question', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI问答记录');
INSERT INTO `sys_menu` VALUES (2320, '查询', 2300, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'edu:notice:query', '#', 'admin', '2026-03-24 17:41:36', '', NULL, '课程公告按钮');
INSERT INTO `sys_menu` VALUES (2321, '新增', 2300, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'edu:notice:add', '#', 'admin', '2026-03-24 17:41:36', '', NULL, '课程公告按钮');
INSERT INTO `sys_menu` VALUES (2322, '修改', 2300, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'edu:notice:edit', '#', 'admin', '2026-03-24 17:41:36', '', NULL, '课程公告按钮');
INSERT INTO `sys_menu` VALUES (2323, '删除', 2300, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'edu:notice:remove', '#', 'admin', '2026-03-24 17:41:36', '', NULL, '课程公告按钮');
INSERT INTO `sys_menu` VALUES (2324, '查询', 2301, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'edu:message:query', '#', 'admin', '2026-03-24 17:41:36', '', NULL, '消息中心按钮');
INSERT INTO `sys_menu` VALUES (2325, '新增', 2301, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'edu:message:add', '#', 'admin', '2026-03-24 17:41:36', '', NULL, '消息中心按钮');
INSERT INTO `sys_menu` VALUES (2326, '删除', 2301, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'edu:message:remove', '#', 'admin', '2026-03-24 17:41:36', '', NULL, '消息中心按钮');
INSERT INTO `sys_menu` VALUES (2327, '搜索', 2302, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'edu:search:list', '#', 'admin', '2026-03-24 17:41:36', '', NULL, '资源搜索按钮');
INSERT INTO `sys_menu` VALUES (2328, '查询', 2303, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'edu:like:query', '#', 'admin', '2026-03-24 17:41:36', '', NULL, '资源点赞按钮');
INSERT INTO `sys_menu` VALUES (2329, '删除', 2303, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'edu:like:remove', '#', 'admin', '2026-03-24 17:41:36', '', NULL, '资源点赞按钮');
INSERT INTO `sys_menu` VALUES (2330, '查询', 2310, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:task:query', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI任务按钮');
INSERT INTO `sys_menu` VALUES (2331, '执行', 2310, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:task:run', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI任务按钮');
INSERT INTO `sys_menu` VALUES (2332, '删除', 2310, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:task:remove', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI任务按钮');
INSERT INTO `sys_menu` VALUES (2333, '查询', 2311, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:prompt:query', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI提示词按钮');
INSERT INTO `sys_menu` VALUES (2334, '新增', 2311, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:prompt:add', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI提示词按钮');
INSERT INTO `sys_menu` VALUES (2335, '修改', 2311, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:prompt:edit', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI提示词按钮');
INSERT INTO `sys_menu` VALUES (2336, '删除', 2311, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:prompt:remove', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI提示词按钮');
INSERT INTO `sys_menu` VALUES (2337, '查询', 2312, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:audit:query', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI审核按钮');
INSERT INTO `sys_menu` VALUES (2338, '删除', 2312, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:audit:remove', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI审核按钮');
INSERT INTO `sys_menu` VALUES (2339, '查询', 2313, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:qa:query', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI问答按钮');
INSERT INTO `sys_menu` VALUES (2340, '执行', 2313, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:qa:ask', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI问答按钮');
INSERT INTO `sys_menu` VALUES (2341, '删除', 2313, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'ai:qa:remove', '#', 'admin', '2026-03-24 17:41:36', '', NULL, 'AI问答按钮');
INSERT INTO `sys_menu` VALUES (2342, '官网配置', 2100, 25, 'portal-config', 'portal/config/index', NULL, '', 1, 0, 'C', '0', '0', 'portal:config:query', 'setting', 'admin', '2026-03-26 16:36:41', '', NULL, '官网配置');
INSERT INTO `sys_menu` VALUES (2343, '官网轮播图', 2100, 26, 'portal-banner', 'portal/banner/index', NULL, '', 1, 0, 'C', '0', '0', 'portal:banner:list', 'picture', 'admin', '2026-03-26 16:36:41', '', NULL, '官网轮播图');
INSERT INTO `sys_menu` VALUES (2344, '查询', 2342, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:config:query', '#', 'admin', '2026-03-26 16:36:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2345, '修改', 2342, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:config:edit', '#', 'admin', '2026-03-26 16:36:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2346, '查询', 2343, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:banner:query', '#', 'admin', '2026-03-26 16:36:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2347, '新增', 2343, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:banner:add', '#', 'admin', '2026-03-26 16:36:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2348, '修改', 2343, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:banner:edit', '#', 'admin', '2026-03-26 16:36:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2349, '删除', 2343, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:banner:remove', '#', 'admin', '2026-03-26 16:36:41', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (10, '教学资源管理系统官网试运行说明', '2', 0x3C703EE69599E5ADA6E8B584E6BA90E7AEA1E79086E7B3BBE7BB9FE5AE98E7BD91E78EB0E5B7B2E8BF9BE585A5E8AF95E8BF90E8A18CE998B6E6AEB5EFBC8CE5B9B3E58FB0E5B086E7BB9FE4B880E5B195E7A4BAE5ADA6E6A0A1E69599E5ADA6E8B584E6BA90E997A8E688B7E38081E585ACE5918AE9809AE79FA5E4B88EE9878DE8A681E8B584E8AEAFE380823C2F703E3C703EE5908EE7BBADE58FAFE7BBA7E7BBADE59CA8E5908EE58FB0E58F91E5B883E69BB4E5A49AE9809AE79FA5E585ACE5918AEFBC8CE5AE98E7BD91E9A1B5E99DA2E5B086E887AAE58AA8E5908CE6ADA5E5B195E7A4BAE380823C2F703E, '0', 'system', '2026-03-26 13:49:04', 'system', '2026-03-26 16:48:50', '官网初始化公告');
INSERT INTO `sys_notice` VALUES (11, '官网公告发布与资讯展示说明', '1', 0x3C703EE5AE98E7BD91E9A696E9A1B5E78EB0E5B7B2E4BD9CE4B8BAE69599E5ADA6E8B584E6BA90E7AEA1E79086E7B3BBE7BB9FE79A84E585ACE5BC80E5B195E7A4BAE997A8E688B7EFBC8CE7BB9FE4B880E58F91E5B883E9809AE79FA5E585ACE5918AE38081E9878DE8A681E8B584E8AEAFE4B88EE69599E5ADA6E8B584E6BA90E58AA8E68081E380823C2F703E3C703EE7AEA1E79086E59198E58FAFE59CA8E5908EE58FB0E7BBB4E68AA4E585ACE5918AE58685E5AEB9EFBC8CE5AE98E7BD91E9A1B5E99DA2E5B086E887AAE58AA8E5908CE6ADA5E5B195E7A4BAE69C80E696B0E4BFA1E681AFE380823C2F703E, '0', 'system', '2026-03-26 13:49:04', 'system', '2026-03-26 16:48:50', '官网初始化公告');
INSERT INTO `sys_notice` VALUES (12, '资源上传与空间共享规范说明', '2', 0x3C703EE4B8BAE4BF9DE99A9CE69599E5ADA6E8B584E6BA90E8B4A8E9878FE4B88EE585B1E4BAABE5AE89E585A8EFBC8CE8AFB7E69599E5B888E59CA8E4B88AE4BCA0E8B584E6BA90E697B6E8A1A5E58585E8AFBEE7A88BE5908DE7A7B0E38081E58886E7B1BBE6A087E7ADBEE38081E8B584E6BA90E7AE80E4BB8BE4B88EE585B1E4BAABE88C83E59BB4E8AFB4E6988EE380823C2F703E3C703EE7AEA1E79086E59198E58FAFE59CA8E5908EE58FB0E7BB9FE4B880E9858DE7BDAEE7A9BAE997B4E5AEB9E9878FE38081E4B88AE4BCA0E5A4A7E5B08FE99990E588B6E38081E58886E4BAABE5AF86E7A081E4B88EE8B4A6E58FB7E5B081E7A681E7AD96E795A5E380823C2F703E, '0', 'system', '2026-03-26 13:49:04', '', NULL, '官网初始化公告');

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read`  (
  `read_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '已读主键',
  `notice_id` int(4) NOT NULL COMMENT '公告id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `read_time` datetime NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_user_notice`(`user_id` ASC, `notice_id` ASC) USING BTREE COMMENT '同一用户同一公告只记录一次'
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公告已读记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------
INSERT INTO `sys_notice_read` VALUES (4, 12, 1, '2026-03-26 14:08:11');
INSERT INTO `sys_notice_read` VALUES (5, 11, 1, '2026-03-26 14:18:17');
INSERT INTO `sys_notice_read` VALUES (6, 10, 1, '2026-03-26 14:18:17');
INSERT INTO `sys_notice_read` VALUES (8, 12, 110, '2026-03-26 14:21:30');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"小曹\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 12:15:57', 29);
INSERT INTO `sys_oper_log` VALUES (101, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"小曹\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 12:15:59', 30);
INSERT INTO `sys_oper_log` VALUES (102, '通知公告', 3, 'com.ruoyi.web.controller.system.SysNoticeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/notice/3', '127.0.0.1', '内网IP', '[3] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 12:20:14', 26);
INSERT INTO `sys_oper_log` VALUES (103, '通知公告', 3, 'com.ruoyi.web.controller.system.SysNoticeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/notice/2', '127.0.0.1', '内网IP', '[2] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 12:20:16', 23);
INSERT INTO `sys_oper_log` VALUES (104, '通知公告', 3, 'com.ruoyi.web.controller.system.SysNoticeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/notice/1', '127.0.0.1', '内网IP', '[1] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 12:20:18', 19);
INSERT INTO `sys_oper_log` VALUES (105, '教学课程', 1, 'com.ruoyi.web.controller.edu.EduCourseController.add()', 'POST', 1, 'admin', '研发部门', '/edu/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"11\",\"courseId\":4,\"courseName\":\"不知道\",\"createBy\":\"admin\",\"params\":{},\"status\":\"0\",\"teacherName\":\"111\",\"teacherUserId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 13:33:54', 196);
INSERT INTO `sys_oper_log` VALUES (106, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"幼专\",\"email\":\"ry@qq.com\",\"leader\":\"幼专11\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 13:35:38', 29);
INSERT INTO `sys_oper_log` VALUES (107, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"幼专总公司\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"幼专\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 13:35:45', 54);
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '平台运维组', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-03-24 17:53:45', 16);
INSERT INTO `sys_oper_log` VALUES (109, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '平台运维组', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":100,\"email\":\"478201690@qq.com\",\"nickName\":\"cese\",\"params\":{},\"phonenumber\":\"13037687601\",\"postIds\":[2],\"roleIds\":[3],\"sex\":\"0\",\"status\":\"0\",\"userId\":107,\"userName\":\"13037687601\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 22:33:52', 391);
INSERT INTO `sys_oper_log` VALUES (110, 'AI任务', 1, 'com.ruoyi.web.controller.ai.AiTaskController.run()', 'POST', 1, 'admin', '平台运维组', '/ai/task/run/1', '127.0.0.1', '内网IP', '1 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-25 22:55:15', 20);
INSERT INTO `sys_oper_log` VALUES (111, '官网配置', 2, 'com.ruoyi.web.controller.portal.PortalSiteConfigAdminController.edit()', 'PUT', 1, 'admin', '平台运维组', '/portal/admin/config', '127.0.0.1', '内网IP', '{\"configId\":1,\"createBy\":\"admin\",\"createTime\":\"2026-03-26 16:36:41\",\"footerCopyright\":\"© 2026 教学资源管理系统\",\"footerDesc\":\"统一发布学校通知、教学公告、资源动态与重要资讯。\",\"footerName\":\"教学资源管理系统\",\"heroBadge\":\"统一教学资源门户\",\"heroPrimaryLink\":\"/announcements\",\"heroPrimaryText\":\"查看公告中心\",\"heroSecondaryLink\":\"#capability\",\"heroSecondaryText\":\"了解官网能力\",\"heroSubtitle\":\"统一展示公告、重要资讯与教学资源动态，让学校和访客可以在官网首页快速获取核心信息。\",\"heroTitle\":\"面向学校与院系的教学资源官网\",\"homeNavText\":\"首页\",\"loginButtonText\":\"进入后台\",\"logoUrl\":\"/profile/upload/2026/03/26/屏幕截图 2026-01-12 210854_20260326165753A001.png\",\"noticeNavText\":\"公告中心\",\"noticePanelMoreText\":\"全部公告\",\"noticePanelTitle\":\"最新公告\",\"params\":{},\"remark\":\"官网默认配置\",\"siteEnName\":\"Teaching Resource Management System\",\"siteName\":\"教学资源管理系统\",\"status\":\"0\",\"studentNavText\":\"学生端\",\"teacherNavText\":\"教师端\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 16:57:56', 31);
INSERT INTO `sys_oper_log` VALUES (112, '官网轮播图', 2, 'com.ruoyi.web.controller.portal.PortalBannerAdminController.edit()', 'PUT', 1, 'admin', '平台运维组', '/portal/admin/banner', '127.0.0.1', '内网IP', '{\"bannerId\":1,\"bannerSubtitle\":\"系统公告、教学通知、校园资讯均可在后台发布后实时同步到官网首页与公告中心。\",\"bannerTitle\":\"重要通知统一发布\",\"buttonText\":\"查看公告\",\"createBy\":\"admin\",\"createTime\":\"2026-03-26 16:36:41\",\"imageUrl\":\"/profile/upload/2026/03/26/屏幕截图 2026-01-13 195826_20260326170001A002.png\",\"params\":{},\"remark\":\"官网默认轮播图\",\"sortNum\":1,\"status\":\"0\",\"targetUrl\":\"/announcements\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 17:00:02', 22);
INSERT INTO `sys_oper_log` VALUES (113, '官网轮播图', 2, 'com.ruoyi.web.controller.portal.PortalBannerAdminController.edit()', 'PUT', 1, 'admin', '平台运维组', '/portal/admin/banner', '127.0.0.1', '内网IP', '{\"bannerId\":2,\"bannerSubtitle\":\"支持首页轮播展示学校重点活动、资源专题、精品课程与最新建设成果。\",\"bannerTitle\":\"重要资讯首页展示\",\"buttonText\":\"查看资讯\",\"createBy\":\"admin\",\"createTime\":\"2026-03-26 16:36:41\",\"imageUrl\":\"/profile/upload/2026/03/26/屏幕截图 2026-01-12 184021_20260326170007A003.png\",\"params\":{},\"remark\":\"官网默认轮播图\",\"sortNum\":2,\"status\":\"0\",\"targetUrl\":\"/announcements\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 17:00:09', 16);
INSERT INTO `sys_oper_log` VALUES (114, '教学资源', 1, 'com.ruoyi.web.controller.edu.EduResourceController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/resource', '127.0.0.1', '内网IP', '{\"auditStatus\":\"draft\",\"categoryName\":\"教学资源库\",\"courseName\":\"教学设计基础\",\"createBy\":\"admin\",\"favoriteCount\":0,\"fileSizeMb\":0.34,\"fileUrl\":\"/profile/upload/resource/2026/03/26/屏幕截图 2026-01-12 184021_20260326181637A001.png\",\"likeCount\":0,\"originalFileName\":\"屏幕截图 2026-01-12 184021.png\",\"params\":{},\"previewUrl\":\"http://localhost:8080/profile/upload/resource/2026/03/26/屏幕截图 2026-01-12 184021_20260326181637A001.png\",\"publishStatus\":\"draft\",\"recommendFlag\":\"0\",\"resourceTitle\":\"1111\",\"resourceType\":\"PDF\",\"resourceVersion\":\"v1.0\",\"storagePath\":\"resource/屏幕截图 2026-01-12 184021_20260326181637A001.png\",\"storageType\":\"local\",\"tagNames\":\"最新上传\",\"uploaderId\":1,\"uploaderName\":\"admin\"} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'download_count\' cannot be null\r\n### The error may exist in URL [jar:nested:/D:/RuoYi-Vue-master/ruoyi-admin/target/ruoyi-admin.jar/!BOOT-INF/lib/ruoyi-system-3.9.1.jar!/mapper/edu/EduResourceMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EduResourceMapper.insertResource-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into edu_resource(             resource_title, resource_type, category_name, course_name, tag_names,             file_url, original_file_name, cover_url, resource_version, file_size_mb,             storage_type, storage_path, preview_url, uploader_id, uploader_name,             audit_status, publish_status, recommend_flag, download_count, favorite_count, like_count,             resource_desc, remark, create_by, create_time         ) values (             ?, ?, ?, ?, ?,             ?, ?, ?, ?, ?,             ?, ?, ?, ?, ?,             ?, ?, ?, ?, ?, ?,             ?, ?, ?, sysdate()         )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'download_count\' cannot be null\n; Column \'download_count\' cannot be null', '2026-03-26 18:16:52', 924);
INSERT INTO `sys_oper_log` VALUES (115, '教学资源', 1, 'com.ruoyi.web.controller.edu.EduResourceController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/resource', '127.0.0.1', '内网IP', '{\"auditStatus\":\"draft\",\"categoryName\":\"教学资源库\",\"courseName\":\"大学英语\",\"createBy\":\"admin\",\"favoriteCount\":0,\"fileSizeMb\":0.34,\"fileUrl\":\"/profile/upload/resource/2026/03/26/屏幕截图 2026-01-12 184021_20260326190619A001.png\",\"likeCount\":0,\"originalFileName\":\"屏幕截图 2026-01-12 184021.png\",\"params\":{},\"previewUrl\":\"http://localhost:8080/profile/upload/resource/2026/03/26/屏幕截图 2026-01-12 184021_20260326190619A001.png\",\"publishStatus\":\"draft\",\"recommendFlag\":\"1\",\"remark\":\"11\",\"resourceDesc\":\"1111\",\"resourceTitle\":\"1212\",\"resourceType\":\"PDF\",\"resourceVersion\":\"v1.0\",\"storagePath\":\"resource/屏幕截图 2026-01-12 184021_20260326190619A001.png\",\"storageType\":\"local\",\"tagNames\":\"最新上传\",\"uploaderId\":1,\"uploaderName\":\"admin\"} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'download_count\' cannot be null\r\n### The error may exist in URL [jar:nested:/D:/RuoYi-Vue-master/ruoyi-admin/target/ruoyi-admin.jar/!BOOT-INF/lib/ruoyi-system-3.9.1.jar!/mapper/edu/EduResourceMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EduResourceMapper.insertResource-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into edu_resource(             resource_title, resource_type, category_name, course_name, tag_names,             file_url, original_file_name, cover_url, resource_version, file_size_mb,             storage_type, storage_path, preview_url, uploader_id, uploader_name,             audit_status, publish_status, recommend_flag, download_count, favorite_count, like_count,             resource_desc, remark, create_by, create_time         ) values (             ?, ?, ?, ?, ?,             ?, ?, ?, ?, ?,             ?, ?, ?, ?, ?,             ?, ?, ?, ?, ?, ?,             ?, ?, ?, sysdate()         )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'download_count\' cannot be null\n; Column \'download_count\' cannot be null', '2026-03-26 19:06:26', 747);
INSERT INTO `sys_oper_log` VALUES (116, '教学资源', 1, 'com.ruoyi.web.controller.edu.EduResourceController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/resource', '127.0.0.1', '内网IP', '{\"auditStatus\":\"draft\",\"categoryName\":\"教学资源库\",\"courseName\":\"大学英语\",\"createBy\":\"admin\",\"favoriteCount\":0,\"fileSizeMb\":0.34,\"fileUrl\":\"/profile/upload/resource/2026/03/26/屏幕截图 2026-01-12 184021_20260326190619A001.png\",\"likeCount\":0,\"originalFileName\":\"屏幕截图 2026-01-12 184021.png\",\"params\":{},\"previewUrl\":\"http://localhost:8080/profile/upload/resource/2026/03/26/屏幕截图 2026-01-12 184021_20260326190619A001.png\",\"publishStatus\":\"draft\",\"recommendFlag\":\"1\",\"remark\":\"11\",\"resourceDesc\":\"1111\",\"resourceTitle\":\"1212\",\"resourceType\":\"PDF\",\"resourceVersion\":\"v1.0\",\"storagePath\":\"resource/屏幕截图 2026-01-12 184021_20260326190619A001.png\",\"storageType\":\"local\",\"tagNames\":\"最新上传\",\"uploaderId\":1,\"uploaderName\":\"admin\"} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'download_count\' cannot be null\r\n### The error may exist in URL [jar:nested:/D:/RuoYi-Vue-master/ruoyi-admin/target/ruoyi-admin.jar/!BOOT-INF/lib/ruoyi-system-3.9.1.jar!/mapper/edu/EduResourceMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EduResourceMapper.insertResource-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into edu_resource(             resource_title, resource_type, category_name, course_name, tag_names,             file_url, original_file_name, cover_url, resource_version, file_size_mb,             storage_type, storage_path, preview_url, uploader_id, uploader_name,             audit_status, publish_status, recommend_flag, download_count, favorite_count, like_count,             resource_desc, remark, create_by, create_time         ) values (             ?, ?, ?, ?, ?,             ?, ?, ?, ?, ?,             ?, ?, ?, ?, ?,             ?, ?, ?, ?, ?, ?,             ?, ?, ?, sysdate()         )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'download_count\' cannot be null\n; Column \'download_count\' cannot be null', '2026-03-26 19:06:27', 3);
INSERT INTO `sys_oper_log` VALUES (117, '教学资源', 1, 'com.ruoyi.web.controller.edu.EduResourceController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/resource', '127.0.0.1', '内网IP', '{\"auditStatus\":\"draft\",\"categoryName\":\"教学资源库\",\"courseName\":\"教学设计基础\",\"createBy\":\"admin\",\"downloadCount\":0,\"favoriteCount\":0,\"fileSizeMb\":0.03,\"fileUrl\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"likeCount\":0,\"originalFileName\":\"教学资源管理系统详细开发文档_AI版.txt\",\"params\":{},\"previewUrl\":\"http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"publishStatus\":\"draft\",\"recommendFlag\":\"0\",\"remark\":\"21212\",\"resourceDesc\":\"12121\",\"resourceId\":1,\"resourceTitle\":\"112\",\"resourceType\":\"PDF\",\"resourceVersion\":\"v1.0\",\"storagePath\":\"resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"storageType\":\"local\",\"tagNames\":\"最新上传\",\"uploaderId\":1,\"uploaderName\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:12:11', 332);
INSERT INTO `sys_oper_log` VALUES (118, '教学资源', 1, 'com.ruoyi.web.controller.edu.EduResourceController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/resource', '127.0.0.1', '内网IP', '{\"auditStatus\":\"draft\",\"categoryName\":\"教学资源库\",\"courseName\":\"教学设计基础\",\"createBy\":\"admin\",\"downloadCount\":0,\"favoriteCount\":0,\"fileSizeMb\":0.03,\"fileUrl\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"likeCount\":0,\"originalFileName\":\"教学资源管理系统详细开发文档_AI版.txt\",\"params\":{},\"previewUrl\":\"http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"publishStatus\":\"draft\",\"recommendFlag\":\"0\",\"remark\":\"21212\",\"resourceDesc\":\"12121\",\"resourceId\":2,\"resourceTitle\":\"112\",\"resourceType\":\"PDF\",\"resourceVersion\":\"v1.0\",\"storagePath\":\"resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"storageType\":\"local\",\"tagNames\":\"最新上传\",\"uploaderId\":1,\"uploaderName\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:12:17', 132);
INSERT INTO `sys_oper_log` VALUES (119, '教学资源', 1, 'com.ruoyi.web.controller.edu.EduResourceController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/resource', '127.0.0.1', '内网IP', '{\"auditStatus\":\"draft\",\"categoryName\":\"教学资源库\",\"courseName\":\"教学设计基础\",\"createBy\":\"admin\",\"downloadCount\":0,\"favoriteCount\":0,\"fileSizeMb\":0.03,\"fileUrl\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"likeCount\":0,\"originalFileName\":\"教学资源管理系统详细开发文档_AI版.txt\",\"params\":{},\"previewUrl\":\"http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"publishStatus\":\"draft\",\"recommendFlag\":\"0\",\"remark\":\"21212\",\"resourceDesc\":\"12121\",\"resourceId\":3,\"resourceTitle\":\"112\",\"resourceType\":\"PDF\",\"resourceVersion\":\"v1.0\",\"storagePath\":\"resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"storageType\":\"local\",\"tagNames\":\"最新上传\",\"uploaderId\":1,\"uploaderName\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:12:18', 87);
INSERT INTO `sys_oper_log` VALUES (120, '教学资源', 1, 'com.ruoyi.web.controller.edu.EduResourceController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/resource', '127.0.0.1', '内网IP', '{\"auditStatus\":\"draft\",\"categoryName\":\"教学资源库\",\"courseName\":\"教学设计基础\",\"createBy\":\"admin\",\"downloadCount\":0,\"favoriteCount\":0,\"fileSizeMb\":0.03,\"fileUrl\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"likeCount\":0,\"originalFileName\":\"教学资源管理系统详细开发文档_AI版.txt\",\"params\":{},\"previewUrl\":\"http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"publishStatus\":\"draft\",\"recommendFlag\":\"0\",\"remark\":\"21212\",\"resourceDesc\":\"12121\",\"resourceId\":4,\"resourceTitle\":\"112\",\"resourceType\":\"PDF\",\"resourceVersion\":\"v1.0\",\"storagePath\":\"resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"storageType\":\"local\",\"tagNames\":\"最新上传\",\"uploaderId\":1,\"uploaderName\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:12:35', 104);
INSERT INTO `sys_oper_log` VALUES (121, '教学资源', 1, 'com.ruoyi.web.controller.edu.EduResourceController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/resource', '127.0.0.1', '内网IP', '{\"auditStatus\":\"draft\",\"categoryName\":\"教学资源库\",\"courseName\":\"教学设计基础\",\"createBy\":\"admin\",\"downloadCount\":0,\"favoriteCount\":0,\"fileSizeMb\":0.03,\"fileUrl\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"likeCount\":0,\"originalFileName\":\"教学资源管理系统详细开发文档_AI版.txt\",\"params\":{},\"previewUrl\":\"http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"publishStatus\":\"draft\",\"recommendFlag\":\"0\",\"remark\":\"21212\",\"resourceDesc\":\"12121\",\"resourceId\":5,\"resourceTitle\":\"112\",\"resourceType\":\"PDF\",\"resourceVersion\":\"v1.0\",\"storagePath\":\"resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"storageType\":\"local\",\"tagNames\":\"最新上传\",\"uploaderId\":1,\"uploaderName\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:13:48', 140);
INSERT INTO `sys_oper_log` VALUES (122, '教学资源', 1, 'com.ruoyi.web.controller.edu.EduResourceController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/resource', '127.0.0.1', '内网IP', '{\"auditStatus\":\"draft\",\"categoryName\":\"教学资源库\",\"courseName\":\"教学设计基础\",\"createBy\":\"admin\",\"downloadCount\":0,\"favoriteCount\":0,\"fileSizeMb\":0.03,\"fileUrl\":\"/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"likeCount\":0,\"originalFileName\":\"教学资源管理系统详细开发文档_AI版.txt\",\"params\":{},\"previewUrl\":\"http://localhost:8080/profile/upload/resource/2026/03/26/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"publishStatus\":\"draft\",\"recommendFlag\":\"0\",\"remark\":\"21212\",\"resourceDesc\":\"12121\",\"resourceId\":6,\"resourceTitle\":\"112\",\"resourceType\":\"PDF\",\"resourceVersion\":\"v1.0\",\"storagePath\":\"resource/教学资源管理系统详细开发文档_AI版_20260326191202A001.txt\",\"storageType\":\"local\",\"tagNames\":\"最新上传\",\"uploaderId\":1,\"uploaderName\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:13:50', 115);
INSERT INTO `sys_oper_log` VALUES (123, '提交资源审核', 2, 'com.ruoyi.web.controller.edu.EduResourceController.submit()', 'POST', 1, 'admin', '平台运维组', '/edu/resource/submit/6', '127.0.0.1', '内网IP', '6 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:15:50', 71);
INSERT INTO `sys_oper_log` VALUES (124, '提交资源审核', 2, 'com.ruoyi.web.controller.edu.EduResourceController.submit()', 'POST', 1, 'admin', '平台运维组', '/edu/resource/submit/6', '127.0.0.1', '内网IP', '6 ', NULL, 1, '该资源已在审核中', '2026-03-26 19:15:52', 14);
INSERT INTO `sys_oper_log` VALUES (125, '资源审核通过', 2, 'com.ruoyi.web.controller.edu.EduAuditController.pass()', 'PUT', 1, 'admin', '平台运维组', '/edu/audit/pass', '127.0.0.1', '内网IP', '{\"auditId\":1,\"auditReason\":\"审核通过\",\"auditStatus\":\"approved\",\"auditTime\":\"2026-03-26 19:16:04.16\",\"auditorId\":1,\"auditorName\":\"admin\",\"params\":{},\"resourceId\":6,\"resourceTitle\":\"112\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:16:04', 23);
INSERT INTO `sys_oper_log` VALUES (126, '教学资源', 1, 'com.ruoyi.web.controller.edu.EduResourceController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/resource', '127.0.0.1', '内网IP', '{\"auditStatus\":\"draft\",\"categoryName\":\"教学资源库\",\"courseName\":\"教学设计基础\",\"createBy\":\"admin\",\"downloadCount\":0,\"favoriteCount\":0,\"fileSizeMb\":3.36,\"fileUrl\":\"/profile/upload/resource/2026/03/26/人体解剖知识在美术中的应用历程_20260326192103A002.pptx\",\"likeCount\":0,\"originalFileName\":\"人体解剖知识在美术中的应用历程.pptx\",\"params\":{},\"previewUrl\":\"http://localhost:8080/profile/upload/resource/2026/03/26/人体解剖知识在美术中的应用历程_20260326192103A002.pptx\",\"publishStatus\":\"draft\",\"recommendFlag\":\"0\",\"remark\":\"6666666666666666666\",\"resourceDesc\":\"666666666\",\"resourceId\":7,\"resourceTitle\":\"666\",\"resourceType\":\"PDF\",\"resourceVersion\":\"v1.0\",\"storagePath\":\"resource/人体解剖知识在美术中的应用历程_20260326192103A002.pptx\",\"storageType\":\"local\",\"tagNames\":\"最新上传,期末冲刺\",\"uploaderId\":1,\"uploaderName\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:21:14', 125);
INSERT INTO `sys_oper_log` VALUES (127, '提交资源审核', 2, 'com.ruoyi.web.controller.edu.EduResourceController.submit()', 'POST', 1, 'admin', '平台运维组', '/edu/resource/submit/7', '127.0.0.1', '内网IP', '7 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:21:19', 87);
INSERT INTO `sys_oper_log` VALUES (128, '资源审核通过', 2, 'com.ruoyi.web.controller.edu.EduAuditController.pass()', 'PUT', 1, 'admin', '平台运维组', '/edu/audit/pass', '127.0.0.1', '内网IP', '{\"auditId\":2,\"auditReason\":\"审核通过\",\"auditStatus\":\"approved\",\"auditTime\":\"2026-03-26 19:21:31.696\",\"auditorId\":1,\"auditorName\":\"admin\",\"params\":{},\"resourceId\":7,\"resourceTitle\":\"666\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:21:31', 23);
INSERT INTO `sys_oper_log` VALUES (129, '空间文件', 1, 'com.ruoyi.web.controller.edu.EduSpaceFileController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/space', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"fileId\":1,\"fileName\":\"1111\",\"fileSizeMb\":0,\"ownerName\":\"admin\",\"ownerUserId\":1,\"params\":{},\"parentId\":0,\"remark\":\"\",\"status\":\"0\",\"targetType\":\"folder\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:26:34', 29);
INSERT INTO `sys_oper_log` VALUES (130, '空间文件', 1, 'com.ruoyi.web.controller.edu.EduSpaceFileController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/space', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"fileExt\":\"pptx\",\"fileId\":2,\"fileName\":\"人体解剖知识在美术中的应用历程.pptx\",\"fileSizeMb\":3.36,\"fileUrl\":\"http://localhost:8080/profile/upload/space/2026/03/26/人体解剖知识在美术中的应用历程_20260326192642A003.pptx\",\"originalFileName\":\"人体解剖知识在美术中的应用历程.pptx\",\"ownerName\":\"admin\",\"ownerUserId\":1,\"params\":{},\"parentId\":1,\"previewUrl\":\"http://localhost:8080/profile/upload/space/2026/03/26/人体解剖知识在美术中的应用历程_20260326192642A003.pptx\",\"status\":\"0\",\"storagePath\":\"space/人体解剖知识在美术中的应用历程_20260326192642A003.pptx\",\"storageType\":\"local\",\"targetType\":\"file\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:26:42', 16);
INSERT INTO `sys_oper_log` VALUES (131, '空间分享', 1, 'com.ruoyi.web.controller.edu.EduSpaceShareController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/share', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"downloadCount\":0,\"downloadLimit\":0,\"expireTime\":\"2026-04-02 19:26:44\",\"fileId\":2,\"ownerName\":\"admin\",\"ownerUserId\":1,\"params\":{},\"remark\":\"\",\"shareId\":6,\"shareMode\":\"public\",\"shareName\":\"人体解剖知识在美术中的应用历程.pptx 分享\",\"status\":\"0\",\"targetName\":\"人体解剖知识在美术中的应用历程.pptx\",\"targetPath\":\"space/人体解剖知识在美术中的应用历程_20260326192642A003.pptx\",\"targetType\":\"file\",\"viewCount\":0} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:26:45', 18);
INSERT INTO `sys_oper_log` VALUES (132, '空间分享', 1, 'com.ruoyi.web.controller.edu.EduSpaceShareController.add()', 'POST', 1, 'admin', '平台运维组', '/edu/share', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"downloadCount\":0,\"downloadLimit\":0,\"expireTime\":\"2026-04-02 19:26:44\",\"fileId\":2,\"ownerName\":\"admin\",\"ownerUserId\":1,\"params\":{},\"remark\":\"\",\"shareId\":7,\"shareMode\":\"public\",\"shareName\":\"人体解剖知识在美术中的应用历程.pptx 分享\",\"status\":\"0\",\"targetName\":\"人体解剖知识在美术中的应用历程.pptx\",\"targetPath\":\"space/人体解剖知识在美术中的应用历程_20260326192642A003.pptx\",\"targetType\":\"file\",\"viewCount\":0} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-26 19:27:23', 8);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'platform_director', '平台负责人', 1, '0', 'admin', '2026-03-23 22:57:46', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'teaching_manager', '教学主管', 2, '0', 'admin', '2026-03-23 22:57:46', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'resource_auditor', '资源审核员', 3, '0', 'admin', '2026-03-23 22:57:46', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'course_assistant', '课程助理', 4, '0', 'admin', '2026-03-23 22:57:46', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-03-23 22:57:46', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-03-23 22:57:46', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (3, '教师', 'teacher', 3, '1', 1, 1, '0', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '教学资源模块教师角色');
INSERT INTO `sys_role` VALUES (4, '学生', 'student', 4, '1', 1, 1, '0', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '教学资源模块学生角色');
INSERT INTO `sys_role` VALUES (5, '审核员', 'auditor', 5, '1', 1, 1, '0', '0', 'admin', '2026-03-23 22:57:48', '', NULL, '教学资源模块审核员角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2100);
INSERT INTO `sys_role_menu` VALUES (1, 2101);
INSERT INTO `sys_role_menu` VALUES (1, 2102);
INSERT INTO `sys_role_menu` VALUES (1, 2103);
INSERT INTO `sys_role_menu` VALUES (1, 2104);
INSERT INTO `sys_role_menu` VALUES (1, 2105);
INSERT INTO `sys_role_menu` VALUES (1, 2110);
INSERT INTO `sys_role_menu` VALUES (1, 2111);
INSERT INTO `sys_role_menu` VALUES (1, 2112);
INSERT INTO `sys_role_menu` VALUES (1, 2113);
INSERT INTO `sys_role_menu` VALUES (1, 2120);
INSERT INTO `sys_role_menu` VALUES (1, 2121);
INSERT INTO `sys_role_menu` VALUES (1, 2122);
INSERT INTO `sys_role_menu` VALUES (1, 2130);
INSERT INTO `sys_role_menu` VALUES (1, 2131);
INSERT INTO `sys_role_menu` VALUES (1, 2132);
INSERT INTO `sys_role_menu` VALUES (1, 2133);
INSERT INTO `sys_role_menu` VALUES (1, 2140);
INSERT INTO `sys_role_menu` VALUES (1, 2141);
INSERT INTO `sys_role_menu` VALUES (1, 2142);
INSERT INTO `sys_role_menu` VALUES (1, 2143);
INSERT INTO `sys_role_menu` VALUES (1, 2201);
INSERT INTO `sys_role_menu` VALUES (1, 2202);
INSERT INTO `sys_role_menu` VALUES (1, 2203);
INSERT INTO `sys_role_menu` VALUES (1, 2210);
INSERT INTO `sys_role_menu` VALUES (1, 2211);
INSERT INTO `sys_role_menu` VALUES (1, 2212);
INSERT INTO `sys_role_menu` VALUES (1, 2213);
INSERT INTO `sys_role_menu` VALUES (1, 2220);
INSERT INTO `sys_role_menu` VALUES (1, 2221);
INSERT INTO `sys_role_menu` VALUES (1, 2222);
INSERT INTO `sys_role_menu` VALUES (1, 2223);
INSERT INTO `sys_role_menu` VALUES (1, 2230);
INSERT INTO `sys_role_menu` VALUES (1, 2231);
INSERT INTO `sys_role_menu` VALUES (1, 2232);
INSERT INTO `sys_role_menu` VALUES (1, 2233);
INSERT INTO `sys_role_menu` VALUES (1, 2240);
INSERT INTO `sys_role_menu` VALUES (1, 2241);
INSERT INTO `sys_role_menu` VALUES (1, 2242);
INSERT INTO `sys_role_menu` VALUES (1, 2243);
INSERT INTO `sys_role_menu` VALUES (1, 2244);
INSERT INTO `sys_role_menu` VALUES (1, 2245);
INSERT INTO `sys_role_menu` VALUES (1, 2250);
INSERT INTO `sys_role_menu` VALUES (1, 2251);
INSERT INTO `sys_role_menu` VALUES (1, 2252);
INSERT INTO `sys_role_menu` VALUES (1, 2253);
INSERT INTO `sys_role_menu` VALUES (1, 2270);
INSERT INTO `sys_role_menu` VALUES (1, 2271);
INSERT INTO `sys_role_menu` VALUES (1, 2272);
INSERT INTO `sys_role_menu` VALUES (1, 2273);
INSERT INTO `sys_role_menu` VALUES (1, 2274);
INSERT INTO `sys_role_menu` VALUES (1, 2275);
INSERT INTO `sys_role_menu` VALUES (1, 2276);
INSERT INTO `sys_role_menu` VALUES (1, 2277);
INSERT INTO `sys_role_menu` VALUES (1, 2278);
INSERT INTO `sys_role_menu` VALUES (1, 2279);
INSERT INTO `sys_role_menu` VALUES (1, 2280);
INSERT INTO `sys_role_menu` VALUES (1, 2281);
INSERT INTO `sys_role_menu` VALUES (1, 2282);
INSERT INTO `sys_role_menu` VALUES (1, 2283);
INSERT INTO `sys_role_menu` VALUES (1, 2284);
INSERT INTO `sys_role_menu` VALUES (1, 2285);
INSERT INTO `sys_role_menu` VALUES (1, 2286);
INSERT INTO `sys_role_menu` VALUES (1, 2287);
INSERT INTO `sys_role_menu` VALUES (1, 2288);
INSERT INTO `sys_role_menu` VALUES (1, 2289);
INSERT INTO `sys_role_menu` VALUES (1, 2290);
INSERT INTO `sys_role_menu` VALUES (1, 2291);
INSERT INTO `sys_role_menu` VALUES (1, 2292);
INSERT INTO `sys_role_menu` VALUES (1, 2293);
INSERT INTO `sys_role_menu` VALUES (1, 2294);
INSERT INTO `sys_role_menu` VALUES (1, 2295);
INSERT INTO `sys_role_menu` VALUES (1, 2296);
INSERT INTO `sys_role_menu` VALUES (1, 2297);
INSERT INTO `sys_role_menu` VALUES (1, 2298);
INSERT INTO `sys_role_menu` VALUES (1, 2299);
INSERT INTO `sys_role_menu` VALUES (1, 2300);
INSERT INTO `sys_role_menu` VALUES (1, 2301);
INSERT INTO `sys_role_menu` VALUES (1, 2302);
INSERT INTO `sys_role_menu` VALUES (1, 2303);
INSERT INTO `sys_role_menu` VALUES (1, 2310);
INSERT INTO `sys_role_menu` VALUES (1, 2311);
INSERT INTO `sys_role_menu` VALUES (1, 2312);
INSERT INTO `sys_role_menu` VALUES (1, 2313);
INSERT INTO `sys_role_menu` VALUES (1, 2320);
INSERT INTO `sys_role_menu` VALUES (1, 2321);
INSERT INTO `sys_role_menu` VALUES (1, 2322);
INSERT INTO `sys_role_menu` VALUES (1, 2323);
INSERT INTO `sys_role_menu` VALUES (1, 2324);
INSERT INTO `sys_role_menu` VALUES (1, 2325);
INSERT INTO `sys_role_menu` VALUES (1, 2326);
INSERT INTO `sys_role_menu` VALUES (1, 2327);
INSERT INTO `sys_role_menu` VALUES (1, 2328);
INSERT INTO `sys_role_menu` VALUES (1, 2329);
INSERT INTO `sys_role_menu` VALUES (1, 2330);
INSERT INTO `sys_role_menu` VALUES (1, 2331);
INSERT INTO `sys_role_menu` VALUES (1, 2332);
INSERT INTO `sys_role_menu` VALUES (1, 2333);
INSERT INTO `sys_role_menu` VALUES (1, 2334);
INSERT INTO `sys_role_menu` VALUES (1, 2335);
INSERT INTO `sys_role_menu` VALUES (1, 2336);
INSERT INTO `sys_role_menu` VALUES (1, 2337);
INSERT INTO `sys_role_menu` VALUES (1, 2338);
INSERT INTO `sys_role_menu` VALUES (1, 2339);
INSERT INTO `sys_role_menu` VALUES (1, 2340);
INSERT INTO `sys_role_menu` VALUES (1, 2341);
INSERT INTO `sys_role_menu` VALUES (1, 2342);
INSERT INTO `sys_role_menu` VALUES (1, 2343);
INSERT INTO `sys_role_menu` VALUES (1, 2344);
INSERT INTO `sys_role_menu` VALUES (1, 2345);
INSERT INTO `sys_role_menu` VALUES (1, 2346);
INSERT INTO `sys_role_menu` VALUES (1, 2347);
INSERT INTO `sys_role_menu` VALUES (1, 2348);
INSERT INTO `sys_role_menu` VALUES (1, 2349);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (3, 2100);
INSERT INTO `sys_role_menu` VALUES (3, 2101);
INSERT INTO `sys_role_menu` VALUES (3, 2103);
INSERT INTO `sys_role_menu` VALUES (3, 2106);
INSERT INTO `sys_role_menu` VALUES (3, 2130);
INSERT INTO `sys_role_menu` VALUES (3, 2131);
INSERT INTO `sys_role_menu` VALUES (3, 2132);
INSERT INTO `sys_role_menu` VALUES (3, 2203);
INSERT INTO `sys_role_menu` VALUES (3, 2230);
INSERT INTO `sys_role_menu` VALUES (3, 2231);
INSERT INTO `sys_role_menu` VALUES (3, 2232);
INSERT INTO `sys_role_menu` VALUES (3, 2233);
INSERT INTO `sys_role_menu` VALUES (3, 2240);
INSERT INTO `sys_role_menu` VALUES (3, 2241);
INSERT INTO `sys_role_menu` VALUES (3, 2242);
INSERT INTO `sys_role_menu` VALUES (3, 2243);
INSERT INTO `sys_role_menu` VALUES (3, 2244);
INSERT INTO `sys_role_menu` VALUES (3, 2260);
INSERT INTO `sys_role_menu` VALUES (3, 2261);
INSERT INTO `sys_role_menu` VALUES (3, 2262);
INSERT INTO `sys_role_menu` VALUES (3, 2276);
INSERT INTO `sys_role_menu` VALUES (3, 2299);
INSERT INTO `sys_role_menu` VALUES (3, 2300);
INSERT INTO `sys_role_menu` VALUES (3, 2301);
INSERT INTO `sys_role_menu` VALUES (3, 2302);
INSERT INTO `sys_role_menu` VALUES (3, 2320);
INSERT INTO `sys_role_menu` VALUES (3, 2321);
INSERT INTO `sys_role_menu` VALUES (3, 2322);
INSERT INTO `sys_role_menu` VALUES (3, 2323);
INSERT INTO `sys_role_menu` VALUES (3, 2324);
INSERT INTO `sys_role_menu` VALUES (3, 2326);
INSERT INTO `sys_role_menu` VALUES (3, 2327);
INSERT INTO `sys_role_menu` VALUES (4, 2100);
INSERT INTO `sys_role_menu` VALUES (4, 2101);
INSERT INTO `sys_role_menu` VALUES (4, 2203);
INSERT INTO `sys_role_menu` VALUES (4, 2240);
INSERT INTO `sys_role_menu` VALUES (4, 2272);
INSERT INTO `sys_role_menu` VALUES (4, 2274);
INSERT INTO `sys_role_menu` VALUES (4, 2275);
INSERT INTO `sys_role_menu` VALUES (4, 2286);
INSERT INTO `sys_role_menu` VALUES (4, 2293);
INSERT INTO `sys_role_menu` VALUES (4, 2294);
INSERT INTO `sys_role_menu` VALUES (4, 2297);
INSERT INTO `sys_role_menu` VALUES (4, 2300);
INSERT INTO `sys_role_menu` VALUES (4, 2301);
INSERT INTO `sys_role_menu` VALUES (4, 2302);
INSERT INTO `sys_role_menu` VALUES (4, 2320);
INSERT INTO `sys_role_menu` VALUES (4, 2324);
INSERT INTO `sys_role_menu` VALUES (4, 2327);
INSERT INTO `sys_role_menu` VALUES (5, 2100);
INSERT INTO `sys_role_menu` VALUES (5, 2101);
INSERT INTO `sys_role_menu` VALUES (5, 2102);
INSERT INTO `sys_role_menu` VALUES (5, 2104);
INSERT INTO `sys_role_menu` VALUES (5, 2140);
INSERT INTO `sys_role_menu` VALUES (5, 2240);
INSERT INTO `sys_role_menu` VALUES (5, 2250);
INSERT INTO `sys_role_menu` VALUES (5, 2251);
INSERT INTO `sys_role_menu` VALUES (5, 2252);
INSERT INTO `sys_role_menu` VALUES (5, 2253);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 111 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 107, 'admin', '平台管理员', '00', 'admin@school.local', '13900001000', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-26 19:05:49', '2026-03-23 22:57:46', 'admin', '2026-03-23 22:57:46', '', '2026-03-24 12:15:59', '管理员');
INSERT INTO `sys_user` VALUES (2, 100, 'demo', '教学演示账号', '00', 'demo@school.local', '13900001001', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-23 22:57:46', '2026-03-23 22:57:46', 'admin', '2026-03-23 22:57:46', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 103, 'teacher01', '张老师', '00', 'teacher01@school.local', '13900001011', '0', '', '/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, '2026-03-24 13:41:28', 'admin', '2026-03-24 13:41:28', '', NULL, 'teacher demo');
INSERT INTO `sys_user` VALUES (101, 108, 'student01', '王同学', '00', 'student01@school.local', '13900001021', '0', '', '/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, '2026-03-24 13:41:28', 'admin', '2026-03-24 13:41:28', '', NULL, 'student demo');
INSERT INTO `sys_user` VALUES (102, 105, 'auditor01', '审核老师', '00', 'auditor01@school.local', '13900001031', '0', '', '/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, '2026-03-24 13:41:28', 'admin', '2026-03-24 13:41:28', '', NULL, 'auditor demo');
INSERT INTO `sys_user` VALUES (104, 108, '478201690', '478201690', '00', '', '', '0', '', '$2a$10$/QdpwuSwlg3fSyiag2hXeu4fLFb8/We0jEPReBRn/JgMv.Slnw7Cu', '0', '0', '127.0.0.1', '2026-03-24 22:30:22', '2026-03-24 15:58:00', '', '2026-03-24 15:58:00', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (107, 100, '13037687601', 'cese', '00', '478201690@qq.com', '13037687601', '0', '', '$2a$10$YpLw4z.nTAlLa7coha4VF.FKY3F4b/1ELf2CJMvrbuJPeyaAPFDES', '0', '0', '127.0.0.1', '2026-03-24 22:34:14', NULL, 'admin', '2026-03-24 22:33:52', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (108, 103, 'tea1774451193', 'tea1774451193', '00', '', '', '0', '', '$2a$10$6UXHkRx37W3JWt2jaUFy1OE6ayKZGGbQ1YGOFeOsKZag7TcHcyxxa', '0', '0', '127.0.0.1', '2026-03-25 23:11:49', '2026-03-25 23:06:34', '', '2026-03-25 23:06:33', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (109, 108, 'stu1774451193', 'stu1774451193', '00', '', '', '0', '', '$2a$10$WevIhvZDRI46reeSmdVMguqwf/jf9VQDkT21i/3Vde4.4Uwn1S5p6', '0', '0', '127.0.0.1', '2026-03-25 23:11:49', '2026-03-25 23:06:34', '', '2026-03-25 23:06:33', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (110, 103, '1741065057', '1741065057', '00', '', '', '0', '', '$2a$10$a0AiMMHCgRH.jjh7l8pEqOpXPYqW4vjaJ8Djt4tN7kQ7qMIt7WWG.', '0', '0', '127.0.0.1', '2026-03-26 14:20:38', '2026-03-26 14:20:22', '', '2026-03-26 14:20:21', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);
INSERT INTO `sys_user_post` VALUES (107, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 3);
INSERT INTO `sys_user_role` VALUES (101, 4);
INSERT INTO `sys_user_role` VALUES (102, 5);
INSERT INTO `sys_user_role` VALUES (104, 4);
INSERT INTO `sys_user_role` VALUES (107, 3);
INSERT INTO `sys_user_role` VALUES (108, 3);
INSERT INTO `sys_user_role` VALUES (109, 4);
INSERT INTO `sys_user_role` VALUES (110, 3);

SET FOREIGN_KEY_CHECKS = 1;
