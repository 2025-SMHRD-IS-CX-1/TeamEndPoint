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

    // 전체 조회
    public List<Member> findAll() {
        return memberRepository.findAll();
    }

    // 회원가입
    public Member signup(Member member) {
        return memberRepository.save(member);
    }

    // 로그인
    public Member login(String memId, String memPw) {
        Member member = memberRepository.findByMemId(memId);
        if (member != null && member.getMemPw().equals(memPw)) {
            return member;
        }
        return null;
    }

    // 이메일로 찾기
    public Member findByEmail(String email) {
        return memberRepository.findByMemEmail(email);
    }

    // ID로 찾기
    public Member findById(String id) {
        return memberRepository.findById(id).orElse(null);
    }

    // 업데이트
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

    // 삭제
    public void delete(String id) {
        memberRepository.deleteById(id);
    }

    // ✅ 비밀번호 재설정
    public void updatePassword(String memId, String newPassword) {
        Member member = memberRepository.findById(memId).orElse(null);
        if (member != null) {
            member.setMemPw(newPassword); // 현재는 평문 저장 (추후 BCrypt 적용 가능)
            memberRepository.save(member);
        }
    }

    // ✅ 아이디 + 연락처 확인
    public boolean verifyContact(String memId, String contact) {
        Member member = findById(memId);
        if (member == null) return false;
        return contact.equals(member.getMemEmail()) || contact.equals(member.getMemPhone());
    }

    /*
    // ✅ 인증번호 검증 (임시)
    // 실제 구현에서는 SMS/이메일 API 연동 필요
    public boolean verifyCode(String code) {
        return "123456".equals(code);
    }
    */
}
