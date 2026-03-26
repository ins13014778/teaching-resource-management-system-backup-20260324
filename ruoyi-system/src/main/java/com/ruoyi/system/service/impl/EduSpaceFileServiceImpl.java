package com.ruoyi.system.service.impl;

import java.math.BigDecimal;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduSpaceFile;
import com.ruoyi.system.domain.EduUserQuota;
import com.ruoyi.system.mapper.EduSpaceFileMapper;
import com.ruoyi.system.mapper.EduUserQuotaMapper;
import com.ruoyi.system.service.IEduSpaceFileService;

@Service
public class EduSpaceFileServiceImpl implements IEduSpaceFileService
{
    @Autowired
    private EduSpaceFileMapper spaceFileMapper;

    @Autowired
    private EduUserQuotaMapper quotaMapper;

    @Override
    public List<EduSpaceFile> selectSpaceFileList(EduSpaceFile spaceFile)
    {
        if (!SecurityUtils.isAdmin())
        {
            spaceFile.setOwnerUserId(SecurityUtils.getUserId());
        }
        return spaceFileMapper.selectSpaceFileList(spaceFile);
    }

    @Override
    public EduSpaceFile selectSpaceFileById(Long fileId)
    {
        EduSpaceFile file = spaceFileMapper.selectSpaceFileById(fileId);
        checkOwnerPermission(file);
        return file;
    }

    @Override
    @Transactional
    public int insertSpaceFile(EduSpaceFile spaceFile)
    {
        fillOwner(spaceFile);
        EduUserQuota quota = requireQuota(spaceFile.getOwnerUserId());
        validateQuota(quota, spaceFile);
        normalizeSpaceFile(spaceFile);
        int rows = spaceFileMapper.insertSpaceFile(spaceFile);
        if (rows > 0 && isActualFile(spaceFile))
        {
            quotaMapper.updateUsedStorageByUserId(spaceFile.getOwnerUserId(), spaceFile.getFileSizeMb());
        }
        return rows;
    }

    @Override
    public int updateSpaceFile(EduSpaceFile spaceFile)
    {
        EduSpaceFile db = spaceFileMapper.selectSpaceFileById(spaceFile.getFileId());
        checkOwnerPermission(db);
        if (db != null)
        {
            spaceFile.setOwnerUserId(db.getOwnerUserId());
            spaceFile.setOwnerName(db.getOwnerName());
            if (spaceFile.getParentId() == null)
            {
                spaceFile.setParentId(db.getParentId());
            }
            if (StringUtils.isEmpty(spaceFile.getTargetType()))
            {
                spaceFile.setTargetType(db.getTargetType());
            }
        }
        normalizeSpaceFile(spaceFile);
        return spaceFileMapper.updateSpaceFile(spaceFile);
    }

    @Override
    @Transactional
    public int deleteSpaceFileByIds(Long[] fileIds)
    {
        if (fileIds == null || fileIds.length == 0)
        {
            return 0;
        }
        BigDecimal released = BigDecimal.ZERO;
        Long ownerUserId = null;
        for (Long fileId : fileIds)
        {
            EduSpaceFile db = spaceFileMapper.selectSpaceFileById(fileId);
            checkOwnerPermission(db);
            if (db != null && isActualFile(db) && db.getFileSizeMb() != null)
            {
                released = released.add(db.getFileSizeMb());
                ownerUserId = db.getOwnerUserId();
            }
        }
        int rows = spaceFileMapper.deleteSpaceFileByIds(fileIds);
        if (rows > 0 && ownerUserId != null && released.compareTo(BigDecimal.ZERO) > 0)
        {
            quotaMapper.updateUsedStorageByUserId(ownerUserId, released.negate());
        }
        return rows;
    }

    private void fillOwner(EduSpaceFile spaceFile)
    {
        if (spaceFile.getOwnerUserId() == null)
        {
            spaceFile.setOwnerUserId(SecurityUtils.getUserId());
        }
        if (StringUtils.isEmpty(spaceFile.getOwnerName()))
        {
            spaceFile.setOwnerName(resolveOperator(null));
        }
        if (spaceFile.getParentId() == null)
        {
            spaceFile.setParentId(0L);
        }
        if (StringUtils.isEmpty(spaceFile.getCreateBy()))
        {
            spaceFile.setCreateBy(resolveOperator(spaceFile.getOwnerName()));
        }
    }

    private void normalizeSpaceFile(EduSpaceFile spaceFile)
    {
        if (StringUtils.isEmpty(spaceFile.getStatus()))
        {
            spaceFile.setStatus("0");
        }
        if (StringUtils.isEmpty(spaceFile.getTargetType()))
        {
            spaceFile.setTargetType("file");
        }
        if (!isActualFile(spaceFile))
        {
            spaceFile.setFileSizeMb(BigDecimal.ZERO);
            spaceFile.setStorageType(null);
            spaceFile.setStoragePath(null);
            spaceFile.setFileUrl(null);
            spaceFile.setPreviewUrl(null);
            spaceFile.setFileExt(null);
            spaceFile.setOriginalFileName(null);
        }
        else
        {
            if (spaceFile.getFileSizeMb() == null)
            {
                spaceFile.setFileSizeMb(BigDecimal.ZERO);
            }
            if (StringUtils.isEmpty(spaceFile.getPreviewUrl()))
            {
                spaceFile.setPreviewUrl(spaceFile.getFileUrl());
            }
            if (StringUtils.isEmpty(spaceFile.getOriginalFileName()))
            {
                spaceFile.setOriginalFileName(spaceFile.getFileName());
            }
            if (StringUtils.isEmpty(spaceFile.getStorageType()))
            {
                spaceFile.setStorageType("local");
            }
        }
    }

    private void validateQuota(EduUserQuota quota, EduSpaceFile spaceFile)
    {
        if (!"0".equals(quota.getStatus()) || !"0".equals(quota.getUserStatus()))
        {
            throw new ServiceException("当前账号已被停用，无法上传空间文件");
        }
        if (!isActualFile(spaceFile))
        {
            return;
        }
        BigDecimal fileSize = spaceFile.getFileSizeMb() == null ? BigDecimal.ZERO : spaceFile.getFileSizeMb();
        if (quota.getUploadMb() != null && fileSize.compareTo(BigDecimal.valueOf(quota.getUploadMb())) > 0)
        {
            throw new ServiceException("上传文件大小超过当前账号限制");
        }
        BigDecimal capacityMb = quota.getStorageGb() == null ? BigDecimal.ZERO
            : BigDecimal.valueOf(quota.getStorageGb()).multiply(BigDecimal.valueOf(1024));
        BigDecimal usedMb = quota.getUsedStorageMb() == null ? BigDecimal.ZERO : quota.getUsedStorageMb();
        if (usedMb.add(fileSize).compareTo(capacityMb) > 0)
        {
            throw new ServiceException("空间容量不足，请联系管理员扩容");
        }
    }

    private EduUserQuota requireQuota(Long userId)
    {
        EduUserQuota quota = quotaMapper.selectQuotaByUserId(userId);
        if (quota == null)
        {
            throw new ServiceException("当前账号未配置空间额度，请联系管理员");
        }
        return quota;
    }

    private boolean isActualFile(EduSpaceFile spaceFile)
    {
        return !"folder".equalsIgnoreCase(spaceFile.getTargetType());
    }

    private void checkOwnerPermission(EduSpaceFile file)
    {
        if (file == null)
        {
            return;
        }
        if (!SecurityUtils.isAdmin() && !file.getOwnerUserId().equals(SecurityUtils.getUserId()))
        {
            throw new ServiceException("只能操作自己的空间文件");
        }
    }

    private String resolveOperator(String fallback)
    {
        try
        {
            return SecurityUtils.getUsername();
        }
        catch (Exception ex)
        {
            return StringUtils.defaultIfEmpty(fallback, "system");
        }
    }
}
