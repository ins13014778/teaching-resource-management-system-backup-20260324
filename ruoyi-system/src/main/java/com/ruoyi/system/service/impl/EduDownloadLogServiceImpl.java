package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.EduDownloadLog;
import com.ruoyi.system.mapper.EduDownloadLogMapper;
import com.ruoyi.system.service.IEduDownloadLogService;

@Service
public class EduDownloadLogServiceImpl implements IEduDownloadLogService
{
    @Autowired
    private EduDownloadLogMapper downloadLogMapper;

    @Override
    public List<EduDownloadLog> selectDownloadLogList(EduDownloadLog log)
    {
        if (!SecurityUtils.isAdmin())
        {
            log.setUserId(SecurityUtils.getUserId());
        }
        return downloadLogMapper.selectDownloadLogList(log);
    }

    @Override
    public int insertDownloadLog(EduDownloadLog log)
    {
        return downloadLogMapper.insertDownloadLog(log);
    }

    @Override
    public int deleteDownloadLogByIds(Long[] logIds)
    {
        return downloadLogMapper.deleteDownloadLogByIds(logIds);
    }
}
