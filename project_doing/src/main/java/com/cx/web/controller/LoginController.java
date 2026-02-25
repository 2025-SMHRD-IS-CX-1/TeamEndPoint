package com.cx.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cx.web.entity.Member;
import com.cx.web.service.MemberService;

@Controller
public class LoginController {

    @Autowired
    private MemberService memberService;

    // 로그인 페이지
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String loginProcess(@RequestParam String username,
                               @RequestParam String password,
                               Model model) {
        Member member = memberService.login(username, password);
        if (member != null) {
            return "redirect:/";
        } else {
            model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "login";
        }
    }

    // 회원가입 페이지
    @GetMapping("/signup")
    public String signupPage() {
        return "signup";
    }

    @PostMapping("/signup")
    public String signupProcess(Member member, Model model) {
        memberService.signup(member);
        model.addAttribute("message", "회원가입이 완료되었습니다. 로그인 해주세요.");
        return "redirect:/login";
    }

    // 비밀번호 찾기 페이지
    @GetMapping("/findPw")
    public String findPwPage() {
        return "findPw";
    }

    // STEP 1 → STEP 3: 아이디 + 연락처 확인
    @PostMapping("/findPw/verify")
    public String verifyUser(@RequestParam String memId,
                             @RequestParam String contact,
                             Model model) {
        Member member = memberService.findById(memId);

        if (member == null) {
            model.addAttribute("error", "해당 아이디가 존재하지 않습니다.");
            return "findPw";
        }

        if (!memberService.verifyContact(memId, contact)) {
            model.addAttribute("error", "입력하신 정보와 일치하는 회원이 없습니다.");
            return "findPw";
        }

        // 연락처 일치 → 인증번호 입력 단계로 이동
        model.addAttribute("memId", memId);
        model.addAttribute("step", 3);
        return "findPw";
    }

    // STEP 3 → STEP 4: 인증번호 확인 후 비밀번호 변경 화면
    @PostMapping("/findPw/verifyCode")
    public String verifyCode(@RequestParam String memId,
                             @RequestParam String verificationCode,
                             Model model) {
        // 실제 인증번호 검증 로직은 추후 구현 예정
        if ("123456".equals(verificationCode)) {
            model.addAttribute("memId", memId);
            model.addAttribute("step", 4);
            return "findPw";
        } else {
            model.addAttribute("error", "인증번호가 올바르지 않습니다.");
            return "findPw";
        }
    }

    // STEP 4: 비밀번호 재설정
    @PostMapping("/findPw")
    public String resetPassword(@RequestParam String memId,
                                @RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                Model model) {
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            model.addAttribute("memId", memId);
            model.addAttribute("step", 4); // 다시 STEP 4로 유지
            return "findPw";
        }

        Member member = memberService.findById(memId);
        if (member != null) {
            memberService.updatePassword(memId, newPassword);
            model.addAttribute("message", "비밀번호가 변경되었습니다. 다시 로그인 해주세요.");
            return "login";
        } else {
            model.addAttribute("error", "해당 아이디가 존재하지 않습니다.");
            return "findPw";
        }
    }

    // 아이디 찾기
    @GetMapping("/findId")
    public String findIdPage() {
        return "findId";
    }

    @PostMapping("/findId")
    public String findIdProcess(@RequestParam String memName,
                                @RequestParam String memEmail,
                                Model model) {
        Member member = memberService.findByEmail(memEmail);
        if (member != null && member.getMemName().equals(memName)) {
            model.addAttribute("foundId", member.getMemId());
            return "findId";
        } else {
            model.addAttribute("error", "입력하신 정보와 일치하는 아이디가 없습니다.");
            return "findId";
        }
    }
}
