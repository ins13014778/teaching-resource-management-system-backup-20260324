package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduComment;

public interface IEduCommentService
{
    List<EduComment> selectCommentList(EduComment comment);

    EduComment selectCommentById(Long commentId);

    List<EduComment> selectApprovedCommentsByResourceId(Long resourceId);

    int insertComment(EduComment comment);

    int updateComment(EduComment comment);

    int deleteCommentByIds(Long[] commentIds);

    int auditComment(Long commentId, String auditStatus, String auditRemark);
}
