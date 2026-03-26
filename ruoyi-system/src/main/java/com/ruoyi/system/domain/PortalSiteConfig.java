package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 官网配置对象 portal_site_config
 */
public class PortalSiteConfig extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long configId;
    private String siteName;
    private String siteEnName;
    private String logoUrl;
    private String homeNavText;
    private String noticeNavText;
    private String teacherNavText;
    private String studentNavText;
    private String loginButtonText;
    private String heroBadge;
    private String heroTitle;
    private String heroSubtitle;
    private String heroPrimaryText;
    private String heroPrimaryLink;
    private String heroSecondaryText;
    private String heroSecondaryLink;
    private String noticePanelTitle;
    private String noticePanelMoreText;
    private String footerName;
    private String footerDesc;
    private String footerCopyright;
    private String status;

    public Long getConfigId()
    {
        return configId;
    }

    public void setConfigId(Long configId)
    {
        this.configId = configId;
    }

    public String getSiteName()
    {
        return siteName;
    }

    public void setSiteName(String siteName)
    {
        this.siteName = siteName;
    }

    public String getSiteEnName()
    {
        return siteEnName;
    }

    public void setSiteEnName(String siteEnName)
    {
        this.siteEnName = siteEnName;
    }

    public String getLogoUrl()
    {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl)
    {
        this.logoUrl = logoUrl;
    }

    public String getHomeNavText()
    {
        return homeNavText;
    }

    public void setHomeNavText(String homeNavText)
    {
        this.homeNavText = homeNavText;
    }

    public String getNoticeNavText()
    {
        return noticeNavText;
    }

    public void setNoticeNavText(String noticeNavText)
    {
        this.noticeNavText = noticeNavText;
    }

    public String getTeacherNavText()
    {
        return teacherNavText;
    }

    public void setTeacherNavText(String teacherNavText)
    {
        this.teacherNavText = teacherNavText;
    }

    public String getStudentNavText()
    {
        return studentNavText;
    }

    public void setStudentNavText(String studentNavText)
    {
        this.studentNavText = studentNavText;
    }

    public String getLoginButtonText()
    {
        return loginButtonText;
    }

    public void setLoginButtonText(String loginButtonText)
    {
        this.loginButtonText = loginButtonText;
    }

    public String getHeroBadge()
    {
        return heroBadge;
    }

    public void setHeroBadge(String heroBadge)
    {
        this.heroBadge = heroBadge;
    }

    public String getHeroTitle()
    {
        return heroTitle;
    }

    public void setHeroTitle(String heroTitle)
    {
        this.heroTitle = heroTitle;
    }

    public String getHeroSubtitle()
    {
        return heroSubtitle;
    }

    public void setHeroSubtitle(String heroSubtitle)
    {
        this.heroSubtitle = heroSubtitle;
    }

    public String getHeroPrimaryText()
    {
        return heroPrimaryText;
    }

    public void setHeroPrimaryText(String heroPrimaryText)
    {
        this.heroPrimaryText = heroPrimaryText;
    }

    public String getHeroPrimaryLink()
    {
        return heroPrimaryLink;
    }

    public void setHeroPrimaryLink(String heroPrimaryLink)
    {
        this.heroPrimaryLink = heroPrimaryLink;
    }

    public String getHeroSecondaryText()
    {
        return heroSecondaryText;
    }

    public void setHeroSecondaryText(String heroSecondaryText)
    {
        this.heroSecondaryText = heroSecondaryText;
    }

    public String getHeroSecondaryLink()
    {
        return heroSecondaryLink;
    }

    public void setHeroSecondaryLink(String heroSecondaryLink)
    {
        this.heroSecondaryLink = heroSecondaryLink;
    }

    public String getNoticePanelTitle()
    {
        return noticePanelTitle;
    }

    public void setNoticePanelTitle(String noticePanelTitle)
    {
        this.noticePanelTitle = noticePanelTitle;
    }

    public String getNoticePanelMoreText()
    {
        return noticePanelMoreText;
    }

    public void setNoticePanelMoreText(String noticePanelMoreText)
    {
        this.noticePanelMoreText = noticePanelMoreText;
    }

    public String getFooterName()
    {
        return footerName;
    }

    public void setFooterName(String footerName)
    {
        this.footerName = footerName;
    }

    public String getFooterDesc()
    {
        return footerDesc;
    }

    public void setFooterDesc(String footerDesc)
    {
        this.footerDesc = footerDesc;
    }

    public String getFooterCopyright()
    {
        return footerCopyright;
    }

    public void setFooterCopyright(String footerCopyright)
    {
        this.footerCopyright = footerCopyright;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("configId", getConfigId())
            .append("siteName", getSiteName())
            .append("siteEnName", getSiteEnName())
            .append("logoUrl", getLogoUrl())
            .append("homeNavText", getHomeNavText())
            .append("noticeNavText", getNoticeNavText())
            .append("teacherNavText", getTeacherNavText())
            .append("studentNavText", getStudentNavText())
            .append("loginButtonText", getLoginButtonText())
            .append("heroBadge", getHeroBadge())
            .append("heroTitle", getHeroTitle())
            .append("heroSubtitle", getHeroSubtitle())
            .append("heroPrimaryText", getHeroPrimaryText())
            .append("heroPrimaryLink", getHeroPrimaryLink())
            .append("heroSecondaryText", getHeroSecondaryText())
            .append("heroSecondaryLink", getHeroSecondaryLink())
            .append("noticePanelTitle", getNoticePanelTitle())
            .append("noticePanelMoreText", getNoticePanelMoreText())
            .append("footerName", getFooterName())
            .append("footerDesc", getFooterDesc())
            .append("footerCopyright", getFooterCopyright())
            .append("status", getStatus())
            .append("remark", getRemark())
            .toString();
    }
}
