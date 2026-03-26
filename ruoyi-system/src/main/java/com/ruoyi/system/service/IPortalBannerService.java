package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.PortalBanner;

public interface IPortalBannerService
{
    PortalBanner selectBannerById(Long bannerId);

    List<PortalBanner> selectBannerList(PortalBanner banner);

    List<PortalBanner> selectEnabledBannerList();

    int insertBanner(PortalBanner banner);

    int updateBanner(PortalBanner banner);

    int deleteBannerByIds(Long[] bannerIds);
}
