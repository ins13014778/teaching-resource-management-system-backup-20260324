import request from '@/utils/request'

export function listQaLog(query) {
  return request({ url: '/ai/qa/log/list', method: 'get', params: query })
}

export function askAiQuestion(question) {
  return request({ url: '/ai/qa/ask', method: 'post', data: { question } })
}

export function delQaLog(qaId) {
  return request({ url: '/ai/qa/log/' + qaId, method: 'delete' })
}
