package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.AiQaLog;

public interface IAiQaLogService
{
    List<AiQaLog> selectQaLogList(AiQaLog log);

    int insertQaLog(AiQaLog log);

    int deleteQaLogByIds(Long[] qaIds);
}
