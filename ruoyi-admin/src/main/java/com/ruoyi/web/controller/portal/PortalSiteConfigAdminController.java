package com.ruoyi.web.controller.portal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.PortalSiteConfig;
import com.ruoyi.system.service.IPortalSiteConfigService;

@RestController
@RequestMapping("/portal/admin/config")
public class PortalSiteConfigAdminController extends BaseController
{
    @Autowired
    private IPortalSiteConfigService configService;

    @PreAuthorize("@ss.hasPermi('portal:config:query')")
    @GetMapping("/current")
    public AjaxResult getCurrent()
    {
        return success(configService.selectCurrentConfig());
    }

    @PreAuthorize("@ss.hasPermi('portal:config:edit')")
    @Log(title = "官网配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody PortalSiteConfig config)
    {
        config.setUpdateBy(getUsername());
        return toAjax(configService.updateConfig(config));
    }
}
