package com.cx.web.controller;

import com.cx.web.entity.TrafficOn;
import com.cx.web.repository.TrafficOnRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class TrafficOnController {

    @Autowired
    private TrafficOnRepository trafficOnRepository;

    @GetMapping("/traffic")
    public String trafficPage(Model model) {
        List<TrafficOn> trafficList = trafficOnRepository.findAll();
        model.addAttribute("trafficList", trafficList);
        return "common/traffic"; // traffic.jsp
    }
}
