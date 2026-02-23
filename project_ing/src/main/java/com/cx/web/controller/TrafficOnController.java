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

    // 전체 조회
    @GetMapping
    public List<TrafficOn> getAllTraffic() {
        return trafficOnService.findAll();
    }

    // 특정 조회
    @GetMapping("/{id}")
    public TrafficOn getTraffic(@PathVariable Long id) {
        return trafficOnService.findById(id);
    }

    // 생성
    @PostMapping
    public TrafficOn createTraffic(@RequestBody TrafficOn trafficOn) {
        return trafficOnService.save(trafficOn);
    }

    // 수정
    @PutMapping("/{id}")
    public TrafficOn updateTraffic(@PathVariable Long id, @RequestBody TrafficOn trafficOn) {
        return trafficOnService.update(id, trafficOn);
    }

    // 삭제
    @DeleteMapping("/{id}")
    public void deleteTraffic(@PathVariable Long id) {
        trafficOnService.delete(id);
    }
}
