package com.cx.web.service;

import com.cx.web.entity.Member;
import com.cx.web.repository.MemberRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberService {
    private final MemberRepository memberRepository;

    public MemberService(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    public List<Member> findAll() {
        return memberRepository.findAll();
    }

    public Member save(Member member) {
        return memberRepository.save(member);
    }

    public Member findByEmail(String email) {
        return memberRepository.findByMemEmail(email);
    }

    public Member findById(String id) {
        return memberRepository.findById(id).orElse(null);
    }

    public Member update(String id, Member member) {
        return memberRepository.findById(id)
                .map(existing -> {
                    existing.setMemName(member.getMemName());
                    existing.setMemEmail(member.getMemEmail());
                    existing.setMemPw(member.getMemPw());
                    existing.setMemPhone(member.getMemPhone());
                    existing.setMemAddr(member.getMemAddr());
                    existing.setMemGender(member.getMemGender());
                    existing.setMemBirthdate(member.getMemBirthdate());
                    existing.setMemType(member.getMemType());
                    existing.setJoinedAt(member.getJoinedAt());
                    return memberRepository.save(existing);
                })
                .orElse(null);
    }

    public void delete(String id) {
        memberRepository.deleteById(id);
    }
}
