package com.ruoyi.common.storage;

import java.io.InputStream;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.config.StorageProperties;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import io.minio.BucketExistsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;

@Service
public class MinioStorageServiceImpl implements StorageService
{
    private final StorageProperties storageProperties;

    public MinioStorageServiceImpl(StorageProperties storageProperties)
    {
        this.storageProperties = storageProperties;
    }

    @Override
    public StoredFileInfo store(MultipartFile file, String bizType) throws Exception
    {
        StorageProperties.Minio minio = storageProperties.getMinio();
        if (!minio.isEnabled())
        {
            throw new ServiceException("MinIO 存储未启用，请先在配置中开启后再使用");
        }
        if (StringUtils.isAnyBlank(minio.getEndpoint(), minio.getAccessKey(), minio.getSecretKey(), minio.getBucket()))
        {
            throw new ServiceException("MinIO 配置不完整，请检查 endpoint、accessKey、secretKey、bucket");
        }

        String normalizedBizType = StringUtils.isBlank(bizType) ? "common" : bizType.trim();
        String objectName = normalizedBizType + "/" + DateUtils.datePath() + "/" + FileUploadUtils.uuidFilename(file).substring(DateUtils.datePath().length() + 1);

        MinioClient client = MinioClient.builder()
            .endpoint(minio.getEndpoint())
            .credentials(minio.getAccessKey(), minio.getSecretKey())
            .build();

        boolean bucketExists = client.bucketExists(BucketExistsArgs.builder().bucket(minio.getBucket()).build());
        if (!bucketExists)
        {
            client.makeBucket(MakeBucketArgs.builder().bucket(minio.getBucket()).build());
        }

        try (InputStream inputStream = file.getInputStream())
        {
            client.putObject(PutObjectArgs.builder()
                .bucket(minio.getBucket())
                .object(objectName)
                .stream(inputStream, file.getSize(), -1)
                .contentType(file.getContentType())
                .build());
        }

        StoredFileInfo info = new StoredFileInfo();
        info.setFileName("/minio/" + minio.getBucket() + "/" + objectName);
        info.setNewFileName(objectName.substring(objectName.lastIndexOf('/') + 1));
        info.setOriginalFilename(file.getOriginalFilename());
        info.setStorageType("minio");
        info.setStoragePath(objectName);
        info.setSize(file.getSize());
        info.setContentType(file.getContentType());
        String baseUrl = StringUtils.isBlank(minio.getPublicUrl()) ? minio.getEndpoint() + "/" + minio.getBucket() : minio.getPublicUrl();
        info.setUrl(baseUrl + "/" + objectName);
        return info;
    }
}
