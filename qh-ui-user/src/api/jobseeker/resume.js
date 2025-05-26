import request from '@/utils/request'




export function getResumeImgs(userId) {
    return request({
        url: '/jobSeeker/get_resumeImgs',
        method: 'post',
        data: {user_id:userId},
         headers: {
            'Content-Type': 'application/x-www-form-urlencoded' // 明确指定表单格式
        }
    })
}

// 登录方法
export function getUserInfo(userId) {
    return request({
        url: '/jobSeeker/get_info',
        method: 'post',
        data: {user_id:userId},
         headers: {
            'Content-Type': 'application/x-www-form-urlencoded' // 明确指定表单格式
        }
    })
}

export function updateUserInfo(data) {
    return request({
        url: '/jobSeeker/updateUserInfo',
        method: 'post',
        data: data
    })
}


export function getInterviewInfo(data) {
    return request({
        url: '/jobSeeker/getInterviewInfo',
        method: 'post',
        params: data
    })
}
