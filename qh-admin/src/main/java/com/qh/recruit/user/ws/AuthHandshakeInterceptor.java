package com.qh.recruit.user.ws;

import com.qh.recruit.common.core.domain.model.LoginUser;
import com.qh.recruit.user.domain.LoginDto;
import com.qh.recruit.user.service.LoginService;
import com.qh.recruit.user.util.UserHolder;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import javax.annotation.Resource;
import java.net.URI;
import java.util.Map;

@Component
public class AuthHandshakeInterceptor implements HandshakeInterceptor {

    @Resource
    private LoginService loginService;


    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                   WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {

        URI uri = request.getURI();
        String query = uri.getQuery(); // 获取 token=xxxx

        if (query == null || !query.startsWith("token=")) {
            return false;
        }

        String token = query.split("=")[1];
        try{
            LoginDto loginUser = (LoginDto) loginService.tokenLogin(token).get("data"); // 返回 userId 或抛出异常
            attributes.put("userId",loginUser.getId());
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
                               WebSocketHandler wsHandler, Exception exception) {}
}
