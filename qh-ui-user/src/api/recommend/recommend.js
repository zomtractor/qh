import request from '@/utils/request'

// 获取推荐职位列表
export function getRecommendJobs(data) {
  return request({
    url: '/jobSeeker/recommend/list',
    method: 'post',
    data
  })
}

// 与职位发布者沟通
export function communicateWithRecruiter(data) {
  const { jobId } = data
  return request({
    url: `/jobSeeker/recommend/communicate/${jobId}`,
    method: 'post'
  })
}

// 投递简历
export function submitResumeToJob(data) {
  const { jobId } = data
  return request({
    url: `/jobSeeker/recommend/submit/${jobId}`,
    method: 'post'
  })
}