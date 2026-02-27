package com.cx.web.controller;

import com.cx.web.entity.Board;
import com.cx.web.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class MyPostsController {

    @Autowired
    private BoardRepository boardRepository;

    @GetMapping("/myposts")
    public String myPostsPage(Model model) {
        // 예시: 로그인한 사용자 ID (실제로는 세션/인증에서 가져와야 함)
        String loginId = "hara01";

        // 해당 사용자가 작성한 게시글 조회
        List<Board> myPosts = boardRepository.findByMemId(loginId);

        model.addAttribute("myPosts", myPosts);
        return "common/my-posts"; // my-posts.jsp
    }
}
