package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.AiPromptTemplate;

public interface IAiPromptTemplateService
{
    List<AiPromptTemplate> selectPromptList(AiPromptTemplate prompt);

    AiPromptTemplate selectPromptById(Long templateId);

    AiPromptTemplate selectPromptByKey(String templateKey);

    int insertPrompt(AiPromptTemplate prompt);

    int updatePrompt(AiPromptTemplate prompt);

    int deletePromptByIds(Long[] templateIds);
}
