package com.ruoyi.common.storage;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.config.StorageProperties;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.FileUtils;

@Service
public class LocalStorageServiceImpl implements StorageService
{
    private final StorageProperties storageProperties;

    public LocalStorageServiceImpl(StorageProperties storageProperties)
    {
        this.storageProperties = storageProperties;
    }

    @Override
    public StoredFileInfo store(MultipartFile file, String bizType) throws Exception
    {
        String normalizedBizType = StringUtils.isBlank(bizType) ? "common" : bizType.trim();
        String baseDir = StringUtils.isBlank(storageProperties.getLocal().getBaseDir())
            ? RuoYiConfig.getUploadPath()
            : storageProperties.getLocal().getBaseDir();
        String fileName = FileUploadUtils.upload(baseDir + "/" + normalizedBizType, file);

        StoredFileInfo info = new StoredFileInfo();
        info.setFileName(fileName);
        info.setNewFileName(FileUtils.getName(fileName));
        info.setOriginalFilename(file.getOriginalFilename());
        info.setStorageType("local");
        info.setStoragePath(normalizedBizType + "/" + FileUtils.getName(fileName));
        info.setSize(file.getSize());
        info.setContentType(file.getContentType());
        return info;
    }
}
