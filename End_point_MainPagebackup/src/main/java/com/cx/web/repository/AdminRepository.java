package com.cx.web.repository;

import com.cx.web.entity.Admin;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdminRepository extends JpaRepository<Admin, String> {
    // 기본 CRUD 제공
}
