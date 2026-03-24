package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduCategory;

public interface EduCategoryMapper
{
    List<EduCategory> selectCategoryList(EduCategory category);

    EduCategory selectCategoryById(Long categoryId);

    EduCategory checkCategoryNameUnique(EduCategory category);

    List<EduCategory> selectChildrenCategoryById(Long categoryId);

    int selectNormalChildrenCategoryById(Long categoryId);

    int hasChildByCategoryId(Long categoryId);

    int insertCategory(EduCategory category);

    int updateCategory(EduCategory category);

    int updateCategoryChildren(List<EduCategory> categories);

    int deleteCategoryById(Long categoryId);
}
