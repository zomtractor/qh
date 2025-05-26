import request from '@/utils/request'

// 查询面试列表
export function listInterview(query) {
    return request({
      url: '/jobSeeker/interviewList',
      method: 'get',
      params: query
    })
  }
  
  // 查询面试详细
  export function getInterview(interviewId) {
    return request({
      url: '/jobSeeker/interview/' + interviewId,
      method: 'get'
    })
  }
  
  // 新增面试
  export function addInterview(data) {
    return request({
      url: '/jobSeeker/addInterview',
      method: 'post',
      data: data
    })
  }
  
  // 修改面试
  export function updateInterview(data) {
    return request({
      url: '/jobSeeker/editInterview',
      method: 'put',
      data: data
    })
  }
  
  // 删除面试
  export function delInterview(interviewId) {
    return request({
      url: '/system/interview/' + interviewId,
      method: 'delete'
    })
  }

  // 面试状态修改
export function changeInterviewStatus(interviewId, status) {
    const data = {
      interviewId,
      status
    }
    return request({
      url: '/system/interview/changeStatus',
      method: 'put',
      data: data
    })
  }

  export function joblist(query) {
    return request({
      url: '/jobSeeker/job/list',
      method: 'get',
      params: query
    })
  }

  export function etplist(query) {
    return request({
      url: '/etp/list',
      method: 'get',
      params: query
    })
  }

  export function userlist(query) {
    return request({
      url: '/jobSeeker/userList',
      method: 'get',
      params: query
    })
  }