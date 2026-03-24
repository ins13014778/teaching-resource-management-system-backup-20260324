import request from '@/utils/request'

export function listGrant(query) {
  return request({
    url: '/edu/grant/list',
    method: 'get',
    params: query
  })
}

export function getGrant(grantId) {
  return request({
    url: '/edu/grant/' + grantId,
    method: 'get'
  })
}

export function addGrant(data) {
  return request({
    url: '/edu/grant',
    method: 'post',
    data
  })
}

export function updateGrant(data) {
  return request({
    url: '/edu/grant',
    method: 'put',
    data
  })
}

export function delGrant(grantId) {
  return request({
    url: '/edu/grant/' + grantId,
    method: 'delete'
  })
}
