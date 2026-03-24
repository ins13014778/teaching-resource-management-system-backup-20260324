package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiEmbeddingIndex;

public interface AiEmbeddingIndexMapper
{
    AiEmbeddingIndex selectByResourceId(Long resourceId);

    int insertIndex(AiEmbeddingIndex index);

    int updateIndex(AiEmbeddingIndex index);
}
