// LoginController.java
package com.qh.recruit.user.controller;

import com.qh.recruit.common.core.controller.BaseController;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.NLoginForm;
import com.qh.recruit.user.service.LoginService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;

@RestController
@RequestMapping("/login")
public class LoginController extends BaseController {

    @Resource
    private LoginService loginService;

    @PostMapping("/login")
    public AjaxResult login(@RequestBody NLoginForm loginForm) {
        return loginService.login(loginForm.getRole(),loginForm.getUsername(), loginForm.getPassword(), loginForm.getCode(),
                loginForm.getUuid());
    }

    @PostMapping("/sendLoginEmail")
    public AjaxResult sendLoginEmail(@RequestBody NLoginForm loginForm) {
        return loginService.sendLoginEmail(loginForm.getRole(),loginForm.getEmail(),loginForm.getCode(), loginForm.getUuid());
    }
    @PostMapping("/sendRegisterEmail")
    public AjaxResult sendRegisterEmail(@RequestBody NLoginForm loginForm) {
        return loginService.sendRegisterEmail(loginForm.getRole(),loginForm.getEmail(),loginForm.getCode(), loginForm.getUuid());
    }
    @PostMapping("/tokenLogin")
    public AjaxResult tokenLogin(String token) {
        return loginService.tokenLogin(token);
    }    @PostMapping("/tokenLogout")
    public AjaxResult tokenLogout(String token) {
        return loginService.tokenLogout(token);
    }

    @PostMapping("/register")
    public AjaxResult register(@RequestBody NLoginForm loginForm) {
        return loginService.register(loginForm.getRole(),loginForm.getUsername(), loginForm.getPassword(),loginForm.getEmail(),loginForm.getPhone() ,loginForm.getVerifyCode());
    }
    @GetMapping("/getOnlineUsers")
    public TableDataInfo getOnlineUsers(){
        return new TableDataInfo();
    }

}
