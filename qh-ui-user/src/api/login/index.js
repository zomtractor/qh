import request from '@/utils/request'

// 登录方法
export function login(data) {
  return request({
    url: '/login/login',
    headers: {
      isToken: false,
      repeatSubmit: false
    },
    method: 'post',
    data: data
  })
}

// 注册方法
export function register(data) {
  return request({
    url: '/login/register',
    headers: {
      isToken: false
    },
    method: 'post',
    data: data
  })
}
export function sendLoginEmail(data) {
  return request({
    url: '/login/sendLoginEmail',
    headers: {
      isToken: false
    },
    method: 'post',
    data: data
  })
}
export function sendRegisterEmail(data) {
  return request({
    url: '/login/sendRegisterEmail',
    headers: {
      isToken: false
    },
    method: 'post',
    data: data
  })
}
export function tokenLogin(token) {
    return request({
        url: `/login/tokenLogin?token=${token}`,
        headers: {
          isToken: false
        },
        method: 'post',
    })
}

// 获取用户详细信息
export function getInfo() {
  return request({
    url: '/login/getInfo',
    method: 'get'
  })
}

// 退出方法
export function logout() {
  return request({
    url: '/login/logout',
    method: 'post'
  })
}

// 获取验证码
export function getCodeImg() {
  return request({
    url: '/captchaImage',
    headers: {
      isToken: false
    },
    method: 'get',
    timeout: 20000
  })
}
