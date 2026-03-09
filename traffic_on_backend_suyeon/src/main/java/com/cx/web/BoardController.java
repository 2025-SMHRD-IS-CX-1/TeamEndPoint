package com.cx.web;

import com.cx.web.entity.Board;
import com.cx.web.entity.Member;
import com.cx.web.repository.BoardRepository;
import com.cx.web.repository.MemberRepository;
import jakarta.servlet.http.HttpSession;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class BoardController {

    @Autowired
    private BoardRepository boardRepository;

    @Autowired
    private MemberRepository memberRepository;

    @GetMapping("/board")
    public String boardPage(Model model, HttpSession session) {
        List<Board> boards = boardRepository.findAllByOrderByBoardIdDesc();

        // 관리자 ID 목록 추출
        List<String> adminIds = memberRepository.findAll().stream()
            .filter(m -> "ADMIN".equals(m.getMemType()))
            .map(Member::getMemID)
            .collect(Collectors.toList());

        // ✅ 공지사항 상단 고정 정렬
        List<Board> pinned = boards.stream()
            .filter(b -> adminIds.contains(b.getMemId()) && b.getTitle().contains("공지사항"))
            .collect(Collectors.toList());
        List<Board> normal = boards.stream()
            .filter(b -> !(adminIds.contains(b.getMemId()) && b.getTitle().contains("공지사항")))
            .collect(Collectors.toList());
        List<Board> sortedBoards = new ArrayList<>();
        sortedBoards.addAll(pinned);
        sortedBoards.addAll(normal);

        model.addAttribute("boards", sortedBoards);
        model.addAttribute("pinnedCount", pinned.size());
        model.addAttribute("adminIds", adminIds);

        Member loginMember = (Member) session.getAttribute("loginMember");
        System.out.println("로그인 사용자: " + loginMember);
        boolean isLoggedIn = loginMember != null;
        boolean isAdmin = isLoggedIn && "ADMIN".equals(loginMember.getMemType());

        model.addAttribute("isLoggedIn", isLoggedIn);
        model.addAttribute("isAdmin", isAdmin);

        return "board";
    }

    // ✅ 크롤링 후 게시글 자동 등록
    @PostMapping("/board/crawl")
    @ResponseBody
    public String crawlAndPost(HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null || !"ADMIN".equals(loginMember.getMemType())) {
            return "UNAUTHORIZED";
        }

        try {
            String BASE_URL = "https://www.gwangju.go.kr/build/boardList.do?boardId=BD_0000001156&pageId=build134";

            Document listDoc = Jsoup.connect(BASE_URL)
                .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
                .get();

            Element firstLink = listDoc.selectFirst("div.board_list_body div.body_row div.subject a");
            if (firstLink == null) return "FAIL";

            String title = firstLink.text().trim();
            String href = "https://www.gwangju.go.kr" + firstLink.attr("href");

            Document detailDoc = Jsoup.connect(href)
                .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
                .get();

            Element contentDiv = detailDoc.selectFirst("div.board_view_body");
            if (contentDiv == null) return "FAIL";

            String rawHtml = contentDiv.html();
            String[] parts = rawHtml.split("<br>");
            StringBuilder sb = new StringBuilder();
            for (String part : parts) {
                String clean = Jsoup.parse(part).text().trim();
                if (!clean.isEmpty()) {
                    sb.append(clean).append("\n");
                }
            }
            String content = sb.toString().trim();

            Board board = new Board();
            board.setMemId(loginMember.getMemID());
            board.setTitle("[공지사항] " + title); // ✅ 공지사항 prefix 추가
            board.setContent(content);
            board.setCategory("정보/가이드");
            board.setCreatedAt(LocalDateTime.now());
            boardRepository.save(board);

            return "SUCCESS";

        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL";
        }
    }
}