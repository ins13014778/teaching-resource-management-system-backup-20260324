package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduFeedback;

public interface EduFeedbackMapper
{
    List<EduFeedback> selectFeedbackList(EduFeedback feedback);

    EduFeedback selectFeedbackById(Long feedbackId);

    int insertFeedback(EduFeedback feedback);

    int updateFeedback(EduFeedback feedback);

    int deleteFeedbackByIds(Long[] feedbackIds);
}
