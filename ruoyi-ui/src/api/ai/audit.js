import request from '@/utils/request'

export function listAiAudit(query) {
  return request({ url: '/ai/audit/list', method: 'get', params: query })
}

export function getAiAudit(resultId) {
  return request({ url: '/ai/audit/' + resultId, method: 'get' })
}

export function delAiAudit(resultId) {
  return request({ url: '/ai/audit/' + resultId, method: 'delete' })
}

export function runAiResourceAudit(resourceId) {
  return request({ url: '/ai/resource/audit/' + resourceId, method: 'get' })
}
