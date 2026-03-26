package com.ruoyi.web.controller.portal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.PortalBanner;
import com.ruoyi.system.domain.PortalSiteConfig;
import com.ruoyi.system.domain.SysNotice;
import com.ruoyi.system.mapper.PortalStatsMapper;
import com.ruoyi.system.mapper.SysNoticeMapper;
import com.ruoyi.system.service.IPortalBannerService;
import com.ruoyi.system.service.IPortalSiteConfigService;
import com.ruoyi.system.service.ISysNoticeService;

@ExtendWith(MockitoExtension.class)
class PortalControllerTest
{
    @InjectMocks
    private PortalController controller;

    @Mock
    private ISysNoticeService noticeService;

    @Mock
    private SysNoticeMapper noticeMapper;

    @Mock
    private PortalStatsMapper portalStatsMapper;

    @Mock
    private IPortalSiteConfigService siteConfigService;

    @Mock
    private IPortalBannerService bannerService;

    @Test
    void overviewShouldIncludeConfigAndEnabledBanners()
    {
        PortalSiteConfig config = new PortalSiteConfig();
        config.setSiteName("教学资源管理系统");

        PortalBanner banner = new PortalBanner();
        banner.setBannerId(1L);
        banner.setBannerTitle("首页轮播");

        when(portalStatsMapper.countCourses()).thenReturn(12);
        when(portalStatsMapper.countResources()).thenReturn(34);
        when(portalStatsMapper.countTeachers()).thenReturn(5);
        when(portalStatsMapper.countStudents()).thenReturn(89);
        when(noticeMapper.countPublishedNotice()).thenReturn(6);
        when(siteConfigService.selectCurrentConfig()).thenReturn(config);
        when(bannerService.selectEnabledBannerList()).thenReturn(Collections.singletonList(banner));
        when(noticeService.selectNoticeList(any(SysNotice.class))).thenReturn(Arrays.asList(
            notice(1L, "公告一"),
            notice(2L, "公告二"),
            notice(3L, "公告三"),
            notice(4L, "公告四")));

        AjaxResult result = controller.overview();

        assertTrue(result.isSuccess());
        Map<String, Object> data = castData(result);
        assertSame(config, data.get("config"));
        assertEquals(1, ((List<?>) data.get("banners")).size());
        assertEquals(3, ((List<?>) data.get("latestNotices")).size());
        assertEquals(6, ((Map<?, ?>) data.get("stats")).get("noticeCount"));
    }

    @Test
    void configShouldReturnCurrentSiteConfig()
    {
        PortalSiteConfig config = new PortalSiteConfig();
        config.setSiteName("教学资源管理系统");
        when(siteConfigService.selectCurrentConfig()).thenReturn(config);

        AjaxResult result = controller.config();

        assertTrue(result.isSuccess());
        assertSame(config, result.get(AjaxResult.DATA_TAG));
    }

    private SysNotice notice(Long id, String title)
    {
        SysNotice notice = new SysNotice();
        notice.setNoticeId(id);
        notice.setNoticeTitle(title);
        notice.setStatus("0");
        return notice;
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> castData(AjaxResult result)
    {
        return (Map<String, Object>) result.get(AjaxResult.DATA_TAG);
    }
}
