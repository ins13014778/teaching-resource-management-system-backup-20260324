import request from '@/utils/request'

export function listCategory(query) {
  return request({
    url: '/edu/category/list',
    method: 'get',
    params: query
  })
}

export function listCategoryExcludeChild(categoryId) {
  return request({
    url: '/edu/category/list/exclude/' + categoryId,
    method: 'get'
  })
}

export function getCategory(categoryId) {
  return request({
    url: '/edu/category/' + categoryId,
    method: 'get'
  })
}

export function addCategory(data) {
  return request({
    url: '/edu/category',
    method: 'post',
    data
  })
}

export function updateCategory(data) {
  return request({
    url: '/edu/category',
    method: 'put',
    data
  })
}

export function delCategory(categoryId) {
  return request({
    url: '/edu/category/' + categoryId,
    method: 'delete'
  })
}
