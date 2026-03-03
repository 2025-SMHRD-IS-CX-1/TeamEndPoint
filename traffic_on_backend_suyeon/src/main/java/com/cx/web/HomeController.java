package com.cx.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/")
	public String index() {
		return "index";
	}
	@GetMapping("/chat")
	public String chatPage() {
		return "chat";   // chat.jsp
	}
}
