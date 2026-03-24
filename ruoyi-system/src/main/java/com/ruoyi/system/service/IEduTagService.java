package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduTag;

public interface IEduTagService
{
    List<EduTag> selectTagList(EduTag tag);

    List<EduTag> selectEnabledTagList();

    EduTag selectTagById(Long tagId);

    boolean checkTagNameUnique(EduTag tag);

    int insertTag(EduTag tag);

    int updateTag(EduTag tag);

    int deleteTagByIds(Long[] tagIds);
}
