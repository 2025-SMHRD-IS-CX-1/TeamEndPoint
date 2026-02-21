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

    public TrafficOn findById(Long id) {
        return trafficOnRepository.findById(id).orElse(null);
    }

    public TrafficOn update(Long id, TrafficOn trafficOn) {
        return trafficOnRepository.findById(id)
                .map(existing -> {
                    existing.setTrafficType(trafficOn.getTrafficType());
                    existing.setTrafficStatus(trafficOn.getTrafficStatus());
                    existing.setUpdatedAt(trafficOn.getUpdatedAt());
                    return trafficOnRepository.save(existing);
                })
                .orElse(null);
    }

    public void delete(Long id) {
        trafficOnRepository.deleteById(id);
    }
}
