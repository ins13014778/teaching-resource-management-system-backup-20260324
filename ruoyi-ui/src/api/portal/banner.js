import request from '@/utils/request'

export function listPortalBanner(query) {
  return request({
    url: '/portal/admin/banner/list',
    method: 'get',
    params: query
  })
}

export function getPortalBanner(bannerId) {
  return request({
    url: `/portal/admin/banner/${bannerId}`,
    method: 'get'
  })
}

export function addPortalBanner(data) {
  return request({
    url: '/portal/admin/banner',
    method: 'post',
    data
  })
}

export function updatePortalBanner(data) {
  return request({
    url: '/portal/admin/banner',
    method: 'put',
    data
  })
}

export function delPortalBanner(bannerId) {
  return request({
    url: `/portal/admin/banner/${bannerId}`,
    method: 'delete'
  })
}
