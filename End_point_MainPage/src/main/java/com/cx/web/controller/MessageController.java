package com.cx.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cx.web.entity.Message;              // ✅ 소문자 entity
import com.cx.web.repository.MessageRepository; // ✅ 소문자 repository

@RestController
@RequestMapping("/messages")
public class MessageController {

    @Autowired
    private MessageRepository messageRepository;

    @GetMapping
    public List<Message> getAllMessages() {
        return messageRepository.findAll();
    }

    @GetMapping("/room/{croomIdx}")
    public List<Message> getMessagesByRoom(@PathVariable int croomIdx) {
        return messageRepository.findByCroomIdx(croomIdx);
    }

    @PostMapping
    public Message saveMessage(@RequestBody Message message) {
        return messageRepository.save(message);
    }
}
