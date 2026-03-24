package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.EduResource;

public interface EduResourceMapper
{
    List<EduResource> selectResourceList(EduResource resource);

    EduResource selectResourceById(Long resourceId);

    int insertResource(EduResource resource);

    int updateResource(EduResource resource);

    int deleteResourceByIds(Long[] resourceIds);

    int updateResourceStatus(@Param("resourceId") Long resourceId, @Param("auditStatus") String auditStatus, @Param("publishStatus") String publishStatus);

    int updateRecommendFlag(@Param("resourceId") Long resourceId, @Param("recommendFlag") String recommendFlag);

    int incrementDownloadCount(Long resourceId);

    int changeFavoriteCount(@Param("resourceId") Long resourceId, @Param("delta") int delta);

    int changeLikeCount(@Param("resourceId") Long resourceId, @Param("delta") int delta);
}
