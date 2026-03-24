package com.ruoyi.web.controller.edu;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.EduCourseNotice;
import com.ruoyi.system.service.IEduCourseNoticeService;

@RestController
@RequestMapping("/edu/notice")
public class EduCourseNoticeController extends BaseController
{
    @Autowired
    private IEduCourseNoticeService noticeService;

    @PreAuthorize("@ss.hasPermi('edu:notice:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduCourseNotice notice)
    {
        startPage();
        List<EduCourseNotice> list = noticeService.selectNoticeList(notice);
        return getDataTable(list);
    }

    @GetMapping("/course/{courseId}")
    public AjaxResult listByCourse(@PathVariable Long courseId)
    {
        return success(noticeService.selectNoticeByCourseId(courseId));
    }

    @PreAuthorize("@ss.hasPermi('edu:notice:query')")
    @GetMapping("/{noticeId}")
    public AjaxResult getInfo(@PathVariable Long noticeId)
    {
        return success(noticeService.selectNoticeById(noticeId));
    }

    @PreAuthorize("@ss.hasPermi('edu:notice:add')")
    @Log(title = "课程公告", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduCourseNotice notice)
    {
        notice.setCreateBy(getUsername());
        return toAjax(noticeService.insertNotice(notice));
    }

    @PreAuthorize("@ss.hasPermi('edu:notice:edit')")
    @Log(title = "课程公告", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduCourseNotice notice)
    {
        notice.setUpdateBy(getUsername());
        return toAjax(noticeService.updateNotice(notice));
    }

    @PreAuthorize("@ss.hasPermi('edu:notice:remove')")
    @Log(title = "课程公告", businessType = BusinessType.DELETE)
    @DeleteMapping("/{noticeIds}")
    public AjaxResult remove(@PathVariable Long[] noticeIds)
    {
        return toAjax(noticeService.deleteNoticeByIds(noticeIds));
    }
}
