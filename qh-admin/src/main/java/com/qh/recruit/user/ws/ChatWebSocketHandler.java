package com.qh.recruit.user.ws;

import com.alibaba.fastjson2.JSONObject;
import com.qh.recruit.admin.domain.Communicate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import javax.annotation.Resource;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {
    private static final Map<Long, WebSocketSession> userSessions = new ConcurrentHashMap<>();

    @Resource
    private StringRedisTemplate template;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        Long userId = getUserId(session);
        userSessions.put(userId, session);

        // 推送在线人数
        pushOnlineStats(userId);
        // 推送未读消息统计
        pushUnreadStats(userId);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        JSONObject json = JSONObject.parseObject(message.getPayload());
        String type = json.getString("type");
        Long fromId = json.getLong("fromId");
        Long toId = json.getLong("toId");
        System.out.println(json);
        switch (type) {
            case "chat":
                JSONObject msgObj = json.getJSONObject("data");
                Communicate comm = msgObj.toJavaObject(Communicate.class);
                template.opsForHash().increment("unread:" + toId, String.valueOf(fromId), 1);
                WebSocketSession toSession = userSessions.get(toId);
                if (toSession != null && toSession.isOpen()) {
                    toSession.sendMessage(new TextMessage(message.getPayload()));
                }
                break;
            case "read":
                String base = "unread:" + fromId;
                Set<String> keys = template.keys(base+":*");
                if(keys!=null){
                    int n = 0;
                    String str = template.opsForValue().get(base+":"+toId);
                    if(str!=null){
                        n = Integer.parseInt(str);
                    }
                    template.delete(base+":"+toId);
                    template.opsForValue().decrement(base+":total",n);
                    pushUnreadStats(fromId);
                }
                break;
        }
    }
    public void sendText(Communicate communicate) throws Exception {
        String base = "unread:" + communicate.getReceiverId();
        WebSocketSession toSession = userSessions.get(communicate.getReceiverId());
        template.opsForValue().increment(base+":total");
        template.opsForValue().increment(base+":"+communicate.getPosterId());
        if (toSession != null && toSession.isOpen()) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("type", "chat");
            jsonObject.put("fromId", communicate.getPosterId());
            jsonObject.put("toId", communicate.getReceiverId());
            jsonObject.put("data", communicate);
            toSession.sendMessage(new TextMessage(jsonObject.toJSONString()));
            pushUnreadStats(communicate.getReceiverId());
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        Long userId = getUserId(session);
        userSessions.remove(userId);
    }

    private Long getUserId(WebSocketSession session) {
        // 从 URL 查询参数或 header 获取 userId
        return (Long) session.getAttributes().get("userId");
    }

    private void pushOnlineStats(Long userId) throws Exception {
        Set<Long> online = userSessions.keySet();
        JSONObject msg = new JSONObject();
        msg.put("type", "online");
        msg.put("toId", userId);
        msg.put("fromId", null);
        msg.put("timestamp", System.currentTimeMillis());

        JSONObject data = new JSONObject();
        data.put("relatedUserCount", online.size() - 1);
        data.put("userIds", online.stream().filter(id -> !id.equals(userId)).collect(Collectors.toList()));
        msg.put("data", data);

        WebSocketSession session = userSessions.get(userId);
        if (session != null && session.isOpen()) {
            session.sendMessage(new TextMessage(msg.toJSONString()));
        }
    }

    private void pushUnreadStats(Long userId) throws Exception {
        JSONObject msg = new JSONObject();
        msg.put("type", "stats");
        msg.put("toId", userId);
        msg.put("fromId", null);
        msg.put("timestamp", System.currentTimeMillis());

        JSONObject data = new JSONObject();
        String base = "unread:" + userId;
        Set<String> keys = template.keys(base+":*");
        if (keys != null && !keys.isEmpty()) {
            data.put("total", template.opsForValue().get(base + ":total"));
            for(String key : keys) {
                if(key.equals(base+":total")) continue;
                data.put(key.substring(base.length()+1), template.opsForValue().get(key));
            }
        } else {
            data.put("total", 0);
        }
        msg.put("data", data);

        WebSocketSession session = userSessions.get(userId);
        if (session != null && session.isOpen()) {
            session.sendMessage(new TextMessage(msg.toJSONString()));
        }
    }
}
