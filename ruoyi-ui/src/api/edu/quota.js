import request from '@/utils/request'

export function listQuota(query) {
  return request({
    url: '/edu/quota/list',
    method: 'get',
    params: query
  })
}

export function getQuota(quotaId) {
  return request({
    url: '/edu/quota/' + quotaId,
    method: 'get'
  })
}

export function updateQuota(data) {
  return request({
    url: '/edu/quota',
    method: 'put',
    data
  })
}
