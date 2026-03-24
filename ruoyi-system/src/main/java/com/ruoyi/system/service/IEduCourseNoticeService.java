package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduCourseNotice;

public interface IEduCourseNoticeService
{
    List<EduCourseNotice> selectNoticeList(EduCourseNotice notice);

    List<EduCourseNotice> selectNoticeByCourseId(Long courseId);

    EduCourseNotice selectNoticeById(Long noticeId);

    int insertNotice(EduCourseNotice notice);

    int updateNotice(EduCourseNotice notice);

    int deleteNoticeByIds(Long[] noticeIds);
}
