package com.cx.web.repository;

import com.cx.web.entity.ChatRoom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ChatRoomRepository extends JpaRepository<ChatRoom, Integer> {
    // 기본 CRUD 제공
}
