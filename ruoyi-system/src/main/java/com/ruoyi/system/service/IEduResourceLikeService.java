package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.EduResourceLike;

public interface IEduResourceLikeService
{
    List<EduResourceLike> selectLikeList(EduResourceLike like);

    EduResourceLike selectLikeById(Long likeId);

    Map<String, Object> toggleLike(Long resourceId);

    int deleteLikeByIds(Long[] likeIds);
}
