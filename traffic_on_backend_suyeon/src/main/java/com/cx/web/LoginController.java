package com.cx.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cx.web.entity.User;

@Controller
public class LoginController {

	@GetMapping("/login")
	public String login() {
		return "login";
	} 
	
	@GetMapping("/signup")
	public String signup() {
		return "signup";
	}
	
	@PostMapping("/login")
	public String loginProcess(@RequestParam String username, @RequestParam String password) {
		System.out.println("로그인 username=" + username);
		System.out.println("로그인 password=" + password);
		return "login";
	}
	
	@PostMapping("/signup")
	public String signupProcess(User user) {
		System.out.println("회원가입 username=" + user.getUsername());
		System.out.println("email=" + user.getEmail());
		System.out.println("role=" + user.getRole());
		return "redirect:/login";
	}
}
