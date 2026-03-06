package com.cx.web;

<<<<<<< HEAD
import com.cx.web.entity.WriteBoard;
import com.cx.web.repository.WriteBoardRepository;
import jakarta.servlet.http.HttpSession;
=======
import com.cx.web.entity.Board;
import com.cx.web.repository.BoardRepository;

import jakarta.servlet.http.HttpSession;

>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
<<<<<<< HEAD
=======

>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
import java.util.List;

@Controller
public class BoardController {

    @Autowired
<<<<<<< HEAD
    private WriteBoardRepository writeBoardRepository;

    @GetMapping("/board")
    public String boardPage(Model model, HttpSession session) {
        List<WriteBoard> boards = writeBoardRepository.findAll();
        model.addAttribute("boards", boards);

        Object loginUser = session.getAttribute("loginMember");
        System.out.println("로그인 사용자: " + loginUser);
        boolean isLoggedIn = (loginUser != null);
        model.addAttribute("isLoggedIn", isLoggedIn);

        return "board";
    }
}
=======
    private BoardRepository boardRepository;

    @GetMapping("/board")
    public String boardPage(Model model, HttpSession session) {
        List<Board> boards = boardRepository.findAll();
        model.addAttribute("boards", boards);

        // 세션에 로그인 사용자 정보가 있는지 확인
        Object loginUser = session.getAttribute("loginMember");
        System.out.println("로그인 사용자: " + loginUser); // ✅ 여기서 로그 찍기

        boolean isLoggedIn = (loginUser != null);
        model.addAttribute("isLoggedIn", isLoggedIn);

        return "board"; // 항상 board.jsp로 렌더링
    }


}

>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
