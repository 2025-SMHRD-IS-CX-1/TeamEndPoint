package com.cx.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/login")
    public String loginPage() {
        // /WEB-INF/views/login.jsp 를 찾아서 렌더링
        return "login";
    }

    @GetMapping("/signup")
    public String signupPage() {
        return "signup"; // signup.jsp
    }
}
