package com.cx.web.controller;

import com.cx.web.entity.Board;
import com.cx.web.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class BoardController {

    @Autowired
    private BoardRepository boardRepository;

    @GetMapping("/board")
    public String boardPage(Model model) {
        List<Board> boards = boardRepository.findAll();
        model.addAttribute("boards", boards);
        model.addAttribute("contentPage", "/WEB-INF/views/common/board.jsp");
        return "common/MobileLayout"; // MobileLayout.jsp 렌더링
    }
}

