import request from '@/utils/request'

export function listReport(query) {
  return request({ url: '/edu/report/list', method: 'get', params: query })
}

export function getReport(reportId) {
  return request({ url: '/edu/report/' + reportId, method: 'get' })
}

export function addReport(data) {
  return request({ url: '/edu/report', method: 'post', data })
}

export function handleReport(data) {
  return request({ url: '/edu/report/handle', method: 'put', data })
}

export function delReport(reportId) {
  return request({ url: '/edu/report/' + reportId, method: 'delete' })
}
