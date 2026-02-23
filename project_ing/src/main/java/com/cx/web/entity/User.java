package com.cx.web.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Column;

@Entity
@Table(name = "t_member")  // 실제 DB 테이블 이름 지정
public class User {

    @Id
    @Column(name = "mem_id")   // DB 컬럼명과 매핑
    private String memId;

    @Column(name = "mem_pw")
    private String memPw;

    @Column(name = "mem_name")
    private String memName;

    @Column(name = "mem_email")
    private String memEmail;

    @Column(name = "mem_phone")
    private String memPhone;

    @Column(name = "mem_addr")
    private String memAddr;

    @Column(name = "mem_gender")
    private String memGender;

    @Column(name = "mem_birthdate")
    private String memBirthdate;

    @Column(name = "mem_type")
    private String memType;

    @Column(name = "joined_at")
    private String joinedAt;

    // Getter & Setter
    public String getMemId() { return memId; }
    public void setMemId(String memId) { this.memId = memId; }

    public String getMemPw() { return memPw; }
    public void setMemPw(String memPw) { this.memPw = memPw; }

    public String getMemName() { return memName; }
    public void setMemName(String memName) { this.memName = memName; }

    public String getMemEmail() { return memEmail; }
    public void setMemEmail(String memEmail) { this.memEmail = memEmail; }

    public String getMemPhone() { return memPhone; }
    public void setMemPhone(String memPhone) { this.memPhone = memPhone; }

    public String getMemAddr() { return memAddr; }
    public void setMemAddr(String memAddr) { this.memAddr = memAddr; }

    public String getMemGender() { return memGender; }
    public void setMemGender(String memGender) { this.memGender = memGender; }

    public String getMemBirthdate() { return memBirthdate; }
    public void setMemBirthdate(String memBirthdate) { this.memBirthdate = memBirthdate; }

    public String getMemType() { return memType; }
    public void setMemType(String memType) { this.memType = memType; }

    public String getJoinedAt() { return joinedAt; }
    public void setJoinedAt(String joinedAt) { this.joinedAt = joinedAt; }
}
