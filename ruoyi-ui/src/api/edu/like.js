import request from '@/utils/request'

export function listLike(query) {
  return request({ url: '/edu/like/list', method: 'get', params: query })
}

export function toggleLike(resourceId) {
  return request({ url: '/edu/like/toggle/' + resourceId, method: 'post' })
}

export function delLike(likeId) {
  return request({ url: '/edu/like/' + likeId, method: 'delete' })
}
