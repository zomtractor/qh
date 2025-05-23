package com.qh.recruit.user.controller;

import com.qh.recruit.admin.domain.Communicate;
import com.qh.recruit.common.core.controller.BaseController;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.LoginDto;
import com.qh.recruit.user.service.ChatService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/jobSeeker/chat")
public class ChatController extends BaseController {
    @Resource
     private ChatService chatService;

    // @PostMapping("/chat")
    // public AjaxResult chat(@RequestBody ChatForm chatForm) {
    //     return chatService.chat(chatForm.getRole(), chatForm.getMessage());
    // }
     @GetMapping("/who")
     public TableDataInfo listChatsObjects(){
            List<LoginDto> chats = chatService.listWhos();
            return getDataTable(chats);
     }
     @GetMapping("/list/{id}")
     public TableDataInfo listChats(@PathVariable Long id){
            List<Communicate> ls = chatService.listChats(id);
            return getDataTable(ls);
     }
     @PostMapping
    public AjaxResult sendChat(@RequestBody Communicate communicate) {
        return chatService.sendChat(communicate);
    }
}
