package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduCourseChapter;

public interface EduCourseChapterMapper
{
    List<EduCourseChapter> selectChapterList(EduCourseChapter chapter);

    EduCourseChapter selectChapterById(Long chapterId);

    int insertChapter(EduCourseChapter chapter);

    int updateChapter(EduCourseChapter chapter);

    int deleteChapterByIds(Long[] chapterIds);
}
