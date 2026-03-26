package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.PortalSiteConfig;

public interface PortalSiteConfigMapper
{
    PortalSiteConfig selectCurrentConfig();

    PortalSiteConfig selectActiveConfig();

    int updateConfig(PortalSiteConfig config);
}
