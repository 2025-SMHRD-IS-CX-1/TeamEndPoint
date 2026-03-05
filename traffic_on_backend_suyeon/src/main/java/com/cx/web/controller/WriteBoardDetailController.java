package com.cx.web.controller;

import com.cx.web.entity.WriteBoard;
import com.cx.web.repository.WriteBoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class WriteBoardDetailController {

    @Autowired
    private WriteBoardRepository writeBoardRepository;

    @GetMapping("/board/{id}")
    public String boardDetail(@PathVariable("id") Integer id, Model model) {
        WriteBoard board = writeBoardRepository.findById(id).orElse(null);
        if (board == null) {
            return "redirect:/board";
        }
        model.addAttribute("board", board);
        return "writeboarddetail";
    }
}