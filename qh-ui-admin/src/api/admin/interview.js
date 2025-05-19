import request from '@/utils/request'

// 查询面试列表
export function listInterview(query) {
  return request({
    url: '/admin/interview/list',
    method: 'get',
    params: query
  })
}

// 查询面试详细
export function getInterview(id) {
  return request({
    url: '/admin/interview/' + id,
    method: 'get'
  })
}

// 新增面试
export function addInterview(data) {
  return request({
    url: '/admin/interview',
    method: 'post',
    data: data
  })
}

// 修改面试
export function updateInterview(data) {
  return request({
    url: '/admin/interview',
    method: 'put',
    data: data
  })
}

// 删除面试
export function delInterview(id) {
  return request({
    url: '/admin/interview/' + id,
    method: 'delete'
  })
}
