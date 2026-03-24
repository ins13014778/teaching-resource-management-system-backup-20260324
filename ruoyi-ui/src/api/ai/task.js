import request from '@/utils/request'

export function listAiTask(query) {
  return request({ url: '/ai/task/list', method: 'get', params: query })
}

export function getAiTask(taskId) {
  return request({ url: '/ai/task/' + taskId, method: 'get' })
}

export function runAiTask(resourceId) {
  return request({ url: '/ai/task/run/' + resourceId, method: 'post' })
}

export function delAiTask(taskId) {
  return request({ url: '/ai/task/' + taskId, method: 'delete' })
}
