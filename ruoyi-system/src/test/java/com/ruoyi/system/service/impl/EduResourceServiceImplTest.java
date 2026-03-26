package com.ruoyi.system.service.impl;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.EduResource;
import com.ruoyi.system.mapper.EduCategoryMapper;
import com.ruoyi.system.mapper.EduCourseMapper;
import com.ruoyi.system.mapper.EduResourceAuditMapper;
import com.ruoyi.system.mapper.EduResourceMapper;
import com.ruoyi.system.mapper.EduTagMapper;
import com.ruoyi.system.mapper.EduTeacherStudentGrantMapper;
import com.ruoyi.system.service.IAiCapabilityService;
import com.ruoyi.system.service.IEduCategoryService;
import com.ruoyi.system.service.IEduDownloadLogService;

@ExtendWith(MockitoExtension.class)
class EduResourceServiceImplTest
{
    @InjectMocks
    private EduResourceServiceImpl service;

    @Mock
    private EduResourceMapper resourceMapper;
    @Mock
    private EduResourceAuditMapper auditMapper;
    @Mock
    private EduCategoryMapper categoryMapper;
    @Mock
    private EduTagMapper tagMapper;
    @Mock
    private EduCourseMapper courseMapper;
    @Mock
    private EduTeacherStudentGrantMapper grantMapper;
    @Mock
    private IEduCategoryService categoryService;
    @Mock
    private IEduDownloadLogService downloadLogService;
    @Mock
    private IAiCapabilityService aiCapabilityService;

    @Test
    void insertResourceShouldDefaultDownloadFavoriteAndLikeCountToZero()
    {
        EduResource resource = buildResource();
        when(resourceMapper.insertResource(any(EduResource.class))).thenAnswer(invocation -> {
            EduResource arg = invocation.getArgument(0);
            arg.setResourceId(100L);
            return 1;
        });

        try (MockedStatic<SecurityUtils> mocked = Mockito.mockStatic(SecurityUtils.class))
        {
            mocked.when(() -> SecurityUtils.hasRole("teacher")).thenReturn(false);
            mocked.when(() -> SecurityUtils.hasRole("student")).thenReturn(false);
            mocked.when(SecurityUtils::isAdmin).thenReturn(false);

            assertDoesNotThrow(() -> service.insertResource(resource));
        }

        assertEquals(0, resource.getDownloadCount());
        assertEquals(0, resource.getFavoriteCount());
        assertEquals(0, resource.getLikeCount());
        verify(resourceMapper).insertResource(resource);
        verify(aiCapabilityService).runAutoTasks(100L, "upload");
    }

    private EduResource buildResource()
    {
        EduResource resource = new EduResource();
        resource.setResourceTitle("测试资源");
        resource.setResourceType("PDF");
        resource.setCategoryName("教学课件");
        resource.setCourseName("数据结构");
        resource.setTagNames("重点,期末复习");
        resource.setFileUrl("/profile/upload/resource/test.pdf");
        resource.setOriginalFileName("test.pdf");
        resource.setResourceVersion("v1.0");
        resource.setFileSizeMb(new BigDecimal("12.50"));
        resource.setStorageType("local");
        resource.setStoragePath("resource/test.pdf");
        resource.setPreviewUrl("/profile/upload/resource/test.pdf");
        resource.setUploaderId(1L);
        resource.setUploaderName("admin");
        resource.setCreateBy("admin");
        return resource;
    }
}