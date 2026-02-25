package com.cx.web.controller;

import com.cx.web.entity.Analysis;
import com.cx.web.service.AnalysisService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/analysis")
public class AnalysisController {
    private final AnalysisService analysisService;

    public AnalysisController(AnalysisService analysisService) {
        this.analysisService = analysisService;
    }

    // 전체 조회
    @GetMapping
    public List<Analysis> getAllAnalysis() {
        return analysisService.findAll();
    }

    // 특정 분석 조회
    @GetMapping("/{id}")
    public Analysis getAnalysis(@PathVariable Long id) {
        return analysisService.findById(id);
    }

    // 분석 등록
    @PostMapping
    public Analysis createAnalysis(@RequestBody Analysis analysis) {
        return analysisService.save(analysis);
    }

    // 분석 수정
    @PutMapping("/{id}")
    public Analysis updateAnalysis(@PathVariable Long id, @RequestBody Analysis analysis) {
        return analysisService.update(id, analysis);
    }

    // 분석 삭제
    @DeleteMapping("/{id}")
    public void deleteAnalysis(@PathVariable Long id) {
        analysisService.delete(id);
    }
}
// 오류투성이잖아