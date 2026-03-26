package com.ruoyi.web.controller.portal;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.PortalBanner;
import com.ruoyi.system.domain.PortalSiteConfig;
import com.ruoyi.system.domain.SysNotice;
import com.ruoyi.system.mapper.PortalStatsMapper;
import com.ruoyi.system.mapper.SysNoticeMapper;
import com.ruoyi.system.service.IPortalBannerService;
import com.ruoyi.system.service.IPortalSiteConfigService;
import com.ruoyi.system.service.ISysNoticeService;

/**
 * 官网公开门户
 */
@RestController
@RequestMapping("/portal")
public class PortalController extends BaseController
{
    @Autowired
    private ISysNoticeService noticeService;

    @Autowired
    private SysNoticeMapper noticeMapper;

    @Autowired
    private PortalStatsMapper portalStatsMapper;

    @Autowired
    private IPortalSiteConfigService siteConfigService;

    @Autowired
    private IPortalBannerService bannerService;

    /**
     * 官网首页概览
     */
    @Anonymous
    @GetMapping("/home/overview")
    public AjaxResult overview()
    {
        Map<String, Object> result = new LinkedHashMap<>();
        Map<String, Object> stats = new LinkedHashMap<>();
        stats.put("courseCount", portalStatsMapper.countCourses());
        stats.put("resourceCount", portalStatsMapper.countResources());
        stats.put("teacherCount", portalStatsMapper.countTeachers());
        stats.put("studentCount", portalStatsMapper.countStudents());
        stats.put("noticeCount", noticeMapper.countPublishedNotice());

        SysNotice query = new SysNotice();
        query.setStatus("0");
        List<SysNotice> latestNotices = noticeService.selectNoticeList(query);
        if (latestNotices.size() > 3)
        {
            latestNotices = latestNotices.subList(0, 3);
        }

        PortalSiteConfig config = siteConfigService.selectActiveConfig();
        if (config == null)
        {
            config = siteConfigService.selectCurrentConfig();
        }
        List<PortalBanner> banners = bannerService.selectEnabledBannerList();

        result.put("stats", stats);
        result.put("latestNotices", latestNotices);
        result.put("config", config);
        result.put("banners", banners);
        return AjaxResult.success(result);
    }

    /**
     * 官网基础配置
     */
    @Anonymous
    @GetMapping("/home/config")
    public AjaxResult config()
    {
        PortalSiteConfig config = siteConfigService.selectActiveConfig();
        if (config == null)
        {
            config = siteConfigService.selectCurrentConfig();
        }
        return AjaxResult.success(config);
    }

    /**
     * 官网公告列表
     */
    @Anonymous
    @GetMapping("/notices")
    public TableDataInfo notices(SysNotice notice)
    {
        notice.setStatus("0");
        startPage();
        List<SysNotice> list = noticeService.selectNoticeList(notice);
        return getDataTable(list);
    }

    /**
     * 官网公告详情
     */
    @Anonymous
    @GetMapping("/notices/{noticeId}")
    public AjaxResult noticeInfo(@PathVariable Long noticeId)
    {
        SysNotice notice = noticeService.selectNoticeById(noticeId);
        if (notice == null || !"0".equals(notice.getStatus()))
        {
            return AjaxResult.error("公告不存在或已下线");
        }
        return AjaxResult.success(notice);
    }
}
