package com.ruoyi.web.controller.ai;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.EduResource;
import com.ruoyi.system.service.IAiCapabilityService;

@RestController
@RequestMapping("/ai")
public class AiCapabilityController extends BaseController
{
    @Autowired
    private IAiCapabilityService capabilityService;

    @GetMapping("/resource/summary/{resourceId}")
    public AjaxResult summary(@PathVariable Long resourceId)
    {
        return success(capabilityService.generateSummary(resourceId));
    }

    @GetMapping("/resource/tags/{resourceId}")
    public AjaxResult tags(@PathVariable Long resourceId)
    {
        return success(capabilityService.generateTags(resourceId));
    }

    @GetMapping("/resource/classify/{resourceId}")
    public AjaxResult classify(@PathVariable Long resourceId)
    {
        return success(capabilityService.classifyResource(resourceId));
    }

    @GetMapping("/resource/ocr/{resourceId}")
    public AjaxResult ocr(@PathVariable Long resourceId)
    {
        return success(capabilityService.ocrExtract(resourceId));
    }

    @GetMapping("/resource/audit/{resourceId}")
    public AjaxResult audit(@PathVariable Long resourceId)
    {
        return success(capabilityService.auditResource(resourceId));
    }

    @GetMapping("/resource/similarity/{resourceId}")
    public AjaxResult similarity(@PathVariable Long resourceId)
    {
        return success(capabilityService.similarity(resourceId));
    }

    @GetMapping("/search/semantic")
    public AjaxResult semantic(@RequestParam String keyword,
                               @RequestParam(required = false) String resourceType,
                               @RequestParam(required = false) String categoryName,
                               @RequestParam(required = false) String courseName,
                               @RequestParam(required = false) String orderBy)
    {
        return success(capabilityService.semanticSearch(keyword, resourceType, categoryName, courseName, orderBy));
    }

    @GetMapping("/search/basic")
    public AjaxResult basic(EduResource resource)
    {
        return success(capabilityService.basicSearch(resource));
    }
}
