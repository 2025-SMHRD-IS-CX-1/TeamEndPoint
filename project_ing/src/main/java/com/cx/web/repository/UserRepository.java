package com.cx.web.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.cx.web.entity.User;

public interface UserRepository extends JpaRepository<User, String> {
    User findByMemId(String memId);
}

