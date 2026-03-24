import request from '@/utils/request'

export function listDownload(query) {
  return request({ url: '/edu/download/list', method: 'get', params: query })
}

export function delDownload(logId) {
  return request({ url: '/edu/download/' + logId, method: 'delete' })
}
