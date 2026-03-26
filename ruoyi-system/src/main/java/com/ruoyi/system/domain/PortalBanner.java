package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 官网轮播图对象 portal_banner
 */
public class PortalBanner extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long bannerId;
    private String bannerTitle;
    private String bannerSubtitle;
    private String imageUrl;
    private String targetUrl;
    private String buttonText;
    private Integer sortNum;
    private String status;

    public Long getBannerId()
    {
        return bannerId;
    }

    public void setBannerId(Long bannerId)
    {
        this.bannerId = bannerId;
    }

    public String getBannerTitle()
    {
        return bannerTitle;
    }

    public void setBannerTitle(String bannerTitle)
    {
        this.bannerTitle = bannerTitle;
    }

    public String getBannerSubtitle()
    {
        return bannerSubtitle;
    }

    public void setBannerSubtitle(String bannerSubtitle)
    {
        this.bannerSubtitle = bannerSubtitle;
    }

    public String getImageUrl()
    {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl)
    {
        this.imageUrl = imageUrl;
    }

    public String getTargetUrl()
    {
        return targetUrl;
    }

    public void setTargetUrl(String targetUrl)
    {
        this.targetUrl = targetUrl;
    }

    public String getButtonText()
    {
        return buttonText;
    }

    public void setButtonText(String buttonText)
    {
        this.buttonText = buttonText;
    }

    public Integer getSortNum()
    {
        return sortNum;
    }

    public void setSortNum(Integer sortNum)
    {
        this.sortNum = sortNum;
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
            .append("bannerId", getBannerId())
            .append("bannerTitle", getBannerTitle())
            .append("bannerSubtitle", getBannerSubtitle())
            .append("imageUrl", getImageUrl())
            .append("targetUrl", getTargetUrl())
            .append("buttonText", getButtonText())
            .append("sortNum", getSortNum())
            .append("status", getStatus())
            .append("remark", getRemark())
            .toString();
    }
}
