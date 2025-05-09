import request from '@/utils/request'

// 查询沟通列表
export function listCommunicate(query) {
  return request({
    url: '/admin/communicate/list',
    method: 'get',
    params: query
  })
}

// 查询沟通详细
export function getCommunicate(id) {
  return request({
    url: '/admin/communicate/' + id,
    method: 'get'
  })
}

// 新增沟通
export function addCommunicate(data) {
  return request({
    url: '/admin/communicate',
    method: 'post',
    data: data
  })
}

// 修改沟通
export function updateCommunicate(data) {
  return request({
    url: '/admin/communicate',
    method: 'put',
    data: data
  })
}

// 删除沟通
export function delCommunicate(id) {
  return request({
    url: '/admin/communicate/' + id,
    method: 'delete'
  })
}
