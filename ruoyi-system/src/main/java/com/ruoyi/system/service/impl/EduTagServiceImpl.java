package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduTag;
import com.ruoyi.system.mapper.EduTagMapper;
import com.ruoyi.system.service.IEduTagService;

@Service
public class EduTagServiceImpl implements IEduTagService
{
    @Autowired
    private EduTagMapper tagMapper;

    @Override
    public List<EduTag> selectTagList(EduTag tag)
    {
        return tagMapper.selectTagList(tag);
    }

    @Override
    public List<EduTag> selectEnabledTagList()
    {
        return tagMapper.selectEnabledTagList();
    }

    @Override
    public EduTag selectTagById(Long tagId)
    {
        return tagMapper.selectTagById(tagId);
    }

    @Override
    public boolean checkTagNameUnique(EduTag tag)
    {
        Long tagId = StringUtils.isNull(tag.getTagId()) ? -1L : tag.getTagId();
        EduTag info = tagMapper.checkTagNameUnique(tag.getTagName());
        return StringUtils.isNull(info) || info.getTagId().longValue() == tagId.longValue();
    }

    @Override
    public int insertTag(EduTag tag)
    {
        return tagMapper.insertTag(tag);
    }

    @Override
    public int updateTag(EduTag tag)
    {
        return tagMapper.updateTag(tag);
    }

    @Override
    public int deleteTagByIds(Long[] tagIds)
    {
        return tagMapper.deleteTagByIds(tagIds);
    }
}
