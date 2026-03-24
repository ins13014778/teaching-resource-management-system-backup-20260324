package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduComment;
import com.ruoyi.system.domain.EduResource;
import com.ruoyi.system.mapper.EduCommentMapper;
import com.ruoyi.system.mapper.EduResourceMapper;
import com.ruoyi.system.service.IEduCommentService;

@Service
public class EduCommentServiceImpl implements IEduCommentService
{
    @Autowired
    private EduCommentMapper commentMapper;

    @Autowired
    private EduResourceMapper resourceMapper;

    @Override
    public List<EduComment> selectCommentList(EduComment comment)
    {
        if (!SecurityUtils.isAdmin() && SecurityUtils.hasRole("student"))
        {
            comment.setUserId(SecurityUtils.getUserId());
        }
        return commentMapper.selectCommentList(comment);
    }

    @Override
    public EduComment selectCommentById(Long commentId)
    {
        return commentMapper.selectCommentById(commentId);
    }

    @Override
    public List<EduComment> selectApprovedCommentsByResourceId(Long resourceId)
    {
        List<EduComment> comments = commentMapper.selectApprovedCommentsByResourceId(resourceId);
        Map<Long, EduComment> commentMap = new LinkedHashMap<>();
        List<EduComment> roots = new ArrayList<>();
        for (EduComment comment : comments)
        {
            comment.setChildren(new ArrayList<>());
            commentMap.put(comment.getCommentId(), comment);
        }
        for (EduComment comment : comments)
        {
            if (comment.getParentId() != null && comment.getParentId() > 0 && commentMap.containsKey(comment.getParentId()))
            {
                commentMap.get(comment.getParentId()).getChildren().add(comment);
            }
            else
            {
                roots.add(comment);
            }
        }
        return roots;
    }

    @Override
    public int insertComment(EduComment comment)
    {
        EduResource resource = resourceMapper.selectResourceById(comment.getResourceId());
        if (resource == null)
        {
            throw new ServiceException("资源不存在");
        }
        comment.setResourceTitle(resource.getResourceTitle());
        comment.setUserId(SecurityUtils.getUserId());
        comment.setUserName(SecurityUtils.getUsername());
        if (comment.getParentId() == null)
        {
            comment.setParentId(0L);
        }
        else if (comment.getParentId() > 0)
        {
            EduComment parent = commentMapper.selectCommentById(comment.getParentId());
            if (parent != null)
            {
                comment.setParentUserName(parent.getUserName());
            }
        }
        if (comment.getLikeCount() == null)
        {
            comment.setLikeCount(0);
        }
        if (StringUtils.isEmpty(comment.getStatus()))
        {
            comment.setStatus("0");
        }
        if (StringUtils.isEmpty(comment.getAuditStatus()))
        {
            comment.setAuditStatus(SecurityUtils.isAdmin() ? "approved" : "pending");
        }
        comment.setCreateBy(SecurityUtils.getUsername());
        return commentMapper.insertComment(comment);
    }

    @Override
    public int updateComment(EduComment comment)
    {
        comment.setUpdateBy(SecurityUtils.getUsername());
        return commentMapper.updateComment(comment);
    }

    @Override
    public int deleteCommentByIds(Long[] commentIds)
    {
        return commentMapper.deleteCommentByIds(commentIds);
    }

    @Override
    public int auditComment(Long commentId, String auditStatus, String auditRemark)
    {
        return commentMapper.auditComment(commentId, auditStatus, auditRemark);
    }
}
