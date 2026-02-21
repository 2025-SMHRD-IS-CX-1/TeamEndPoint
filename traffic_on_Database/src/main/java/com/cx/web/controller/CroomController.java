package com.cx.web.controller;

import com.cx.web.entity.Croom;
import com.cx.web.service.CroomService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/crooms")
public class CroomController {
    private final CroomService croomService;

    public CroomController(CroomService croomService) {
        this.croomService = croomService;
    }

    // 전체 채팅방 조회
    @GetMapping
    public List<Croom> getAllCrooms() {
        return croomService.findAll();
    }

    // 특정 채팅방 조회
    @GetMapping("/{id}")
    public Croom getCroom(@PathVariable Long id) {
        return croomService.findById(id);
    }

    // 채팅방 생성
    @PostMapping
    public Croom createCroom(@RequestBody Croom croom) {
        return croomService.save(croom);
    }

    // 채팅방 수정
    @PutMapping("/{id}")
    public Croom updateCroom(@PathVariable Long id, @RequestBody Croom croom) {
        return croomService.update(id, croom);
    }

    // 채팅방 삭제
    @DeleteMapping("/{id}")
    public void deleteCroom(@PathVariable Long id) {
        croomService.delete(id);
    }
}
