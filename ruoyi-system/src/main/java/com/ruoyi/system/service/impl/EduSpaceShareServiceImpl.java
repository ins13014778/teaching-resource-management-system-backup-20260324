package com.ruoyi.system.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduSpaceShare;
import com.ruoyi.system.domain.EduUserQuota;
import com.ruoyi.system.mapper.EduSpaceShareMapper;
import com.ruoyi.system.mapper.EduUserQuotaMapper;
import com.ruoyi.system.service.IEduSpaceShareService;

@Service
public class EduSpaceShareServiceImpl implements IEduSpaceShareService
{
    @Autowired
    private EduSpaceShareMapper shareMapper;

    @Autowired
    private EduUserQuotaMapper quotaMapper;

    @Override
    public List<EduSpaceShare> selectShareList(EduSpaceShare share)
    {
        if (!SecurityUtils.isAdmin())
        {
            share.setOwnerUserId(SecurityUtils.getUserId());
        }
        return shareMapper.selectShareList(share);
    }

    @Override
    public EduSpaceShare selectShareById(Long shareId)
    {
        EduSpaceShare share = shareMapper.selectShareById(shareId);
        checkOwnerPermission(share);
        return share;
    }

    @Override
    public int insertShare(EduSpaceShare share)
    {
        fillOwner(share);
        validateShare(share);
        return shareMapper.insertShare(share);
    }

    @Override
    public int updateShare(EduSpaceShare share)
    {
        EduSpaceShare db = shareMapper.selectShareById(share.getShareId());
        checkOwnerPermission(db);
        if (db != null)
        {
            share.setOwnerUserId(db.getOwnerUserId());
            share.setOwnerName(db.getOwnerName());
            if (StringUtils.isEmpty(share.getCreateBy()))
            {
                share.setCreateBy(db.getCreateBy());
            }
        }
        validateShare(share);
        return shareMapper.updateShare(share);
    }

    @Override
    public int deleteShareByIds(Long[] shareIds)
    {
        if (shareIds != null)
        {
            for (Long shareId : shareIds)
            {
                checkOwnerPermission(shareMapper.selectShareById(shareId));
            }
        }
        return shareMapper.deleteShareByIds(shareIds);
    }

    private void fillOwner(EduSpaceShare share)
    {
        if (share.getOwnerUserId() == null)
        {
            share.setOwnerUserId(SecurityUtils.getUserId());
        }
        if (StringUtils.isEmpty(share.getOwnerName()))
        {
            share.setOwnerName(resolveOperator(null));
        }
        if (StringUtils.isEmpty(share.getStatus()))
        {
            share.setStatus("0");
        }
        if (share.getDownloadLimit() == null)
        {
            share.setDownloadLimit(0);
        }
        if (share.getDownloadCount() == null)
        {
            share.setDownloadCount(0);
        }
        if (share.getViewCount() == null)
        {
            share.setViewCount(0);
        }
        if (StringUtils.isEmpty(share.getCreateBy()))
        {
            share.setCreateBy(resolveOperator(share.getOwnerName()));
        }
    }

    private void validateShare(EduSpaceShare share)
    {
        EduUserQuota quota = quotaMapper.selectQuotaByUserId(share.getOwnerUserId());
        if (quota == null)
        {
            throw new ServiceException("当前账号未配置空间额度，请联系管理员");
        }
        if (!"0".equals(quota.getStatus()) || !"0".equals(quota.getUserStatus()))
        {
            throw new ServiceException("当前账号已被停用，无法创建分享");
        }
        if ("1".equals(quota.getAllowShare()))
        {
            throw new ServiceException("当前账号已被禁止创建分享");
        }
        if ("password".equalsIgnoreCase(share.getShareMode()))
        {
            if ("1".equals(quota.getAllowPasswordShare()))
            {
                throw new ServiceException("当前账号已被禁止密码分享");
            }
            if (StringUtils.isEmpty(share.getSharePassword()))
            {
                throw new ServiceException("密码分享必须设置提取码");
            }
        }
        else
        {
            share.setSharePassword(null);
        }
        if (share.getExpireTime() != null && quota.getMaxShareDays() != null)
        {
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.DAY_OF_YEAR, quota.getMaxShareDays());
            Date maxExpireTime = calendar.getTime();
            if (share.getExpireTime().after(maxExpireTime))
            {
                throw new ServiceException("分享有效期超过当前账号允许的最大天数");
            }
        }
    }

    private void checkOwnerPermission(EduSpaceShare share)
    {
        if (share == null)
        {
            return;
        }
        if (!SecurityUtils.isAdmin() && !share.getOwnerUserId().equals(SecurityUtils.getUserId()))
        {
            throw new ServiceException("只能操作自己的分享记录");
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
