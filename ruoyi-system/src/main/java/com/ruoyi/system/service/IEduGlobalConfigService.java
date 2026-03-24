package com.ruoyi.system.service;

import com.ruoyi.system.domain.EduGlobalConfig;

public interface IEduGlobalConfigService
{
    EduGlobalConfig selectCurrentConfig();

    int updateConfig(EduGlobalConfig config);
}
