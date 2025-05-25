import request from '@/utils/request'

// 搜索方法
export function jobList(query) {
  return request({
    url: '/jobSeeker/job/list',
    method: 'get',
    params: query
  })
}

// 查询岗位详细
export function getJob(id) {
  return request({
    url: '/jobSeeker/job/' + id,
    method: 'get'
  })
}
