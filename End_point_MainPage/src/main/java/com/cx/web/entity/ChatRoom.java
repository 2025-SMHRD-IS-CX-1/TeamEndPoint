package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_croom")
public class ChatRoom {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idx;

    @Column(name = "croom_title", length = 255, nullable = false)
    private String croomTitle;

    @Column(name = "category", length = 255)
    private String category;

    @Column(name = "croom_desc")
    private String croomDesc;

    @Column(name = "croom_limit")
    private int croomLimit;

    @Column(name = "mem_id", length = 50)
    private String memId;

    @Column(name = "croom_status", length = 2)
    private String croomStatus;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    // getter, setter
}
