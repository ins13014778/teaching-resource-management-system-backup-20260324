package com.ruoyi.web.controller.edu;

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
import com.ruoyi.system.domain.EduGlobalConfig;
import com.ruoyi.system.service.IEduGlobalConfigService;

@RestController
@RequestMapping("/edu/config")
public class EduGlobalConfigController extends BaseController
{
    @Autowired
    private IEduGlobalConfigService configService;

    @PreAuthorize("@ss.hasPermi('edu:config:query')")
    @GetMapping("/current")
    public AjaxResult getCurrent()
    {
        return success(configService.selectCurrentConfig());
    }

    @PreAuthorize("@ss.hasPermi('edu:config:edit')")
    @Log(title = "空间策略", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduGlobalConfig config)
    {
        config.setUpdateBy(getUsername());
        return toAjax(configService.updateConfig(config));
    }
}
