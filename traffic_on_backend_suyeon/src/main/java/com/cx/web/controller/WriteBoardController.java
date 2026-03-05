package com.cx.web.controller;

import com.cx.web.entity.WriteBoard;
import com.cx.web.entity.Member;
import com.cx.web.repository.WriteBoardRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class WriteBoardController {

    @Autowired
    private WriteBoardRepository writeBoardRepository;

    @GetMapping("/board/write")
    public String writeBoardPage() {
        return "writeboard";
    }

    @PostMapping("/board/write")
    public String writeBoard(@RequestParam("title") String title,
                              @RequestParam("content") String content,
                              HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/login";
        }

        WriteBoard board = new WriteBoard();
        board.setTitle(title);
        board.setContent(content);
        board.setMemId(loginMember.getMemID());
        board.setCreatedAt(java.time.LocalDateTime.now());

        writeBoardRepository.save(board);

        return "redirect:/board";
    }
}