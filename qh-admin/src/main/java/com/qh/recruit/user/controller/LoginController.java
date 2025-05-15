// LoginController.java
package com.qh.recruit.user.controller;

import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.user.service.LoginService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class LoginController {

    @Resource
    private LoginService loginService;

    @PostMapping("/login")
    public AjaxResult login(@RequestBody Map<String, String> loginData) {
        String role = loginData.get("role");
        String username = loginData.get("username");
        String phone = loginData.get("phone");
        String password = loginData.get("password");
        String code = loginData.get("code");
        String uuid = loginData.get("uuid");

        return loginService.login(role, username, phone, password, code, uuid);
    }
}
