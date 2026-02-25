package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "t_member")
public class Member {
    @Id
    @Column(name = "mem_id", length = 50)
    private String memId;

    @Column(name = "mem_pw", nullable = false)
    private String memPw;

    @Column(name = "mem_name", length = 50)
    private String memName;

    @Column(name = "mem_email")
    private String memEmail;

    @Column(name = "mem_phone")
    private String memPhone;

    @Column(name = "mem_addr")
    private String memAddr;

    @Column(name = "mem_gender", length = 2)
    private String memGender;

    @Column(name = "mem_birthdate")
    private LocalDate memBirthdate;

    @Column(name = "mem_type", length = 10)
    private String memType;

    @Column(name = "joined_at")
    private java.time.LocalDateTime joinedAt;
}
