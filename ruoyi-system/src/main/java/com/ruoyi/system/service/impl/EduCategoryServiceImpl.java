package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduCategory;
import com.ruoyi.system.mapper.EduCategoryMapper;
import com.ruoyi.system.service.IEduCategoryService;

@Service
public class EduCategoryServiceImpl implements IEduCategoryService
{
    @Autowired
    private EduCategoryMapper categoryMapper;

    @Override
    public List<EduCategory> selectCategoryList(EduCategory category)
    {
        return categoryMapper.selectCategoryList(category);
    }

    @Override
    public List<EduCategory> buildCategoryTree(List<EduCategory> categories)
    {
        List<EduCategory> returnList = new ArrayList<>();
        List<Long> ids = categories.stream().map(EduCategory::getCategoryId).collect(Collectors.toList());
        for (EduCategory category : categories)
        {
            if (!ids.contains(category.getParentId()))
            {
                recursionFn(categories, category);
                returnList.add(category);
            }
        }
        return returnList.isEmpty() ? categories : returnList;
    }

    private void recursionFn(List<EduCategory> list, EduCategory category)
    {
        List<EduCategory> children = getChildList(list, category);
        category.setChildren(children);
        for (EduCategory child : children)
        {
            if (hasChild(list, child))
            {
                recursionFn(list, child);
            }
        }
    }

    private List<EduCategory> getChildList(List<EduCategory> list, EduCategory category)
    {
        List<EduCategory> childList = new ArrayList<>();
        for (EduCategory item : list)
        {
            if (StringUtils.isNotNull(item.getParentId()) && item.getParentId().longValue() == category.getCategoryId().longValue())
            {
                childList.add(item);
            }
        }
        return childList;
    }

    private boolean hasChild(List<EduCategory> list, EduCategory category)
    {
        return !getChildList(list, category).isEmpty();
    }

    @Override
    public EduCategory selectCategoryById(Long categoryId)
    {
        return categoryMapper.selectCategoryById(categoryId);
    }

    @Override
    public boolean checkCategoryNameUnique(EduCategory category)
    {
        Long categoryId = StringUtils.isNull(category.getCategoryId()) ? -1L : category.getCategoryId();
        EduCategory info = categoryMapper.checkCategoryNameUnique(category);
        return StringUtils.isNull(info) || info.getCategoryId().longValue() == categoryId.longValue();
    }

    @Override
    public boolean hasChildByCategoryId(Long categoryId)
    {
        return categoryMapper.hasChildByCategoryId(categoryId) > 0;
    }

    @Override
    public int selectNormalChildrenCategoryById(Long categoryId)
    {
        return categoryMapper.selectNormalChildrenCategoryById(categoryId);
    }

    @Override
    public int insertCategory(EduCategory category)
    {
        EduCategory parent = categoryMapper.selectCategoryById(category.getParentId());
        if (StringUtils.isNull(parent))
        {
            throw new ServiceException("上级分类不存在");
        }
        if (!"0".equals(parent.getStatus()))
        {
            throw new ServiceException("上级分类已停用，不能新增子分类");
        }
        category.setAncestors(parent.getAncestors() + "," + parent.getCategoryId());
        return categoryMapper.insertCategory(category);
    }

    @Override
    public int updateCategory(EduCategory category)
    {
        EduCategory newParent = categoryMapper.selectCategoryById(category.getParentId());
        EduCategory oldCategory = categoryMapper.selectCategoryById(category.getCategoryId());
        if (StringUtils.isNull(newParent) || StringUtils.isNull(oldCategory))
        {
            throw new ServiceException("分类数据不存在");
        }
        String newAncestors = newParent.getAncestors() + "," + newParent.getCategoryId();
        String oldAncestors = oldCategory.getAncestors();
        category.setAncestors(newAncestors);
        updateCategoryChildren(category.getCategoryId(), newAncestors, oldAncestors);
        return categoryMapper.updateCategory(category);
    }

    private void updateCategoryChildren(Long categoryId, String newAncestors, String oldAncestors)
    {
        List<EduCategory> children = categoryMapper.selectChildrenCategoryById(categoryId);
        for (EduCategory child : children)
        {
            child.setAncestors(child.getAncestors().replaceFirst(oldAncestors, newAncestors));
        }
        if (!children.isEmpty())
        {
            categoryMapper.updateCategoryChildren(children);
        }
    }

    @Override
    public int deleteCategoryById(Long categoryId)
    {
        return categoryMapper.deleteCategoryById(categoryId);
    }
}
