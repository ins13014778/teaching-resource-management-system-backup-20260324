package com.ruoyi.web.core.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.ruoyi.common.config.RuoYiConfig;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;

/**
 * OpenAPI 接口文档配置
 *
 * @author ruoyi
 */
@Configuration
public class SwaggerConfig
{
    /** 系统基础配置 */
    @Autowired
    private RuoYiConfig ruoyiConfig;

    /**
     * 自定义 OpenAPI 对象
     */
    @Bean
    public OpenAPI customOpenApi()
    {
        return new OpenAPI().components(new Components()
            .addSecuritySchemes("apikey", securityScheme()))
            .addSecurityItem(new SecurityRequirement().addList("apikey"))
            .info(getApiInfo());
    }

    @Bean
    public SecurityScheme securityScheme()
    {
        return new SecurityScheme()
            .type(SecurityScheme.Type.APIKEY)
            .name("Authorization")
            .in(SecurityScheme.In.HEADER)
            .scheme("Bearer");
    }

    /**
     * 接口文档基础信息
     */
    public Info getApiInfo()
    {
        return new Info()
            .title("教学资源管理系统接口文档")
            .description("用于维护教学资源、课程公告、空间分享、配额策略与系统管理相关接口。")
            .contact(new Contact().name(ruoyiConfig.getName()))
            .version("版本号：" + ruoyiConfig.getVersion());
    }
}
