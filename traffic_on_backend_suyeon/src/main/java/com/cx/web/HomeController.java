package com.cx.web;

import java.util.List;
import java.util.Optional;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.cx.web.entity.Member;
import com.cx.web.entity.WriteBoard;
import com.cx.web.repository.MemberRepository;
import com.cx.web.repository.WriteBoardRepository;

@Controller
public class HomeController {

    private final MemberRepository memberRepository;
    private final WriteBoardRepository writeBoardRepository;

    public HomeController(MemberRepository memberRepository, WriteBoardRepository writeBoardRepository) {
        this.memberRepository = memberRepository;
        this.writeBoardRepository = writeBoardRepository;
    }

    // ✅ 쿠키 자동로그인: 세션 없을 때만 복구 (관리자는 절대 X)
    private void tryAutoLogin(HttpSession session, HttpServletRequest request) {
        if (session.getAttribute("loginMember") != null) return; // 이미 로그인 상태면 끝

        Cookie[] cookies = request.getCookies();
        if (cookies == null) return;

        String keepLoginId = null;
        for (Cookie c : cookies) {
            if ("keepLoginId".equals(c.getName())) {
                keepLoginId = c.getValue();
                break;
            }
        }

        if (keepLoginId == null || keepLoginId.isBlank()) return;

        Optional<Member> opt = memberRepository.findByMemID(keepLoginId);
        if (opt.isEmpty()) return;

        Member m = opt.get();

        // ✅ 관리자 자동로그인 차단
        if ("ADMIN".equalsIgnoreCase(m.getMemType())) return;

        // (선택) 정지/비활성 계정이면 막고 싶으면 여기에 조건 추가
        // 예: if (!"ACTIVE".equalsIgnoreCase(m.getStatus())) return;

        session.setAttribute("loginMember", m);
        session.setAttribute("loginRole", "USER");
    }

    // 로그인 여부 체크
    private boolean isLoggedIn(HttpSession session) {
        return session != null && session.getAttribute("loginMember") != null;
    }

    @GetMapping("/")
    public String index(HttpSession session, HttpServletRequest request, Model model) {
        tryAutoLogin(session, request);
        model.addAttribute("isLoggedIn", isLoggedIn(session));
        return "index";
    }

    @GetMapping("/chat")
    public String chatPage(HttpSession session, HttpServletRequest request, Model model) {
        tryAutoLogin(session, request);
        model.addAttribute("isLoggedIn", isLoggedIn(session));
        return "chat";
    }

    @GetMapping("/events")
    public String eventsPage(HttpSession session, HttpServletRequest request, Model model) {
        tryAutoLogin(session, request);
        model.addAttribute("isLoggedIn", isLoggedIn(session));
        return "events";
    }

    @GetMapping("/about")
    public String aboutPage(HttpSession session, HttpServletRequest request, Model model) {
        tryAutoLogin(session, request);
        model.addAttribute("isLoggedIn", isLoggedIn(session));
        return "redirect:/";
    }

    @GetMapping("/application-process")
    public String applicationProcess(HttpSession session, HttpServletRequest request, Model model) {
        tryAutoLogin(session, request);
        model.addAttribute("isLoggedIn", isLoggedIn(session));
        return "process";
    }
    
    @GetMapping("/guide")
    public String guide() {
        return "guide";
    }
    
    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/login";
        }

        model.addAttribute("member", loginMember);

        // ✅ 내 게시글 미리보기(최근 3개)
        List<WriteBoard> all =
            writeBoardRepository.findByMemIdOrderByCreatedAtDesc(loginMember.getMemID());

        model.addAttribute("myPostsPreview", all.size() > 3 ? all.subList(0, 3) : all);

        return "mypage";   // mypage.jsp
    }
    
    @GetMapping("/my-posts")
    public String myPosts(HttpSession session, Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/login";

        List<WriteBoard> posts =
        	    writeBoardRepository.findByMemIdOrderByCreatedAtDesc(loginMember.getMemID());

        model.addAttribute("posts", posts);
        return "my-posts";
    }
}