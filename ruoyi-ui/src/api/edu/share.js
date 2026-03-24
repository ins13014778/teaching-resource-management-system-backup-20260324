import request from '@/utils/request'

export function listShare(query) {
  return request({
    url: '/edu/share/list',
    method: 'get',
    params: query
  })
}

export function getShare(shareId) {
  return request({
    url: '/edu/share/' + shareId,
    method: 'get'
  })
}

export function addShare(data) {
  return request({
    url: '/edu/share',
    method: 'post',
    data
  })
}

export function updateShare(data) {
  return request({
    url: '/edu/share',
    method: 'put',
    data
  })
}

export function delShare(shareId) {
  return request({
    url: '/edu/share/' + shareId,
    method: 'delete'
  })
}
