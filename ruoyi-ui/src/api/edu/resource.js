import request from '@/utils/request'

export function listResource(query) {
  return request({
    url: '/edu/resource/list',
    method: 'get',
    params: query
  })
}

export function getResource(resourceId) {
  return request({
    url: '/edu/resource/' + resourceId,
    method: 'get'
  })
}

export function addResource(data) {
  return request({
    url: '/edu/resource',
    method: 'post',
    data
  })
}

export function updateResource(data) {
  return request({
    url: '/edu/resource',
    method: 'put',
    data
  })
}

export function delResource(resourceId) {
  return request({
    url: '/edu/resource/' + resourceId,
    method: 'delete'
  })
}

export function submitResource(resourceId) {
  return request({
    url: '/edu/resource/submit/' + resourceId,
    method: 'post'
  })
}

export function recommendResource(resourceId, recommendFlag) {
  return request({
    url: '/edu/resource/recommend/' + resourceId + '/' + recommendFlag,
    method: 'put'
  })
}

export function downloadResource(resourceId) {
  return request({
    url: '/edu/resource/download/' + resourceId,
    method: 'post'
  })
}

export function getResourceFormOptions() {
  return request({
    url: '/edu/resource/formOptions',
    method: 'get'
  })
}
