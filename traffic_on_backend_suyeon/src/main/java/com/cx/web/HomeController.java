package com.cx.web;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cx.web.entity.Board;
import com.cx.web.entity.Member;
import com.cx.web.entity.WriteBoard;
import com.cx.web.repository.BoardRepository;
import com.cx.web.repository.MemberRepository;
import com.cx.web.repository.WriteBoardRepository;

@Controller
public class HomeController {

    private final MemberRepository memberRepository;
    private final WriteBoardRepository writeBoardRepository;
    private final BoardRepository boardRepository;

    public HomeController(MemberRepository memberRepository,
                          WriteBoardRepository writeBoardRepository,
                          BoardRepository boardRepository) {
        this.memberRepository = memberRepository;
        this.writeBoardRepository = writeBoardRepository;
        this.boardRepository = boardRepository;
    }

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

        // 관리자 ID 목록
        List<String> adminIds = memberRepository.findAll().stream()
            .filter(m -> "ADMIN".equals(m.getMemType()))
            .map(Member::getMemID)
            .collect(Collectors.toList());

        // ✅ 관리자가 쓴 글 중 제목에 '공지사항' 포함된 것만 최신 5개
        List<Board> allBoards = boardRepository.findAllByOrderByBoardIdDesc();
        List<Board> adminBoards = allBoards.stream()
            .filter(b -> adminIds.contains(b.getMemId()) && b.getTitle().contains("공지사항"))
            .limit(5)
            .collect(Collectors.toList());

        model.addAttribute("recentBoards", adminBoards);

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
    public String guide(HttpSession session, Model model) {
        model.addAttribute("isLoggedIn", isLoggedIn(session));
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

    // ✅ 여기에 추가
    @PostMapping("/mypage/update-preferences")
    public String updatePreferences(@RequestParam(required = false) String regions,
                                     HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/login";

        loginMember.setMemAddr(regions);
        memberRepository.save(loginMember);
        session.setAttribute("loginMember", loginMember);

        return "redirect:/mypage";
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

    @GetMapping("/events/{id}")
    public String eventDetailPage(@PathVariable("id") int id,
                                  HttpSession session,
                                  HttpServletRequest request,
                                  Model model) {
        tryAutoLogin(session, request);
        model.addAttribute("isLoggedIn", isLoggedIn(session));

        if (id == 1) {
            model.addAttribute("eventTitle", "광주 추억의 충장축제");
            model.addAttribute("eventDate", "2025.10.15 ~ 10.19");
            model.addAttribute("eventCategory", "축제");
            model.addAttribute("eventImage", "/images/1.jpg");
            model.addAttribute("eventDesc",
                    "7080 세대의 추억을 되살리는 광주 대표 거리축제! 옛 거리 재현, 추억의 전시관, 화려한 퍼레이드가 펼쳐지는 전 세대 공감 페스티벌입니다.");
        } else if (id == 2) {
            model.addAttribute("eventTitle", "광주 비엔날레");
            model.addAttribute("eventDate", "2025.08.30 ~ 11.02");
            model.addAttribute("eventCategory", "전시");
            model.addAttribute("eventImage", "/images/2.jpg");
            model.addAttribute("eventDesc",
                    "현대 예술의 흐름을 보여주는 최고의 전시! 전 세계 아티스트들이 참여하여 실험적이고 창의적인 작품들을 선보이는 글로벌 문화 예술의 장입니다.");
        } else if (id == 3) {
            model.addAttribute("eventTitle", "광주 세계 김치 축제");
            model.addAttribute("eventDate", "2024.10.18 ~ 10.20");
            model.addAttribute("eventCategory", "음식");
            model.addAttribute("eventImage", "/images/3.jpg");
            model.addAttribute("eventDesc",
                    "대한민국 김치의 맛을 세계에 알리는 풍성한 축제! 김치 담그기 체험부터 명인의 비법 전수까지, 김치의 모든 것을 직접 경험할 수 있습니다.");
        } else {
            return "redirect:/events";
        }

        return "event-detail";
    }
}