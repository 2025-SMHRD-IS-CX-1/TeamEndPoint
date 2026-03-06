package com.cx.web.controller;

import com.cx.web.entity.Board;
import com.cx.web.entity.Member;
import com.cx.web.repository.BoardRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class WriteBoardController {

    @Autowired
    private BoardRepository boardRepository;

    @GetMapping("/board/write")
    public String writeBoardPage() {
        return "writeboard";
    }

    @PostMapping("/board/write")
    public String writeBoard(@RequestParam("title") String title,
                             @RequestParam("content") String content,
                             @RequestParam("category") String category,
                             HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/login";
        }
        Board board = new Board();
        board.setTitle(title);
        board.setContent(content);
        board.setCategory(category);
        board.setMemId(loginMember.getMemID());
        board.setCreatedAt(java.time.LocalDateTime.now());
        boardRepository.save(board);
        return "redirect:/board";
    }
}