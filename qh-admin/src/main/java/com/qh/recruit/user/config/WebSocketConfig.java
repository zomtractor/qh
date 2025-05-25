package com.qh.recruit.user.config;

import com.qh.recruit.user.ws.AuthHandshakeInterceptor;
import com.qh.recruit.user.ws.ChatWebSocketHandler;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.*;

import javax.annotation.Resource;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Resource
    private ChatWebSocketHandler chatWebSocketHandler;

    @Resource
    private AuthHandshakeInterceptor authHandshakeInterceptor;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(chatWebSocketHandler, "/ws-chat")
                .setAllowedOrigins("*")
                .addInterceptors(authHandshakeInterceptor);
    }
}