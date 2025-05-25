package com.qh.recruit.user.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MessageWrapper {
    private int signal; // 1-在线用户更新 2-新消息
    private String data;
}