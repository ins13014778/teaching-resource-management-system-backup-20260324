package com.ruoyi.web.controller.portal;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.PortalBanner;
import com.ruoyi.system.service.IPortalBannerService;

@RestController
@RequestMapping("/portal/admin/banner")
public class PortalBannerAdminController extends BaseController
{
    @Autowired
    private IPortalBannerService bannerService;

    @PreAuthorize("@ss.hasPermi('portal:banner:list')")
    @GetMapping("/list")
    public TableDataInfo list(PortalBanner banner)
    {
        startPage();
        List<PortalBanner> list = bannerService.selectBannerList(banner);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('portal:banner:query')")
    @GetMapping("/{bannerId}")
    public AjaxResult getInfo(@PathVariable Long bannerId)
    {
        return success(bannerService.selectBannerById(bannerId));
    }

    @PreAuthorize("@ss.hasPermi('portal:banner:add')")
    @Log(title = "官网轮播图", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody PortalBanner banner)
    {
        banner.setCreateBy(getUsername());
        return toAjax(bannerService.insertBanner(banner));
    }

    @PreAuthorize("@ss.hasPermi('portal:banner:edit')")
    @Log(title = "官网轮播图", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody PortalBanner banner)
    {
        banner.setUpdateBy(getUsername());
        return toAjax(bannerService.updateBanner(banner));
    }

    @PreAuthorize("@ss.hasPermi('portal:banner:remove')")
    @Log(title = "官网轮播图", businessType = BusinessType.DELETE)
    @DeleteMapping("/{bannerIds}")
    public AjaxResult remove(@PathVariable Long[] bannerIds)
    {
        return toAjax(bannerService.deleteBannerByIds(bannerIds));
    }
}
