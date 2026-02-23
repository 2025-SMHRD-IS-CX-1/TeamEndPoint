package com.cx.web.service;

import com.cx.web.entity.Board;
import com.cx.web.repository.BoardRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardService {
    private final BoardRepository boardRepository;

    public BoardService(BoardRepository boardRepository) {
        this.boardRepository = boardRepository;
    }

    public List<Board> findAll() {
        return boardRepository.findAll();
    }

    public Board save(Board board) {
        return boardRepository.save(board);
    }

    public List<Board> findByCategory(String category) {
        return boardRepository.findByCategory(category);
    }

    public Board findById(Long id) {
        return boardRepository.findById(id).orElse(null);
    }

    public Board update(Long id, Board board) {
        return boardRepository.findById(id)
                .map(existing -> {
                    existing.setTitle(board.getTitle());
                    existing.setContent(board.getContent());
                    existing.setCategory(board.getCategory());
                    existing.setMemId(board.getMemId());
                    existing.setUpdatedAt(board.getUpdatedAt());
                    return boardRepository.save(existing);
                })
                .orElse(null);
    }

    public void delete(Long id) {
        boardRepository.deleteById(id);
    }
}
