package com.cx.web.controller;

import com.cx.web.entity.TrafficOn;
import com.cx.web.service.TrafficOnService;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/traffic")
public class TrafficOnController {
    private final TrafficOnService trafficOnService;

    public TrafficOnController(TrafficOnService trafficOnService) {
        this.trafficOnService = trafficOnService;
    }

    @GetMapping
    public List<TrafficOn> getTrafficList() {
        return trafficOnService.findAll();
    }

    @PostMapping
    public TrafficOn createTraffic(@RequestBody TrafficOn trafficOn) {
        return trafficOnService.save(trafficOn);
    }

    @GetMapping("/category/{lCategory}")
    public List<TrafficOn> getTrafficByCategory(@PathVariable String lCategory) {
        return trafficOnService.findByLCategory(lCategory);
    }
}
