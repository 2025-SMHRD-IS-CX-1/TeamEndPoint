package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_member")
public class Member {

    @Id
    @Column(name = "mem_id", length = 50, nullable = false)
    private String memId;   // PK: 회원 아이디 (String)

    @Column(name = "mem_pw", length = 255, nullable = false)
    private String memPw;

    @Column(name = "mem_name", length = 50)
    private String memName;

    @Column(name = "mem_email", length = 50)
    private String memEmail;

    @Column(name = "mem_phone", length = 20)
    private String memPhone;

    @Column(name = "mem_addr", length = 255)
    private String memAddr;

    @Column(name = "mem_gender", length = 1)
    private String memGender;

    @Column(name = "mem_birthdate")
    private LocalDate memBirthdate;

    @Column(name = "mem_type", length = 10)
    private String memType;

    @Column(name = "joined_at")
    private LocalDateTime joinedAt;

    // ✅ Getter/Setter
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

    public LocalDate getMemBirthdate() { return memBirthdate; }
    public void setMemBirthdate(LocalDate memBirthdate) { this.memBirthdate = memBirthdate; }

    public String getMemType() { return memType; }
    public void setMemType(String memType) { this.memType = memType; }

    public LocalDateTime getJoinedAt() { return joinedAt; }
    public void setJoinedAt(LocalDateTime joinedAt) { this.joinedAt = joinedAt; }
}
