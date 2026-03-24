import request from '@/utils/request'

export function listComment(query) {
  return request({ url: '/edu/comment/list', method: 'get', params: query })
}

export function getComment(commentId) {
  return request({ url: '/edu/comment/' + commentId, method: 'get' })
}

export function addComment(data) {
  return request({ url: '/edu/comment', method: 'post', data })
}

export function updateComment(data) {
  return request({ url: '/edu/comment', method: 'put', data })
}

export function delComment(commentId) {
  return request({ url: '/edu/comment/' + commentId, method: 'delete' })
}

export function listResourceComments(resourceId) {
  return request({ url: '/edu/comment/resource/' + resourceId, method: 'get' })
}

export function auditComment(commentId, auditStatus, remark) {
  return request({ url: '/edu/comment/audit/' + commentId + '/' + auditStatus, method: 'put', params: { remark } })
}
