package com.cx.web.repository;

import com.cx.web.entity.TrafficOn;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface TrafficOnRepository extends JpaRepository<TrafficOn, Integer> {
    // 대분류로 민원 조회
    List<TrafficOn> findByLCategory(String lCategory);
}
