package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_traffic_on")
public class TrafficOn {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idx;

    @Column(name = "l_category", length = 255)
    private String lCategory;

    @Column(name = "m_category", length = 255)
    private String mCategory;

    @Column(name = "s_category", length = 255)
    private String sCategory;

    @Column(name = "minwon_content")
    private String minwonContent;

    @Column(name = "img_1")
    private String img1;

    @Column(name = "img_2")
    private String img2;

    @Column(name = "img_3")
    private String img3;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "admin_id", length = 50)
    private String adminId;

    // getter, setter
}
