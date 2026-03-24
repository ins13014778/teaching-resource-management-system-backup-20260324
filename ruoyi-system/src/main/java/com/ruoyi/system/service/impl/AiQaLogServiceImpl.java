package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.AiQaLog;
import com.ruoyi.system.mapper.AiQaLogMapper;
import com.ruoyi.system.service.IAiQaLogService;

@Service
public class AiQaLogServiceImpl implements IAiQaLogService
{
    @Autowired
    private AiQaLogMapper qaLogMapper;

    @Override
    public List<AiQaLog> selectQaLogList(AiQaLog log)
    {
        return qaLogMapper.selectQaLogList(log);
    }

    @Override
    public int insertQaLog(AiQaLog log)
    {
        return qaLogMapper.insertQaLog(log);
    }

    @Override
    public int deleteQaLogByIds(Long[] qaIds)
    {
        return qaLogMapper.deleteQaLogByIds(qaIds);
    }
}
