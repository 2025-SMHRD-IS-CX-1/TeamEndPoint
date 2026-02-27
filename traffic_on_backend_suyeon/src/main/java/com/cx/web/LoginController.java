package com.cx.web;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cx.web.entity.Admin;
import com.cx.web.entity.Member;
import com.cx.web.repository.AdminRepository;
import com.cx.web.repository.MemberRepository;

@Controller
public class LoginController {

    private final MemberRepository memberRepository;
    private final AdminRepository adminRepository;

    // 생성자 주입 (Spring이 자동으로 넣어줌)
    public LoginController(MemberRepository memberRepository, AdminRepository adminRepository) {
        this.memberRepository = memberRepository;
        this.adminRepository = adminRepository;
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/signup")
    public String signup() {
        return "signup";
    }
    
    @GetMapping("/api/member/check-id")
    @ResponseBody
    public boolean checkId(@RequestParam String memId) {
    	return memberRepository.existsByMemID(memId);
    }

    @GetMapping("/findPw")
    public String findPwPage() {
        return "findPw";
    }

    @GetMapping("/findId")
    public String findIdPage() {
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

        Optional<Member> opt = memberRepository.findByMemIDAndMemPW(username, password);

        if (opt.isEmpty()) {
            return "redirect:/login?error=true&tab=" + activeTab;
        }

        Member loginMember = opt.get();

        // ✅ 관리자로 들어가려면 DB에서 memType이 ADMIN이어야 함
        if ("admin".equals(activeTab)) {
            if (!"ADMIN".equalsIgnoreCase(loginMember.getMemType())) {
                // 일반회원이 관리자탭으로 로그인 시도한 경우
                return "redirect:/login?error=notAdmin&tab=admin";
            }
            return "redirect:/admin/dashboard";
        }

        return "redirect:/";
    }

    @PostMapping("/signup")
    public String signupProcess(
            @RequestParam String memId,
            @RequestParam String memPw,
            @RequestParam String memName,
            @RequestParam String memEmail,
            @RequestParam String memPhone,

            @RequestParam(required = false) String memAddr,
            @RequestParam(required = false) String memGender,
            @RequestParam(required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate memBirthdate,

            // ✅ hidden으로 받음 (USER / ADMIN)
            @RequestParam(required = false, defaultValue = "user") String activeTab,

            @RequestParam(required = false) String memType,

            // ✅ 관리자일 때만 넘어오는 값들
            @RequestParam(required = false) String businessNum1,
            @RequestParam(required = false) String businessNum2,
            @RequestParam(required = false) String businessNum3,
            @RequestParam(required = false) String agencyNum,
            @RequestParam(required = false) String ceoName,
            @RequestParam(required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate openDate
    ) {
    	
    	System.out.println("========== SIGNUP DEBUG ==========");
    	System.out.println("activeTab = " + activeTab);

    	// ✅ 서버가 최종 memType 결정 (프론트에서 memType 비어도 안전)
    	if ("admin".equals(activeTab)) memType = "ADMIN";
    	else memType = "USER";

    	System.out.println("memType(최종) = " + memType);

        // 1) Member 저장
        Member member = new Member();
        member.setMemID(memId);
        member.setMemPW(memPw);
        member.setMemName(memName);
        member.setMemEmail(memEmail);
        member.setMemPhone(memPhone);

        // 일반회원일 때만 들어오는 값들
        member.setMemAddr(memAddr);
        member.setMemGender(memGender);
        member.setMemBirthdate(memBirthdate);

        member.setMemType(memType);                 // USER or ADMIN
        member.setJoinedAt(LocalDateTime.now());

        Member savedMember = memberRepository.save(member);

        // 2) 관리자면 Admin도 저장
        if ("ADMIN".equalsIgnoreCase(memType)) {
            String bizNum = (businessNum1 == null ? "" : businessNum1)
                    + (businessNum2 == null ? "" : businessNum2)
                    + (businessNum3 == null ? "" : businessNum3);

            System.out.println("=== ADMIN SIGNUP DEBUG ===");
            System.out.println("bizNum=" + bizNum);
            System.out.println("agencyNum=" + agencyNum);
            System.out.println("ceoName=" + ceoName);
            System.out.println("openDate=" + openDate);

            Admin admin = new Admin();
            admin.setMember(savedMember);  // ✅ 이걸로!
            admin.setBizNum(bizNum);
            admin.setAgencyNum(agencyNum);
            admin.setCeoName(ceoName);
            admin.setOpenDate(openDate);

            adminRepository.save(admin);
        }

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