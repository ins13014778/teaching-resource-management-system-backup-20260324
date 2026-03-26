package com.ruoyi.common.storage;

import org.springframework.web.multipart.MultipartFile;

public interface StorageService
{
    StoredFileInfo store(MultipartFile file, String bizType) throws Exception;
}
