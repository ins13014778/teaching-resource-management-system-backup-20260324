package com.ruoyi.web.controller.edu;

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
import com.ruoyi.system.domain.EduSpaceShare;
import com.ruoyi.system.service.IEduSpaceShareService;

@RestController
@RequestMapping("/edu/share")
public class EduSpaceShareController extends BaseController
{
    @Autowired
    private IEduSpaceShareService shareService;

    @PreAuthorize("@ss.hasPermi('edu:share:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduSpaceShare share)
    {
        startPage();
        List<EduSpaceShare> list = shareService.selectShareList(share);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:share:query')")
    @GetMapping("/{shareId}")
    public AjaxResult getInfo(@PathVariable Long shareId)
    {
        return success(shareService.selectShareById(shareId));
    }

    @PreAuthorize("@ss.hasPermi('edu:share:add')")
    @Log(title = "空间分享", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduSpaceShare share)
    {
        share.setCreateBy(getUsername());
        return toAjax(shareService.insertShare(share));
    }

    @PreAuthorize("@ss.hasPermi('edu:share:edit')")
    @Log(title = "空间分享", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduSpaceShare share)
    {
        share.setUpdateBy(getUsername());
        return toAjax(shareService.updateShare(share));
    }

    @PreAuthorize("@ss.hasPermi('edu:share:remove')")
    @Log(title = "空间分享", businessType = BusinessType.DELETE)
    @DeleteMapping("/{shareIds}")
    public AjaxResult remove(@PathVariable Long[] shareIds)
    {
        return toAjax(shareService.deleteShareByIds(shareIds));
    }
}
