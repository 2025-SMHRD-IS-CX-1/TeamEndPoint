package com.cx.web.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cx.web.entity.Member;

public interface MemberRepository extends JpaRepository<Member, String>{

	Optional<Member> findByMemIDAndMemPW(String memID, String memPW);
	boolean existsByMemID(String memID);
}
