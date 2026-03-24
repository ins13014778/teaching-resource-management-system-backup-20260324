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
import com.ruoyi.system.domain.EduFeedback;
import com.ruoyi.system.service.IEduFeedbackService;

@RestController
@RequestMapping("/edu/feedback")
public class EduFeedbackController extends BaseController
{
    @Autowired
    private IEduFeedbackService feedbackService;

    @PreAuthorize("@ss.hasPermi('edu:feedback:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduFeedback feedback)
    {
        startPage();
        List<EduFeedback> list = feedbackService.selectFeedbackList(feedback);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:feedback:query')")
    @GetMapping("/{feedbackId}")
    public AjaxResult getInfo(@PathVariable Long feedbackId)
    {
        return success(feedbackService.selectFeedbackById(feedbackId));
    }

    @Log(title = "意见反馈", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduFeedback feedback)
    {
        return toAjax(feedbackService.insertFeedback(feedback));
    }

    @PreAuthorize("@ss.hasPermi('edu:feedback:reply')")
    @Log(title = "意见反馈回复", businessType = BusinessType.UPDATE)
    @PutMapping("/reply")
    public AjaxResult reply(@RequestBody EduFeedback feedback)
    {
        return toAjax(feedbackService.replyFeedback(feedback));
    }

    @PreAuthorize("@ss.hasPermi('edu:feedback:remove')")
    @Log(title = "意见反馈", businessType = BusinessType.DELETE)
    @DeleteMapping("/{feedbackIds}")
    public AjaxResult remove(@PathVariable Long[] feedbackIds)
    {
        return toAjax(feedbackService.deleteFeedbackByIds(feedbackIds));
    }
}
