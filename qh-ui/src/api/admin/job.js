import request from '@/utils/request'

// 查询岗位列表
export function listJob(query) {
  return request({
    url: '/admin/job/list',
    method: 'get',
    params: query
  })
}

// 查询岗位详细
export function getJob(id) {
  return request({
    url: '/admin/job/' + id,
    method: 'get'
  })
}

// 新增岗位
export function addJob(data) {
  return request({
    url: '/admin/job',
    method: 'post',
    data: data
  })
}

// 修改岗位
export function updateJob(data) {
  return request({
    url: '/admin/job',
    method: 'put',
    data: data
  })
}

// 删除岗位
export function delJob(id) {
  return request({
    url: '/admin/job/' + id,
    method: 'delete'
  })
}
