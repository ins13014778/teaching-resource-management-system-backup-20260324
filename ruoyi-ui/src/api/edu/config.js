import request from '@/utils/request'

export function getCurrentConfig() {
  return request({
    url: '/edu/config/current',
    method: 'get'
  })
}

export function updateConfig(data) {
  return request({
    url: '/edu/config',
    method: 'put',
    data
  })
}
