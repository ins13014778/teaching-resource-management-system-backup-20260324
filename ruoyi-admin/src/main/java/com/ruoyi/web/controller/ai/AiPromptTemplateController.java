package com.ruoyi.web.controller.ai;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiPromptTemplate;
import com.ruoyi.system.service.IAiPromptTemplateService;

@RestController
@RequestMapping("/ai/prompt")
public class AiPromptTemplateController extends BaseController
{
    @Autowired
    private IAiPromptTemplateService promptService;

    @PreAuthorize("@ss.hasPermi('ai:prompt:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiPromptTemplate prompt)
    {
        startPage();
        List<AiPromptTemplate> list = promptService.selectPromptList(prompt);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:prompt:query')")
    @GetMapping("/{templateId}")
    public AjaxResult getInfo(@PathVariable Long templateId)
    {
        return success(promptService.selectPromptById(templateId));
    }

    @PreAuthorize("@ss.hasPermi('ai:prompt:add')")
    @Log(title = "AI提示词", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AiPromptTemplate prompt)
    {
        prompt.setCreateBy(getUsername());
        return toAjax(promptService.insertPrompt(prompt));
    }

    @PreAuthorize("@ss.hasPermi('ai:prompt:edit')")
    @Log(title = "AI提示词", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AiPromptTemplate prompt)
    {
        prompt.setUpdateBy(getUsername());
        return toAjax(promptService.updatePrompt(prompt));
    }

    @PreAuthorize("@ss.hasPermi('ai:prompt:remove')")
    @Log(title = "AI提示词", businessType = BusinessType.DELETE)
    @DeleteMapping("/{templateIds}")
    public AjaxResult remove(@PathVariable Long[] templateIds)
    {
        return toAjax(promptService.deletePromptByIds(templateIds));
    }
}
