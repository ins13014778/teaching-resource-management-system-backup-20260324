import request from '@/utils/request'

export function listSpace(query) {
  return request({
    url: '/edu/space/list',
    method: 'get',
    params: query
  })
}

export function getSpace(fileId) {
  return request({
    url: '/edu/space/' + fileId,
    method: 'get'
  })
}

export function addSpace(data) {
  return request({
    url: '/edu/space',
    method: 'post',
    data
  })
}

export function updateSpace(data) {
  return request({
    url: '/edu/space',
    method: 'put',
    data
  })
}

export function delSpace(fileId) {
  return request({
    url: '/edu/space/' + fileId,
    method: 'delete'
  })
}