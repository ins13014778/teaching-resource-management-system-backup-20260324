package com.ruoyi.system.service.impl;

import java.util.LinkedHashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.EduStatsMapper;
import com.ruoyi.system.service.IEduStatsService;

@Service
public class EduStatsServiceImpl implements IEduStatsService
{
    @Autowired
    private EduStatsMapper statsMapper;

    @Override
    public Map<String, Object> getDashboardStats()
    {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("overview", statsMapper.selectOverview());
        result.put("topResources", statsMapper.selectTopResources());
        result.put("topTeachers", statsMapper.selectTopTeachers());
        result.put("activeUsers", statsMapper.selectActiveUsers());
        result.put("categoryDistribution", statsMapper.selectCategoryDistribution());
        result.put("uploadTrend", statsMapper.selectRecentUploadTrend());
        result.put("downloadTrend", statsMapper.selectRecentDownloadTrend());
        return result;
    }
}
