package com.ruoyi.system.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduDownloadLog;
import com.ruoyi.system.domain.EduResource;
import com.ruoyi.system.domain.EduResourceAudit;
import com.ruoyi.system.mapper.EduCategoryMapper;
import com.ruoyi.system.mapper.EduCourseMapper;
import com.ruoyi.system.mapper.EduResourceAuditMapper;
import com.ruoyi.system.mapper.EduResourceMapper;
import com.ruoyi.system.mapper.EduTagMapper;
import com.ruoyi.system.mapper.EduTeacherStudentGrantMapper;
import com.ruoyi.system.service.IAiCapabilityService;
import com.ruoyi.system.service.IEduCategoryService;
import com.ruoyi.system.service.IEduDownloadLogService;
import com.ruoyi.system.service.IEduResourceService;

@Service
public class EduResourceServiceImpl implements IEduResourceService
{
    @Autowired
    private EduResourceMapper resourceMapper;

    @Autowired
    private EduResourceAuditMapper auditMapper;

    @Autowired
    private EduCategoryMapper categoryMapper;

    @Autowired
    private EduTagMapper tagMapper;

    @Autowired
    private EduCourseMapper courseMapper;

    @Autowired
    private EduTeacherStudentGrantMapper grantMapper;

    @Autowired
    private IEduCategoryService categoryService;

    @Autowired
    private IEduDownloadLogService downloadLogService;

    @Autowired
    private IAiCapabilityService aiCapabilityService;

    @Override
    public List<EduResource> selectResourceList(EduResource resource)
    {
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin())
        {
            resource.setUploaderId(SecurityUtils.getUserId());
        }
        if (SecurityUtils.hasRole("student") && !SecurityUtils.isAdmin())
        {
            resource.setAuditStatus("approved");
            resource.setPublishStatus("published");
        }
        return resourceMapper.selectResourceList(resource);
    }

    @Override
    public EduResource selectResourceById(Long resourceId)
    {
        EduResource resource = resourceMapper.selectResourceById(resourceId);
        checkResourcePermission(resource);
        return resource;
    }

    @Override
    public int insertResource(EduResource resource)
    {
        fillResourceOwner(resource);
        if (StringUtils.isEmpty(resource.getResourceVersion()))
        {
            resource.setResourceVersion("v1.0");
        }
        if (StringUtils.isEmpty(resource.getAuditStatus()))
        {
            resource.setAuditStatus("draft");
        }
        if (StringUtils.isEmpty(resource.getPublishStatus()))
        {
            resource.setPublishStatus("draft");
        }
        if (StringUtils.isEmpty(resource.getRecommendFlag()))
        {
            resource.setRecommendFlag("0");
        }
        if (resource.getFavoriteCount() == null)
        {
            resource.setFavoriteCount(0);
        }
        if (resource.getLikeCount() == null)
        {
            resource.setLikeCount(0);
        }
        int rows = resourceMapper.insertResource(resource);
        aiCapabilityService.runAutoTasks(resource.getResourceId(), "upload");
        return rows;
    }

    @Override
    public int updateResource(EduResource resource)
    {
        EduResource db = resourceMapper.selectResourceById(resource.getResourceId());
        checkResourcePermission(db);
        fillResourceOwner(resource);
        int rows = resourceMapper.updateResource(resource);
        aiCapabilityService.runAutoTasks(resource.getResourceId(), "update");
        return rows;
    }

    @Override
    public int deleteResourceByIds(Long[] resourceIds)
    {
        for (Long resourceId : resourceIds)
        {
            EduResource db = resourceMapper.selectResourceById(resourceId);
            checkResourcePermission(db);
        }
        return resourceMapper.deleteResourceByIds(resourceIds);
    }

    @Override
    @Transactional
    public int submitAudit(Long resourceId)
    {
        EduResource resource = resourceMapper.selectResourceById(resourceId);
        checkResourcePermission(resource);
        if (resource == null)
        {
            throw new ServiceException("资源不存在");
        }
        if ("review".equals(resource.getPublishStatus()))
        {
            throw new ServiceException("该资源已在审核中");
        }
        aiCapabilityService.runAutoTasks(resourceId, "pre_audit");
        EduResourceAudit pending = auditMapper.selectPendingAuditByResourceId(resourceId);
        if (pending != null)
        {
            throw new ServiceException("该资源存在待审核记录");
        }
        EduResourceAudit audit = new EduResourceAudit();
        audit.setResourceId(resource.getResourceId());
        audit.setResourceTitle(resource.getResourceTitle());
        audit.setAuditStatus("pending");
        audit.setAuditReason("提交审核");
        audit.setCreateBy(SecurityUtils.getUsername());
        auditMapper.insertAudit(audit);
        return resourceMapper.updateResourceStatus(resourceId, "pending", "review");
    }

    @Override
    public int updateRecommendFlag(Long resourceId, String recommendFlag)
    {
        EduResource resource = resourceMapper.selectResourceById(resourceId);
        if (resource == null)
        {
            throw new ServiceException("资源不存在");
        }
        return resourceMapper.updateRecommendFlag(resourceId, recommendFlag);
    }

    @Override
    public int incrementDownloadCount(Long resourceId)
    {
        EduResource resource = resourceMapper.selectResourceById(resourceId);
        if (resource == null)
        {
            throw new ServiceException("资源不存在");
        }
        checkResourcePermission(resource);
        EduDownloadLog log = new EduDownloadLog();
        log.setResourceId(resourceId);
        log.setResourceTitle(resource.getResourceTitle());
        log.setUserId(SecurityUtils.getUserId());
        log.setUserName(SecurityUtils.getUsername());
        log.setFileUrl(resource.getFileUrl());
        log.setCreateBy(SecurityUtils.getUsername());
        downloadLogService.insertDownloadLog(log);
        return resourceMapper.incrementDownloadCount(resourceId);
    }

    @Override
    public Map<String, Object> getFormOptions()
    {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("categories", categoryService.buildCategoryTree(categoryMapper.selectCategoryList(new com.ruoyi.system.domain.EduCategory())));
        result.put("tags", tagMapper.selectEnabledTagList());
        result.put("courses", courseMapper.selectEnabledCourseList());
        return result;
    }

    private void fillResourceOwner(EduResource resource)
    {
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin())
        {
            resource.setUploaderId(SecurityUtils.getUserId());
            resource.setUploaderName(SecurityUtils.getUsername());
        }
        else
        {
            if (StringUtils.isNull(resource.getUploaderId()))
            {
                resource.setUploaderId(SecurityUtils.getUserId());
            }
            if (StringUtils.isEmpty(resource.getUploaderName()))
            {
                resource.setUploaderName(SecurityUtils.getUsername());
            }
        }
    }

    private void checkResourcePermission(EduResource resource)
    {
        if (resource == null)
        {
            return;
        }
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin()
            && !resource.getUploaderId().equals(SecurityUtils.getUserId()))
        {
            throw new ServiceException("只能操作自己上传的资源");
        }
        if (SecurityUtils.hasRole("student") && !SecurityUtils.isAdmin())
        {
            if (!"approved".equals(resource.getAuditStatus()) || !"published".equals(resource.getPublishStatus()))
            {
                throw new ServiceException("当前资源尚未开放给学生访问");
            }
            List<String> courseNames = grantMapper.selectActiveCourseNamesByStudentId(SecurityUtils.getUserId());
            if (!courseNames.isEmpty() && StringUtils.isNotEmpty(resource.getCourseName()) && !courseNames.contains(resource.getCourseName()))
            {
                throw new ServiceException("您暂无该课程资源的访问权限");
            }
        }
    }
}
