package com.qh.recruit;

import com.qh.recruit.user.aop.TokenInterceptor;
import com.qh.recruit.user.service.impl.RecommendServiceImpl;
import com.qh.recruit.user.util.SpringUtil;
import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 启动程序
 *
 * @author ruoyi
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class RuoYiApplication implements WebMvcConfigurer
{

    private static RecommendServiceImpl recommendService;
    public static void main(String[] args)
    {
        SpringApplication.run(RuoYiApplication.class, args);
        ApplicationContext context = SpringUtil.getApplicationContext();
        recommendService= context.getBean(RecommendServiceImpl.class);
        System.out.println("启航 启动完毕");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new TokenInterceptor())
                .addPathPatterns("/jobSeeker/**")
                .addPathPatterns("/etp/**");
    }
}
