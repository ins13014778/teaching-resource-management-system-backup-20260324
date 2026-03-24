package com.ruoyi.system.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.AiAuditResult;
import com.ruoyi.system.domain.AiEmbeddingIndex;
import com.ruoyi.system.domain.AiQaLog;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.domain.EduResource;
import com.ruoyi.system.mapper.AiEmbeddingIndexMapper;
import com.ruoyi.system.mapper.EduResourceMapper;
import com.ruoyi.system.service.IAiAuditResultService;
import com.ruoyi.system.service.IAiCapabilityService;
import com.ruoyi.system.service.IAiQaLogService;
import com.ruoyi.system.service.IAiTaskService;

@Service
public class AiCapabilityServiceImpl implements IAiCapabilityService
{
    private static final List<String> TEACHING_KEYWORDS = Arrays.asList(
        "教案", "课件", "试题", "答案", "实验", "习题", "教学", "课程",
        "课堂", "视频", "音频", "文档", "资源", "数学", "语文", "英语", "PPT", "物理", "Java", "Python");
    private static final List<String> RISK_KEYWORDS = Arrays.asList("涉政", "暴力", "色情", "赌博", "毒品", "违法");
    private static final List<String> AD_KEYWORDS = Arrays.asList("广告", "推广", "加微信", "二维码", "刷单", "返利");
    private static final List<String> COURSE_CANDIDATES = Arrays.asList("数学", "语文", "英语", "物理", "化学", "生物", "Java", "Python");

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private EduResourceMapper resourceMapper;

    @Autowired
    private IAiTaskService taskService;

    @Autowired
    private IAiAuditResultService auditResultService;

    @Autowired
    private IAiQaLogService qaLogService;

    @Autowired
    private AiEmbeddingIndexMapper embeddingIndexMapper;

    @Override
    public void runAutoTasks(Long resourceId, String scene)
    {
        EduResource resource = resourceMapper.selectResourceById(resourceId);
        if (resource == null)
        {
            return;
        }
        Map<String, Object> summary = generateSummary(resourceId);
        recordTask(resource, "summary", scene, summary, null);
        Map<String, Object> tags = generateTags(resourceId);
        recordTask(resource, "tags", scene, tags, null);
        Map<String, Object> classify = classifyResource(resourceId);
        recordTask(resource, "classify", scene, classify, null);
        Map<String, Object> ocr = ocrExtract(resourceId);
        recordTask(resource, "ocr", scene, ocr, null);
        AiAuditResult auditResult = auditResource(resourceId);
        recordTask(resource, "audit", scene, auditResult, null);
        updateIndex(resource, summary, tags);
    }

    @Override
    public Map<String, Object> generateSummary(Long resourceId)
    {
        EduResource resource = getResource(resourceId);
        StringBuilder summary = new StringBuilder();
        summary.append("资源《").append(resource.getResourceTitle()).append("》");
        if (StringUtils.isNotBlank(resource.getCourseName()))
        {
            summary.append("属于课程：").append(resource.getCourseName()).append("。 ");
        }
        if (StringUtils.isNotBlank(resource.getCategoryName()))
        {
            summary.append("分类为：").append(resource.getCategoryName()).append("。 ");
        }
        summary.append("资源类型：").append(StringUtils.defaultIfBlank(resource.getResourceType(), "未分类")).append("。 ");
        if (StringUtils.isNotBlank(resource.getResourceDesc()))
        {
            summary.append("资源简介：").append(truncate(resource.getResourceDesc(), 120)).append("。 ");
        }
        else
        {
            summary.append("当前资源暂未填写详细简介，建议补充内容说明以便检索与推荐。 ");
        }
        summary.append("适合用于").append(StringUtils.defaultIfBlank(resource.getCourseName(), "通用教学场景")).append("的备课、授课或学习参考。 ");
        summary.append("系统建议结合课程章节、教学目标与知识点标签进一步完善资料信息。 ");
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("resourceId", resourceId);
        result.put("summary", summary.toString());
        result.put("applicable", StringUtils.defaultIfBlank(resource.getCourseName(), "通用教学"));
        return result;
    }

    @Override
    public Map<String, Object> generateTags(Long resourceId)
    {
        EduResource resource = getResource(resourceId);
        LinkedHashSet<String> tags = new LinkedHashSet<>();
        if (StringUtils.isNotBlank(resource.getTagNames()))
        {
            Arrays.stream(resource.getTagNames().split(","))
                .map(String::trim)
                .filter(StringUtils::isNotBlank)
                .forEach(tags::add);
        }
        if (StringUtils.isNotBlank(resource.getCourseName()))
        {
            tags.add(resource.getCourseName());
        }
        if (StringUtils.isNotBlank(resource.getCategoryName()))
        {
            tags.add(resource.getCategoryName());
        }
        if (StringUtils.isNotBlank(resource.getResourceType()))
        {
            tags.add(resource.getResourceType());
        }
        String raw = buildRawText(resource).toLowerCase(Locale.ROOT);
        for (String keyword : TEACHING_KEYWORDS)
        {
            if (raw.contains(keyword.toLowerCase(Locale.ROOT)))
            {
                tags.add(keyword);
            }
        }
        if (raw.contains("教案"))
        {
            tags.add("教学设计");
        }
        if (raw.contains("试题"))
        {
            tags.add("题库练习");
        }
        if (raw.contains("视频") || raw.contains("录播"))
        {
            tags.add("视频课程");
        }
        if (raw.contains("ppt") || raw.contains("课件"))
        {
            tags.add("课堂课件");
        }
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("resourceId", resourceId);
        result.put("tags", new ArrayList<>(tags));
        return result;
    }

    @Override
    public Map<String, Object> classifyResource(Long resourceId)
    {
        EduResource resource = getResource(resourceId);
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("resourceId", resourceId);
        result.put("courseName", StringUtils.defaultIfBlank(resource.getCourseName(), inferValue(resource, COURSE_CANDIDATES, "通用课程")));
        result.put("categoryName", StringUtils.defaultIfBlank(resource.getCategoryName(), inferCategory(resource)));
        result.put("resourceType", StringUtils.defaultIfBlank(resource.getResourceType(), inferResourceType(resource)));
        result.put("grade", inferGrade(resource));
        return result;
    }

    @Override
    public Map<String, Object> ocrExtract(Long resourceId)
    {
        EduResource resource = getResource(resourceId);
        Map<String, Object> result = new LinkedHashMap<>();
        String desc = StringUtils.defaultIfBlank(resource.getResourceDesc(), resource.getResourceTitle());
        List<String> catalog = Arrays.stream(desc.split("[，,；;。\\n]+"))
            .map(String::trim)
            .filter(StringUtils::isNotBlank)
            .limit(5)
            .collect(Collectors.toList());
        result.put("resourceId", resourceId);
        result.put("title", resource.getResourceTitle());
        result.put("catalog", catalog);
        result.put("keywords", generateTags(resourceId).get("tags"));
        result.put("keyContent", truncate(desc, 160));
        result.put("source", StringUtils.defaultIfBlank(resource.getFileUrl(), "未上传文件"));
        return result;
    }

    @Override
    public AiAuditResult auditResource(Long resourceId)
    {
        EduResource resource = getResource(resourceId);
        String raw = buildRawText(resource);
        BigDecimal riskScore = BigDecimal.ZERO;
        Set<String> hitWords = new LinkedHashSet<>();
        for (String keyword : RISK_KEYWORDS)
        {
            if (raw.contains(keyword))
            {
                riskScore = riskScore.add(new BigDecimal("35"));
                hitWords.add(keyword);
            }
        }
        for (String keyword : AD_KEYWORDS)
        {
            if (raw.contains(keyword))
            {
                riskScore = riskScore.add(new BigDecimal("20"));
                hitWords.add(keyword);
            }
        }
        if (StringUtils.length(StringUtils.defaultString(resource.getResourceDesc())) < 15)
        {
            riskScore = riskScore.add(new BigDecimal("10"));
        }
        if (StringUtils.isBlank(resource.getFileUrl()))
        {
            riskScore = riskScore.add(new BigDecimal("15"));
        }
        BigDecimal duplicateScore = findDuplicateScore(resource);
        String complianceLevel;
        if (riskScore.compareTo(new BigDecimal("60")) >= 0)
        {
            complianceLevel = "high_risk";
        }
        else if (riskScore.compareTo(new BigDecimal("25")) >= 0 || duplicateScore.compareTo(new BigDecimal("70")) >= 0)
        {
            complianceLevel = "warning";
        }
        else
        {
            complianceLevel = "safe";
        }
        AiAuditResult result = new AiAuditResult();
        result.setResourceId(resourceId);
        result.setResourceTitle(resource.getResourceTitle());
        result.setRiskScore(riskScore.setScale(2, RoundingMode.HALF_UP));
        result.setDuplicateScore(duplicateScore.setScale(2, RoundingMode.HALF_UP));
        result.setComplianceLevel(complianceLevel);
        result.setHitWords(String.join(",", hitWords));
        result.setSuggestion(buildSuggestion(riskScore, duplicateScore, hitWords));
        result.setAuditSummary("AI审核：风险分=" + result.getRiskScore() + "，重复分=" + result.getDuplicateScore() + "，等级=" + complianceLevel);
        result.setStatus("done");
        result.setRawResult(toJsonSafe(buildAuditMap(result)));
        result.setCreateBy(getCurrentUserName());
        result.setUpdateBy(getCurrentUserName());
        auditResultService.saveAuditResult(result);
        return auditResultService.selectAuditResultByResourceId(resourceId);
    }

    @Override
    public List<Map<String, Object>> similarity(Long resourceId)
    {
        EduResource target = getResource(resourceId);
        List<EduResource> resources = resourceMapper.selectResourceList(new EduResource());
        List<Map<String, Object>> result = new ArrayList<>();
        for (EduResource item : resources)
        {
            if (item.getResourceId().equals(resourceId))
            {
                continue;
            }
            BigDecimal score = calculateSimilarity(target, item);
            if (score.compareTo(new BigDecimal("15")) < 0)
            {
                continue;
            }
            Map<String, Object> map = new LinkedHashMap<>();
            map.put("resourceId", item.getResourceId());
            map.put("resourceTitle", item.getResourceTitle());
            map.put("courseName", item.getCourseName());
            map.put("categoryName", item.getCategoryName());
            map.put("score", score.setScale(2, RoundingMode.HALF_UP));
            result.add(map);
        }
        result.sort((a, b) -> new BigDecimal(String.valueOf(b.get("score"))).compareTo(new BigDecimal(String.valueOf(a.get("score")))));
        return result.stream().limit(5).collect(Collectors.toList());
    }

    @Override
    public List<Map<String, Object>> semanticSearch(String keyword, String resourceType, String categoryName, String courseName, String orderBy)
    {
        EduResource query = new EduResource();
        query.setKeyword(keyword);
        query.setResourceType(resourceType);
        query.setCategoryName(categoryName);
        query.setCourseName(courseName);
        query.setOrderBy(StringUtils.defaultIfBlank(orderBy, "latest"));
        List<EduResource> base = resourceMapper.selectResourceList(query);
        List<Map<String, Object>> result = new ArrayList<>();
        for (EduResource item : base)
        {
            BigDecimal score = scoreKeyword(keyword, item);
            Map<String, Object> map = new LinkedHashMap<>();
            map.put("resourceId", item.getResourceId());
            map.put("resourceTitle", item.getResourceTitle());
            map.put("courseName", item.getCourseName());
            map.put("categoryName", item.getCategoryName());
            map.put("resourceType", item.getResourceType());
            map.put("fileUrl", item.getFileUrl());
            map.put("semanticScore", score.setScale(2, RoundingMode.HALF_UP));
            map.put("downloadCount", item.getDownloadCount());
            map.put("favoriteCount", item.getFavoriteCount());
            map.put("likeCount", item.getLikeCount());
            result.add(map);
        }
        result.sort((a, b) -> new BigDecimal(String.valueOf(b.get("semanticScore"))).compareTo(new BigDecimal(String.valueOf(a.get("semanticScore")))));
        return result.stream().limit(20).collect(Collectors.toList());
    }

    @Override
    public Map<String, Object> ask(String question)
    {
        long begin = System.currentTimeMillis();
        List<Map<String, Object>> refs = semanticSearch(question, null, null, null, "latest");
        List<Map<String, Object>> topRefs = refs.stream().limit(3).collect(Collectors.toList());
        String answer;
        if (topRefs.isEmpty())
        {
            answer = "暂未检索到与该问题高度相关的教学资源，建议更换关键词后再次尝试。";
        }
        else
        {
            List<String> titles = topRefs.stream().map(item -> String.valueOf(item.get("resourceTitle"))).collect(Collectors.toList());
            answer = "根据当前检索结果，建议优先查看《" + String.join("》《", titles) + "》，这些资源与您的问题较为相关，可作为备课或学习参考。";
        }
        AiQaLog log = new AiQaLog();
        try
        {
            log.setUserId(SecurityUtils.getUserId());
            log.setUserName(SecurityUtils.getUsername());
            log.setCreateBy(SecurityUtils.getUsername());
        }
        catch (Exception e)
        {
            log.setUserName("anonymous");
            log.setCreateBy("anonymous");
        }
        log.setQuestion(question);
        log.setAnswer(answer);
        log.setReferenceResourceIds(topRefs.stream().map(item -> String.valueOf(item.get("resourceId"))).collect(Collectors.joining(",")));
        log.setReferenceTitles(topRefs.stream().map(item -> String.valueOf(item.get("resourceTitle"))).collect(Collectors.joining(",")));
        log.setModelName("Local-Heuristic-AI");
        log.setCostMillis(System.currentTimeMillis() - begin);
        qaLogService.insertQaLog(log);
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("question", question);
        result.put("answer", answer);
        result.put("references", topRefs);
        return result;
    }

    @Override
    public List<EduResource> basicSearch(EduResource resource)
    {
        return resourceMapper.selectResourceList(resource);
    }

    private EduResource getResource(Long resourceId)
    {
        EduResource resource = resourceMapper.selectResourceById(resourceId);
        if (resource == null)
        {
            throw new ServiceException("资源不存在");
        }
        return resource;
    }

    private void recordTask(EduResource resource, String taskType, String scene, Object result, String error)
    {
        AiTask task = new AiTask();
        task.setTaskType(taskType);
        task.setResourceId(resource.getResourceId());
        task.setResourceTitle(resource.getResourceTitle());
        task.setTriggerScene(scene);
        task.setTaskStatus(StringUtils.isBlank(error) ? "success" : "failed");
        task.setResultJson(toJsonSafe(result));
        task.setErrorMsg(error);
        task.setStartTime(new Date());
        task.setFinishTime(new Date());
        task.setCreateBy(getCurrentUserName());
        taskService.insertTask(task);
    }

    private void updateIndex(EduResource resource, Map<String, Object> summary, Map<String, Object> tags)
    {
        AiEmbeddingIndex db = embeddingIndexMapper.selectByResourceId(resource.getResourceId());
        AiEmbeddingIndex index = db == null ? new AiEmbeddingIndex() : db;
        index.setResourceId(resource.getResourceId());
        index.setResourceTitle(resource.getResourceTitle());
        index.setKeywordText(String.join(",", castStringList(tags.get("tags"))));
        index.setSummaryText(String.valueOf(summary.get("summary")));
        if (db == null)
        {
            index.setCreateBy(getCurrentUserName());
            embeddingIndexMapper.insertIndex(index);
        }
        else
        {
            index.setUpdateBy(getCurrentUserName());
            embeddingIndexMapper.updateIndex(index);
        }
    }

    @SuppressWarnings("unchecked")
    private List<String> castStringList(Object source)
    {
        if (source instanceof List)
        {
            return ((List<Object>) source).stream().map(String::valueOf).collect(Collectors.toList());
        }
        return new ArrayList<>();
    }

    private String buildRawText(EduResource resource)
    {
        return String.join(" ", Arrays.asList(
            StringUtils.defaultString(resource.getResourceTitle()),
            StringUtils.defaultString(resource.getResourceDesc()),
            StringUtils.defaultString(resource.getTagNames()),
            StringUtils.defaultString(resource.getCourseName()),
            StringUtils.defaultString(resource.getCategoryName()),
            StringUtils.defaultString(resource.getFileUrl())));
    }

    private String truncate(String text, int max)
    {
        if (StringUtils.isBlank(text) || text.length() <= max)
        {
            return StringUtils.defaultString(text);
        }
        return text.substring(0, max) + "...";
    }

    private String inferCategory(EduResource resource)
    {
        String raw = buildRawText(resource);
        if (raw.contains("试题") || raw.contains("试卷"))
        {
            return "试题";
        }
        if (raw.contains("教案") || raw.contains("教学设计"))
        {
            return "教案";
        }
        if (raw.toLowerCase(Locale.ROOT).contains("ppt") || raw.contains("课件"))
        {
            return "课件";
        }
        return "文档";
    }

    private String inferResourceType(EduResource resource)
    {
        String raw = buildRawText(resource).toLowerCase(Locale.ROOT);
        if (raw.contains("ppt"))
        {
            return "PPT";
        }
        if (raw.contains("pdf"))
        {
            return "PDF";
        }
        if (raw.contains("doc") || raw.contains("word") || raw.contains("文档"))
        {
            return "Word";
        }
        if (raw.contains("xls") || raw.contains("excel"))
        {
            return "Excel";
        }
        if (raw.contains("mp4") || raw.contains("视频"))
        {
            return "视频文件";
        }
        return "PDF";
    }

    private String inferGrade(EduResource resource)
    {
        String raw = buildRawText(resource);
        if (raw.contains("小学") || raw.contains("一年级") || raw.contains("二年级"))
        {
            return "小学";
        }
        if (raw.contains("初中") || raw.contains("七年级") || raw.contains("八年级") || raw.contains("九年级"))
        {
            return "初中";
        }
        if (raw.contains("高中") || raw.contains("高一") || raw.contains("高二") || raw.contains("高三"))
        {
            return "高中";
        }
        if (raw.contains("大学") || raw.contains("高等数学") || raw.contains("专业课") || raw.contains("本科"))
        {
            return "大学";
        }
        return "通用";
    }

    private String inferValue(EduResource resource, List<String> candidates, String defaultValue)
    {
        String raw = buildRawText(resource);
        for (String candidate : candidates)
        {
            if (raw.contains(candidate))
            {
                return candidate;
            }
        }
        return defaultValue;
    }

    private BigDecimal findDuplicateScore(EduResource target)
    {
        List<EduResource> resources = resourceMapper.selectResourceList(new EduResource());
        BigDecimal max = BigDecimal.ZERO;
        for (EduResource item : resources)
        {
            if (item.getResourceId().equals(target.getResourceId()))
            {
                continue;
            }
            BigDecimal score = calculateSimilarity(target, item);
            if (score.compareTo(max) > 0)
            {
                max = score;
            }
        }
        return max;
    }

    private BigDecimal calculateSimilarity(EduResource a, EduResource b)
    {
        BigDecimal score = BigDecimal.ZERO;
        if (StringUtils.equalsIgnoreCase(StringUtils.defaultString(a.getCourseName()), StringUtils.defaultString(b.getCourseName()))
            && StringUtils.isNotBlank(a.getCourseName()))
        {
            score = score.add(new BigDecimal("20"));
        }
        if (StringUtils.equalsIgnoreCase(StringUtils.defaultString(a.getCategoryName()), StringUtils.defaultString(b.getCategoryName()))
            && StringUtils.isNotBlank(a.getCategoryName()))
        {
            score = score.add(new BigDecimal("15"));
        }
        Set<String> aTags = tokenizeForSet(a);
        Set<String> bTags = tokenizeForSet(b);
        if (!aTags.isEmpty() && !bTags.isEmpty())
        {
            Set<String> intersection = new HashSet<>(aTags);
            intersection.retainAll(bTags);
            Set<String> union = new HashSet<>(aTags);
            union.addAll(bTags);
            score = score.add(new BigDecimal(intersection.size() * 50.0 / union.size()));
        }
        if (StringUtils.containsIgnoreCase(StringUtils.defaultString(a.getResourceTitle()), StringUtils.defaultString(b.getResourceTitle()))
            || StringUtils.containsIgnoreCase(StringUtils.defaultString(b.getResourceTitle()), StringUtils.defaultString(a.getResourceTitle())))
        {
            score = score.add(new BigDecimal("20"));
        }
        return score.min(new BigDecimal("99"));
    }

    private Set<String> tokenizeForSet(EduResource resource)
    {
        String raw = buildRawText(resource).replaceAll("[^\\p{IsAlphabetic}\\p{IsDigit}\\u4e00-\\u9fa5]+", " ");
        Set<String> result = new LinkedHashSet<>();
        for (String item : raw.split("\\s+"))
        {
            if (StringUtils.isNotBlank(item) && item.length() > 1)
            {
                result.add(item.toLowerCase(Locale.ROOT));
            }
        }
        return result;
    }

    private BigDecimal scoreKeyword(String keyword, EduResource resource)
    {
        if (StringUtils.isBlank(keyword))
        {
            return new BigDecimal("50");
        }
        String raw = buildRawText(resource).toLowerCase(Locale.ROOT);
        BigDecimal score = BigDecimal.ZERO;
        String[] parts = keyword.toLowerCase(Locale.ROOT).split("[\\s,，；;。]+");
        if (parts.length == 0)
        {
            parts = new String[] { keyword.toLowerCase(Locale.ROOT) };
        }
        for (String part : parts)
        {
            if (StringUtils.isBlank(part))
            {
                continue;
            }
            if (StringUtils.containsIgnoreCase(StringUtils.defaultString(resource.getResourceTitle()), part))
            {
                score = score.add(new BigDecimal("35"));
            }
            if (StringUtils.containsIgnoreCase(StringUtils.defaultString(resource.getTagNames()), part))
            {
                score = score.add(new BigDecimal("20"));
            }
            if (StringUtils.containsIgnoreCase(StringUtils.defaultString(resource.getCourseName()), part))
            {
                score = score.add(new BigDecimal("15"));
            }
            if (StringUtils.containsIgnoreCase(StringUtils.defaultString(resource.getCategoryName()), part))
            {
                score = score.add(new BigDecimal("10"));
            }
            if (raw.contains(part))
            {
                score = score.add(new BigDecimal("8"));
            }
        }
        score = score.add(new BigDecimal(Math.min(15, safeInt(resource.getDownloadCount()) / 10)));
        score = score.add(new BigDecimal(Math.min(10, safeInt(resource.getFavoriteCount()) / 5)));
        score = score.add(new BigDecimal(Math.min(10, safeInt(resource.getLikeCount()) / 5)));
        return score;
    }

    private int safeInt(Integer value)
    {
        return value == null ? 0 : value;
    }

    private String buildSuggestion(BigDecimal riskScore, BigDecimal duplicateScore, Set<String> hitWords)
    {
        if (riskScore.compareTo(new BigDecimal("60")) >= 0)
        {
            return "检测到高风险内容，建议立即复核并重点检查以下命中词：" + String.join(",", hitWords) + "。";
        }
        if (duplicateScore.compareTo(new BigDecimal("70")) >= 0)
        {
            return "检测到较高重复风险，建议核对资源内容并避免重复上传。";
        }
        if (riskScore.compareTo(new BigDecimal("25")) >= 0)
        {
            return "资源存在一定风险，建议人工复核后再决定是否发布。";
        }
        return "资源整体风险较低，可继续进入人工复核或发布流程。";
    }

    private Map<String, Object> buildAuditMap(AiAuditResult result)
    {
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("riskScore", result.getRiskScore());
        map.put("duplicateScore", result.getDuplicateScore());
        map.put("complianceLevel", result.getComplianceLevel());
        map.put("hitWords", result.getHitWords());
        map.put("suggestion", result.getSuggestion());
        return map;
    }

    private String toJsonSafe(Object obj)
    {
        try
        {
            return objectMapper.writeValueAsString(obj);
        }
        catch (JsonProcessingException e)
        {
            return String.valueOf(obj);
        }
    }

    private String getCurrentUserName()
    {
        try
        {
            return SecurityUtils.getUsername();
        }
        catch (Exception e)
        {
            return "system";
        }
    }
}
