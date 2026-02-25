package com.cx.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cx.web.entity.Member;
import com.cx.web.repository.MemberRepository;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final MemberRepository memberRepository;

    // 🔥 생성자 주입
    public AdminController(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "admin/dashboard";
    }

    @GetMapping("/users")
    public String users(Model model) {
        List<Member> members = memberRepository.findAll();
        model.addAttribute("members", members);
        return "admin/users";
    }

    @GetMapping("/boards")
    public String boards() {
        return "admin/boards";
    }
}