package com.qh.recruit.user.service;

import com.qh.recruit.admin.domain.Communicate;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.user.domain.LoginDto;

import java.util.List;
import java.util.Map;

public interface ChatService {
    List<LoginDto> listWhos();

    List<Communicate> listChats(Long refId);

    AjaxResult sendChat(Communicate communicate);

}
