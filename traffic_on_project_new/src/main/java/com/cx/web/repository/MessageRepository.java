package com.cx.web.repository;

import com.cx.web.entity.Message;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface MessageRepository extends JpaRepository<Message, Integer> {
    // 특정 방의 메시지 조회
    List<Message> findByCroomIdx(Integer croomIdx);
}
