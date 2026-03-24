-- 修复 2026-03-24 菜单中文、教师学生端菜单授权
update sys_menu set menu_name='课程公告' where menu_id = 2300;
update sys_menu set menu_name='消息中心' where menu_id = 2301;
update sys_menu set menu_name='资源搜索' where menu_id = 2302;
update sys_menu set menu_name='资源点赞' where menu_id = 2303;
update sys_menu set menu_name='AI任务' where menu_id = 2310;
update sys_menu set menu_name='AI提示词' where menu_id = 2311;
update sys_menu set menu_name='AI审核结果' where menu_id = 2312;
update sys_menu set menu_name='AI问答' where menu_id = 2313;

update sys_menu set menu_name='查询' where menu_id in (2320,2324,2328,2330,2333,2337,2339);
update sys_menu set menu_name='新增' where menu_id in (2321,2325,2334);
update sys_menu set menu_name='修改' where menu_id in (2322,2335);
update sys_menu set menu_name='删除' where menu_id in (2323,2326,2329,2332,2336,2338,2341);
update sys_menu set menu_name='搜索' where menu_id = 2327;
update sys_menu set menu_name='执行' where menu_id in (2331,2340);

-- 教师端补齐：课程公告、消息中心、资源搜索、统计分析及其常用按钮
insert into sys_role_menu(role_id, menu_id)
select 3, m.menu_id from sys_menu m
where m.menu_id in (2276,2299,2300,2301,2302,2320,2321,2322,2323,2324,2326,2327)
  and not exists (select 1 from sys_role_menu rm where rm.role_id = 3 and rm.menu_id = m.menu_id);

-- 学生端补齐：课程专区、资源搜索、我的收藏、我的下载、留言反馈、消息中心、课程公告
insert into sys_role_menu(role_id, menu_id)
select 4, m.menu_id from sys_menu m
where m.menu_id in (2203,2272,2274,2275,2300,2301,2302,2286,2293,2294,2297,2320,2324,2327)
  and not exists (select 1 from sys_role_menu rm where rm.role_id = 4 and rm.menu_id = m.menu_id);
