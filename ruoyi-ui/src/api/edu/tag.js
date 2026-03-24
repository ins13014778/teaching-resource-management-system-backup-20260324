import request from '@/utils/request'

export function listTag(query) {
  return request({
    url: '/edu/tag/list',
    method: 'get',
    params: query
  })
}

export function getTag(tagId) {
  return request({
    url: '/edu/tag/' + tagId,
    method: 'get'
  })
}

export function addTag(data) {
  return request({
    url: '/edu/tag',
    method: 'post',
    data
  })
}

export function updateTag(data) {
  return request({
    url: '/edu/tag',
    method: 'put',
    data
  })
}

export function delTag(tagId) {
  return request({
    url: '/edu/tag/' + tagId,
    method: 'delete'
  })
}
