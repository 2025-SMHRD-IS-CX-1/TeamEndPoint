package com.cx.web.repository;

import com.cx.web.entity.Message;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MessageRepository extends JpaRepository<Message, Integer> {
    // 기본 CRUD 제공
}
