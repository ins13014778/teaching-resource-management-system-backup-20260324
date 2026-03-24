package com.ruoyi.web.controller.edu;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.EduResourceAudit;
import com.ruoyi.system.service.IEduResourceAuditService;

@RestController
@RequestMapping("/edu/audit")
public class EduAuditController extends BaseController
{
    @Autowired
    private IEduResourceAuditService auditService;

    @PreAuthorize("@ss.hasPermi('edu:audit:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduResourceAudit audit)
    {
        startPage();
        List<EduResourceAudit> list = auditService.selectAuditList(audit);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:audit:query')")
    @GetMapping("/{auditId}")
    public AjaxResult getInfo(@PathVariable Long auditId)
    {
        return success(auditService.selectAuditById(auditId));
    }

    @PreAuthorize("@ss.hasPermi('edu:audit:pass')")
    @Log(title = "资源审核通过", businessType = BusinessType.UPDATE)
    @PutMapping("/pass")
    public AjaxResult pass(@RequestBody EduResourceAudit audit)
    {
        return toAjax(auditService.passAudit(audit));
    }

    @PreAuthorize("@ss.hasPermi('edu:audit:reject')")
    @Log(title = "资源审核驳回", businessType = BusinessType.UPDATE)
    @PutMapping("/reject")
    public AjaxResult reject(@RequestBody EduResourceAudit audit)
    {
        return toAjax(auditService.rejectAudit(audit));
    }

    @PreAuthorize("@ss.hasPermi('edu:audit:offline')")
    @Log(title = "资源下架", businessType = BusinessType.UPDATE)
    @PutMapping("/offline")
    public AjaxResult offline(@RequestBody EduResourceAudit audit)
    {
        return toAjax(auditService.offlineResource(audit));
    }
}
