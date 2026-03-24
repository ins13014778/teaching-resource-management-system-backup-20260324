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
import com.ruoyi.system.domain.EduCourseChapter;
import com.ruoyi.system.service.IEduCourseChapterService;

@RestController
@RequestMapping("/edu/chapter")
public class EduCourseChapterController extends BaseController
{
    @Autowired
    private IEduCourseChapterService chapterService;

    @PreAuthorize("@ss.hasPermi('edu:chapter:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduCourseChapter chapter)
    {
        startPage();
        List<EduCourseChapter> list = chapterService.selectChapterList(chapter);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:chapter:query')")
    @GetMapping("/{chapterId}")
    public AjaxResult getInfo(@PathVariable Long chapterId)
    {
        return success(chapterService.selectChapterById(chapterId));
    }

    @PreAuthorize("@ss.hasPermi('edu:chapter:add')")
    @Log(title = "课程章节", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduCourseChapter chapter)
    {
        chapter.setCreateBy(getUsername());
        return toAjax(chapterService.insertChapter(chapter));
    }

    @PreAuthorize("@ss.hasPermi('edu:chapter:edit')")
    @Log(title = "课程章节", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduCourseChapter chapter)
    {
        chapter.setUpdateBy(getUsername());
        return toAjax(chapterService.updateChapter(chapter));
    }

    @PreAuthorize("@ss.hasPermi('edu:chapter:remove')")
    @Log(title = "课程章节", businessType = BusinessType.DELETE)
    @DeleteMapping("/{chapterIds}")
    public AjaxResult remove(@PathVariable Long[] chapterIds)
    {
        return toAjax(chapterService.deleteChapterByIds(chapterIds));
    }
}
