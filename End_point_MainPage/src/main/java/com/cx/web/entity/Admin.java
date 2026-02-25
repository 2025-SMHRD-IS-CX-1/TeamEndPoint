package com.cx.web.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "t_admin")
public class Admin {
    @Id
    private String memId;

    private String bizNum;
    private String agencyNum;
    private String ceoName;
    private java.time.LocalDate openDate;
    private java.time.LocalDateTime createdAt;
}
