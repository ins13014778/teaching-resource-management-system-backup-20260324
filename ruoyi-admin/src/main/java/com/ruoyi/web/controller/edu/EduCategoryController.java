package com.ruoyi.web.controller.edu;

import java.util.List;
import org.apache.commons.lang3.ArrayUtils;
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
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduCategory;
import com.ruoyi.system.service.IEduCategoryService;

@RestController
@RequestMapping("/edu/category")
public class EduCategoryController extends BaseController
{
    @Autowired
    private IEduCategoryService categoryService;

    @PreAuthorize("@ss.hasPermi('edu:category:list')")
    @GetMapping("/list")
    public AjaxResult list(EduCategory category)
    {
        List<EduCategory> categories = categoryService.selectCategoryList(category);
        return success(categoryService.buildCategoryTree(categories));
    }

    @PreAuthorize("@ss.hasPermi('edu:category:list')")
    @GetMapping("/list/exclude/{categoryId}")
    public AjaxResult excludeChild(@PathVariable(value = "categoryId", required = false) Long categoryId)
    {
        List<EduCategory> categories = categoryService.selectCategoryList(new EduCategory());
        categories.removeIf(c -> c.getCategoryId().intValue() == categoryId
            || ArrayUtils.contains(StringUtils.split(c.getAncestors(), ","), String.valueOf(categoryId)));
        return success(categoryService.buildCategoryTree(categories));
    }

    @PreAuthorize("@ss.hasPermi('edu:category:query')")
    @GetMapping("/{categoryId}")
    public AjaxResult getInfo(@PathVariable Long categoryId)
    {
        return success(categoryService.selectCategoryById(categoryId));
    }

    @PreAuthorize("@ss.hasPermi('edu:category:add')")
    @Log(title = "教学分类", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduCategory category)
    {
        if (!categoryService.checkCategoryNameUnique(category))
        {
            return error("新增分类失败，当前层级下分类名称已存在");
        }
        category.setCreateBy(getUsername());
        return toAjax(categoryService.insertCategory(category));
    }

    @PreAuthorize("@ss.hasPermi('edu:category:edit')")
    @Log(title = "教学分类", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduCategory category)
    {
        if (!categoryService.checkCategoryNameUnique(category))
        {
            return error("修改分类失败，当前层级下分类名称已存在");
        }
        if (category.getCategoryId().equals(category.getParentId()))
        {
            return error("上级分类不能选择自己");
        }
        if ("1".equals(category.getStatus()) && categoryService.selectNormalChildrenCategoryById(category.getCategoryId()) > 0)
        {
            return error("当前分类下仍存在启用中的子分类");
        }
        category.setUpdateBy(getUsername());
        return toAjax(categoryService.updateCategory(category));
    }

    @PreAuthorize("@ss.hasPermi('edu:category:remove')")
    @Log(title = "教学分类", businessType = BusinessType.DELETE)
    @DeleteMapping("/{categoryId}")
    public AjaxResult remove(@PathVariable Long categoryId)
    {
        if (categoryService.hasChildByCategoryId(categoryId))
        {
            return warn("存在下级分类，不允许删除");
        }
        return toAjax(categoryService.deleteCategoryById(categoryId));
    }
}
