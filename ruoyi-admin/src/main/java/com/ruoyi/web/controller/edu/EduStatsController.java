package com.ruoyi.web.controller.edu;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.service.IEduStatsService;

@RestController
@RequestMapping("/edu/stats")
public class EduStatsController extends BaseController
{
    @Autowired
    private IEduStatsService statsService;

    @PreAuthorize("@ss.hasPermi('edu:stats:view')")
    @GetMapping("/dashboard")
    public AjaxResult dashboard()
    {
        return success(statsService.getDashboardStats());
    }
}
