import request from '@/utils/request'

// 登录方法
export function listContact() {
    return request({
        url: '/jobSeeker/chat/who',
        method: 'get',
    })
}
export function listChats(id) {
    return request({
        url: '/jobSeeker/chat/list/'+id,
        method: 'get',
    })
}
export function postMsg(data) {
    return request({
        url: '/jobSeeker/chat',
        method: 'post',
        data: data
    })
}
