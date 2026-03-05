package com.cx.web.controller;

import com.cx.web.entity.WriteBoard;
import com.cx.web.entity.Member;
import com.cx.web.repository.WriteBoardRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class WriteBoardDetailController {

    @Autowired
    private WriteBoardRepository writeBoardRepository;

    @GetMapping("/board/{id}")
    public String boardDetail(@PathVariable("id") Integer id, Model model, HttpSession session) {
        WriteBoard board = writeBoardRepository.findById(id).orElse(null);
        if (board == null) {
            return "redirect:/board";
        }

        Member loginMember = (Member) session.getAttribute("loginMember");
        boolean canDelete = false;

        if (loginMember != null) {
            boolean isAdmin = "ADMIN".equals(loginMember.getMemType()); // ← mem_type 체크
            boolean isWriter = loginMember.getMemID().equals(board.getMemId());
            canDelete = isAdmin || isWriter;
        }

        model.addAttribute("board", board);
        model.addAttribute("canDelete", canDelete);
        return "writeboarddetail";
    }

    @PostMapping("/board/delete/{id}")
    public String deleteBoard(@PathVariable("id") Integer id, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/login";
        }

        WriteBoard board = writeBoardRepository.findById(id).orElse(null);
        if (board == null) {
            return "redirect:/board";
        }

        boolean isAdmin = "ADMIN".equals(loginMember.getMemType());
        boolean isWriter = loginMember.getMemID().equals(board.getMemId());

        if (isAdmin || isWriter) {
            writeBoardRepository.deleteById(id);
        }

        return "redirect:/board";
    }
}