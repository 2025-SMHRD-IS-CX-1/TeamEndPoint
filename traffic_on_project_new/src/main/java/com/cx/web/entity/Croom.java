package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_croom")
public class Croom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idx")
    private Long idx;

    @Column(name = "croom_title", length = 255)
    private String croomTitle;

    @Column(name = "category", length = 255)
    private String category;

    @Column(name = "croom_desc", length = 255)
    private String croomDesc;

    @Column(name = "croom_limit")
    private Integer croomLimit;

    @Column(name = "mem_id", length = 50)
    private String memId;

    @Column(name = "croom_status", length = 20)
    private String croomStatus;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    // Getter/Setter
    public Long getIdx() { return idx; }
    public void setIdx(Long idx) { this.idx = idx; }

    public String getCroomTitle() { return croomTitle; }
    public void setCroomTitle(String croomTitle) { this.croomTitle = croomTitle; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getCroomDesc() { return croomDesc; }
    public void setCroomDesc(String croomDesc) { this.croomDesc = croomDesc; }

    public Integer getCroomLimit() { return croomLimit; }
    public void setCroomLimit(Integer croomLimit) { this.croomLimit = croomLimit; }

    public String getMemId() { return memId; }
    public void setMemId(String memId) { this.memId = memId; }

    public String getCroomStatus() { return croomStatus; }
    public void setCroomStatus(String croomStatus) { this.croomStatus = croomStatus; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}