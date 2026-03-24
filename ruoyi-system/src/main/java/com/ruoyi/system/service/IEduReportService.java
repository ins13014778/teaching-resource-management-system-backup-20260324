package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduReport;

public interface IEduReportService
{
    List<EduReport> selectReportList(EduReport report);

    EduReport selectReportById(Long reportId);

    int insertReport(EduReport report);

    int handleReport(EduReport report);

    int deleteReportByIds(Long[] reportIds);
}
