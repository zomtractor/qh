// LoginController.java
package com.qh.recruit.user.controller;

import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.user.domain.NLoginForm;
import com.qh.recruit.user.service.LoginService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/login")
public class LoginController {

    @Resource
    private LoginService loginService;

    @PostMapping("/login")
    public AjaxResult login(@RequestBody NLoginForm loginForm) {
        return loginService.login(loginForm.getRole(),loginForm.getUsername(), loginForm.getPassword(), loginForm.getCode(),
                loginForm.getUuid());
    }

    @PostMapping("/sendEmail")
    public AjaxResult sendEmail(@RequestBody NLoginForm loginForm) {
        return loginService.sendEmail(loginForm.getRole(),loginForm.getEmail(),loginForm.getCode(), loginForm.getUuid());
    }
    @PostMapping("tokenLogin")
    public AjaxResult tokenLogin(String token) {
        return loginService.tokenLogin(token);
    }

}
