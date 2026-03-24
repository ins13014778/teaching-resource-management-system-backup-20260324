import request from '@/utils/request'

export function listNotice(query) {
  return request({ url: '/edu/notice/list', method: 'get', params: query })
}

export function getNotice(noticeId) {
  return request({ url: '/edu/notice/' + noticeId, method: 'get' })
}

export function addNotice(data) {
  return request({ url: '/edu/notice', method: 'post', data })
}

export function updateNotice(data) {
  return request({ url: '/edu/notice', method: 'put', data })
}

export function delNotice(noticeId) {
  return request({ url: '/edu/notice/' + noticeId, method: 'delete' })
}

export function listCourseNotice(courseId) {
  return request({ url: '/edu/notice/course/' + courseId, method: 'get' })
}
