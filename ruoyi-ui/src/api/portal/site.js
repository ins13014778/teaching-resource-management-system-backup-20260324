import request from '@/utils/request'

export function getPortalOverview() {
  return request({
    url: '/portal/home/overview',
    method: 'get',
    headers: {
      isToken: false
    }
  })
}

export function getPortalHomeConfig() {
  return request({
    url: '/portal/home/config',
    method: 'get',
    headers: {
      isToken: false
    }
  })
}

export function listPortalNotices(query) {
  return request({
    url: '/portal/notices',
    method: 'get',
    params: query,
    headers: {
      isToken: false
    }
  })
}

export function getPortalNotice(noticeId) {
  return request({
    url: `/portal/notices/${noticeId}`,
    method: 'get',
    headers: {
      isToken: false
    }
  })
}
