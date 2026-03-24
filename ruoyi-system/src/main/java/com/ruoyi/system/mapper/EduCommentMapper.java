package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.EduComment;

public interface EduCommentMapper
{
    List<EduComment> selectCommentList(EduComment comment);

    EduComment selectCommentById(Long commentId);

    List<EduComment> selectApprovedCommentsByResourceId(Long resourceId);

    int insertComment(EduComment comment);

    int updateComment(EduComment comment);

    int deleteCommentByIds(Long[] commentIds);

    int auditComment(@Param("commentId") Long commentId, @Param("auditStatus") String auditStatus, @Param("remark") String remark);
}
