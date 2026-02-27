package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_admin")
public class Admin {
    @Id
    @Column(name = "mem_id", length = 50)
    private String memId;

    @Column(name = "biz_num", length = 20)
    private String bizNum;

    @Column(name = "agency_num", length = 10)
    private String agencyNum;

    @Column(name = "ceo_name", length = 50)
    private String ceoName;

    @Column(name = "open_date")
    private LocalDate openDate;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    // getter, setter
}
