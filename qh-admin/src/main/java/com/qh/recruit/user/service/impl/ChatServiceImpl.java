package com.qh.recruit.user.service.impl;

import com.qh.recruit.admin.domain.dto.ResumeDto;
import com.qh.recruit.admin.mapper.CommunicateMapper;
import com.qh.recruit.admin.mapper.EtpMapper;
import com.qh.recruit.admin.mapper.ResumeMapper;
import com.qh.recruit.user.domain.LoginDto;
import com.qh.recruit.user.service.ChatService;
import com.qh.recruit.user.util.UserHolder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class ChatServiceImpl implements ChatService {
    @Resource
    private CommunicateMapper communicateMapper;
    @Resource
    private ResumeMapper resumeMapper;
    @Resource
    private EtpMapper etpMapper;

    @Override
    public List<LoginDto> listWhos() {
        LoginDto user = UserHolder.getUser();
        if ("job_seeker".equals(user.getUserType())){
            return resumeMapper.selectResumeChatted(user.getId());
        } else{
            return etpMapper.selectEtpChatted(user.getId());
        }
    }
}
