import request from '@/utils/request'

// 查询企业管理列表
export function listEtp(query) {
  return request({
    url: '/admin/etp/list',
    method: 'get',
    params: query
  })
}

// 查询企业管理详细
export function getEtp(id) {
  return request({
    url: '/admin/etp/' + id,
    method: 'get'
  })
}

// 新增企业管理
export function addEtp(data) {
  return request({
    url: '/admin/etp',
    method: 'post',
    data: data
  })
}

// 修改企业管理
export function updateEtp(data) {
  return request({
    url: '/admin/etp',
    method: 'put',
    data: data
  })
}

// 删除企业管理
export function delEtp(id) {
  return request({
    url: '/admin/etp/' + id,
    method: 'delete'
  })
}
