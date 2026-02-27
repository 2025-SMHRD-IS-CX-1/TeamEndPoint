package com.cx.web.controller;

import com.cx.web.entity.Member;
import com.cx.web.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class MemberController {

    @Autowired
    private MemberRepository memberRepository;

    @GetMapping("/members")
    public String memberPage(Model model) {
        List<Member> members = memberRepository.findAll();
        model.addAttribute("members", members);
        return "common/member"; // member.jsp
    }
}
