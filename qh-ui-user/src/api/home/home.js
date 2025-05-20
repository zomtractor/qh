import request from '@/utils/request'

// 搜索方法
export function search(params) {
  return request({
    url: '/search',
    method: 'get',
    params
  })
}

// 确认筛选条件方法
export function confirmFilters(params) {
  return request({
    url: '/confirm',
    method: 'post',
    data: params
  })
}

// 分页方法
export function getPage(params) {
  return request({
    url: '/page',
    method: 'get',
    params
  })
}

// 沟通方法
export function communicate(jobId) {
  return request({
    url: `/${jobId}/communicate`,
    method: 'post'
  });
}

// 投递简历方法
export function submitResume(jobId) {
  return request({
    url: `/${jobId}/submit`,
    method: 'post'
  });
}
