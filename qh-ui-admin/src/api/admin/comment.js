import request from '@/utils/request'

// 查询评价列表
export function listComment(query) {
  return request({
    url: '/admin/comment/list',
    method: 'get',
    params: query
  })
}

// 查询评价详细
export function getComment(id) {
  return request({
    url: '/admin/comment/' + id,
    method: 'get'
  })
}

// 新增评价
export function addComment(data) {
  return request({
    url: '/admin/comment',
    method: 'post',
    data: data
  })
}

// 修改评价
export function updateComment(data) {
  return request({
    url: '/admin/comment',
    method: 'put',
    data: data
  })
}

// 删除评价
export function delComment(id) {
  return request({
    url: '/admin/comment/' + id,
    method: 'delete'
  })
}
