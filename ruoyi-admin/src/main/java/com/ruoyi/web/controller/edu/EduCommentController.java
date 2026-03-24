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
import com.ruoyi.system.domain.EduComment;
import com.ruoyi.system.service.IEduCommentService;

@RestController
@RequestMapping("/edu/comment")
public class EduCommentController extends BaseController
{
    @Autowired
    private IEduCommentService commentService;

    @PreAuthorize("@ss.hasPermi('edu:comment:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduComment comment)
    {
        startPage();
        List<EduComment> list = commentService.selectCommentList(comment);
        return getDataTable(list);
    }

    @GetMapping("/resource/{resourceId}")
    public AjaxResult listByResource(@PathVariable Long resourceId)
    {
        return success(commentService.selectApprovedCommentsByResourceId(resourceId));
    }

    @PreAuthorize("@ss.hasPermi('edu:comment:query')")
    @GetMapping("/{commentId}")
    public AjaxResult getInfo(@PathVariable Long commentId)
    {
        return success(commentService.selectCommentById(commentId));
    }

    @Log(title = "资源评论", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduComment comment)
    {
        return toAjax(commentService.insertComment(comment));
    }

    @PreAuthorize("@ss.hasPermi('edu:comment:edit')")
    @Log(title = "资源评论", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduComment comment)
    {
        comment.setUpdateBy(getUsername());
        return toAjax(commentService.updateComment(comment));
    }

    @PreAuthorize("@ss.hasPermi('edu:comment:audit')")
    @Log(title = "评论审核", businessType = BusinessType.UPDATE)
    @PutMapping("/audit/{commentId}/{auditStatus}")
    public AjaxResult audit(@PathVariable Long commentId, @PathVariable String auditStatus, String remark)
    {
        return toAjax(commentService.auditComment(commentId, auditStatus, remark));
    }

    @PreAuthorize("@ss.hasPermi('edu:comment:remove')")
    @Log(title = "资源评论", businessType = BusinessType.DELETE)
    @DeleteMapping("/{commentIds}")
    public AjaxResult remove(@PathVariable Long[] commentIds)
    {
        return toAjax(commentService.deleteCommentByIds(commentIds));
    }
}
