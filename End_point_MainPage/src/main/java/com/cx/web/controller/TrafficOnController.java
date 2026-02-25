package com.cx.web.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.cx.web.entity.TrafficOn;              // ✅ 소문자 entity
import com.cx.web.repository.TrafficOnRepository; // ✅ 소문자 repository

@RestController
@RequestMapping("/traffic")
public class TrafficOnController {

    @Autowired
    private TrafficOnRepository trafficOnRepository;

    @GetMapping
    public List<TrafficOn> getAllTrafficOn() {
        return trafficOnRepository.findAll();
    }

    @PostMapping
    public TrafficOn saveTrafficOn(@RequestBody TrafficOn trafficOn) {
        return trafficOnRepository.save(trafficOn);
    }
}
