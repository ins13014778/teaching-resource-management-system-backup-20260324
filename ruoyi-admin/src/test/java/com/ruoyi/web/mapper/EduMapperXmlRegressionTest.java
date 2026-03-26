package com.ruoyi.web.mapper;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.jupiter.api.Test;

class EduMapperXmlRegressionTest
{
    @Test
    void statsOverviewShouldNotRequireDelFlagOnAuditTable() throws IOException
    {
        String xml = read("ruoyi-system/src/main/resources/mapper/edu/EduStatsMapper.xml");
        assertTrue(xml.contains("from edu_resource_audit"));
        assertFalse(xml.contains("from edu_resource_audit where del_flag = '0'"));
        assertFalse(xml.contains("""
from edu_resource_audit
                where del_flag = '0'
"""));
    }

    @Test
    void resourceMapperShouldPersistUploadStorageMetadata() throws IOException
    {
        String xml = read("ruoyi-system/src/main/resources/mapper/edu/EduResourceMapper.xml");
        assertTrue(xml.contains("original_file_name"));
        assertTrue(xml.contains("storage_type"));
        assertTrue(xml.contains("storage_path"));
        assertTrue(xml.contains("preview_url"));
    }

    private String read(String relativePath) throws IOException
    {
        Path moduleRoot = Path.of("").toAbsolutePath();
        Path repoRoot = moduleRoot.getFileName().toString().equals("ruoyi-admin") ? moduleRoot.getParent() : moduleRoot;
        return Files.readString(repoRoot.resolve(relativePath), StandardCharsets.UTF_8);
    }
}