package com.cx.web;

import com.cx.web.entity.Board;
import com.cx.web.entity.Member;
import com.cx.web.repository.BoardRepository;
import com.cx.web.repository.MemberRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class BoardController {

    @Autowired
    private BoardRepository boardRepository;

    @Autowired
    private MemberRepository memberRepository;

    @GetMapping("/board")
    public String boardPage(Model model, HttpSession session) {
        List<Board> boards = boardRepository.findAllByOrderByBoardIdDesc();
        model.addAttribute("boards", boards);

        // ✅ 관리자 ID 목록 추출
        List<String> adminIds = memberRepository.findAll().stream()
            .filter(m -> "ADMIN".equals(m.getMemType()))
            .map(Member::getMemID)
            .collect(Collectors.toList());
        model.addAttribute("adminIds", adminIds);

        Object loginUser = session.getAttribute("loginMember");
        System.out.println("로그인 사용자: " + loginUser);
        boolean isLoggedIn = (loginUser != null);
        model.addAttribute("isLoggedIn", isLoggedIn);

        return "board";
    }
}