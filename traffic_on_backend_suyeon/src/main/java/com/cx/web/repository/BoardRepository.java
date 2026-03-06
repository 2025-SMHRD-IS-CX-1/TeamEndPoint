package com.cx.web.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.cx.web.entity.Board;

public interface BoardRepository extends JpaRepository<Board, Integer>{

	Page<Board> findByTitleContainingOrMemIdContaining(
			String title,
			String memId,
			Pageable pageable);

	List<Board> findAllByOrderByBoardIdDesc();
}
