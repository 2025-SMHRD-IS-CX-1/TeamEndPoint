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

    @GetMapping
    public List<Croom> getCrooms() {
        return croomService.findAll();
    }

    @PostMapping
    public Croom createCroom(@RequestBody Croom croom) {
        return croomService.save(croom);
    }

    @GetMapping("/status/{status}")
    public List<Croom> getCroomsByStatus(@PathVariable String status) {
        return croomService.findByStatus(status);
    }
}
