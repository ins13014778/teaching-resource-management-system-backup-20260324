package com.ruoyi.system.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.PortalSiteConfig;
import com.ruoyi.system.mapper.PortalSiteConfigMapper;
import com.ruoyi.system.service.IPortalSiteConfigService;

@Service
public class PortalSiteConfigServiceImpl implements IPortalSiteConfigService
{
    @Autowired
    private PortalSiteConfigMapper configMapper;

    @Override
    public PortalSiteConfig selectCurrentConfig()
    {
        return configMapper.selectCurrentConfig();
    }

    @Override
    public PortalSiteConfig selectActiveConfig()
    {
        return configMapper.selectActiveConfig();
    }

    @Override
    public int updateConfig(PortalSiteConfig config)
    {
        return configMapper.updateConfig(config);
    }
}
