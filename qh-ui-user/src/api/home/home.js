import request from '@/utils/request'

// 搜索方法
export function search(params) {
  return request({
    url: '/jobSeeker/search',
    method: 'get',
    params
  })
}

// 确认筛选条件方法
export function confirmFilters(params) {
  return request({
    url: '/jobSeeker/confirm',
    method: 'post',
    data: params
  })
}

// 首页按钮路径
export function navigateToHome() {
  return request({
    url: '/jobSeeker/list',
    method: 'get'
  });
}
