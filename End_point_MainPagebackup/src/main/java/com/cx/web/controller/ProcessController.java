package com.cx.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProcessController {

    @GetMapping("/process")
    public String process(Model model) {
        model.addAttribute("contentPage", "/WEB-INF/views/common/process.jsp");
        return "common/MobileLayout";
    }
}

