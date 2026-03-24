package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduCategory;

public interface IEduCategoryService
{
    List<EduCategory> selectCategoryList(EduCategory category);

    List<EduCategory> buildCategoryTree(List<EduCategory> categories);

    EduCategory selectCategoryById(Long categoryId);

    boolean checkCategoryNameUnique(EduCategory category);

    boolean hasChildByCategoryId(Long categoryId);

    int selectNormalChildrenCategoryById(Long categoryId);

    int insertCategory(EduCategory category);

    int updateCategory(EduCategory category);

    int deleteCategoryById(Long categoryId);
}
