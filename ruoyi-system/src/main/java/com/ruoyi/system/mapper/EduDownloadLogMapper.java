package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduDownloadLog;

public interface EduDownloadLogMapper
{
    List<EduDownloadLog> selectDownloadLogList(EduDownloadLog log);

    int insertDownloadLog(EduDownloadLog log);

    int deleteDownloadLogByIds(Long[] logIds);
}
