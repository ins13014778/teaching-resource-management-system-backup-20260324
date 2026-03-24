package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduCourse;
import com.ruoyi.system.domain.EduCourseNotice;
import com.ruoyi.system.domain.EduTeacherStudentGrant;
import com.ruoyi.system.mapper.EduCourseMapper;
import com.ruoyi.system.mapper.EduCourseNoticeMapper;
import com.ruoyi.system.mapper.EduTeacherStudentGrantMapper;
import com.ruoyi.system.service.IEduCourseNoticeService;
import com.ruoyi.system.service.IEduMessageService;

@Service
public class EduCourseNoticeServiceImpl implements IEduCourseNoticeService
{
    @Autowired
    private EduCourseNoticeMapper noticeMapper;

    @Autowired
    private EduCourseMapper courseMapper;

    @Autowired
    private EduTeacherStudentGrantMapper grantMapper;

    @Autowired
    private IEduMessageService messageService;

    @Override
    public List<EduCourseNotice> selectNoticeList(EduCourseNotice notice)
    {
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin())
        {
            notice.setPublisherId(SecurityUtils.getUserId());
        }
        if (SecurityUtils.hasRole("student") && !SecurityUtils.isAdmin())
        {
            notice.setStatus("0");
            List<String> courseNames = grantMapper.selectActiveCourseNamesByStudentId(SecurityUtils.getUserId());
            if (!courseNames.isEmpty())
            {
                notice.setCourseNameScope(courseNames);
            }
        }
        return noticeMapper.selectNoticeList(notice);
    }

    @Override
    public List<EduCourseNotice> selectNoticeByCourseId(Long courseId)
    {
        return noticeMapper.selectNoticeByCourseId(courseId);
    }

    @Override
    public EduCourseNotice selectNoticeById(Long noticeId)
    {
        return noticeMapper.selectNoticeById(noticeId);
    }

    @Override
    public int insertNotice(EduCourseNotice notice)
    {
        EduCourse course = courseMapper.selectCourseById(notice.getCourseId());
        if (course == null)
        {
            throw new ServiceException("课程不存在");
        }
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin()
            && !SecurityUtils.getUserId().equals(course.getTeacherUserId()))
        {
            throw new ServiceException("只能发布自己课程的公告");
        }
        notice.setCourseName(course.getCourseName());
        notice.setPublisherId(SecurityUtils.getUserId());
        notice.setPublisherName(SecurityUtils.getUsername());
        if (StringUtils.isEmpty(notice.getStatus()))
        {
            notice.setStatus("0");
        }
        notice.setCreateBy(SecurityUtils.getUsername());
        int rows = noticeMapper.insertNotice(notice);
        if (rows > 0 && "0".equals(notice.getStatus()))
        {
            notifyGrantedStudents(notice);
        }
        return rows;
    }

    @Override
    public int updateNotice(EduCourseNotice notice)
    {
        EduCourseNotice db = noticeMapper.selectNoticeById(notice.getNoticeId());
        checkPermission(db);
        EduCourse course = courseMapper.selectCourseById(notice.getCourseId());
        if (course != null)
        {
            notice.setCourseName(course.getCourseName());
        }
        notice.setUpdateBy(SecurityUtils.getUsername());
        int rows = noticeMapper.updateNotice(notice);
        if (rows > 0 && "0".equals(notice.getStatus()))
        {
            notifyGrantedStudents(notice);
        }
        return rows;
    }

    @Override
    public int deleteNoticeByIds(Long[] noticeIds)
    {
        for (Long noticeId : noticeIds)
        {
            checkPermission(noticeMapper.selectNoticeById(noticeId));
        }
        return noticeMapper.deleteNoticeByIds(noticeIds);
    }

    private void checkPermission(EduCourseNotice notice)
    {
        if (notice == null)
        {
            throw new ServiceException("课程公告不存在");
        }
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin()
            && !SecurityUtils.getUserId().equals(notice.getPublisherId()))
        {
            throw new ServiceException("只能操作自己发布的课程公告");
        }
    }

    private void notifyGrantedStudents(EduCourseNotice notice)
    {
        if (StringUtils.isEmpty(notice.getCourseName()))
        {
            return;
        }
        List<EduTeacherStudentGrant> grantList = grantMapper.selectActiveGrantListByCourseName(notice.getCourseName());
        for (EduTeacherStudentGrant grant : grantList)
        {
            if (grant.getStudentUserId() == null)
            {
                continue;
            }
            messageService.sendMessage(
                grant.getStudentUserId(),
                grant.getStudentName(),
                "课程公告更新",
                "您有新的课程公告：《" + notice.getNoticeTitle() + "》，所属课程：" + notice.getCourseName(),
                "course_notice",
                notice.getNoticeId());
        }
    }
}
