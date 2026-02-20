package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_analysis")
public class Analysis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idx")
    private Long idx;

    @Column(name = "dl_model", length = 255)
    private String dlModel;

    @Column(name = "analysis_result", length = 255)
    private String analysisResult;

    @Column(name = "kwd_1", length = 255)
    private String kwd1;

    @Column(name = "kwd_2", length = 255)
    private String kwd2;

    @Column(name = "kwd_3", length = 255)
    private String kwd3;

    @Column(name = "kwd_4", length = 255)
    private String kwd4;

    @Column(name = "kwd_5", length = 255)
    private String kwd5;

    @Column(name = "kwd_6", length = 255)
    private String kwd6;

    @Column(name = "kwd_7", length = 255)
    private String kwd7;

    @Column(name = "kwd_8", length = 255)
    private String kwd8;

    @Column(name = "kwd_9", length = 255)
    private String kwd9;

    @Column(name = "kwd_10", length = 255)
    private String kwd10;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "admin_id", length = 50)
    private String adminId;

    // Getter/Setter
    public Long getIdx() { return idx; }
    public void setIdx(Long idx) { this.idx = idx; }

    public String getDlModel() { return dlModel; }
    public void setDlModel(String dlModel) { this.dlModel = dlModel; }

    public String getAnalysisResult() { return analysisResult; }
    public void setAnalysisResult(String analysisResult) { this.analysisResult = analysisResult; }

    public String getKwd1() { return kwd1; }
    public void setKwd1(String kwd1) { this.kwd1 = kwd1; }

    public String getKwd2() { return kwd2; }
    public void setKwd2(String kwd2) { this.kwd2 = kwd2; }

    public String getKwd3() { return kwd3; }
    public void setKwd3(String kwd3) { this.kwd3 = kwd3; }

    public String getKwd4() { return kwd4; }
    public void setKwd4(String kwd4) { this.kwd4 = kwd4; }

    public String getKwd5() { return kwd5; }
    public void setKwd5(String kwd5) { this.kwd5 = kwd5; }

    public String getKwd6() { return kwd6; }
    public void setKwd6(String kwd6) { this.kwd6 = kwd6; }

    public String getKwd7() { return kwd7; }
    public void setKwd7(String kwd7) { this.kwd7 = kwd7; }

    public String getKwd8() { return kwd8; }
    public void setKwd8(String kwd8) { this.kwd8 = kwd8; }

    public String getKwd9() { return kwd9; }
    public void setKwd9(String kwd9) { this.kwd9 = kwd9; }

    public String getKwd10() { return kwd10; }
    public void setKwd10(String kwd10) { this.kwd10 = kwd10; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public String getAdminId() { return adminId; }
    public void setAdminId(String adminId) { this.adminId = adminId; }
}
