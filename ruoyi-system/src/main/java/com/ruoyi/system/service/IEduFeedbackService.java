package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduFeedback;

public interface IEduFeedbackService
{
    List<EduFeedback> selectFeedbackList(EduFeedback feedback);

    EduFeedback selectFeedbackById(Long feedbackId);

    int insertFeedback(EduFeedback feedback);

    int replyFeedback(EduFeedback feedback);

    int deleteFeedbackByIds(Long[] feedbackIds);
}
