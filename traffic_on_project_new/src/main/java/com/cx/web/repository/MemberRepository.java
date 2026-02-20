package com.cx.web.repository;

import com.cx.web.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, String> {
    Member findByMemEmail(String memEmail);
}
