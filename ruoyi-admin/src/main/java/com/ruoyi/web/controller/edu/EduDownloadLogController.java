package com.ruoyi.web.controller.edu;

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
import com.ruoyi.system.domain.EduDownloadLog;
import com.ruoyi.system.service.IEduDownloadLogService;

@RestController
@RequestMapping("/edu/download")
public class EduDownloadLogController extends BaseController
{
    @Autowired
    private IEduDownloadLogService downloadLogService;

    @PreAuthorize("@ss.hasPermi('edu:download:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduDownloadLog log)
    {
        startPage();
        List<EduDownloadLog> list = downloadLogService.selectDownloadLogList(log);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:download:remove')")
    @Log(title = "下载日志", businessType = BusinessType.DELETE)
    @DeleteMapping("/{logIds}")
    public AjaxResult remove(@PathVariable Long[] logIds)
    {
        return toAjax(downloadLogService.deleteDownloadLogByIds(logIds));
    }
}
