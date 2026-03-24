import request from '@/utils/request'

export function basicSearch(query) {
  return request({ url: '/ai/search/basic', method: 'get', params: query })
}

export function semanticSearch(query) {
  return request({ url: '/ai/search/semantic', method: 'get', params: query })
}
