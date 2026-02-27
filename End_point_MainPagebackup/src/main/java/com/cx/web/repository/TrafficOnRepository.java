package com.cx.web.repository;

import com.cx.web.entity.TrafficOn;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TrafficOnRepository extends JpaRepository<TrafficOn, Integer> {
    // 기본 CRUD 제공
}
