package com.cx.web.controller;

import com.cx.web.entity.ChatRoom;
import com.cx.web.repository.ChatRoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class ChatRoomController {

    @Autowired
    private ChatRoomRepository chatRoomRepository;

    @GetMapping("/chatrooms")
    public String chatRoomPage(Model model) {
        List<ChatRoom> chatRooms = chatRoomRepository.findAll();
        model.addAttribute("chatRooms", chatRooms);
        return "common/chatroom"; // chatroom.jsp
    }
}
