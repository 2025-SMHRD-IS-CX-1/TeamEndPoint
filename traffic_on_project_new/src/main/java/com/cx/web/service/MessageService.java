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

    // 전체 메시지 조회
    public List<Message> findAll() {
        return messageRepository.findAll();
    }

    // 메시지 저장
    public Message save(Message message) {
        return messageRepository.save(message);
    }

    // 특정 채팅방(croomIdx) 메시지 조회
    public List<Message> findByCroomIdx(Integer croomIdx) {
        return messageRepository.findByCroomIdx(croomIdx);
    }
}
