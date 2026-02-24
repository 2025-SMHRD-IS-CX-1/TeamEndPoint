package com.cx.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String homePage() {
        // /WEB-INF/views/home.jsp 를 찾아서 렌더링
        return "home";
    }
}
