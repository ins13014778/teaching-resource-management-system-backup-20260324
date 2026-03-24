import request from '@/utils/request'

export function listAiPrompt(query) {
  return request({ url: '/ai/prompt/list', method: 'get', params: query })
}

export function getAiPrompt(templateId) {
  return request({ url: '/ai/prompt/' + templateId, method: 'get' })
}

export function addAiPrompt(data) {
  return request({ url: '/ai/prompt', method: 'post', data })
}

export function updateAiPrompt(data) {
  return request({ url: '/ai/prompt', method: 'put', data })
}

export function delAiPrompt(templateId) {
  return request({ url: '/ai/prompt/' + templateId, method: 'delete' })
}
