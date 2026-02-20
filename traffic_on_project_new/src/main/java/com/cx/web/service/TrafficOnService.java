package com.cx.web.service;

import com.cx.web.entity.TrafficOn;
import com.cx.web.repository.TrafficOnRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class TrafficOnService {
    private final TrafficOnRepository trafficOnRepository;

    public TrafficOnService(TrafficOnRepository trafficOnRepository) {
        this.trafficOnRepository = trafficOnRepository;
    }

    public List<TrafficOn> findAll() {
        return trafficOnRepository.findAll();
    }

    public TrafficOn save(TrafficOn trafficOn) {
        return trafficOnRepository.save(trafficOn);
    }

    public List<TrafficOn> findByLCategory(String lCategory) {
        return trafficOnRepository.findByLCategory(lCategory);
    }
}
