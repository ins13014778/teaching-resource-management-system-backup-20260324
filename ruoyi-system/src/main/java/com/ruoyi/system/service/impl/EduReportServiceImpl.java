package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduReport;
import com.ruoyi.system.mapper.EduReportMapper;
import com.ruoyi.system.service.IEduMessageService;
import com.ruoyi.system.service.IEduReportService;

@Service
public class EduReportServiceImpl implements IEduReportService
{
    @Autowired
    private EduReportMapper reportMapper;

    @Autowired
    private IEduMessageService messageService;

    @Override
    public List<EduReport> selectReportList(EduReport report)
    {
        if (!SecurityUtils.isAdmin())
        {
            report.setReporterId(SecurityUtils.getUserId());
        }
        return reportMapper.selectReportList(report);
    }

    @Override
    public EduReport selectReportById(Long reportId)
    {
        return reportMapper.selectReportById(reportId);
    }

    @Override
    public int insertReport(EduReport report)
    {
        report.setReporterId(SecurityUtils.getUserId());
        report.setReporterName(SecurityUtils.getUsername());
        if (StringUtils.isEmpty(report.getStatus()))
        {
            report.setStatus("pending");
        }
        report.setCreateBy(SecurityUtils.getUsername());
        return reportMapper.insertReport(report);
    }

    @Override
    public int handleReport(EduReport report)
    {
        report.setHandlerId(SecurityUtils.getUserId());
        report.setHandlerName(SecurityUtils.getUsername());
        report.setUpdateBy(SecurityUtils.getUsername());
        int rows = reportMapper.updateReport(report);
        EduReport db = reportMapper.selectReportById(report.getReportId());
        if (db != null)
        {
            messageService.sendMessage(db.getReporterId(), db.getReporterName(), "举报处理通知", "您提交的举报《" + db.getTargetTitle() + "》已处理，处理结果：" + StringUtils.defaultIfBlank(report.getHandleResult(), db.getHandleResult()), "report", db.getReportId());
        }
        return rows;
    }

    @Override
    public int deleteReportByIds(Long[] reportIds)
    {
        return reportMapper.deleteReportByIds(reportIds);
    }
}
