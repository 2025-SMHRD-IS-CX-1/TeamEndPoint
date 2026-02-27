package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_analysis")
public class Analysis {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idx;

    @Column(name = "dl_model", length = 255)
    private String dlModel;

    @Column(name = "analysis_result")
    private String analysisResult;

    @Column(name = "kwd_1")
    private String kwd1;

    @Column(name = "kwd_2")
    private String kwd2;

    @Column(name = "kwd_3")
    private String kwd3;

    @Column(name = "kwd_4")
    private String kwd4;

    @Column(name = "kwd_5")
    private String kwd5;

    @Column(name = "kwd_6")
    private String kwd6;

    @Column(name = "kwd_7")
    private String kwd7;

    @Column(name = "kwd_8")
    private String kwd8;

    @Column(name = "kwd_9")
    private String kwd9;

    @Column(name = "kwd_10")
    private String kwd10;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "admin_id", length = 50)
    private String adminId;

    // getter, setter
}
