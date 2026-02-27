package com.cx.web.controller;

import com.cx.web.entity.Message;
import com.cx.web.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class ChatController {

    @Autowired
    private MessageRepository messageRepository;

    @GetMapping("/chat")
    public String chatPage(Model model) {
        // DB에서 메시지 불러오기
        List<Message> messages = messageRepository.findAll();
        model.addAttribute("messages", messages);

        // 본문 JSP 지정
        model.addAttribute("contentPage", "/WEB-INF/views/common/chat.jsp");

        // MobileLayout.jsp 렌더링
        return "common/MobileLayout";
    }
}
