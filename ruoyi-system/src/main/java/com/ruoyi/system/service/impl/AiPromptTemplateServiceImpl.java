package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.AiPromptTemplate;
import com.ruoyi.system.mapper.AiPromptTemplateMapper;
import com.ruoyi.system.service.IAiPromptTemplateService;

@Service
public class AiPromptTemplateServiceImpl implements IAiPromptTemplateService
{
    @Autowired
    private AiPromptTemplateMapper promptMapper;

    @Override
    public List<AiPromptTemplate> selectPromptList(AiPromptTemplate prompt)
    {
        return promptMapper.selectPromptList(prompt);
    }

    @Override
    public AiPromptTemplate selectPromptById(Long templateId)
    {
        return promptMapper.selectPromptById(templateId);
    }

    @Override
    public AiPromptTemplate selectPromptByKey(String templateKey)
    {
        return promptMapper.selectPromptByKey(templateKey);
    }

    @Override
    public int insertPrompt(AiPromptTemplate prompt)
    {
        return promptMapper.insertPrompt(prompt);
    }

    @Override
    public int updatePrompt(AiPromptTemplate prompt)
    {
        return promptMapper.updatePrompt(prompt);
    }

    @Override
    public int deletePromptByIds(Long[] templateIds)
    {
        return promptMapper.deletePromptByIds(templateIds);
    }
}
