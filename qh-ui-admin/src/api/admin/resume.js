import request from '@/utils/request'

// 查询简历列表
export function listResume(query) {
  return request({
    url: '/admin/resume/list',
    method: 'get',
    params: query
  })
}

// 查询简历详细
export function getResume(id) {
  return request({
    url: '/admin/resume/' + id,
    method: 'get'
  })
}

// 新增简历
export function addResume(data) {
  return request({
    url: '/admin/resume',
    method: 'post',
    data: data
  })
}

// 修改简历
export function updateResume(data) {
  return request({
    url: '/admin/resume',
    method: 'put',
    data: data
  })
}

// 删除简历
export function delResume(id) {
  return request({
    url: '/admin/resume/' + id,
    method: 'delete'
  })
}
