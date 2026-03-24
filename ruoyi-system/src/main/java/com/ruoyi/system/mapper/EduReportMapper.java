package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduReport;

public interface EduReportMapper
{
    List<EduReport> selectReportList(EduReport report);

    EduReport selectReportById(Long reportId);

    int insertReport(EduReport report);

    int updateReport(EduReport report);

    int deleteReportByIds(Long[] reportIds);
}
