// 하라 수정중
package com.cx.web;

import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
                               @RequestParam(required = false, defaultValue = "user") String activeTab,
                               HttpSession session) {

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
            session.setAttribute("loginMember", loginMember);
            session.setAttribute("loginRole", "ADMIN");  
            
            return "redirect:/admin/dashboard";
        }

        session.setAttribute("loginMember", loginMember);
        session.setAttribute("loginRole", "USER");  
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

            @RequestParam(required = false, defaultValue = "user") String activeTab,
            @RequestParam(required = false) String memType,

            @RequestParam(required = false) String businessNum1,
            @RequestParam(required = false) String businessNum2,
            @RequestParam(required = false) String businessNum3,
            @RequestParam(required = false) String agencyNum,
            @RequestParam(required = false) String ceoName,
            @RequestParam(required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate openDate,

            RedirectAttributes ra
    ) {

        System.out.println("========== SIGNUP DEBUG ==========");
        System.out.println("activeTab = " + activeTab);

        // ✅ 서버가 최종 memType 결정
        if ("admin".equals(activeTab)) memType = "ADMIN";
        else memType = "USER";

        System.out.println("memType(최종) = " + memType);

        // ✅ 1) 아이디 중복 방지 (DB에서 터지기 전에 차단)
        if (memberRepository.existsByMemID(memId)) {
            ra.addFlashAttribute("signupError", "이미 사용 중인 아이디입니다.");
            return "redirect:/signup";
        }

        // ✅ 2) 관리자면 필수값 검증(비어 있으면 500 터질 가능성 큼)
        if ("ADMIN".equalsIgnoreCase(memType)) {
            String b1 = nvl(businessNum1);
            String b2 = nvl(businessNum2);
            String b3 = nvl(businessNum3);

            boolean missing = b1.isBlank() || b2.isBlank() || b3.isBlank()
                    || isBlank(agencyNum) || isBlank(ceoName) || openDate == null;

            if (missing) {
                ra.addFlashAttribute("signupError", "관리자 회원가입 필수 항목을 모두 입력해 주세요.");
                return "redirect:/signup";
            }
        }

        try {
            // 1) Member 저장
            Member member = new Member();
            member.setMemID(memId);
            member.setMemPW(memPw);
            member.setMemName(memName);
            member.setMemEmail(memEmail);
            member.setMemPhone(memPhone);

            member.setMemAddr(memAddr);
            member.setMemGender(memGender);
            member.setMemBirthdate(memBirthdate);

            member.setMemType(memType);
            member.setJoinedAt(LocalDateTime.now());
            
            member.setWarnCnt(0);
            member.setStatus("ACTIVE");

            Member savedMember = memberRepository.save(member);

            // 2) 관리자면 Admin도 저장
            if ("ADMIN".equalsIgnoreCase(memType)) {
                String bizNum = nvl(businessNum1) + nvl(businessNum2) + nvl(businessNum3);

                System.out.println("=== ADMIN SIGNUP DEBUG ===");
                System.out.println("bizNum=" + bizNum);
                System.out.println("agencyNum=" + agencyNum);
                System.out.println("ceoName=" + ceoName);
                System.out.println("openDate=" + openDate);

                Admin admin = new Admin();
                admin.setMember(savedMember);
                admin.setBizNum(bizNum);
                admin.setAgencyNum(agencyNum);
                admin.setCeoName(ceoName);
                admin.setOpenDate(openDate);

                adminRepository.save(admin);

                // ✅ 관리자 회원가입 성공 -> 관리자 탭으로 로그인 화면
                return "redirect:/login?signup=admin_success&tab=admin";
            }

            // ✅ 일반 회원가입 성공 -> 유저 탭으로 로그인 화면
            return "redirect:/login?signup=success&tab=user";

        } catch (Exception e) {
            e.printStackTrace(); // ✅ 콘솔에 원인 찍힘
            ra.addFlashAttribute("signupError", "회원가입 중 오류가 발생했습니다. (콘솔 로그 확인)");
            return "redirect:/signup";
        }
    }

    // ===== helper =====
    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
    private String nvl(String s) {
        return (s == null) ? "" : s.trim();
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