package com.cx.web.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.cx.web.entity.Analysis;   // ✅ 소문자 entity로 변경

public interface AnalysisRepository extends JpaRepository<Analysis, Integer> {
}
