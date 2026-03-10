package com.cx.web.entity;
import java.time.LocalDate;
import java.time.LocalDateTime;
import org.hibernate.annotations.CreationTimestamp;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="t_admin")
public class Admin {
    @Id
    @Column(name = "mem_id", length = 50)
    private String memId;

    @MapsId
    @OneToOne
    @JoinColumn(name ="mem_id")
    private Member member;

    @Column(name = "biz_num", length = 20, nullable = false)
    private String bizNum;

    @Column(name = "agency_num", length = 10, nullable = false)
    private String agencyNum;

    @Column(name = "ceo_name", length = 50, nullable = false)
    private String ceoName;

    @Column(name = "open_date", length = 10, nullable = false)
    private LocalDate openDate;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    public String getMemId() { return memId; }
    public void setMemId(String memId) { this.memId = memId; }

    public Member getMember() { return member; }
    public void setMember(Member member) { this.member = member; }

    public String getBizNum() { return bizNum; }
    public void setBizNum(String bizNum) { this.bizNum = bizNum; }

    public String getAgencyNum() { return agencyNum; }
    public void setAgencyNum(String agencyNum) { this.agencyNum = agencyNum; }

    public String getCeoName() { return ceoName; }
    public void setCeoName(String ceoName) { this.ceoName = ceoName; }

    public LocalDate getOpenDate() { return openDate; }
    public void setOpenDate(LocalDate openDate) { this.openDate = openDate; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}