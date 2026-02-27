package com.cx.web.repository;

import com.cx.web.entity.Board;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface BoardRepository extends JpaRepository<Board, Integer> {
    List<Board> findByMemId(String memId);
}
