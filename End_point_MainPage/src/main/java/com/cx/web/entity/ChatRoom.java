package com.cx.web.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Column;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_croom")
public class ChatRoom {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idx;

    @Column(name = "croom_title")
    private String croomTitle;

    @Column(name = "category")
    private String category;

    @Column(name = "croom_desc")
    private String croomDesc;

    @Column(name = "croom_limit")
    private int croomLimit;

    @Column(name = "mem_id")
    private String memId;

    @Column(name = "croom_status")
    private String croomStatus;

    @Column(name = "created_at")   // ✅ DB 컬럼명과 매핑
    private LocalDateTime createdAt;
}
