package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AiQaLog;

public interface AiQaLogMapper
{
    List<AiQaLog> selectQaLogList(AiQaLog log);

    int insertQaLog(AiQaLog log);

    int deleteQaLogByIds(Long[] qaIds);
}
