package com.cx.web.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "t_traffic_on")
public class TrafficOn {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idx;

    private String lCategory;
    private String mCategory;
    private String sCategory;

    @Column(columnDefinition = "TEXT")
    private String minwonContent;

    private String img1;
    private String img2;
    private String img3;

    private java.time.LocalDateTime createdAt;
    private String adminId;
}
