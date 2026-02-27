package com.cx.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ComplaintTypeController {

    @GetMapping("/complaint-type")
    public String complaintType(Model model) {
        model.addAttribute("contentPage", "/WEB-INF/views/common/complaint-type.jsp");
        return "common/MobileLayout";
    }
}
