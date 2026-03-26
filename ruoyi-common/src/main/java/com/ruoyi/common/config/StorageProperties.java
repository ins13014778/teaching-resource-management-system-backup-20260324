package com.ruoyi.common.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "storage")
public class StorageProperties
{
    private String type = "local";

    private String domain;

    private Local local = new Local();

    private Minio minio = new Minio();

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getDomain()
    {
        return domain;
    }

    public void setDomain(String domain)
    {
        this.domain = domain;
    }

    public Local getLocal()
    {
        return local;
    }

    public void setLocal(Local local)
    {
        this.local = local;
    }

    public Minio getMinio()
    {
        return minio;
    }

    public void setMinio(Minio minio)
    {
        this.minio = minio;
    }

    public static class Local
    {
        private String baseDir;

        public String getBaseDir()
        {
            return baseDir;
        }

        public void setBaseDir(String baseDir)
        {
            this.baseDir = baseDir;
        }
    }

    public static class Minio
    {
        private boolean enabled;

        private String endpoint;

        private String accessKey;

        private String secretKey;

        private String bucket;

        private String publicUrl;

        public boolean isEnabled()
        {
            return enabled;
        }

        public void setEnabled(boolean enabled)
        {
            this.enabled = enabled;
        }

        public String getEndpoint()
        {
            return endpoint;
        }

        public void setEndpoint(String endpoint)
        {
            this.endpoint = endpoint;
        }

        public String getAccessKey()
        {
            return accessKey;
        }

        public void setAccessKey(String accessKey)
        {
            this.accessKey = accessKey;
        }

        public String getSecretKey()
        {
            return secretKey;
        }

        public void setSecretKey(String secretKey)
        {
            this.secretKey = secretKey;
        }

        public String getBucket()
        {
            return bucket;
        }

        public void setBucket(String bucket)
        {
            this.bucket = bucket;
        }

        public String getPublicUrl()
        {
            return publicUrl;
        }

        public void setPublicUrl(String publicUrl)
        {
            this.publicUrl = publicUrl;
        }
    }
}
