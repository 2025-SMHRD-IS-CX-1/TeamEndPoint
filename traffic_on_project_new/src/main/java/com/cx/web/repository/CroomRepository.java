package com.cx.web.repository;

import com.cx.web.entity.Croom;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CroomRepository extends JpaRepository<Croom, Integer> {
    // 방 상태별 조회
    List<Croom> findByCroomStatus(String status);
}
