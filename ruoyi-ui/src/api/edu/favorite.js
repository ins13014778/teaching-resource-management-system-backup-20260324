import request from '@/utils/request'

export function listFavorite(query) {
  return request({ url: '/edu/favorite/list', method: 'get', params: query })
}

export function getFavorite(favoriteId) {
  return request({ url: '/edu/favorite/' + favoriteId, method: 'get' })
}

export function toggleFavorite(resourceId) {
  return request({ url: '/edu/favorite/toggle/' + resourceId, method: 'post' })
}

export function delFavorite(favoriteId) {
  return request({ url: '/edu/favorite/' + favoriteId, method: 'delete' })
}
