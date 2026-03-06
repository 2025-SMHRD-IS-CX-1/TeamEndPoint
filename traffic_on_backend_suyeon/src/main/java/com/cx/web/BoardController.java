package com.cx.web;

import com.cx.web.entity.WriteBoard;
import com.cx.web.repository.WriteBoardRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class BoardController {

    @Autowired
    private WriteBoardRepository writeBoardRepository;

    @GetMapping("/board")
    public String boardPage(Model model, HttpSession session) {
        List<WriteBoard> boards = writeBoardRepository.findAll();
        model.addAttribute("boards", boards);

        Object loginUser = session.getAttribute("loginMember");
        System.out.println("로그인 사용자: " + loginUser);

        boolean isLoggedIn = (loginUser != null);
        model.addAttribute("isLoggedIn", isLoggedIn);

        return "board";
    }
}