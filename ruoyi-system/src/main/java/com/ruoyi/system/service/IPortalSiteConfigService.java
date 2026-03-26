package com.ruoyi.system.service;

import com.ruoyi.system.domain.PortalSiteConfig;

public interface IPortalSiteConfigService
{
    PortalSiteConfig selectCurrentConfig();

    PortalSiteConfig selectActiveConfig();

    int updateConfig(PortalSiteConfig config);
}
