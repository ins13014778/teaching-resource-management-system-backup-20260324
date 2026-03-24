package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.EduFavorite;

public interface EduFavoriteMapper
{
    List<EduFavorite> selectFavoriteList(EduFavorite favorite);

    EduFavorite selectFavoriteById(Long favoriteId);

    EduFavorite selectByUserIdAndResourceId(@Param("userId") Long userId, @Param("resourceId") Long resourceId);

    int insertFavorite(EduFavorite favorite);

    int deleteFavoriteByIds(Long[] favoriteIds);

    int deleteById(Long favoriteId);
}
