package com.cx.web.repository;

import com.cx.web.entity.Board;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface BoardRepository extends JpaRepository<Board, Long> {
    // 예시: 카테고리로 검색
    List<Board> findByCategory(String category);
}
