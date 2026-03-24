package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.EduGlobalConfig;

public interface EduGlobalConfigMapper
{
    EduGlobalConfig selectCurrentConfig();

    int updateConfig(EduGlobalConfig config);
}
