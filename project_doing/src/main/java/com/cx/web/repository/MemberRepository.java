package com.cx.web.repository;

import com.cx.web.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, String> {
    Member findByMemId(String memId);       // 로그인용
    Member findByMemEmail(String memEmail); // 이메일 조회용
}
