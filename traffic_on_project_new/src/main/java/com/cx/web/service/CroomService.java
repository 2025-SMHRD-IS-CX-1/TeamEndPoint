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

    public List<Croom> findByStatus(String status) {
        return croomRepository.findByCroomStatus(status);
    }
}
