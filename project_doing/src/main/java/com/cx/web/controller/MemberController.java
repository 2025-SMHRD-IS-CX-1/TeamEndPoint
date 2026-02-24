package com.cx.web.controller;

import com.cx.web.entity.Member;
import com.cx.web.service.MemberService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/members")
public class MemberController {

    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    // 회원 목록 조회
    @GetMapping
    public String list(Model model) {
        List<Member> members = memberService.findAll();
        model.addAttribute("members", members);
        return "member_list"; // member_list.jsp
    }

    // 회원 상세 조회
    @GetMapping("/{id}")
    public String detail(@PathVariable String id, Model model) {
        Member member = memberService.findById(id);
        model.addAttribute("member", member);
        return "member_detail"; // member_detail.jsp
    }

    // 회원 삭제
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable String id) {
        memberService.delete(id);
        return "redirect:/members";
    }

    // 회원 수정
    @PostMapping("/{id}/update")
    public String update(@PathVariable String id, Member member) {
        memberService.update(id, member);
        return "redirect:/members/" + id;
    }
}
