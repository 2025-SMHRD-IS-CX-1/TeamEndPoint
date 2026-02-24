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
	
	@GetMapping("/findPw")
	public String findPwPage() {
		return "findPw";
	}
	
	@GetMapping("/findId")
	public String findIdPage() {
		System.out.println("### findIdPage GET 들어옴 ###");
	    return "findId";
	}
	
	@GetMapping("/find-id")
	public String findIdAlias() {
	    return "redirect:/findId";
	}
	
	@PostMapping("/login")
	public String loginProcess(@RequestParam String username,
	                           @RequestParam String password,
	                           @RequestParam(required = false, defaultValue = "user") String activeTab) {

	    System.out.println("로그인 username=" + username);
	    System.out.println("로그인 password=" + password);
	    System.out.println("activeTab=" + activeTab);

	    // 관리자 탭이면 관리자 대시보드
	    if ("admin".equals(activeTab)) {
	        return "redirect:/admin/dashboard";
	    }

	    // 일반회원 메인 아직 없으니까 일단 로그인 페이지로 다시
	    return "redirect:/login";
	}
	
	@PostMapping("/signup")
	public String signupProcess(User user) {
		System.out.println("회원가입 username=" + user.getUsername());
		System.out.println("email=" + user.getEmail());
		System.out.println("role=" + user.getRole());
		return "redirect:/login";
	}
	
	@PostMapping("/findPw")
	public String findPwSubmit() {
		return "findPwResult";
	}
	
	@PostMapping("/findId")
	public String findIdProcess(@RequestParam String name,
	                            @RequestParam String contact) {
	    // TODO: DB 조회해서 아이디 찾기
	    return "findIdResult";
	}
}
