package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduTag;

public interface EduTagMapper
{
    List<EduTag> selectTagList(EduTag tag);

    List<EduTag> selectEnabledTagList();

    EduTag selectTagById(Long tagId);

    EduTag checkTagNameUnique(String tagName);

    int insertTag(EduTag tag);

    int updateTag(EduTag tag);

    int deleteTagByIds(Long[] tagIds);
}
