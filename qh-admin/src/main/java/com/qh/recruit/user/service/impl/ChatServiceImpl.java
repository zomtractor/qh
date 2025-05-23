package com.qh.recruit.user.service.impl;

import com.qh.recruit.admin.domain.Communicate;
import com.qh.recruit.admin.domain.dto.ResumeDto;
import com.qh.recruit.admin.mapper.CommunicateMapper;
import com.qh.recruit.admin.mapper.EtpMapper;
import com.qh.recruit.admin.mapper.ResumeMapper;
import com.qh.recruit.admin.service.ICommunicateService;
import com.qh.recruit.common.core.domain.AjaxResult;
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

    @Resource
    private ICommunicateService communicateService;

    @Override
    public List<LoginDto> listWhos() {
        LoginDto user = UserHolder.getUser();
        if ("job_seeker".equals(user.getUserType())){
            return etpMapper.selectEtpChatted(user.getId());
        } else{
            return resumeMapper.selectResumeChatted(user.getId());
        }
    }

    @Override
    public List<Communicate> listChats(Long refId) {
        return communicateMapper.selectListByPeerId(UserHolder.getUser().getId(), refId);
    }

    @Override
    public AjaxResult sendChat(Communicate communicate) {
        int i = communicateService.insertCommunicate(communicate);
        if (i > 0) {
            return AjaxResult.success("发送成功");
        } else {
            return AjaxResult.error("发送失败");
        }
    }
}
