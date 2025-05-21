package com.qh.recruit.user.aop;

import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.exception.user.UserException;
import com.qh.recruit.common.utils.bean.BeanUtils;
import com.qh.recruit.common.utils.spring.SpringUtils;
import com.qh.recruit.user.domain.LoginDto;
import com.qh.recruit.user.service.LoginService;
import com.qh.recruit.user.util.UserHolder;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TokenInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String token = request.getHeader("Authorization");
        if (token == null || token.isEmpty()) {
            throw new UserException("login.blocked", "请登录");
        }
        LoginService service = SpringUtils.getBean(LoginService.class);
        AjaxResult ajaxResult = service.tokenLogin(token);
        if (ajaxResult.isError()) {
            throw new UserException("login.blocked", "token已过期");
        } else {
            UserHolder.setUser(((LoginDto) ajaxResult.get("data")));
            return true;
        }
//        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        UserHolder.remove();
    }
}
