package com.cx.web.controller;

import com.cx.web.entity.Analysis;
import com.cx.web.repository.AnalysisRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class AnalysisController {

    @Autowired
    private AnalysisRepository analysisRepository;

    @GetMapping("/analysis")
    public String analysisPage(Model model) {
        List<Analysis> analysisList = analysisRepository.findAll();
        model.addAttribute("analysisList", analysisList);
        return "common/analysis"; // analysis.jsp
    }
}
