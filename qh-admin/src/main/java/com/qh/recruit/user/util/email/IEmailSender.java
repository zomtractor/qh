package com.qh.recruit.user.util.email;

public interface IEmailSender {

    void sendVerificationEmail(String toEmail, String... args) throws Exception;
}
