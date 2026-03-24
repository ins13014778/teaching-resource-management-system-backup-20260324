package com.ruoyi.web.controller.ai;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiAuditResult;
import com.ruoyi.system.service.IAiAuditResultService;

@RestController
@RequestMapping("/ai/audit")
public class AiAuditResultController extends BaseController
{
    @Autowired
    private IAiAuditResultService auditResultService;

    @PreAuthorize("@ss.hasPermi('ai:audit:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiAuditResult result)
    {
        startPage();
        List<AiAuditResult> list = auditResultService.selectAuditResultList(result);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:audit:query')")
    @GetMapping("/{resultId}")
    public AjaxResult getInfo(@PathVariable Long resultId)
    {
        return success(auditResultService.selectAuditResultById(resultId));
    }

    @PreAuthorize("@ss.hasPermi('ai:audit:remove')")
    @Log(title = "AI审核结果", businessType = BusinessType.DELETE)
    @DeleteMapping("/{resultIds}")
    public AjaxResult remove(@PathVariable Long[] resultIds)
    {
        return toAjax(auditResultService.deleteAuditResultByIds(resultIds));
    }
}
