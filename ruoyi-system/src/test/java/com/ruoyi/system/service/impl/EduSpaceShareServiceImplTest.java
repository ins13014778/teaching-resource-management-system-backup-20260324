package com.ruoyi.system.service.impl;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Calendar;
import java.util.Date;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.EduSpaceShare;
import com.ruoyi.system.domain.EduUserQuota;
import com.ruoyi.system.mapper.EduSpaceShareMapper;
import com.ruoyi.system.mapper.EduUserQuotaMapper;

@ExtendWith(MockitoExtension.class)
class EduSpaceShareServiceImplTest
{
    @InjectMocks
    private EduSpaceShareServiceImpl service;

    @Mock
    private EduSpaceShareMapper shareMapper;

    @Mock
    private EduUserQuotaMapper quotaMapper;

    @Test
    void insertShareShouldRejectWhenShareDisabled()
    {
        EduSpaceShare share = buildShare("public", null, 3);
        EduUserQuota quota = buildQuota();
        quota.setAllowShare("1");
        when(quotaMapper.selectQuotaByUserId(share.getOwnerUserId())).thenReturn(quota);

        ServiceException ex = assertThrows(ServiceException.class, () -> service.insertShare(share));

        assertEquals("当前账号已被禁止创建分享", ex.getMessage());
    }

    @Test
    void insertShareShouldRejectPasswordShareWhenQuotaDisallows()
    {
        EduSpaceShare share = buildShare("password", "abcd", 3);
        EduUserQuota quota = buildQuota();
        quota.setAllowPasswordShare("1");
        when(quotaMapper.selectQuotaByUserId(share.getOwnerUserId())).thenReturn(quota);

        ServiceException ex = assertThrows(ServiceException.class, () -> service.insertShare(share));

        assertEquals("当前账号已被禁止密码分享", ex.getMessage());
    }

    @Test
    void insertShareShouldRejectWhenExpireDaysTooLarge()
    {
        EduSpaceShare share = buildShare("public", null, 15);
        EduUserQuota quota = buildQuota();
        quota.setMaxShareDays(7);
        when(quotaMapper.selectQuotaByUserId(share.getOwnerUserId())).thenReturn(quota);

        ServiceException ex = assertThrows(ServiceException.class, () -> service.insertShare(share));

        assertEquals("分享有效期超过当前账号允许的最大天数", ex.getMessage());
    }

    @Test
    void insertShareShouldPassValidationAndPersist()
    {
        EduSpaceShare share = buildShare("password", "abcd", 3);
        EduUserQuota quota = buildQuota();
        when(quotaMapper.selectQuotaByUserId(share.getOwnerUserId())).thenReturn(quota);
        when(shareMapper.insertShare(any(EduSpaceShare.class))).thenReturn(1);

        assertDoesNotThrow(() -> service.insertShare(share));
        verify(shareMapper).insertShare(any(EduSpaceShare.class));
    }

    private EduSpaceShare buildShare(String mode, String password, int expireDays)
    {
        EduSpaceShare share = new EduSpaceShare();
        share.setOwnerUserId(100L);
        share.setOwnerName("teacher01");
        share.setShareName("章节资料分享");
        share.setTargetType("file");
        share.setTargetName("第1章资源.pdf");
        share.setTargetPath("/teacher01/第1章资源.pdf");
        share.setShareMode(mode);
        share.setSharePassword(password);
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_YEAR, expireDays);
        share.setExpireTime(calendar.getTime());
        share.setDownloadLimit(10);
        share.setStatus("0");
        share.setCreateBy("teacher01");
        return share;
    }

    private EduUserQuota buildQuota()
    {
        EduUserQuota quota = new EduUserQuota();
        quota.setUserId(100L);
        quota.setStatus("0");
        quota.setUserStatus("0");
        quota.setAllowShare("0");
        quota.setAllowPasswordShare("0");
        quota.setMaxShareDays(7);
        return quota;
    }
}
