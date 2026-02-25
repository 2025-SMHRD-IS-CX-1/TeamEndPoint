package com.cx.web.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.cx.web.entity.TrafficOn;   // ✅ 소문자 entity로 변경

public interface TrafficOnRepository extends JpaRepository<TrafficOn, Integer> {
}
