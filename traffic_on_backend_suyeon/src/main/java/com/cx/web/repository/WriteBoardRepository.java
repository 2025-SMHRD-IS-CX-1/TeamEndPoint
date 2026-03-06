package com.cx.web.repository;

import com.cx.web.entity.WriteBoard;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface WriteBoardRepository extends JpaRepository<WriteBoard, Integer> {
    List<WriteBoard> findByMemIdOrderByCreatedAtDesc(String memId);
}