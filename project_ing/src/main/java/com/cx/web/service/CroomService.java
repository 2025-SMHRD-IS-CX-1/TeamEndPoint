package com.cx.web.service;

import com.cx.web.entity.Croom;
import com.cx.web.repository.CroomRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CroomService {
    private final CroomRepository croomRepository;

    public CroomService(CroomRepository croomRepository) {
        this.croomRepository = croomRepository;
    }

    public List<Croom> findAll() {
        return croomRepository.findAll();
    }

    public Croom save(Croom croom) {
        return croomRepository.save(croom);
    }

    public Croom findById(Long id) {
        return croomRepository.findById(id).orElse(null);
    }

    public Croom update(Long id, Croom croom) {
        return croomRepository.findById(id)
                .map(existing -> {
                    existing.setCroomName(croom.getCroomName());
                    existing.setMemId(croom.getMemId());
                    existing.setCreatedAt(croom.getCreatedAt());
                    return croomRepository.save(existing);
                })
                .orElse(null);
    }

    public void delete(Long id) {
        croomRepository.deleteById(id);
    }
}
