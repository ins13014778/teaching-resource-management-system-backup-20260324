package com.ruoyi.common.storage;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.config.StorageProperties;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;

@Component
public class StorageFacade
{
    private final StorageProperties storageProperties;

    private final LocalStorageServiceImpl localStorageService;

    private final MinioStorageServiceImpl minioStorageService;

    public StorageFacade(StorageProperties storageProperties, LocalStorageServiceImpl localStorageService,
        MinioStorageServiceImpl minioStorageService)
    {
        this.storageProperties = storageProperties;
        this.localStorageService = localStorageService;
        this.minioStorageService = minioStorageService;
    }

    public StoredFileInfo store(MultipartFile file, String bizType) throws Exception
    {
        String type = StringUtils.defaultIfBlank(storageProperties.getType(), "local");
        if ("minio".equalsIgnoreCase(type))
        {
            return minioStorageService.store(file, bizType);
        }
        if ("local".equalsIgnoreCase(type))
        {
            return localStorageService.store(file, bizType);
        }
        throw new ServiceException("不支持的存储类型：" + type);
    }
}