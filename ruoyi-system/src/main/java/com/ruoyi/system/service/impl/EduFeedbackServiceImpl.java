package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduFeedback;
import com.ruoyi.system.mapper.EduFeedbackMapper;
import com.ruoyi.system.service.IEduFeedbackService;
import com.ruoyi.system.service.IEduMessageService;

@Service
public class EduFeedbackServiceImpl implements IEduFeedbackService
{
    @Autowired
    private EduFeedbackMapper feedbackMapper;

    @Autowired
    private IEduMessageService messageService;

    @Override
    public List<EduFeedback> selectFeedbackList(EduFeedback feedback)
    {
        if (!SecurityUtils.isAdmin())
        {
            feedback.setUserId(SecurityUtils.getUserId());
        }
        return feedbackMapper.selectFeedbackList(feedback);
    }

    @Override
    public EduFeedback selectFeedbackById(Long feedbackId)
    {
        return feedbackMapper.selectFeedbackById(feedbackId);
    }

    @Override
    public int insertFeedback(EduFeedback feedback)
    {
        feedback.setUserId(SecurityUtils.getUserId());
        feedback.setUserName(SecurityUtils.getUsername());
        if (StringUtils.isEmpty(feedback.getStatus()))
        {
            feedback.setStatus("pending");
        }
        feedback.setCreateBy(SecurityUtils.getUsername());
        return feedbackMapper.insertFeedback(feedback);
    }

    @Override
    public int replyFeedback(EduFeedback feedback)
    {
        EduFeedback db = feedbackMapper.selectFeedbackById(feedback.getFeedbackId());
        feedback.setReplyBy(SecurityUtils.getUsername());
        feedback.setUpdateBy(SecurityUtils.getUsername());
        if (StringUtils.isEmpty(feedback.getStatus()))
        {
            feedback.setStatus("replied");
        }
        int rows = feedbackMapper.updateFeedback(feedback);
        if (db != null)
        {
            messageService.sendMessage(
                db.getUserId(),
                db.getUserName(),
                "反馈处理通知",
                "您提交的反馈《" + db.getTitle() + "》已收到回复：" + StringUtils.defaultIfBlank(feedback.getReplyContent(), "请进入系统查看详情"),
                "feedback",
                db.getFeedbackId());
        }
        return rows;
    }

    @Override
    public int deleteFeedbackByIds(Long[] feedbackIds)
    {
        return feedbackMapper.deleteFeedbackByIds(feedbackIds);
    }
}
