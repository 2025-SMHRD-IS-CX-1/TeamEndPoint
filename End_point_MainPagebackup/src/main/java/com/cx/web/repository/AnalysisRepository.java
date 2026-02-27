package com.cx.web.repository;

import com.cx.web.entity.Analysis;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AnalysisRepository extends JpaRepository<Analysis, Integer> {
    // 기본 CRUD 제공
}
