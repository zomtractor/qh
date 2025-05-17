// LoginService.java
package com.qh.recruit.user.service;

import com.qh.recruit.admin.domain.User;
import com.qh.recruit.admin.mapper.UserMapper;
import com.qh.recruit.common.constant.Constants;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.domain.model.LoginUser;
import com.qh.recruit.common.core.redis.RedisCache;
import com.qh.recruit.common.exception.user.UserException;
import com.qh.recruit.common.utils.SecurityUtils;
import com.qh.recruit.common.utils.uuid.IdUtils;
import com.qh.recruit.framework.web.service.SysLoginService;
import com.qh.recruit.framework.web.service.TokenService;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@Service
public class LoginService {

    @Value("${token.secret}")
    private String secret;

    @Resource
    private UserMapper userMapper;

    @Resource
    private RedisCache redisCache;

    @Resource
    private SysLoginService sysLoginService;

    public AjaxResult login(String role, String username,  String password, String code, String uuid) {

        try{
            sysLoginService.validateCaptcha(username,code,uuid);
            sysLoginService.loginPreCheck(username,password);
        } catch (UserException e) {
            return AjaxResult.error(e.getMessage());
        }
        // 查询用户
        User user = StringUtils.hasText(username) ? userMapper.selectJobSeekerByIdentifier(username) : null;
        if (user == null || !Objects.equals(user.getUserType(), role)) {
            return AjaxResult.error("用户不存在或身份不匹配");
        }

        if (!Objects.equals(password, user.getPassword())) {
            return AjaxResult.error("密码错误");
        }
        // 构造令牌并返回
        return AjaxResult.success("登录成功", createToken(user));
    }
    private String createToken(User user)
    {
        String token = IdUtils.fastUUID();
        Map<String, Object> claims = new HashMap<>();
        claims.put(Constants.LOGIN_USER_KEY, token);
        claims.put(Constants.JWT_USERNAME, user.getUsername());
        return Jwts.builder()
                .setClaims(claims)
                .signWith(SignatureAlgorithm.HS512, secret).compact();

    }
}
