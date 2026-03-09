package com.cx.web.controller;

import com.cx.web.entity.Board;
import com.cx.web.entity.Member;
import com.cx.web.repository.BoardRepository;
import com.cx.web.repository.MemberRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class WriteBoardDetailController {

    @Autowired
    private BoardRepository boardRepository;

    @Autowired
    private MemberRepository memberRepository; // ✅ 추가

    @GetMapping("/board/{id}")
    public String boardDetail(@PathVariable("id") Integer id, Model model, HttpSession session) {
        Board board = boardRepository.findById(id).orElse(null);
        if (board == null) {
            return "redirect:/board";
        }

        Member loginMember = (Member) session.getAttribute("loginMember");
        boolean canDelete = false;
        boolean canEdit = false;

        if (loginMember != null) {
            boolean isAdmin = "ADMIN".equals(loginMember.getMemType());
            boolean isWriter = loginMember.getMemID().equals(board.getMemId());
            canDelete = isAdmin || isWriter;
            canEdit = isAdmin || isWriter;
        }

        // ✅ 작성자가 관리자인지 확인
        List<String> adminIds = memberRepository.findAll().stream()
            .filter(m -> "ADMIN".equals(m.getMemType()))
            .map(Member::getMemID)
            .collect(Collectors.toList());
        boolean isAdminPost = adminIds.contains(board.getMemId());

        model.addAttribute("board", board);
        model.addAttribute("canDelete", canDelete);
        model.addAttribute("canEdit", canEdit);
        model.addAttribute("isAdminPost", isAdminPost); // ✅ 추가

        return "writeboarddetail";
    }

    @GetMapping("/board/edit/{id}")
    public String editBoardPage(@PathVariable("id") Integer id, Model model, HttpSession session) {
        Board board = boardRepository.findById(id).orElse(null);
        if (board == null) return "redirect:/board";

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/login";

        boolean isAdmin = "ADMIN".equals(loginMember.getMemType());
        boolean isWriter = loginMember.getMemID().equals(board.getMemId());
        if (!isAdmin && !isWriter) return "redirect:/board";

        model.addAttribute("board", board);
        return "writeboardedit";
    }

    @PostMapping("/board/edit/{id}")
    public String editBoard(@PathVariable("id") Integer id,
                             @RequestParam("title") String title,
                             @RequestParam("content") String content,
                             HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/login";

        Board board = boardRepository.findById(id).orElse(null);
        if (board == null) return "redirect:/board";

        boolean isAdmin = "ADMIN".equals(loginMember.getMemType());
        boolean isWriter = loginMember.getMemID().equals(board.getMemId());

        if (isAdmin || isWriter) {
            board.setTitle(title);
            board.setContent(content);
            board.setUpdatedAt(java.time.LocalDateTime.now());
            boardRepository.save(board);
        }

        return "redirect:/board/" + id;
    }

    @PostMapping("/board/delete/{id}")
    public String deleteBoard(@PathVariable("id") Integer id, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/login";

        Board board = boardRepository.findById(id).orElse(null);
        if (board == null) return "redirect:/board";

        boolean isAdmin = "ADMIN".equals(loginMember.getMemType());
        boolean isWriter = loginMember.getMemID().equals(board.getMemId());

        if (isAdmin || isWriter) {
            boardRepository.deleteById(id);
        }

        return "redirect:/board";
    }
}