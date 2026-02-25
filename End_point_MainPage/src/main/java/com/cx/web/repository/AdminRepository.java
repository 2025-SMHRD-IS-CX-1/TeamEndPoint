package com.cx.web.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.cx.web.entity.Admin;   // ✅ 패키지명을 소문자로 변경

public interface AdminRepository extends JpaRepository<Admin, String> {
}
