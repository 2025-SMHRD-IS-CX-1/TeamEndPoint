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

    // 쿠키 자동로그인
    private void tryAutoLogin(HttpSession session, HttpServletRequest request) {
        if (session.getAttribute("loginMember") != null) return;

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
        if ("ADMIN".equalsIgnoreCase(m.getMemType())) return;

        session.setAttribute("loginMember", m);
        session.setAttribute("loginRole", "USER");
    }

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
        return "about";
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
        if (loginMember == null) return "redirect:/login";

        model.addAttribute("member", loginMember);

        List<WriteBoard> all =
                writeBoardRepository.findByMemIdOrderByCreatedAtDesc(loginMember.getMemID());

        model.addAttribute("myPostsPreview", all.size() > 3 ? all.subList(0, 3) : all);

        return "mypage";
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