package com.cx.web.service;

import com.cx.web.entity.Analysis;
import com.cx.web.repository.AnalysisRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnalysisService {
    private final AnalysisRepository analysisRepository;

    public AnalysisService(AnalysisRepository analysisRepository) {
        this.analysisRepository = analysisRepository;
    }

    public List<Analysis> findAll() {
        return analysisRepository.findAll();
    }

    public Analysis save(Analysis analysis) {
        return analysisRepository.save(analysis);
    }

    public Analysis findById(Long id) {
        return analysisRepository.findById(id).orElse(null);
    }

    public Analysis update(Long id, Analysis analysis) {
        return analysisRepository.findById(id)
                .map(existing -> {
                    existing.setDlModel(analysis.getDlModel());
                    existing.setAnalysisResult(analysis.getAnalysisResult());
                    existing.setKwd1(analysis.getKwd1());
                    existing.setKwd2(analysis.getKwd2());
                    // ... 필요한 필드들 업데이트
                    return analysisRepository.save(existing);
                })
                .orElse(null);
    }

    public void delete(Long id) {
        analysisRepository.deleteById(id);
    }
}
