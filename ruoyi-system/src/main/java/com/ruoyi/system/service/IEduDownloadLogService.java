package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduDownloadLog;

public interface IEduDownloadLogService
{
    List<EduDownloadLog> selectDownloadLogList(EduDownloadLog log);

    int insertDownloadLog(EduDownloadLog log);

    int deleteDownloadLogByIds(Long[] logIds);
}
