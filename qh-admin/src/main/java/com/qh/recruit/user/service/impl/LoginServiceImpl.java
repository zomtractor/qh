// LoginService.java
package com.qh.recruit.user.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.qh.recruit.admin.domain.Etp;
import com.qh.recruit.admin.domain.Resume;
import com.qh.recruit.admin.domain.User;
import com.qh.recruit.admin.mapper.EtpMapper;
import com.qh.recruit.admin.mapper.ResumeMapper;
import com.qh.recruit.admin.mapper.UserMapper;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.redis.RedisCache;
import com.qh.recruit.common.exception.user.UserException;
import com.qh.recruit.common.utils.spring.SpringUtils;
import com.qh.recruit.common.utils.uuid.IdUtils;
import com.qh.recruit.framework.web.service.SysLoginService;
import com.qh.recruit.user.domain.LoginDto;
import com.qh.recruit.user.service.LoginService;
import com.qh.recruit.user.util.email.LoginEmailSender;
import com.qh.recruit.user.util.email.RegisterEmailSender;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.time.Duration;
import java.util.Map;
import java.util.Objects;
import java.util.Random;

@Service
public class LoginServiceImpl implements LoginService {

    @Value("${token.secret}")
    private String secret;

    @Resource
    private UserMapper userMapper;

    @Resource
    private EtpMapper etpMapper;

    @Resource
    private ResumeMapper resumeMapper;

    @Resource
    private RedisCache redisCache;

    @Resource
    private SysLoginService sysLoginService;

    @Resource
    private StringRedisTemplate template;


    @Override
    public AjaxResult login(String role, String username, String password, String code, String uuid) {
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

    @Override
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

    @Override
    public AjaxResult sendLoginEmail(String role, String email, String code, String uuid) {
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

    @Override
    public AjaxResult tokenLogin(String token) {
        String idStr = template.opsForValue().get("token:" + token);
        if(idStr==null) idStr = template.opsForValue().get("token:" + token.split(" ")[1]);

        if (StringUtils.isEmpty(idStr)) {
            return AjaxResult.error("token已过期");
        }
        Long id = Long.valueOf(idStr);
        User user = userMapper.selectUserById(id);
        if (user == null) {
            return AjaxResult.error("用户不存在");
        }
        LoginDto dto = new LoginDto();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setUserType(user.getUserType());
        if("job_seeker".equals(user.getUserType())) {
            Resume resume = resumeMapper.selectResumeByUserId(id);
            if(resume == null) {
                return AjaxResult.error("用户对应信息不存在");
            }
            dto.setRefId(resume.getId());
            dto.setAvatar(resume.getAvatarFileId());
            dto.setName(resume.getName());
            dto.setPhone(resume.getPhone());
            dto.setEmail(resume.getEmail());
        } else {
            Etp etp = etpMapper.selectEtpByUserId(id);
            if(etp == null) {
                return AjaxResult.error("用户对应信息不存在");
            }
            dto.setRefId(etp.getId());
            dto.setName(etp.getName());
            dto.setPhone(etp.getPhone());
            dto.setEmail(etp.getEmail());
            dto.setAvatar(etp.getLogoFileId());
        }

        return AjaxResult.success("登录成功",dto);
    }

    @Override
    public AjaxResult tokenLogout(String token) {
        String idStr = template.opsForValue().get("token:" + token);
        if(idStr==null) idStr = template.opsForValue().get("token:" + token.split(" ")[1]);
        if (StringUtils.isEmpty(idStr)) {
            return AjaxResult.success();
        }

        return AjaxResult.success();
    }

    @Override
    public AjaxResult sendRegisterEmail(String role, String email, String code, String uuid) {
        try {
            sysLoginService.validateCaptcha("email", code, uuid);
        }catch (UserException e) {
            return AjaxResult.error(e.getMessage());
        }
        User user = "job_seeker".equals(role) ? userMapper.selectJobSeekerByIdentifier(email) : userMapper.selectEnterpriseByIdentifier(email);
        if(user != null) {
            return AjaxResult.error("用户已存在！");
        }
        RegisterEmailSender registerEmailSender = SpringUtils.getBean(RegisterEmailSender.class);
        String verifyCode =  generateVerifyCode();
        template.opsForValue().set("verifyCode:" + email, verifyCode, Duration.ofMinutes(5));
        try {
            registerEmailSender.sendVerificationEmail(email,verifyCode);
        } catch (Exception e) {
            return AjaxResult.error("邮箱发送失败");
        }
        return AjaxResult.success();
    }

    @Override
    public String generateVerifyCode(){
        Random random = new Random();
        int randomNumber = random.nextInt(1000000);
        return String.format("%06d", randomNumber);
    }

    @Override
    public AjaxResult register(String role, String username, String password, String email, String phone, String verifyCode) {
        User user = "job_seeker".equals(role) ? userMapper.selectJobSeekerByIdentifier(email) : userMapper.selectEnterpriseByIdentifier(email);
        if(user != null) {
            return AjaxResult.error("用户已存在！");
        }
        String verifyRef = template.opsForValue().get("verifyCode:" + email);
        if (StringUtils.isEmpty(verifyRef)) {
            return AjaxResult.error("验证码已过期");
        }
        if (!verifyRef.equals(verifyCode)) {
            return AjaxResult.error("验证码错误");
        }
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setUserType(role);
        userMapper.insertUser(newUser);
        if ("enterprise".equals(role)) {
            Etp etp = new Etp();
            etp.setName(username);
            etp.setEmail(email);
            etp.setPhone(phone);
            etp.setUserId(newUser.getId());
            etpMapper.insertEtp(etp);
        } else {
            Resume resume = new Resume();
            resume.setName(username);
            resume.setEmail(email);
            resume.setPhone(phone);
            resume.setUserId(newUser.getId());
            resumeMapper.insertResume(resume);
        }
        return AjaxResult.success();
    }
}
