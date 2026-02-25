package com.cx.web.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "t_analysis")
public class Analysis {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idx;

    private String dlModel;
    private String analysisResult;

    private String kwd1;
    private String kwd2;
    private String kwd3;
    private String kwd4;
    private String kwd5;
    private String kwd6;
    private String kwd7;
    private String kwd8;
    private String kwd9;
    private String kwd10;

    private java.time.LocalDateTime createdAt;
    private String adminId;
}
