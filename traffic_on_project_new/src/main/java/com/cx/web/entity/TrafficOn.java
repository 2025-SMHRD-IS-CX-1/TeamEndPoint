package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_traffic_on")
public class TrafficOn {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idx")
    private Long idx;

    @Column(name = "l_category", length = 255)
    private String lCategory;

    @Column(name = "m_category", length = 255)
    private String mCategory;

    @Column(name = "s_category", length = 255)
    private String sCategory;

    @Column(name = "minwon_content", length = 255)
    private String minwonContent;

    @Column(name = "img_1", length = 255)
    private String img1;

    @Column(name = "img_2", length = 255)
    private String img2;

    @Column(name = "img_3", length = 255)
    private String img3;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "admin_id", length = 50)
    private String adminId;

    // Getter/Setter
    public Long getIdx() { return idx; }
    public void setIdx(Long idx) { this.idx = idx; }

    public String getLCategory() { return lCategory; }
    public void setLCategory(String lCategory) { this.lCategory = lCategory; }

    public String getMCategory() { return mCategory; }
    public void setMCategory(String mCategory) { this.mCategory = mCategory; }

    public String getSCategory() { return sCategory; }
    public void setSCategory(String sCategory) { this.sCategory = sCategory; }

    public String getMinwonContent() { return minwonContent; }
    public void setMinwonContent(String minwonContent) { this.minwonContent = minwonContent; }

    public String getImg1() { return img1; }
    public void setImg1(String img1) { this.img1 = img1; }

    public String getImg2() { return img2; }
    public void setImg2(String img2) { this.img2 = img2; }

    public String getImg3() { return img3; }
    public void setImg3(String img3) { this.img3 = img3; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public String getAdminId() { return adminId; }
    public void setAdminId(String adminId) { this.adminId = adminId; }
}