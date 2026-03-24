import request from '@/utils/request'

export function listChapter(query) {
  return request({ url: '/edu/chapter/list', method: 'get', params: query })
}

export function getChapter(chapterId) {
  return request({ url: '/edu/chapter/' + chapterId, method: 'get' })
}

export function addChapter(data) {
  return request({ url: '/edu/chapter', method: 'post', data })
}

export function updateChapter(data) {
  return request({ url: '/edu/chapter', method: 'put', data })
}

export function delChapter(chapterId) {
  return request({ url: '/edu/chapter/' + chapterId, method: 'delete' })
}
