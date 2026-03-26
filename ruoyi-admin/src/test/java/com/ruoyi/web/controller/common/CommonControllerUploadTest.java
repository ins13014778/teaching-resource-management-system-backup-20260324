package com.ruoyi.web.controller.common;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockMultipartFile;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.storage.StorageFacade;
import com.ruoyi.common.storage.StoredFileInfo;
import com.ruoyi.framework.config.ServerConfig;

@ExtendWith(MockitoExtension.class)
class CommonControllerUploadTest
{
    @InjectMocks
    private CommonController controller;

    @Mock
    private ServerConfig serverConfig;

    @Mock
    private StorageFacade storageFacade;

    @Test
    void uploadFileShouldReturnStorageMetadata() throws Exception
    {
        MockMultipartFile file = new MockMultipartFile("file", "lesson.pdf", "application/pdf", "demo".getBytes());
        StoredFileInfo storedFileInfo = new StoredFileInfo();
        storedFileInfo.setFileName("/profile/upload/resource/2026/03/26/lesson_1.pdf");
        storedFileInfo.setNewFileName("lesson_1.pdf");
        storedFileInfo.setOriginalFilename("lesson.pdf");
        storedFileInfo.setStorageType("local");
        storedFileInfo.setStoragePath("resource/2026/03/26/lesson_1.pdf");
        storedFileInfo.setSize(file.getSize());

        when(storageFacade.store(file, "common")).thenReturn(storedFileInfo);
        when(serverConfig.getUrl()).thenReturn("http://127.0.0.1");

        AjaxResult result = controller.uploadFile(file, "common");

        assertTrue(result.isSuccess());
        assertEquals("local", result.get("storageType"));
        assertEquals("resource/2026/03/26/lesson_1.pdf", result.get("storagePath"));
        assertEquals(file.getSize(), result.get("size"));
        assertEquals("http://127.0.0.1/profile/upload/resource/2026/03/26/lesson_1.pdf", result.get("url"));
    }
}
