package com.cx.web.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.cx.web.entity.Analysis;
import com.cx.web.repository.AnalysisRepository;

@RestController
@RequestMapping("/analysis")
public class AnalysisController {

    @Autowired
    private AnalysisRepository analysisRepository;

    @GetMapping
    public List<Analysis> getAllAnalysis() {
        return analysisRepository.findAll();
    }

    @PostMapping
    public Analysis saveAnalysis(@RequestBody Analysis analysis) {
        return analysisRepository.save(analysis);
    }
}
