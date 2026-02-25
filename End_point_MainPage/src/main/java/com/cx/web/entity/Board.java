package com.cx.web.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "t_board")
public class Board {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int boardId;

    private String title;
    private String content;
    private String category;
    private String memId;

    private java.time.LocalDateTime createdAt;
    private java.time.LocalDateTime updatedAt;
}
