// LoginService.java
package com.qh.recruit.user.service;

import com.qh.recruit.admin.domain.User;
import com.qh.recruit.admin.mapper.UserMapper;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.redis.RedisCache;
import com.qh.recruit.common.exception.user.UserException;
import com.qh.recruit.common.utils.bean.BeanUtils;
import com.qh.recruit.common.utils.spring.SpringUtils;
import com.qh.recruit.common.utils.uuid.IdUtils;
import com.qh.recruit.framework.web.service.SysLoginService;
import com.qh.recruit.user.util.email.LoginEmailSender;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.time.Duration;
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

    @Resource
    private StringRedisTemplate template;

    public AjaxResult login(String role, String username,  String password, String code, String uuid) {
        try{
            sysLoginService.validateCaptcha(username,code,uuid);
            sysLoginService.loginPreCheck(username,password);
        } catch (UserException e) {
            return AjaxResult.error(e.getMessage());
        }
        User user = "job_seeker".equals(role) ? userMapper.selectJobSeekerByIdentifier(username) : userMapper.selectEnterpriseByIdentifier(username);
        if (user == null) {
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
        String token = user.getUserType()+IdUtils.fastUUID();
//        Map<String, Object> claims = new HashMap<>();
//        claims.put(Constants.LOGIN_USER_KEY, token);
//        claims.put(Constants.JWT_USERNAME, user.getUsername());
//        return Jwts.builder()
//                .setClaims(claims)
//                .signWith(SignatureAlgorithm.HS512, secret).compact();
        template.opsForValue().set("token:"+token, ""+user.getId(), Duration.ofHours(1)) ;
        return token;

    }

    public AjaxResult emailLogin(String role, String username, String password, String code, String uuid) {

        try{
            sysLoginService.validateCaptcha(username,code,uuid);
            sysLoginService.loginPreCheck(username,password);
        } catch (UserException e) {
            return AjaxResult.error(e.getMessage());
        }
        User user = "job_seeker".equals(role) ? userMapper.selectJobSeekerByIdentifier(username) : userMapper.selectEnterpriseByIdentifier(username);
        if (user == null) {
            return AjaxResult.error("用户不存在或身份不匹配");
        }

        if (!Objects.equals(password, user.getPassword())) {
            return AjaxResult.error("密码错误");
        }
        // 构造令牌并返回
        return AjaxResult.success("登录成功", createToken(user));
    }


    public AjaxResult sendEmail(String role, String email, String code, String uuid) {
        User user = "job_seeker".equals(role) ? userMapper.selectJobSeekerByIdentifier(email) : userMapper.selectEnterpriseByIdentifier(email);
        if(user == null) {
            return AjaxResult.error("用户不存在或身份不匹配");
        }
        AjaxResult login = login(role, user.getUsername(), user.getPassword(), code, uuid);
        if(!login.get("code").equals(200)) {
            return login;
        }
        LoginEmailSender loginEmailSender = SpringUtils.getBean(LoginEmailSender.class);
        String token = (String) login.get("data");
        try {
            loginEmailSender.sendVerificationEmail(email,token);
        } catch (Exception e) {
            return AjaxResult.error("邮箱发送失败");
        }
        return AjaxResult.success();
    }

    public AjaxResult tokenLogin(String token) {
        String idStr = template.opsForValue().get("token:" + token);
        if (StringUtils.isEmpty(idStr)) {
            return AjaxResult.error("token已过期");
        }
        Long id = Long.valueOf(idStr);
        User user = userMapper.selectUserById(id);
        if (user == null) {
            return AjaxResult.error("用户不存在");
        }
        return AjaxResult.success("登录成功", createToken(user));
    }
}
