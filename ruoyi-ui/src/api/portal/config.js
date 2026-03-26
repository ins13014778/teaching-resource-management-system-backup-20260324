import request from '@/utils/request'

export function getCurrentPortalConfig() {
  return request({
    url: '/portal/admin/config/current',
    method: 'get'
  })
}

export function updatePortalConfig(data) {
  return request({
    url: '/portal/admin/config',
    method: 'put',
    data
  })
}
