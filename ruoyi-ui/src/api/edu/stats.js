import request from '@/utils/request'

export function getStatsDashboard() {
  return request({ url: '/edu/stats/dashboard', method: 'get' })
}
