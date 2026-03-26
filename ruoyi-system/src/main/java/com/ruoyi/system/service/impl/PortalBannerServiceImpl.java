package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.PortalBanner;
import com.ruoyi.system.mapper.PortalBannerMapper;
import com.ruoyi.system.service.IPortalBannerService;

@Service
public class PortalBannerServiceImpl implements IPortalBannerService
{
    @Autowired
    private PortalBannerMapper bannerMapper;

    @Override
    public PortalBanner selectBannerById(Long bannerId)
    {
        return bannerMapper.selectBannerById(bannerId);
    }

    @Override
    public List<PortalBanner> selectBannerList(PortalBanner banner)
    {
        return bannerMapper.selectBannerList(banner);
    }

    @Override
    public List<PortalBanner> selectEnabledBannerList()
    {
        return bannerMapper.selectEnabledBannerList();
    }

    @Override
    public int insertBanner(PortalBanner banner)
    {
        return bannerMapper.insertBanner(banner);
    }

    @Override
    public int updateBanner(PortalBanner banner)
    {
        return bannerMapper.updateBanner(banner);
    }

    @Override
    public int deleteBannerByIds(Long[] bannerIds)
    {
        return bannerMapper.deleteBannerByIds(bannerIds);
    }
}
