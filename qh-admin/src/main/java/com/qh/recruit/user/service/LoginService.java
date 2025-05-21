package com.qh.recruit.user.service;

import com.qh.recruit.common.core.domain.AjaxResult;

public interface LoginService {
    AjaxResult login(String role, String username, String password, String code, String uuid);

    AjaxResult emailLogin(String role, String username, String password, String code, String uuid);

    AjaxResult sendLoginEmail(String role, String email, String code, String uuid);

    AjaxResult tokenLogin(String token);

    AjaxResult sendRegisterEmail(String role, String email, String code, String uuid);

    String generateVerifyCode();

    AjaxResult register(String role, String username, String password, String email, String phone, String verifyCode);
}
