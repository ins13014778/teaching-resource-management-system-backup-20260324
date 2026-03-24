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
import com.ruoyi.system.domain.EduTeacherStudentGrant;
import com.ruoyi.system.service.IEduTeacherStudentGrantService;

@RestController
@RequestMapping("/edu/grant")
public class EduTeacherStudentGrantController extends BaseController
{
    @Autowired
    private IEduTeacherStudentGrantService grantService;

    @PreAuthorize("@ss.hasPermi('edu:grant:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduTeacherStudentGrant grant)
    {
        startPage();
        List<EduTeacherStudentGrant> list = grantService.selectGrantList(grant);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:grant:query')")
    @GetMapping("/{grantId}")
    public AjaxResult getInfo(@PathVariable Long grantId)
    {
        return success(grantService.selectGrantById(grantId));
    }

    @PreAuthorize("@ss.hasPermi('edu:grant:add')")
    @Log(title = "资源授权", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduTeacherStudentGrant grant)
    {
        grant.setCreateBy(getUsername());
        return toAjax(grantService.insertGrant(grant));
    }

    @PreAuthorize("@ss.hasPermi('edu:grant:edit')")
    @Log(title = "资源授权", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduTeacherStudentGrant grant)
    {
        grant.setUpdateBy(getUsername());
        return toAjax(grantService.updateGrant(grant));
    }

    @PreAuthorize("@ss.hasPermi('edu:grant:remove')")
    @Log(title = "资源授权", businessType = BusinessType.DELETE)
    @DeleteMapping("/{grantIds}")
    public AjaxResult remove(@PathVariable Long[] grantIds)
    {
        return toAjax(grantService.deleteGrantByIds(grantIds));
    }
}
