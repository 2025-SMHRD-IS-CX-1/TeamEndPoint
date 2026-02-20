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

    @GetMapping
    public List<Message> getMessages() {
        return messageService.findAll();
    }

    @PostMapping
    public Message createMessage(@RequestBody Message message) {
        return messageService.save(message);
    }

    @GetMapping("/croom/{croomIdx}")
    public List<Message> getMessagesByCroom(@PathVariable Integer croomIdx) {
        return messageService.findByCroomIdx(croomIdx);
    }
}
