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
import com.ruoyi.system.domain.EduResourceLike;
import com.ruoyi.system.service.IEduResourceLikeService;

@RestController
@RequestMapping("/edu/like")
public class EduResourceLikeController extends BaseController
{
    @Autowired
    private IEduResourceLikeService likeService;

    @PreAuthorize("@ss.hasPermi('edu:like:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduResourceLike like)
    {
        startPage();
        List<EduResourceLike> list = likeService.selectLikeList(like);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:like:query')")
    @GetMapping("/{likeId}")
    public AjaxResult getInfo(@PathVariable Long likeId)
    {
        return success(likeService.selectLikeById(likeId));
    }

    @Log(title = "资源点赞", businessType = BusinessType.UPDATE)
    @PostMapping("/toggle/{resourceId}")
    public AjaxResult toggle(@PathVariable Long resourceId)
    {
        Map<String, Object> result = likeService.toggleLike(resourceId);
        return success(result);
    }

    @PreAuthorize("@ss.hasPermi('edu:like:remove')")
    @Log(title = "资源点赞", businessType = BusinessType.DELETE)
    @DeleteMapping("/{likeIds}")
    public AjaxResult remove(@PathVariable Long[] likeIds)
    {
        return toAjax(likeService.deleteLikeByIds(likeIds));
    }
}
