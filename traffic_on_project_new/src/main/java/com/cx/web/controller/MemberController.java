package com.cx.web.controller;

import com.cx.web.entity.Member;
import com.cx.web.service.MemberService;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/members")
public class MemberController {
    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping
    public List<Member> getMembers() {
        return memberService.findAll();
    }

    @PostMapping
    public Member createMember(@RequestBody Member member) {
        return memberService.save(member);
    }

    @GetMapping("/email/{email}")
    public Member getMemberByEmail(@PathVariable String email) {
        return memberService.findByEmail(email);
    }
}
