package com.cx.web;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LogoutController {

    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse response) {

        // ✅ 세션 삭제
        session.invalidate();

        // ✅ 자동로그인 쿠키 삭제
        Cookie c = new Cookie("keepLoginId", "");
        c.setMaxAge(0);   // 삭제
        c.setPath("/");
        response.addCookie(c);

        return "redirect:/login";
    }
}