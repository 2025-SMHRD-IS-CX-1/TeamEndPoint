package com.cx.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cx.web.entity.Member;
import com.cx.web.service.MemberService;

@Controller
public class LoginController {

    @Autowired
    private MemberService memberService;

    // 로그인 페이지 이동
    @GetMapping("/login")
    public String login() {
        return "login"; // login.jsp
    }

    // 회원가입 페이지 이동
    @GetMapping("/signup")
    public String signup() {
        return "signup"; // signup.jsp (파일명만 반환, .jsp 확장자 X)
    }

    // 로그인 처리
    @PostMapping("/login")
    public String loginProcess(@RequestParam String username, @RequestParam String password) {
        Member member = memberService.login(username, password);
        if (member != null) {
            System.out.println("로그인 성공: " + member.getMemId());
            return "redirect:/"; 
        } else {
            System.out.println("로그인 실패");
            return "login"; 
        }
    }

    // 회원가입 처리
    @PostMapping("/signup")
    public String signupProcess(Member member) {
        memberService.signup(member);
        System.out.println("회원가입 성공: " + member.getMemId());
        return "redirect:/login"; // 회원가입 후 로그인 페이지로 이동
    }
}
