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
import com.ruoyi.system.domain.EduUserQuota;
import com.ruoyi.system.service.IEduUserQuotaService;

@RestController
@RequestMapping("/edu/quota")
public class EduUserQuotaController extends BaseController
{
    @Autowired
    private IEduUserQuotaService quotaService;

    @PreAuthorize("@ss.hasPermi('edu:quota:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduUserQuota quota)
    {
        startPage();
        List<EduUserQuota> list = quotaService.selectQuotaList(quota);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:quota:query')")
    @GetMapping("/{quotaId}")
    public AjaxResult getInfo(@PathVariable Long quotaId)
    {
        return success(quotaService.selectQuotaById(quotaId));
    }

    @PreAuthorize("@ss.hasPermi('edu:quota:edit')")
    @Log(title = "空间配额", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduUserQuota quota)
    {
        quota.setUpdateBy(getUsername());
        return toAjax(quotaService.updateQuota(quota));
    }
}
