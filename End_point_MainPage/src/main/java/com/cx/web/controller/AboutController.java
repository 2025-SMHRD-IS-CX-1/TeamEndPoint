package com.cx.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AboutController {

    @GetMapping("/about")
    public String about(Model model) {
        // 본문 JSP 지정
        model.addAttribute("contentPage", "/WEB-INF/views/common/about.jsp");

        // MobileLayout.jsp 렌더링
        return "common/MobileLayout";
    }
}
