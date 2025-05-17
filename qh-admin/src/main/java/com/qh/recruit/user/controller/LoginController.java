// LoginController.java
package com.qh.recruit.user.controller;

import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.domain.model.LoginBody;
import com.qh.recruit.user.domain.NLoginForm;
import com.qh.recruit.user.service.LoginService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

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
}
