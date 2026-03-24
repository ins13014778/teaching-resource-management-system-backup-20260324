package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduTeacherStudentGrant;
import com.ruoyi.system.mapper.EduTeacherStudentGrantMapper;
import com.ruoyi.system.service.IEduMessageService;
import com.ruoyi.system.service.IEduTeacherStudentGrantService;

@Service
public class EduTeacherStudentGrantServiceImpl implements IEduTeacherStudentGrantService
{
    @Autowired
    private EduTeacherStudentGrantMapper grantMapper;

    @Autowired
    private IEduMessageService messageService;

    @Override
    public List<EduTeacherStudentGrant> selectGrantList(EduTeacherStudentGrant grant)
    {
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin())
        {
            grant.setTeacherUserId(SecurityUtils.getUserId());
        }
        if (SecurityUtils.hasRole("student") && !SecurityUtils.isAdmin())
        {
            grant.setStudentUserId(SecurityUtils.getUserId());
        }
        return grantMapper.selectGrantList(grant);
    }

    @Override
    public EduTeacherStudentGrant selectGrantById(Long grantId)
    {
        return grantMapper.selectGrantById(grantId);
    }

    @Override
    public int insertGrant(EduTeacherStudentGrant grant)
    {
        normalizeGrantOwner(grant);
        grant.setCreateBy(SecurityUtils.getUsername());
        if (StringUtils.isEmpty(grant.getStatus()))
        {
            grant.setStatus("0");
        }
        int rows = grantMapper.insertGrant(grant);
        if (rows > 0)
        {
            sendGrantMessage(grant, "新增");
        }
        return rows;
    }

    @Override
    public int updateGrant(EduTeacherStudentGrant grant)
    {
        EduTeacherStudentGrant db = grantMapper.selectGrantById(grant.getGrantId());
        if (db == null)
        {
            throw new ServiceException("授权记录不存在");
        }
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin()
            && !SecurityUtils.getUserId().equals(db.getTeacherUserId()))
        {
            throw new ServiceException("只能修改自己发起的授权记录");
        }
        normalizeGrantOwner(grant);
        grant.setUpdateBy(SecurityUtils.getUsername());
        int rows = grantMapper.updateGrant(grant);
        if (rows > 0)
        {
            sendGrantMessage(grant, "更新");
        }
        return rows;
    }

    @Override
    public int deleteGrantByIds(Long[] grantIds)
    {
        return grantMapper.deleteGrantByIds(grantIds);
    }

    private void normalizeGrantOwner(EduTeacherStudentGrant grant)
    {
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin())
        {
            grant.setTeacherUserId(SecurityUtils.getUserId());
            if (StringUtils.isEmpty(grant.getTeacherName()))
            {
                grant.setTeacherName(SecurityUtils.getUsername());
            }
        }
    }

    private void sendGrantMessage(EduTeacherStudentGrant grant, String action)
    {
        if (grant.getStudentUserId() == null)
        {
            return;
        }
        StringBuilder content = new StringBuilder("课程资源授权已").append(action).append("。");
        if (StringUtils.isNotEmpty(grant.getCourseName()))
        {
            content.append("课程：").append(grant.getCourseName()).append("。");
        }
        if (StringUtils.isNotEmpty(grant.getGrantPerms()))
        {
            content.append("权限：").append(grant.getGrantPerms()).append("。");
        }
        messageService.sendMessage(
            grant.getStudentUserId(),
            grant.getStudentName(),
            "课程资源授权通知",
            content.toString(),
            "grant",
            grant.getGrantId());
    }
}
