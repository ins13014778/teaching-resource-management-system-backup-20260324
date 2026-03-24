package com.ruoyi.system.mapper;

import java.util.List;
import java.util.Map;

public interface EduStatsMapper
{
    Map<String, Object> selectOverview();

    List<Map<String, Object>> selectTopResources();

    List<Map<String, Object>> selectTopTeachers();

    List<Map<String, Object>> selectActiveUsers();

    List<Map<String, Object>> selectCategoryDistribution();

    List<Map<String, Object>> selectRecentUploadTrend();

    List<Map<String, Object>> selectRecentDownloadTrend();
}
