package com.cx.web;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


//수정중
@Controller
public class HomeController {
	
    // 로그인 여부 체크 함수 (여러 페이지에서 재사용)
    private boolean isLoggedIn(HttpSession session) {
        return session != null && session.getAttribute("loginMember") != null;
    }
	
	@GetMapping("/")
	public String index(HttpSession session, Model model) {
	    boolean isLoggedIn = (session.getAttribute("loginMember") != null);
	    model.addAttribute("isLoggedIn", isLoggedIn);
	    return "index";
	}
	
	@GetMapping("/chat")
	public String chatPage(HttpSession session, Model model) { // HttpSession, Model 추가
        boolean isLoggedIn = (session.getAttribute("loginMember") != null);
        model.addAttribute("isLoggedIn", isLoggedIn);
		return "chat";   // chat.jsp
	}
	
    @GetMapping("/events")
    public String eventsPage(HttpSession session, Model model) {
        model.addAttribute("isLoggedIn", isLoggedIn(session));
        return "events";
    }
    
    @GetMapping("/about")
    public String aboutPage(HttpSession session, Model model) {
        model.addAttribute("isLoggedIn", isLoggedIn(session));
        return "about";
    }
    
    // 신청절차 안내 페이지 (내 링크 : application-process)
    @GetMapping("/application-process")
    public String applicationProcess(HttpSession session, Model model) {
        model.addAttribute("isLoggedIn", isLoggedIn(session));
        return "process"; // application-process.jsp
    }
    
}
