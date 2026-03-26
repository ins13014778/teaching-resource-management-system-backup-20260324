# API 接口清单

## 基础地址

- 后端 API 根地址：`http://127.0.0.1:8080`
- Swagger UI：`http://127.0.0.1:8080/swagger-ui.html`
- OpenAPI JSON：`http://127.0.0.1:8080/v3/api-docs`
- 前端代理前缀：`/dev-api`

## 调用说明

- 大部分鉴权接口都需要请求头：`Authorization: Bearer <token>`
- 文件类业务建议先调用 `/common/upload` 或 `/common/uploads`，再把返回的 URL 写入业务表单。

## 全量接口列表

### Auth APIs

| Method | Path | Purpose | Controller | Handler |
|---|---|---|---|---|
| GET | `/captchaImage` | Get captcha | CaptchaController | `getCode` |
| GET | `/getInfo` | Detail query | SysLoginController | `getInfo` |
| GET | `/getRouters` | Get routers | SysLoginController | `getRouters` |
| POST | `/login` | Login | SysLoginController | `login` |
| POST | `/register` | Register | SysRegisterController | `register` |
| POST | `/unlockscreen` | Unlock screen | SysIndexController | `unlockScreen` |

### Common File APIs

| Method | Path | Purpose | Controller | Handler |
|---|---|---|---|---|
| GET | `/common/download` | File download | CommonController | `fileDownload` |
| GET | `/common/download/resource` | Resource download | CommonController | `resourceDownload` |
| POST | `/common/upload` | Single upload | CommonController | `uploadFile` |
| POST | `/common/uploads` | Multi upload | CommonController | `uploadFiles` |

### Education APIs

| Method | Path | Purpose | Controller | Handler |
|---|---|---|---|---|
| GET | `/edu/audit/list` | List query | EduAuditController | `list` |
| PUT | `/edu/audit/offline` | Take offline | EduAuditController | `offline` |
| PUT | `/edu/audit/pass` | Approve | EduAuditController | `pass` |
| PUT | `/edu/audit/reject` | Reject | EduAuditController | `reject` |
| GET | `/edu/audit/{auditId}` | Detail query | EduAuditController | `getInfo` |
| GET | `/edu/category/list` | List query | EduCategoryController | `list` |
| GET | `/edu/category/list/exclude/{categoryId}` | Exclude child | EduCategoryController | `excludeChild` |
| DELETE | `/edu/category/{categoryId}` | Delete | EduCategoryController | `remove` |
| GET | `/edu/category/{categoryId}` | Detail query | EduCategoryController | `getInfo` |
| GET | `/edu/chapter/list` | List query | EduCourseChapterController | `list` |
| DELETE | `/edu/chapter/{chapterIds}` | Delete | EduCourseChapterController | `remove` |
| GET | `/edu/chapter/{chapterId}` | Detail query | EduCourseChapterController | `getInfo` |
| PUT | `/edu/comment/audit/{commentId}/{auditStatus}` | Audit | EduCommentController | `audit` |
| GET | `/edu/comment/list` | List query | EduCommentController | `list` |
| GET | `/edu/comment/resource/{resourceId}` | listByResource | EduCommentController | `listByResource` |
| DELETE | `/edu/comment/{commentIds}` | Delete | EduCommentController | `remove` |
| GET | `/edu/comment/{commentId}` | Detail query | EduCommentController | `getInfo` |
| GET | `/edu/config/current` | Current config | EduGlobalConfigController | `getCurrent` |
| GET | `/edu/course/list` | List query | EduCourseController | `list` |
| DELETE | `/edu/course/{courseIds}` | Delete | EduCourseController | `remove` |
| GET | `/edu/course/{courseId}` | Detail query | EduCourseController | `getInfo` |
| GET | `/edu/download/list` | List query | EduDownloadLogController | `list` |
| DELETE | `/edu/download/{logIds}` | Delete | EduDownloadLogController | `remove` |
| GET | `/edu/favorite/list` | List query | EduFavoriteController | `list` |
| POST | `/edu/favorite/toggle/{resourceId}` | Toggle state | EduFavoriteController | `toggle` |
| DELETE | `/edu/favorite/{favoriteIds}` | Delete | EduFavoriteController | `remove` |
| GET | `/edu/favorite/{favoriteId}` | Detail query | EduFavoriteController | `getInfo` |
| GET | `/edu/feedback/list` | List query | EduFeedbackController | `list` |
| PUT | `/edu/feedback/reply` | Reply | EduFeedbackController | `reply` |
| DELETE | `/edu/feedback/{feedbackIds}` | Delete | EduFeedbackController | `remove` |
| GET | `/edu/feedback/{feedbackId}` | Detail query | EduFeedbackController | `getInfo` |
| GET | `/edu/grant/list` | List query | EduTeacherStudentGrantController | `list` |
| DELETE | `/edu/grant/{grantIds}` | Delete | EduTeacherStudentGrantController | `remove` |
| GET | `/edu/grant/{grantId}` | Detail query | EduTeacherStudentGrantController | `getInfo` |
| GET | `/edu/like/list` | List query | EduResourceLikeController | `list` |
| POST | `/edu/like/toggle/{resourceId}` | Toggle state | EduResourceLikeController | `toggle` |
| DELETE | `/edu/like/{likeIds}` | Delete | EduResourceLikeController | `remove` |
| GET | `/edu/like/{likeId}` | Detail query | EduResourceLikeController | `getInfo` |
| GET | `/edu/message/list` | List query | EduMessageController | `list` |
| GET | `/edu/message/my` | My messages | EduMessageController | `my` |
| POST | `/edu/message/read/{messageId}` | Read message | EduMessageController | `read` |
| DELETE | `/edu/message/{messageIds}` | Delete | EduMessageController | `remove` |
| GET | `/edu/message/{messageId}` | Detail query | EduMessageController | `getInfo` |
| GET | `/edu/notice/course/{courseId}` | listByCourse | EduCourseNoticeController | `listByCourse` |
| GET | `/edu/notice/list` | List query | EduCourseNoticeController | `list` |
| DELETE | `/edu/notice/{noticeIds}` | Delete | EduCourseNoticeController | `remove` |
| GET | `/edu/notice/{noticeId}` | Detail query | EduCourseNoticeController | `getInfo` |
| GET | `/edu/quota/list` | List query | EduUserQuotaController | `list` |
| GET | `/edu/quota/{quotaId}` | Detail query | EduUserQuotaController | `getInfo` |
| PUT | `/edu/report/handle` | Handle | EduReportController | `handle` |
| GET | `/edu/report/list` | List query | EduReportController | `list` |
| DELETE | `/edu/report/{reportIds}` | Delete | EduReportController | `remove` |
| GET | `/edu/report/{reportId}` | Detail query | EduReportController | `getInfo` |
| POST | `/edu/resource/download/{resourceId}` | Download resource | EduResourceController | `download` |
| GET | `/edu/resource/formOptions` | Form options | EduResourceController | `formOptions` |
| GET | `/edu/resource/list` | List query | EduResourceController | `list` |
| PUT | `/edu/resource/recommend/{resourceId}/{recommendFlag}` | Set recommend | EduResourceController | `recommend` |
| POST | `/edu/resource/submit/{resourceId}` | Submit for audit | EduResourceController | `submit` |
| DELETE | `/edu/resource/{resourceIds}` | Delete | EduResourceController | `remove` |
| GET | `/edu/resource/{resourceId}` | Detail query | EduResourceController | `getInfo` |
| GET | `/edu/share/list` | List query | EduSpaceShareController | `list` |
| DELETE | `/edu/share/{shareIds}` | Delete | EduSpaceShareController | `remove` |
| GET | `/edu/share/{shareId}` | Detail query | EduSpaceShareController | `getInfo` |
| GET | `/edu/space/list` | List query | EduSpaceFileController | `list` |
| DELETE | `/edu/space/{fileIds}` | Delete | EduSpaceFileController | `remove` |
| GET | `/edu/space/{fileId}` | Detail query | EduSpaceFileController | `getInfo` |
| GET | `/edu/stats/dashboard` | Stats dashboard | EduStatsController | `dashboard` |
| GET | `/edu/tag/list` | List query | EduTagController | `list` |
| DELETE | `/edu/tag/{tagIds}` | Delete | EduTagController | `remove` |
| GET | `/edu/tag/{tagId}` | Detail query | EduTagController | `getInfo` |

### Portal APIs

| Method | Path | Purpose | Controller | Handler |
|---|---|---|---|---|
| GET | `/portal/admin/banner/list` | List query | PortalBannerAdminController | `list` |
| DELETE | `/portal/admin/banner/{bannerIds}` | Delete | PortalBannerAdminController | `remove` |
| GET | `/portal/admin/banner/{bannerId}` | Detail query | PortalBannerAdminController | `getInfo` |
| GET | `/portal/admin/config/current` | Current config | PortalSiteConfigAdminController | `getCurrent` |
| GET | `/portal/home/config` | Portal config | PortalController | `config` |
| GET | `/portal/home/overview` | Portal overview | PortalController | `overview` |
| GET | `/portal/notices` | Portal notices | PortalController | `notices` |
| GET | `/portal/notices/{noticeId}` | Portal notice detail | PortalController | `noticeInfo` |

### AI APIs

| Method | Path | Purpose | Controller | Handler |
|---|---|---|---|---|
| GET | `/ai/audit/list` | List query | AiAuditResultController | `list` |
| DELETE | `/ai/audit/{resultIds}` | Delete | AiAuditResultController | `remove` |
| GET | `/ai/audit/{resultId}` | Detail query | AiAuditResultController | `getInfo` |
| GET | `/ai/prompt/list` | List query | AiPromptTemplateController | `list` |
| DELETE | `/ai/prompt/{templateIds}` | Delete | AiPromptTemplateController | `remove` |
| GET | `/ai/prompt/{templateId}` | Detail query | AiPromptTemplateController | `getInfo` |
| POST | `/ai/qa/ask` | AI ask | AiQaController | `ask` |
| GET | `/ai/qa/log/list` | List query | AiQaController | `list` |
| DELETE | `/ai/qa/log/{qaIds}` | Delete | AiQaController | `remove` |
| GET | `/ai/resource/audit/{resourceId}` | Audit | AiCapabilityController | `audit` |
| GET | `/ai/resource/classify/{resourceId}` | AI classify | AiCapabilityController | `classify` |
| GET | `/ai/resource/ocr/{resourceId}` | OCR analyze | AiCapabilityController | `ocr` |
| GET | `/ai/resource/similarity/{resourceId}` | Similarity analyze | AiCapabilityController | `similarity` |
| GET | `/ai/resource/summary/{resourceId}` | AI summary | AiCapabilityController | `summary` |
| GET | `/ai/resource/tags/{resourceId}` | AI tags | AiCapabilityController | `tags` |
| GET | `/ai/search/basic` | Basic search | AiCapabilityController | `basic` |
| GET | `/ai/search/semantic` | Semantic search | AiCapabilityController | `semantic` |
| GET | `/ai/task/list` | List query | AiTaskController | `list` |
| POST | `/ai/task/run/{resourceId}` | Run task | AiTaskController | `run` |
| DELETE | `/ai/task/{taskIds}` | Delete | AiTaskController | `remove` |
| GET | `/ai/task/{taskId}` | Detail query | AiTaskController | `getInfo` |

### System APIs

| Method | Path | Purpose | Controller | Handler |
|---|---|---|---|---|
| GET | `/system/config/configKey/{configKey}` | getConfigKey | SysConfigController | `getConfigKey` |
| POST | `/system/config/export` | Export | SysConfigController | `export` |
| GET | `/system/config/list` | List query | SysConfigController | `list` |
| DELETE | `/system/config/refreshCache` | Refresh cache | SysConfigController | `refreshCache` |
| DELETE | `/system/config/{configIds}` | Delete | SysConfigController | `remove` |
| GET | `/system/config/{configId}` | Detail query | SysConfigController | `getInfo` |
| GET | `/system/dept/list` | List query | SysDeptController | `list` |
| GET | `/system/dept/list/exclude/{deptId}` | Exclude child | SysDeptController | `excludeChild` |
| PUT | `/system/dept/updateSort` | Update sort | SysDeptController | `updateSort` |
| DELETE | `/system/dept/{deptId}` | Delete | SysDeptController | `remove` |
| GET | `/system/dept/{deptId}` | Detail query | SysDeptController | `getInfo` |
| POST | `/system/dict/data/export` | Export | SysDictDataController | `export` |
| GET | `/system/dict/data/list` | List query | SysDictDataController | `list` |
| GET | `/system/dict/data/type/{dictType}` | Dict type data | SysDictDataController | `dictType` |
| DELETE | `/system/dict/data/{dictCodes}` | Delete | SysDictDataController | `remove` |
| GET | `/system/dict/data/{dictCode}` | Detail query | SysDictDataController | `getInfo` |
| POST | `/system/dict/type/export` | Export | SysDictTypeController | `export` |
| GET | `/system/dict/type/list` | List query | SysDictTypeController | `list` |
| GET | `/system/dict/type/optionselect` | Option select | SysDictTypeController | `optionselect` |
| DELETE | `/system/dict/type/refreshCache` | Refresh cache | SysDictTypeController | `refreshCache` |
| DELETE | `/system/dict/type/{dictIds}` | Delete | SysDictTypeController | `remove` |
| GET | `/system/dict/type/{dictId}` | Detail query | SysDictTypeController | `getInfo` |
| GET | `/system/menu/list` | List query | SysMenuController | `list` |
| GET | `/system/menu/roleMenuTreeselect/{roleId}` | Role menu tree | SysMenuController | `roleMenuTreeselect` |
| GET | `/system/menu/treeselect` | Tree select | SysMenuController | `treeselect` |
| PUT | `/system/menu/updateSort` | Update sort | SysMenuController | `updateSort` |
| DELETE | `/system/menu/{menuId}` | Delete | SysMenuController | `remove` |
| GET | `/system/menu/{menuId}` | Detail query | SysMenuController | `getInfo` |
| GET | `/system/notice/list` | List query | SysNoticeController | `list` |
| GET | `/system/notice/listTop` | Top notices | SysNoticeController | `listTop` |
| POST | `/system/notice/markRead` | Mark read | SysNoticeController | `markRead` |
| POST | `/system/notice/markReadAll` | Mark all read | SysNoticeController | `markReadAll` |
| DELETE | `/system/notice/{noticeIds}` | Delete | SysNoticeController | `remove` |
| GET | `/system/notice/{noticeId}` | Detail query | SysNoticeController | `getInfo` |
| POST | `/system/post/export` | Export | SysPostController | `export` |
| GET | `/system/post/list` | List query | SysPostController | `list` |
| GET | `/system/post/optionselect` | Option select | SysPostController | `optionselect` |
| DELETE | `/system/post/{postIds}` | Delete | SysPostController | `remove` |
| GET | `/system/post/{postId}` | Detail query | SysPostController | `getInfo` |
| GET | `/system/role/authUser/allocatedList` | Allocated users | SysRoleController | `allocatedList` |
| PUT | `/system/role/authUser/cancel` | Cancel auth user | SysRoleController | `cancelAuthUser` |
| PUT | `/system/role/authUser/cancelAll` | Cancel all auth users | SysRoleController | `cancelAuthUserAll` |
| PUT | `/system/role/authUser/selectAll` | Select all auth users | SysRoleController | `selectAuthUserAll` |
| GET | `/system/role/authUser/unallocatedList` | Unallocated users | SysRoleController | `unallocatedList` |
| PUT | `/system/role/changeStatus` | Change status | SysRoleController | `changeStatus` |
| PUT | `/system/role/dataScope` | Data scope | SysRoleController | `dataScope` |
| GET | `/system/role/deptTree/{roleId}` | Department tree | SysRoleController | `deptTree` |
| POST | `/system/role/export` | Export | SysRoleController | `export` |
| GET | `/system/role/list` | List query | SysRoleController | `list` |
| GET | `/system/role/optionselect` | Option select | SysRoleController | `optionselect` |
| DELETE | `/system/role/{roleIds}` | Delete | SysRoleController | `remove` |
| GET | `/system/role/{roleId}` | Detail query | SysRoleController | `getInfo` |
| GET | `/system/user/` | Detail query | SysUserController | `getInfo` |
| PUT | `/system/user/authRole` | Assign role | SysUserController | `insertAuthRole` |
| GET | `/system/user/authRole/{userId}` | User role detail | SysUserController | `authRole` |
| PUT | `/system/user/changeStatus` | Change status | SysUserController | `changeStatus` |
| GET | `/system/user/deptTree` | Department tree | SysUserController | `deptTree` |
| POST | `/system/user/export` | Export | SysUserController | `export` |
| POST | `/system/user/importData` | Import data | SysUserController | `importData` |
| POST | `/system/user/importTemplate` | Import template | SysUserController | `importTemplate` |
| GET | `/system/user/list` | List query | SysUserController | `list` |
| POST | `/system/user/profile/avatar` | Upload avatar | SysProfileController | `avatar` |
| REQUEST | `/system/user/profile/system/user/profile` | Profile | SysProfileController | `profile` |
| PUT | `/system/user/profile/updatePwd` | Update password | SysProfileController | `updatePwd` |
| PUT | `/system/user/resetPwd` | Reset password | SysUserController | `resetPwd` |
| DELETE | `/system/user/{userIds}` | Delete | SysUserController | `remove` |

### Monitor APIs

| Method | Path | Purpose | Controller | Handler |
|---|---|---|---|---|
| GET | `/monitor/cache/` | Detail query | CacheController | `getInfo` |
| DELETE | `/monitor/cache/clearCacheAll` | Clear all cache | CacheController | `clearCacheAll` |
| DELETE | `/monitor/cache/clearCacheKey/{cacheKey}` | Clear cache key | CacheController | `clearCacheKey` |
| DELETE | `/monitor/cache/clearCacheName/{cacheName}` | Clear cache name | CacheController | `clearCacheName` |
| GET | `/monitor/cache/getKeys/{cacheName}` | Get cache keys | CacheController | `getCacheKeys` |
| GET | `/monitor/cache/getNames` | Cache overview | CacheController | `cache` |
| GET | `/monitor/cache/getValue/{cacheName}/{cacheKey}` | Get cache value | CacheController | `getCacheValue` |
| DELETE | `/monitor/logininfor/clean` | Clean | SysLogininforController | `clean` |
| POST | `/monitor/logininfor/export` | Export | SysLogininforController | `export` |
| GET | `/monitor/logininfor/list` | List query | SysLogininforController | `list` |
| GET | `/monitor/logininfor/unlock/{userName}` | Unlock | SysLogininforController | `unlock` |
| DELETE | `/monitor/logininfor/{infoIds}` | Delete | SysLogininforController | `remove` |
| GET | `/monitor/online/list` | List query | SysUserOnlineController | `list` |
| DELETE | `/monitor/online/{tokenId}` | Force logout | SysUserOnlineController | `forceLogout` |
| DELETE | `/monitor/operlog/clean` | Clean | SysOperlogController | `clean` |
| POST | `/monitor/operlog/export` | Export | SysOperlogController | `export` |
| GET | `/monitor/operlog/list` | List query | SysOperlogController | `list` |
| DELETE | `/monitor/operlog/{operIds}` | Delete | SysOperlogController | `remove` |
| GET | `/monitor/server/` | Detail query | ServerController | `getInfo` |

### Test APIs

| Method | Path | Purpose | Controller | Handler |
|---|---|---|---|---|
| GET | `/test/user/list` | Test user list | TestController | `userList` |
| POST | `/test/user/save` | Save | TestController | `save` |
| PUT | `/test/user/update` | Update | TestController | `update` |
| DELETE | `/test/user/{userId}` | Delete | TestController | `delete` |
| GET | `/test/user/{userId}` | Test user detail | TestController | `getUser` |

### Other APIs

| Method | Path | Purpose | Controller | Handler |
|---|---|---|---|---|
| REQUEST | `/` | Index | SysIndexController | `index` |
