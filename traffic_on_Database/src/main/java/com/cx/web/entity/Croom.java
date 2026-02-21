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
    private String croomTitle;   // 채팅방 제목

    @Column(name = "category", length = 255)
    private String category;     // 카테고리

    @Column(name = "croom_desc", length = 255)
    private String croomDesc;    // 설명

    @Column(name = "croom_limit")
    private Integer croomLimit;  // 인원 제한

    @Column(name = "mem_id", length = 50)
    private String memId;        // 방장 ID

    @Column(name = "croom_status", length = 20)
    private String croomStatus;  // 상태 (예: OPEN, CLOSED)

    @Column(name = "created_at")
    private LocalDateTime createdAt; // 생성일시

    // 필요하다면 추가로 사용할 수 있는 필드
    private String croomName;

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

    public String getCroomName() { return croomName; }
    public void setCroomName(String croomName) { this.croomName = croomName; }
}
