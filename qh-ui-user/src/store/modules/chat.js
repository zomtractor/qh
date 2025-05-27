import {getToken} from "@/utils/auth";
import {getCurrentUser} from "@/utils/local";

const state = {
    socket: null,
    userId: null,
    unreadStats: {
        total: 0,
    },
    newMessages: [],
}

const mutations = {
    SET_SOCKET(state, socket) {
        state.socket = socket
    },
    SET_USER_ID(state, id) {
        state.userId = id
    },
    SET_ONLINE_USERS(state, users) {
        state.onlineUsers = users
    },
    SET_UNREAD_STATS(state, stats) {
        state.unreadStats = stats
    }
}

const actions = {
    connect({commit, state, dispatch}) {
        if (state.socket) return;

        const socket = new WebSocket(`ws://${location.host}:8080/ws-chat?token=${getToken()}`);
        commit('SET_USER_ID', getCurrentUser().id);
        commit('SET_SOCKET', socket);

        socket.onmessage = (event) => {
            const msg = JSON.parse(event.data);
            switch (msg.type) {
                case 'chat':
                    console.log('收到聊天消息:', msg);
                    // 可在此提交消息到另一个模块中处理
                    state.newMessages.push(msg.data)
                    break;
                case 'stats':
                    console.log('收到未读消息统计:', msg);
                    commit('SET_UNREAD_STATS', msg.data);
                    break;
                case 'online':
                    commit('SET_ONLINE_USERS', msg.data.userIds);
                    break;
            }
        };
    },

    sendMessage({state}, message) {
        if (!state.socket) return;
        const data = {
            type: "chat",
            fromId: message.posterId,
            toId: message.receiverId,
            timestamp: Date.now(),
            data: {
                ...message
            }
        };
        state.socket.send(JSON.stringify(data));
    },
    readSomeone({date},toId){
        if (!state.socket) return;
        const data = {
            type: "read",
            fromId: getCurrentUser().id,
            toId: toId,
            timestamp: Date.now(),
        };
        state.socket.send(JSON.stringify(data));
    }
}

export default {
    namespaced: true,
    state,
    mutations,
    actions
}
