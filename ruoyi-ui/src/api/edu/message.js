import request from '@/utils/request'

export function listMessage(query) {
  return request({ url: '/edu/message/list', method: 'get', params: query })
}

export function listMyMessage(query) {
  return request({ url: '/edu/message/my', method: 'get', params: query })
}

export function getMessage(messageId) {
  return request({ url: '/edu/message/' + messageId, method: 'get' })
}

export function addMessage(data) {
  return request({ url: '/edu/message', method: 'post', data })
}

export function readMessage(messageId) {
  return request({ url: '/edu/message/read/' + messageId, method: 'post' })
}

export function delMessage(messageId) {
  return request({ url: '/edu/message/' + messageId, method: 'delete' })
}
