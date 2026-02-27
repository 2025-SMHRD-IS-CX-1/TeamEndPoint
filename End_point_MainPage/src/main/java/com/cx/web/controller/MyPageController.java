package com.cx.web.controller;

import com.cx.web.entity.Member;
import com.cx.web.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyPageController {

    @Autowired
    private MemberRepository memberRepository;

    @GetMapping("/mypage")
    public String myPage(Model model) {
        // 예시: 현재 로그인한 사용자 ID를 가져와 DB 조회
        String loginId = "hara01"; // 실제로는 세션/인증에서 가져와야 함
        Member member = memberRepository.findByMemId(loginId);

        // DB 조회 결과 전달
        model.addAttribute("member", member);

        // 본문 JSP 지정
        model.addAttribute("contentPage", "/WEB-INF/views/common/mypage.jsp");

        // MobileLayout.jsp 렌더링
        return "common/MobileLayout";
    }

    @GetMapping("/my-posts")
    public String myPosts(Model model) {
        // 본문 JSP 지정
        model.addAttribute("contentPage", "/WEB-INF/views/common/my-posts.jsp");

        // MobileLayout.jsp 렌더링
        return "common/MobileLayout";
    }
}
