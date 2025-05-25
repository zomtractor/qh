package com.qh.recruit.user.config;

import com.qh.recruit.user.aop.TokenInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new TokenInterceptor())
                .addPathPatterns("/jobSeeker/**")
                .addPathPatterns("/ws-chat")
                .addPathPatterns("/etp/**");
    }
}
