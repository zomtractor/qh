// LoginService.java
package com.qh.recruit.user.service;

import com.qh.recruit.admin.domain.User;
import com.qh.recruit.admin.mapper.UserMapper;
import com.qh.recruit.common.constant.Constants;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.domain.model.LoginUser;
import com.qh.recruit.common.core.redis.RedisCache;
import com.qh.recruit.common.utils.SecurityUtils;
import com.qh.recruit.common.utils.uuid.IdUtils;
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
    private TokenService tokenService;

    public AjaxResult login(String role, String username, String phone, String password, String code, String uuid) {
        // 校验验证码
        String verifyKey = "captcha_codes:" + uuid;
        String cachedCode = redisCache.getCacheObject(verifyKey);
        if (!StringUtils.hasText(cachedCode) || !cachedCode.equalsIgnoreCase(code)) {
            return AjaxResult.error("验证码错误");
        }

        // 查询用户
        User user = null;
        if ("job_seeker".equals(role)) {
            user = StringUtils.hasText(username) ? userMapper.selectJobSeekerByIdentifier(username) : null;
        } else if ("enterprise".equals(role)) {
            user = StringUtils.hasText(phone) ? userMapper.selectEnterpriseByIdentifier(phone) : null;
        }

        if (user == null || !Objects.equals(user.getUserType(), role)) {
            return AjaxResult.error("用户不存在或身份不匹配");
        }

        if (!SecurityUtils.matchesPassword(password, user.getPassword())) {
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
        String tokenf = Jwts.builder()
                .setClaims(claims)
                .signWith(SignatureAlgorithm.HS512, secret).compact();
        return tokenf;

    }
}
