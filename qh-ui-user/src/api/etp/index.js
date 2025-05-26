import request from "@/utils/request";

export function loadMyCompany(id) {
    return request({
        url: '/etp/my/'+id,
        method: 'get',
    })
}
export function updateEtp(data){
    return request({
        url: '/etp',
        method: 'put',
        data: data
    })
}