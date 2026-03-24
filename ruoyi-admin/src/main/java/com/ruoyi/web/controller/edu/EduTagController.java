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
import com.ruoyi.system.domain.EduTag;
import com.ruoyi.system.service.IEduTagService;

@RestController
@RequestMapping("/edu/tag")
public class EduTagController extends BaseController
{
    @Autowired
    private IEduTagService tagService;

    @PreAuthorize("@ss.hasPermi('edu:tag:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduTag tag)
    {
        startPage();
        List<EduTag> list = tagService.selectTagList(tag);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:tag:query')")
    @GetMapping("/{tagId}")
    public AjaxResult getInfo(@PathVariable Long tagId)
    {
        return success(tagService.selectTagById(tagId));
    }

    @PreAuthorize("@ss.hasPermi('edu:tag:add')")
    @Log(title = "教学标签", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduTag tag)
    {
        if (!tagService.checkTagNameUnique(tag))
        {
            return error("新增标签失败，标签名称已存在");
        }
        tag.setCreateBy(getUsername());
        return toAjax(tagService.insertTag(tag));
    }

    @PreAuthorize("@ss.hasPermi('edu:tag:edit')")
    @Log(title = "教学标签", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduTag tag)
    {
        if (!tagService.checkTagNameUnique(tag))
        {
            return error("修改标签失败，标签名称已存在");
        }
        tag.setUpdateBy(getUsername());
        return toAjax(tagService.updateTag(tag));
    }

    @PreAuthorize("@ss.hasPermi('edu:tag:remove')")
    @Log(title = "教学标签", businessType = BusinessType.DELETE)
    @DeleteMapping("/{tagIds}")
    public AjaxResult remove(@PathVariable Long[] tagIds)
    {
        return toAjax(tagService.deleteTagByIds(tagIds));
    }
}
