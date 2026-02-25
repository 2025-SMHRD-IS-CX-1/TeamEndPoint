package com.cx.web.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cx.web.entity.Admin;

public interface AdminRepository extends JpaRepository<Admin, String> {

}
