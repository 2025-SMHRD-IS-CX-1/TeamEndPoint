package com.cx.web.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.cx.web.entity.Message;   // ✅ 소문자 entity로 변경
import java.util.List;

public interface MessageRepository extends JpaRepository<Message, Integer> {
    List<Message> findByCroomIdx(int croomIdx);
}
