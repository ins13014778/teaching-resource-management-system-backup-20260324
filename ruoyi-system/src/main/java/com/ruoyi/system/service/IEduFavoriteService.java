package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.EduFavorite;

public interface IEduFavoriteService
{
    List<EduFavorite> selectFavoriteList(EduFavorite favorite);

    EduFavorite selectFavoriteById(Long favoriteId);

    int insertFavorite(EduFavorite favorite);

    int deleteFavoriteByIds(Long[] favoriteIds);

    Map<String, Object> toggleFavorite(Long resourceId);
}
