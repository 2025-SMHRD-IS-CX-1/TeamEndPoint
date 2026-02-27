package com.cx.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EventController {

    @GetMapping("/events")
    public String events(Model model) {
        // 본문 JSP 지정
        model.addAttribute("contentPage", "/WEB-INF/views/common/events.jsp");

        // MobileLayout.jsp 렌더링
        return "common/MobileLayout";
    }
}
