package com.cx.web.repository;

import com.cx.web.entity.WriteBoard;
import org.springframework.data.jpa.repository.JpaRepository;
<<<<<<< HEAD
import java.util.List;

public interface WriteBoardRepository extends JpaRepository<WriteBoard, Integer> {
    List<WriteBoard> findByMemIdOrderByCreatedAtDesc(String memId);
=======

public interface WriteBoardRepository extends JpaRepository<WriteBoard, Integer> {
>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
}