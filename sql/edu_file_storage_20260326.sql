SET NAMES utf8mb4;

DROP PROCEDURE IF EXISTS ensure_column;
DELIMITER $$
CREATE PROCEDURE ensure_column(
    IN p_table_name VARCHAR(64),
    IN p_column_name VARCHAR(64),
    IN p_column_definition TEXT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = p_table_name
          AND COLUMN_NAME = p_column_name
    ) THEN
        SET @ddl = CONCAT('ALTER TABLE `', p_table_name, '` ADD COLUMN `', p_column_name, '` ', p_column_definition);
        PREPARE stmt FROM @ddl;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END$$
DELIMITER ;

CALL ensure_column('edu_resource', 'original_file_name', "varchar(255) DEFAULT NULL COMMENT '原始文件名' AFTER file_url");
CALL ensure_column('edu_resource', 'storage_type', "varchar(20) DEFAULT 'local' COMMENT '存储类型(local/minio)' AFTER original_file_name");
CALL ensure_column('edu_resource', 'storage_path', "varchar(500) DEFAULT NULL COMMENT '存储路径' AFTER storage_type");
CALL ensure_column('edu_resource', 'preview_url', "varchar(500) DEFAULT NULL COMMENT '预览地址' AFTER storage_path");

CALL ensure_column('edu_course_chapter', 'attachment_url', "varchar(500) DEFAULT NULL COMMENT '章节附件地址' AFTER resource_count");
CALL ensure_column('edu_course_chapter', 'attachment_name', "varchar(255) DEFAULT NULL COMMENT '章节附件名称' AFTER attachment_url");
CALL ensure_column('edu_course_chapter', 'attachment_size_mb', "decimal(10,2) DEFAULT 0.00 COMMENT '章节附件大小MB' AFTER attachment_name");

CALL ensure_column('edu_resource_audit', 'del_flag', "char(1) DEFAULT '0' COMMENT '删除标识(0存在 2删除)' AFTER audit_time");

CREATE TABLE IF NOT EXISTS edu_space_file (
  file_id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '空间文件ID',
  parent_id bigint(20) DEFAULT 0 COMMENT '父级ID',
  owner_user_id bigint(20) NOT NULL COMMENT '所属用户ID',
  owner_name varchar(100) DEFAULT '' COMMENT '所属用户名',
  file_name varchar(255) NOT NULL COMMENT '逻辑文件名',
  original_file_name varchar(255) DEFAULT NULL COMMENT '原始文件名',
  target_type varchar(20) NOT NULL DEFAULT 'file' COMMENT '类型(folder/file)',
  file_ext varchar(50) DEFAULT NULL COMMENT '文件后缀',
  file_size_mb decimal(10,2) DEFAULT 0.00 COMMENT '文件大小MB',
  storage_type varchar(20) DEFAULT 'local' COMMENT '存储类型',
  storage_path varchar(500) DEFAULT NULL COMMENT '存储路径',
  file_url varchar(500) DEFAULT NULL COMMENT '访问地址',
  preview_url varchar(500) DEFAULT NULL COMMENT '预览地址',
  status char(1) DEFAULT '0' COMMENT '状态(0正常 1停用)',
  del_flag char(1) DEFAULT '0' COMMENT '删除标识(0存在 2删除)',
  create_by varchar(64) DEFAULT '' COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT '' COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (file_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='空间文件表';

CALL ensure_column('edu_space_share', 'file_id', "bigint(20) DEFAULT NULL COMMENT '关联空间文件ID' AFTER share_name");
CALL ensure_column('edu_space_share', 'del_flag', "char(1) DEFAULT '0' COMMENT '删除标识(0存在 2删除)' AFTER status");

DROP PROCEDURE IF EXISTS ensure_column;