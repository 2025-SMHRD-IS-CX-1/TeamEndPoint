package com.cx.web.service;

import com.cx.web.entity.Message;
import com.cx.web.repository.MessageRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageService {
    private final MessageRepository messageRepository;

    public MessageService(MessageRepository messageRepository) {
        this.messageRepository = messageRepository;
    }

    public List<Message> findAll() {
        return messageRepository.findAll();
    }

    public Message save(Message message) {
        return messageRepository.save(message);
    }

    public Message findById(Long id) {
        return messageRepository.findById(id).orElse(null);
    }

    public Message update(Long id, Message message) {
        return messageRepository.findById(id)
                .map(existing -> {
                    existing.setSenderId(message.getSenderId());
                    existing.setReceiverId(message.getReceiverId());
                    existing.setContent(message.getContent());
                    existing.setSentAt(message.getSentAt());
                    return messageRepository.save(existing);
                })
                .orElse(null);
    }

    public void delete(Long id) {
        messageRepository.deleteById(id);
    }
}
