package com.ruoyi.system.service.impl;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.EduSpaceFile;
import com.ruoyi.system.domain.EduUserQuota;
import com.ruoyi.system.mapper.EduSpaceFileMapper;
import com.ruoyi.system.mapper.EduUserQuotaMapper;

@ExtendWith(MockitoExtension.class)
class EduSpaceFileServiceImplTest
{
    @InjectMocks
    private EduSpaceFileServiceImpl service;

    @Mock
    private EduSpaceFileMapper spaceFileMapper;

    @Mock
    private EduUserQuotaMapper quotaMapper;

    @Test
    void createFileShouldRejectWhenUploadLimitExceeded()
    {
        EduSpaceFile file = buildFile(new BigDecimal("300"));
        EduUserQuota quota = buildQuota();
        quota.setUploadMb(200);
        when(quotaMapper.selectQuotaByUserId(file.getOwnerUserId())).thenReturn(quota);

        ServiceException ex = assertThrows(ServiceException.class, () -> service.insertSpaceFile(file));

        assertEquals("上传文件大小超过当前账号限制", ex.getMessage());
    }

    @Test
    void createFileShouldRejectWhenStorageQuotaExceeded()
    {
        EduSpaceFile file = buildFile(new BigDecimal("200"));
        EduUserQuota quota = buildQuota();
        quota.setStorageGb(1);
        quota.setUsedStorageMb(new BigDecimal("950"));
        when(quotaMapper.selectQuotaByUserId(file.getOwnerUserId())).thenReturn(quota);

        ServiceException ex = assertThrows(ServiceException.class, () -> service.insertSpaceFile(file));

        assertEquals("空间容量不足，请联系管理员扩容", ex.getMessage());
    }

    @Test
    void createFolderShouldNotOccupyStorageQuota()
    {
        EduSpaceFile folder = buildFolder();
        EduUserQuota quota = buildQuota();
        when(quotaMapper.selectQuotaByUserId(folder.getOwnerUserId())).thenReturn(quota);
        when(spaceFileMapper.insertSpaceFile(any(EduSpaceFile.class))).thenReturn(1);

        assertDoesNotThrow(() -> service.insertSpaceFile(folder));
        verify(spaceFileMapper).insertSpaceFile(any(EduSpaceFile.class));
    }

    @Test
    void createFileShouldPersistAndIncreaseUsedStorage()
    {
        EduSpaceFile file = buildFile(new BigDecimal("128"));
        EduUserQuota quota = buildQuota();
        when(quotaMapper.selectQuotaByUserId(file.getOwnerUserId())).thenReturn(quota);
        when(spaceFileMapper.insertSpaceFile(any(EduSpaceFile.class))).thenReturn(1);
        when(quotaMapper.updateUsedStorageByUserId(file.getOwnerUserId(), file.getFileSizeMb())).thenReturn(1);

        assertDoesNotThrow(() -> service.insertSpaceFile(file));
        verify(quotaMapper).updateUsedStorageByUserId(file.getOwnerUserId(), file.getFileSizeMb());
    }

    private EduSpaceFile buildFile(BigDecimal size)
    {
        EduSpaceFile file = new EduSpaceFile();
        file.setOwnerUserId(100L);
        file.setOwnerName("teacher01");
        file.setParentId(0L);
        file.setTargetType("file");
        file.setFileName("第1章资源.pdf");
        file.setOriginalFileName("第1章资源.pdf");
        file.setFileExt("pdf");
        file.setFileSizeMb(size);
        file.setStorageType("local");
        file.setStoragePath("space/teacher01/chapter1.pdf");
        file.setFileUrl("/profile/upload/space/chapter1.pdf");
        file.setPreviewUrl("/profile/upload/space/chapter1.pdf");
        file.setStatus("0");
        file.setCreateBy("teacher01");
        return file;
    }

    private EduSpaceFile buildFolder()
    {
        EduSpaceFile folder = new EduSpaceFile();
        folder.setOwnerUserId(100L);
        folder.setOwnerName("teacher01");
        folder.setParentId(0L);
        folder.setTargetType("folder");
        folder.setFileName("教学资料");
        folder.setFileSizeMb(BigDecimal.ZERO);
        folder.setStatus("0");
        folder.setCreateBy("teacher01");
        return folder;
    }

    private EduUserQuota buildQuota()
    {
        EduUserQuota quota = new EduUserQuota();
        quota.setUserId(100L);
        quota.setStorageGb(2);
        quota.setUploadMb(512);
        quota.setUsedStorageMb(new BigDecimal("256"));
        quota.setStatus("0");
        quota.setUserStatus("0");
        return quota;
    }
}
