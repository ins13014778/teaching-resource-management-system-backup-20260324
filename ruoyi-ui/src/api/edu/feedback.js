import request from '@/utils/request'

export function listFeedback(query) {
  return request({ url: '/edu/feedback/list', method: 'get', params: query })
}

export function getFeedback(feedbackId) {
  return request({ url: '/edu/feedback/' + feedbackId, method: 'get' })
}

export function addFeedback(data) {
  return request({ url: '/edu/feedback', method: 'post', data })
}

export function replyFeedback(data) {
  return request({ url: '/edu/feedback/reply', method: 'put', data })
}

export function delFeedback(feedbackId) {
  return request({ url: '/edu/feedback/' + feedbackId, method: 'delete' })
}
