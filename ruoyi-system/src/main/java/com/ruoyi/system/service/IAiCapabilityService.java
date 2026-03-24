package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.AiAuditResult;
import com.ruoyi.system.domain.EduResource;

public interface IAiCapabilityService
{
    void runAutoTasks(Long resourceId, String scene);

    Map<String, Object> generateSummary(Long resourceId);

    Map<String, Object> generateTags(Long resourceId);

    Map<String, Object> classifyResource(Long resourceId);

    Map<String, Object> ocrExtract(Long resourceId);

    AiAuditResult auditResource(Long resourceId);

    List<Map<String, Object>> similarity(Long resourceId);

    List<Map<String, Object>> semanticSearch(String keyword, String resourceType, String categoryName, String courseName, String orderBy);

    Map<String, Object> ask(String question);

    List<EduResource> basicSearch(EduResource resource);
}
