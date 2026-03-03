package com.cx.web;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


//수정중
@Controller
public class HomeController {
	
	@GetMapping("/")
	public String index(HttpSession session, Model model) {
	    boolean isLoggedIn = (session.getAttribute("loginMember") != null);
	    model.addAttribute("isLoggedIn", isLoggedIn);
	    return "index";
	}
	
	@GetMapping("/chat")
	public String chatPage() {
		return "chat";   // chat.jsp
	}
	@GetMapping("/events")
	public String eventsPage() {
	    return "events";   // events.jsp
	}
	@GetMapping("/about")
	public String aboutPage() {
	    return "about";   // about.jsp
	}
}
