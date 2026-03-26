SET NAMES utf8mb4;
START TRANSACTION;

CREATE TABLE IF NOT EXISTS portal_site_config (
  config_id              bigint(20) NOT NULL AUTO_INCREMENT COMMENT '官网配置ID',
  site_name              varchar(100) NOT NULL COMMENT '站点中文名',
  site_en_name           varchar(200) DEFAULT NULL COMMENT '站点英文名',
  logo_url               varchar(255) DEFAULT NULL COMMENT 'Logo地址',
  home_nav_text          varchar(50) DEFAULT '首页' COMMENT '首页导航名称',
  notice_nav_text        varchar(50) DEFAULT '公告中心' COMMENT '公告导航名称',
  teacher_nav_text       varchar(50) DEFAULT '教师端' COMMENT '教师端导航名称',
  student_nav_text       varchar(50) DEFAULT '学生端' COMMENT '学生端导航名称',
  login_button_text      varchar(50) DEFAULT '进入后台' COMMENT '后台按钮名称',
  hero_badge             varchar(100) DEFAULT NULL COMMENT '首页角标',
  hero_title             varchar(255) DEFAULT NULL COMMENT '首页主标题',
  hero_subtitle          varchar(1000) DEFAULT NULL COMMENT '首页副标题',
  hero_primary_text      varchar(50) DEFAULT NULL COMMENT '主按钮文案',
  hero_primary_link      varchar(255) DEFAULT NULL COMMENT '主按钮链接',
  hero_secondary_text    varchar(50) DEFAULT NULL COMMENT '次按钮文案',
  hero_secondary_link    varchar(255) DEFAULT NULL COMMENT '次按钮链接',
  notice_panel_title     varchar(100) DEFAULT '最新公告' COMMENT '公告面板标题',
  notice_panel_more_text varchar(50) DEFAULT '全部公告' COMMENT '公告更多文案',
  footer_name            varchar(100) DEFAULT NULL COMMENT '页脚名称',
  footer_desc            varchar(1000) DEFAULT NULL COMMENT '页脚简介',
  footer_copyright       varchar(255) DEFAULT NULL COMMENT '版权信息',
  status                 char(1) DEFAULT '0' COMMENT '状态（0启用 1停用）',
  create_by              varchar(64) DEFAULT '' COMMENT '创建者',
  create_time            datetime DEFAULT NULL COMMENT '创建时间',
  update_by              varchar(64) DEFAULT '' COMMENT '更新者',
  update_time            datetime DEFAULT NULL COMMENT '更新时间',
  remark                 varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (config_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='官网配置';

CREATE TABLE IF NOT EXISTS portal_banner (
  banner_id       bigint(20) NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
  banner_title    varchar(200) NOT NULL COMMENT '轮播标题',
  banner_subtitle varchar(1000) DEFAULT NULL COMMENT '轮播副标题',
  image_url       varchar(255) NOT NULL COMMENT '图片地址',
  target_url      varchar(255) DEFAULT NULL COMMENT '跳转链接',
  button_text     varchar(50) DEFAULT NULL COMMENT '按钮文案',
  sort_num        int(11) DEFAULT 10 COMMENT '排序号',
  status          char(1) DEFAULT '0' COMMENT '状态（0启用 1停用）',
  create_by       varchar(64) DEFAULT '' COMMENT '创建者',
  create_time     datetime DEFAULT NULL COMMENT '创建时间',
  update_by       varchar(64) DEFAULT '' COMMENT '更新者',
  update_time     datetime DEFAULT NULL COMMENT '更新时间',
  remark          varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (banner_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='官网轮播图';

INSERT INTO portal_site_config (
  config_id, site_name, site_en_name, logo_url, home_nav_text, notice_nav_text,
  teacher_nav_text, student_nav_text, login_button_text, hero_badge, hero_title,
  hero_subtitle, hero_primary_text, hero_primary_link, hero_secondary_text,
  hero_secondary_link, notice_panel_title, notice_panel_more_text, footer_name,
  footer_desc, footer_copyright, status, create_by, create_time, remark
)
SELECT 1,
       '教学资源管理系统',
       'Teaching Resource Management System',
       '',
       '首页',
       '公告中心',
       '教师端',
       '学生端',
       '进入后台',
       '统一教学资源门户',
       '面向学校与院系的教学资源官网',
       '统一展示公告、重要资讯与教学资源动态，让学校和访客可以在官网首页快速获取核心信息。',
       '查看公告中心',
       '/announcements',
       '了解官网能力',
       '#capability',
       '最新公告',
       '全部公告',
       '教学资源管理系统',
       '统一发布学校通知、教学公告、资源动态与重要资讯。',
       '© 2026 教学资源管理系统',
       '0',
       'admin',
       NOW(),
       '官网默认配置'
WHERE NOT EXISTS (SELECT 1 FROM portal_site_config WHERE config_id = 1);

INSERT INTO portal_banner (banner_title, banner_subtitle, image_url, target_url, button_text, sort_num, status, create_by, create_time, remark)
SELECT '重要通知统一发布',
       '系统公告、教学通知、校园资讯均可在后台发布后实时同步到官网首页与公告中心。',
       '',
       '/announcements',
       '查看公告',
       1,
       '0',
       'admin',
       NOW(),
       '官网默认轮播图'
WHERE NOT EXISTS (SELECT 1 FROM portal_banner WHERE banner_title = '重要通知统一发布');

INSERT INTO portal_banner (banner_title, banner_subtitle, image_url, target_url, button_text, sort_num, status, create_by, create_time, remark)
SELECT '重要资讯首页展示',
       '支持首页轮播展示学校重点活动、资源专题、精品课程与最新建设成果。',
       '',
       '/announcements',
       '查看资讯',
       2,
       '0',
       'admin',
       NOW(),
       '官网默认轮播图'
WHERE NOT EXISTS (SELECT 1 FROM portal_banner WHERE banner_title = '重要资讯首页展示');

INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2342, '官网配置', 2100, 25, 'portal-config', 'portal/config/index', 1, 0, 'C', '0', '0', 'portal:config:query', 'setting', 'admin', NOW(), '官网配置'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2342);

INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2343, '官网轮播图', 2100, 26, 'portal-banner', 'portal/banner/index', 1, 0, 'C', '0', '0', 'portal:banner:list', 'picture', 'admin', NOW(), '官网轮播图'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2343);

INSERT INTO sys_menu SELECT 2344, '查询', 2342, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:config:query', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2344);
INSERT INTO sys_menu SELECT 2345, '修改', 2342, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:config:edit', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2345);
INSERT INTO sys_menu SELECT 2346, '查询', 2343, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:banner:query', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2346);
INSERT INTO sys_menu SELECT 2347, '新增', 2343, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:banner:add', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2347);
INSERT INTO sys_menu SELECT 2348, '修改', 2343, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:banner:edit', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2348);
INSERT INTO sys_menu SELECT 2349, '删除', 2343, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'portal:banner:remove', '#', 'admin', NOW(), '', NULL, '' WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2349);

INSERT INTO sys_role_menu(role_id, menu_id)
SELECT 1, m.menu_id
FROM sys_menu m
WHERE m.menu_id BETWEEN 2342 AND 2349
  AND NOT EXISTS (SELECT 1 FROM sys_role_menu rm WHERE rm.role_id = 1 AND rm.menu_id = m.menu_id);

COMMIT;
