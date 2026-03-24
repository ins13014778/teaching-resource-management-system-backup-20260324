package com.ruoyi.web.controller.edu;

import java.util.List;
import java.util.Map;
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
import com.ruoyi.system.domain.EduResource;
import com.ruoyi.system.service.IEduResourceService;

@RestController
@RequestMapping("/edu/resource")
public class EduResourceController extends BaseController
{
    @Autowired
    private IEduResourceService resourceService;

    @PreAuthorize("@ss.hasPermi('edu:resource:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduResource resource)
    {
        startPage();
        List<EduResource> list = resourceService.selectResourceList(resource);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:resource:list')")
    @GetMapping("/formOptions")
    public AjaxResult formOptions()
    {
        Map<String, Object> result = resourceService.getFormOptions();
        return success(result);
    }

    @PreAuthorize("@ss.hasPermi('edu:resource:query')")
    @GetMapping("/{resourceId}")
    public AjaxResult getInfo(@PathVariable Long resourceId)
    {
        return success(resourceService.selectResourceById(resourceId));
    }

    @PreAuthorize("@ss.hasPermi('edu:resource:add')")
    @Log(title = "教学资源", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduResource resource)
    {
        resource.setCreateBy(getUsername());
        return toAjax(resourceService.insertResource(resource));
    }

    @PreAuthorize("@ss.hasPermi('edu:resource:edit')")
    @Log(title = "教学资源", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduResource resource)
    {
        resource.setUpdateBy(getUsername());
        return toAjax(resourceService.updateResource(resource));
    }

    @PreAuthorize("@ss.hasPermi('edu:resource:remove')")
    @Log(title = "教学资源", businessType = BusinessType.DELETE)
    @DeleteMapping("/{resourceIds}")
    public AjaxResult remove(@PathVariable Long[] resourceIds)
    {
        return toAjax(resourceService.deleteResourceByIds(resourceIds));
    }

    @PreAuthorize("@ss.hasPermi('edu:resource:audit')")
    @Log(title = "提交资源审核", businessType = BusinessType.UPDATE)
    @PostMapping("/submit/{resourceId}")
    public AjaxResult submit(@PathVariable Long resourceId)
    {
        return toAjax(resourceService.submitAudit(resourceId));
    }

    @PreAuthorize("@ss.hasPermi('edu:resource:recommend')")
    @Log(title = "资源推荐设置", businessType = BusinessType.UPDATE)
    @PutMapping("/recommend/{resourceId}/{recommendFlag}")
    public AjaxResult recommend(@PathVariable Long resourceId, @PathVariable String recommendFlag)
    {
        return toAjax(resourceService.updateRecommendFlag(resourceId, recommendFlag));
    }

    @PreAuthorize("@ss.hasPermi('edu:resource:query')")
    @PostMapping("/download/{resourceId}")
    public AjaxResult download(@PathVariable Long resourceId)
    {
        return toAjax(resourceService.incrementDownloadCount(resourceId));
    }
}
