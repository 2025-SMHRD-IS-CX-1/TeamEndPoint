package com.cx.web.controller;

import com.cx.web.entity.Message;
import com.cx.web.service.MessageService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/messages")
public class MessageController {
    private final MessageService messageService;

    public MessageController(MessageService messageService) {
        this.messageService = messageService;
    }

    // 전체 메시지 조회
    @GetMapping
    public List<Message> getAllMessages() {
        return messageService.findAll();
    }

    // 특정 메시지 조회
    @GetMapping("/{id}")
    public Message getMessage(@PathVariable Long id) {
        return messageService.findById(id);
    }

    // 메시지 생성
    @PostMapping
    public Message createMessage(@RequestBody Message message) {
        return messageService.save(message);
    }

    // 메시지 수정
    @PutMapping("/{id}")
    public Message updateMessage(@PathVariable Long id, @RequestBody Message message) {
        return messageService.update(id, message);
    }

    // 메시지 삭제
    @DeleteMapping("/{id}")
    public void deleteMessage(@PathVariable Long id) {
        messageService.delete(id);
    }
}
