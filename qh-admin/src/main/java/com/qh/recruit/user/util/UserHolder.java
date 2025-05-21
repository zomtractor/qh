package com.qh.recruit.user.util;

import com.qh.recruit.user.domain.LoginDto;

public class UserHolder{
    private static final ThreadLocal<LoginDto> tl = new ThreadLocal<>();

    public static void setUser(LoginDto user) {
        tl.set(user);
    }
    public static LoginDto getUser() {
        return tl.get();
    }
    public static void remove() {
        tl.remove();
    }
}