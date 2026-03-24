package com.ruoyi.web.controller.edu;

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
import com.ruoyi.system.domain.EduReport;
import com.ruoyi.system.service.IEduReportService;

@RestController
@RequestMapping("/edu/report")
public class EduReportController extends BaseController
{
    @Autowired
    private IEduReportService reportService;

    @PreAuthorize("@ss.hasPermi('edu:report:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduReport report)
    {
        startPage();
        List<EduReport> list = reportService.selectReportList(report);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:report:query')")
    @GetMapping("/{reportId}")
    public AjaxResult getInfo(@PathVariable Long reportId)
    {
        return success(reportService.selectReportById(reportId));
    }

    @Log(title = "举报处理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduReport report)
    {
        return toAjax(reportService.insertReport(report));
    }

    @PreAuthorize("@ss.hasPermi('edu:report:handle')")
    @Log(title = "举报处理", businessType = BusinessType.UPDATE)
    @PutMapping("/handle")
    public AjaxResult handle(@RequestBody EduReport report)
    {
        return toAjax(reportService.handleReport(report));
    }

    @PreAuthorize("@ss.hasPermi('edu:report:remove')")
    @Log(title = "举报处理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{reportIds}")
    public AjaxResult remove(@PathVariable Long[] reportIds)
    {
        return toAjax(reportService.deleteReportByIds(reportIds));
    }
}
