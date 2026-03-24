package com.ruoyi.web.controller.edu;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.EduFavorite;
import com.ruoyi.system.service.IEduFavoriteService;

@RestController
@RequestMapping("/edu/favorite")
public class EduFavoriteController extends BaseController
{
    @Autowired
    private IEduFavoriteService favoriteService;

    @PreAuthorize("@ss.hasPermi('edu:favorite:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduFavorite favorite)
    {
        startPage();
        List<EduFavorite> list = favoriteService.selectFavoriteList(favorite);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:favorite:query')")
    @GetMapping("/{favoriteId}")
    public AjaxResult getInfo(@PathVariable Long favoriteId)
    {
        return success(favoriteService.selectFavoriteById(favoriteId));
    }

    @Log(title = "资源收藏", businessType = BusinessType.UPDATE)
    @PostMapping("/toggle/{resourceId}")
    public AjaxResult toggle(@PathVariable Long resourceId)
    {
        Map<String, Object> result = favoriteService.toggleFavorite(resourceId);
        return success(result);
    }

    @PreAuthorize("@ss.hasPermi('edu:favorite:remove')")
    @Log(title = "资源收藏", businessType = BusinessType.DELETE)
    @DeleteMapping("/{favoriteIds}")
    public AjaxResult remove(@PathVariable Long[] favoriteIds)
    {
        return toAjax(favoriteService.deleteFavoriteByIds(favoriteIds));
    }
}
