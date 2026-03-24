-- edu mvp schema

drop table if exists edu_category;
create table edu_category (
  category_id      bigint(20)      not null auto_increment comment 'category id',
  parent_id        bigint(20)      default 0 comment 'parent id',
  ancestors        varchar(255)    default '' comment 'ancestor list',
  category_name    varchar(100)    not null comment 'category name',
  order_num        int(4)          default 0 comment 'order num',
  status           char(1)         default '0' comment 'status',
  del_flag         char(1)         default '0' comment 'delete flag',
  create_by        varchar(64)     default '' comment 'create by',
  create_time      datetime        default null comment 'create time',
  update_by        varchar(64)     default '' comment 'update by',
  update_time      datetime        default null comment 'update time',
  remark           varchar(500)    default null comment 'remark',
  primary key (category_id)
) engine=innodb comment='edu category';

insert into edu_category values
(1, 0, '0', 'Education', 0, '0', '0', 'admin', now(), '', null, 'root'),
(2, 1, '0,1', 'Primary School', 1, '0', '0', 'admin', now(), '', null, null),
(3, 1, '0,1', 'Middle School', 2, '0', '0', 'admin', now(), '', null, null),
(4, 1, '0,1', 'High School', 3, '0', '0', 'admin', now(), '', null, null),
(5, 1, '0,1', 'University', 4, '0', '0', 'admin', now(), '', null, null),
(6, 5, '0,1,5', 'Computer Science', 1, '0', '0', 'admin', now(), '', null, null),
(7, 5, '0,1,5', 'Mathematics', 2, '0', '0', 'admin', now(), '', null, null),
(8, 5, '0,1,5', 'English', 3, '0', '0', 'admin', now(), '', null, null);

drop table if exists edu_tag;
create table edu_tag (
  tag_id            bigint(20)      not null auto_increment comment 'tag id',
  tag_name          varchar(100)    not null comment 'tag name',
  tag_type          varchar(50)     default 'general' comment 'tag type',
  color             varchar(30)     default '#409EFF' comment 'tag color',
  status            char(1)         default '0' comment 'status',
  del_flag          char(1)         default '0' comment 'delete flag',
  create_by         varchar(64)     default '' comment 'create by',
  create_time       datetime        default null comment 'create time',
  update_by         varchar(64)     default '' comment 'update by',
  update_time       datetime        default null comment 'update time',
  remark            varchar(500)    default null comment 'remark',
  primary key (tag_id)
) engine=innodb comment='edu tag';

insert into edu_tag values
(1, 'Featured', 'quality', '#67C23A', '0', '0', 'admin', now(), '', null, null),
(2, 'Teacher Choice', 'quality', '#E6A23C', '0', '0', 'admin', now(), '', null, null),
(3, 'Midterm Review', 'phase', '#409EFF', '0', '0', 'admin', now(), '', null, null),
(4, 'Final Review', 'phase', '#F56C6C', '0', '0', 'admin', now(), '', null, null),
(5, 'Latest', 'time', '#909399', '0', '0', 'admin', now(), '', null, null);

drop table if exists edu_course;
create table edu_course (
  course_id          bigint(20)      not null auto_increment comment 'course id',
  course_name        varchar(100)    not null comment 'course name',
  course_code        varchar(100)    default null comment 'course code',
  teacher_user_id    bigint(20)      default null comment 'teacher user id',
  teacher_name       varchar(100)    default null comment 'teacher name',
  course_intro       varchar(1000)   default null comment 'course intro',
  status             char(1)         default '0' comment 'status',
  del_flag           char(1)         default '0' comment 'delete flag',
  create_by          varchar(64)     default '' comment 'create by',
  create_time        datetime        default null comment 'create time',
  update_by          varchar(64)     default '' comment 'update by',
  update_time        datetime        default null comment 'update time',
  remark             varchar(500)    default null comment 'remark',
  primary key (course_id)
) engine=innodb comment='edu course';

insert into edu_course values
(1, 'Data Structure', 'CS101', 1, 'admin', 'Core course for computer majors.', '0', '0', 'admin', now(), '', null, null),
(2, 'Advanced Mathematics', 'MATH201', 1, 'admin', 'Mathematics foundation course.', '0', '0', 'admin', now(), '', null, null),
(3, 'College English', 'ENG301', 1, 'admin', 'English improvement course.', '0', '0', 'admin', now(), '', null, null);

alter table edu_resource add column tag_names varchar(500) default null comment 'tag names' after course_name;
alter table edu_resource add column cover_url varchar(500) default null comment 'cover url' after file_url;
alter table edu_resource add column resource_version varchar(20) default 'v1.0' comment 'resource version' after cover_url;
alter table edu_resource add column recommend_flag char(1) default '0' comment 'recommend flag' after publish_status;

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2200, 'Teaching', 0, 5, 'edu', null, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', now(), '', null, 'edu root'
where not exists (select 1 from sys_menu where menu_id = 2200);

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2201, 'Category', 2200, 1, 'category', 'edu/category/index', '', '', 1, 0, 'C', '0', '0', 'edu:category:list', 'tree', 'admin', now(), '', null, 'category'
where not exists (select 1 from sys_menu where menu_id = 2201);

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2202, 'Tag', 2200, 2, 'tag', 'edu/tag/index', '', '', 1, 0, 'C', '0', '0', 'edu:tag:list', 'dict', 'admin', now(), '', null, 'tag'
where not exists (select 1 from sys_menu where menu_id = 2202);

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2203, 'Course', 2200, 3, 'course', 'edu/course/index', '', '', 1, 0, 'C', '0', '0', 'edu:course:list', 'form', 'admin', now(), '', null, 'course'
where not exists (select 1 from sys_menu where menu_id = 2203);

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2204, 'Resource', 2200, 4, 'resource', 'edu/resource/index', '', '', 1, 0, 'C', '0', '0', 'edu:resource:list', 'documentation', 'admin', now(), '', null, 'resource'
where not exists (select 1 from sys_menu where menu_id = 2204);

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2205, 'Audit', 2200, 5, 'audit', 'edu/audit/index', '', '', 1, 0, 'C', '0', '0', 'edu:audit:list', 'eye-open', 'admin', now(), '', null, 'audit'
where not exists (select 1 from sys_menu where menu_id = 2205);

insert into sys_menu select 2210, 'Category Query', 2201, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:category:query', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2210);
insert into sys_menu select 2211, 'Category Add', 2201, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:category:add', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2211);
insert into sys_menu select 2212, 'Category Edit', 2201, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:category:edit', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2212);
insert into sys_menu select 2213, 'Category Remove', 2201, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:category:remove', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2213);

insert into sys_menu select 2220, 'Tag Query', 2202, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:tag:query', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2220);
insert into sys_menu select 2221, 'Tag Add', 2202, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:tag:add', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2221);
insert into sys_menu select 2222, 'Tag Edit', 2202, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:tag:edit', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2222);
insert into sys_menu select 2223, 'Tag Remove', 2202, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:tag:remove', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2223);

insert into sys_menu select 2230, 'Course Query', 2203, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:course:query', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2230);
insert into sys_menu select 2231, 'Course Add', 2203, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:course:add', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2231);
insert into sys_menu select 2232, 'Course Edit', 2203, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:course:edit', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2232);
insert into sys_menu select 2233, 'Course Remove', 2203, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:course:remove', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2233);

insert into sys_menu select 2240, 'Resource Query', 2204, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:query', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2240);
insert into sys_menu select 2241, 'Resource Add', 2204, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:add', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2241);
insert into sys_menu select 2242, 'Resource Edit', 2204, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:edit', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2242);
insert into sys_menu select 2243, 'Resource Remove', 2204, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:remove', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2243);
insert into sys_menu select 2244, 'Resource Audit', 2204, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:audit', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2244);
insert into sys_menu select 2245, 'Resource Recommend', 2204, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:resource:recommend', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2245);

insert into sys_menu select 2250, 'Audit Query', 2205, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:audit:query', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2250);
insert into sys_menu select 2251, 'Audit Pass', 2205, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:audit:pass', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2251);
insert into sys_menu select 2252, 'Audit Reject', 2205, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:audit:reject', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2252);
insert into sys_menu select 2253, 'Audit Offline', 2205, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'edu:audit:offline', '#', 'admin', now(), '', null, '' where not exists (select 1 from sys_menu where menu_id = 2253);

insert into sys_role_menu(role_id, menu_id)
select 1, m.menu_id
from sys_menu m
where m.menu_id between 2200 and 2253
  and not exists (select 1 from sys_role_menu rm where rm.role_id = 1 and rm.menu_id = m.menu_id);
