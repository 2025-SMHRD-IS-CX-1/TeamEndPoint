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
                              HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember"); // ← 수정

        Board board = new Board();
        board.setTitle(title);
        board.setContent(content);
        board.setMemId(loginMember.getMemID()); // 

        boardRepository.save(board);

        return "redirect:/board";
    }
}