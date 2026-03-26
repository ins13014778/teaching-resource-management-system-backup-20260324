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
import com.ruoyi.system.domain.EduSpaceFile;
import com.ruoyi.system.service.IEduSpaceFileService;

@RestController
@RequestMapping("/edu/space")
public class EduSpaceFileController extends BaseController
{
    @Autowired
    private IEduSpaceFileService spaceFileService;

    @PreAuthorize("@ss.hasPermi('edu:share:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduSpaceFile spaceFile)
    {
        startPage();
        List<EduSpaceFile> list = spaceFileService.selectSpaceFileList(spaceFile);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:share:query')")
    @GetMapping("/{fileId}")
    public AjaxResult getInfo(@PathVariable Long fileId)
    {
        return success(spaceFileService.selectSpaceFileById(fileId));
    }

    @PreAuthorize("@ss.hasPermi('edu:share:add')")
    @Log(title = "空间文件", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduSpaceFile spaceFile)
    {
        spaceFile.setCreateBy(getUsername());
        return toAjax(spaceFileService.insertSpaceFile(spaceFile));
    }

    @PreAuthorize("@ss.hasPermi('edu:share:edit')")
    @Log(title = "空间文件", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduSpaceFile spaceFile)
    {
        spaceFile.setUpdateBy(getUsername());
        return toAjax(spaceFileService.updateSpaceFile(spaceFile));
    }

    @PreAuthorize("@ss.hasPermi('edu:share:remove')")
    @Log(title = "空间文件", businessType = BusinessType.DELETE)
    @DeleteMapping("/{fileIds}")
    public AjaxResult remove(@PathVariable Long[] fileIds)
    {
        return toAjax(spaceFileService.deleteSpaceFileByIds(fileIds));
    }
}