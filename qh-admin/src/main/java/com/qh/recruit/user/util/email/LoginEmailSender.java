package com.qh.recruit.user.util.email;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;

@Component
public class LoginEmailSender implements IEmailSender {
    @Resource
    private JavaMailSender mailSender;

    @Resource
    private TemplateEngine templateEngine;

    @Value("${spring.mail.username}")
    private String from;

    @Override
    public void sendVerificationEmail(String toEmail, String... args) throws Exception {
        // 准备上下文
        Context context = new Context();
        context.setVariable("token", args[0]);
        // 处理模板
        String emailContent = templateEngine.process("login_template.html", context);
        // 创建邮件
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        helper.setFrom(from);
        helper.setTo(toEmail);
        helper.setSubject("【启航】登录邮件");
        helper.setText(emailContent, true); // true表示HTML内容
        // 发送邮件
        mailSender.send(message);
    }

}
