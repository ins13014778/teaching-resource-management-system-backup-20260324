package com.ruoyi.web.controller.common;

import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.storage.StorageFacade;
import com.ruoyi.common.storage.StoredFileInfo;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUtils;
import com.ruoyi.framework.config.ServerConfig;

@RestController
@RequestMapping("/common")
public class CommonController
{
    private static final Logger log = LoggerFactory.getLogger(CommonController.class);

    private static final String FILE_DELIMITER = ",";

    @Autowired
    private ServerConfig serverConfig;

    @Autowired
    private StorageFacade storageFacade;

    @GetMapping("/download")
    public void fileDownload(String fileName, Boolean delete, HttpServletResponse response, HttpServletRequest request)
    {
        try
        {
            if (!FileUtils.checkAllowDownload(fileName))
            {
                throw new Exception(StringUtils.format("文件名称({}) 非法，不允许下载。", fileName));
            }
            String realFileName = System.currentTimeMillis() + fileName.substring(fileName.indexOf("_") + 1);
            String filePath = RuoYiConfig.getDownloadPath() + fileName;

            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            FileUtils.setAttachmentResponseHeader(response, realFileName);
            FileUtils.writeBytes(filePath, response.getOutputStream());
            if (delete)
            {
                FileUtils.deleteFile(filePath);
            }
        }
        catch (Exception e)
        {
            log.error("下载文件失败", e);
        }
    }

    @PostMapping("/upload")
    public AjaxResult uploadFile(MultipartFile file, String bizType) throws Exception
    {
        try
        {
            StoredFileInfo storedFileInfo = storageFacade.store(file, bizType);
            String url = StringUtils.isNotEmpty(storedFileInfo.getUrl())
                ? storedFileInfo.getUrl()
                : serverConfig.getUrl() + storedFileInfo.getFileName();
            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", url);
            ajax.put("fileName", storedFileInfo.getFileName());
            ajax.put("newFileName", storedFileInfo.getNewFileName());
            ajax.put("originalFilename", storedFileInfo.getOriginalFilename());
            ajax.put("storageType", storedFileInfo.getStorageType());
            ajax.put("storagePath", storedFileInfo.getStoragePath());
            ajax.put("size", storedFileInfo.getSize());
            ajax.put("contentType", storedFileInfo.getContentType());
            return ajax;
        }
        catch (Exception e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }

    @PostMapping("/uploads")
    public AjaxResult uploadFiles(List<MultipartFile> files, String bizType) throws Exception
    {
        try
        {
            List<String> urls = new ArrayList<>();
            List<String> fileNames = new ArrayList<>();
            List<String> newFileNames = new ArrayList<>();
            List<String> originalFilenames = new ArrayList<>();
            List<String> storageTypes = new ArrayList<>();
            List<String> storagePaths = new ArrayList<>();
            for (MultipartFile file : files)
            {
                StoredFileInfo storedFileInfo = storageFacade.store(file, bizType);
                String url = StringUtils.isNotEmpty(storedFileInfo.getUrl())
                    ? storedFileInfo.getUrl()
                    : serverConfig.getUrl() + storedFileInfo.getFileName();
                urls.add(url);
                fileNames.add(storedFileInfo.getFileName());
                newFileNames.add(storedFileInfo.getNewFileName());
                originalFilenames.add(storedFileInfo.getOriginalFilename());
                storageTypes.add(storedFileInfo.getStorageType());
                storagePaths.add(storedFileInfo.getStoragePath());
            }
            AjaxResult ajax = AjaxResult.success();
            ajax.put("urls", StringUtils.join(urls, FILE_DELIMITER));
            ajax.put("fileNames", StringUtils.join(fileNames, FILE_DELIMITER));
            ajax.put("newFileNames", StringUtils.join(newFileNames, FILE_DELIMITER));
            ajax.put("originalFilenames", StringUtils.join(originalFilenames, FILE_DELIMITER));
            ajax.put("storageTypes", StringUtils.join(storageTypes, FILE_DELIMITER));
            ajax.put("storagePaths", StringUtils.join(storagePaths, FILE_DELIMITER));
            return ajax;
        }
        catch (Exception e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }

    @GetMapping("/download/resource")
    public void resourceDownload(String resource, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        try
        {
            if (!FileUtils.checkAllowDownload(resource))
            {
                throw new Exception(StringUtils.format("资源文件({}) 非法，不允许下载。", resource));
            }
            String localPath = RuoYiConfig.getProfile();
            String downloadPath = localPath + FileUtils.stripPrefix(resource);
            String downloadName = StringUtils.substringAfterLast(downloadPath, "/");
            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            FileUtils.setAttachmentResponseHeader(response, downloadName);
            FileUtils.writeBytes(downloadPath, response.getOutputStream());
        }
        catch (Exception e)
        {
            log.error("下载资源文件失败", e);
        }
    }
}