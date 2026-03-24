package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduCourseChapter;

public interface IEduCourseChapterService
{
    List<EduCourseChapter> selectChapterList(EduCourseChapter chapter);

    EduCourseChapter selectChapterById(Long chapterId);

    int insertChapter(EduCourseChapter chapter);

    int updateChapter(EduCourseChapter chapter);

    int deleteChapterByIds(Long[] chapterIds);
}
