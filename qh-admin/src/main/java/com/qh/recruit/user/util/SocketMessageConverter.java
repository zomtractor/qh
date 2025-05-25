package com.qh.recruit.user.util;

import com.alibaba.fastjson2.JSONObject;
import com.qh.recruit.admin.domain.Communicate;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.converter.MessageConverter;
import org.springframework.messaging.support.GenericMessage;
import org.springframework.web.socket.TextMessage;

public class SocketMessageConverter implements MessageConverter {

    @Override
    public Object fromMessage(Message<?> message, Class<?> targetClass) {
        if (message.getPayload() instanceof TextMessage) {
            TextMessage textMessage = (TextMessage) message.getPayload();
            String payload = textMessage.getPayload();
            return decodeWebSocketMessage(payload);
        }
        // 处理内部系统消息
        return message.getPayload();
    }

    @Override
    public Message<?> toMessage(Object payload, MessageHeaders headers) {
        // 处理发往WebSocket的消息
        String encoded = encodeWebSocketMessage(payload);
        return new GenericMessage<>(encoded, headers);
    }

    private Object decodeWebSocketMessage(String raw) {
        int signal = Integer.parseInt(raw.substring(0, 1));
        int length = Integer.parseInt(raw.substring(1, 5));
        String json = raw.substring(5, 5 + length);

        switch (signal) {
            case 1: return JSONObject.parseObject(json,boolean.class);
            case 2: return JSONObject.parseObject(json, Communicate.class);
            default: throw new IllegalArgumentException("未知信号类型");
        }
    }

    private String encodeWebSocketMessage(Object payload) {
        int signal = payload instanceof Communicate ? 2 : 1;
        String json = JSONObject.toJSONString(payload);
        return signal + String.format("%04d", json.length()) + json;
    }
}