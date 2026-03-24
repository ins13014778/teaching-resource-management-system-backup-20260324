import request from '@/utils/request'

export function listAudit(query) {
  return request({
    url: '/edu/audit/list',
    method: 'get',
    params: query
  })
}

export function getAudit(auditId) {
  return request({
    url: '/edu/audit/' + auditId,
    method: 'get'
  })
}

export function passAudit(data) {
  return request({
    url: '/edu/audit/pass',
    method: 'put',
    data
  })
}

export function rejectAudit(data) {
  return request({
    url: '/edu/audit/reject',
    method: 'put',
    data
  })
}

export function offlineAudit(data) {
  return request({
    url: '/edu/audit/offline',
    method: 'put',
    data
  })
}
