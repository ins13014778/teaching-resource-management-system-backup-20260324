package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.EduResource;

public interface IEduResourceService
{
    List<EduResource> selectResourceList(EduResource resource);

    EduResource selectResourceById(Long resourceId);

    int insertResource(EduResource resource);

    int updateResource(EduResource resource);

    int deleteResourceByIds(Long[] resourceIds);

    int submitAudit(Long resourceId);

    int updateRecommendFlag(Long resourceId, String recommendFlag);

    int incrementDownloadCount(Long resourceId);

    Map<String, Object> getFormOptions();
}
