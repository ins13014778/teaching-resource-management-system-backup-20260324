package com.ruoyi.system.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.EduGlobalConfig;
import com.ruoyi.system.mapper.EduGlobalConfigMapper;
import com.ruoyi.system.service.IEduGlobalConfigService;

@Service
public class EduGlobalConfigServiceImpl implements IEduGlobalConfigService
{
    @Autowired
    private EduGlobalConfigMapper configMapper;

    @Override
    public EduGlobalConfig selectCurrentConfig()
    {
        return configMapper.selectCurrentConfig();
    }

    @Override
    public int updateConfig(EduGlobalConfig config)
    {
        return configMapper.updateConfig(config);
    }
}
