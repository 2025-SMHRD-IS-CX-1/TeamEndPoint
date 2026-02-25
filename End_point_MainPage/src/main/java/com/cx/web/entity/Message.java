package com.cx.web.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "t_message")
public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idx;

    private int croomIdx;
    private String chatter;

    @Column(columnDefinition = "TEXT")
    private String chatContent;

    private String chatEmoticon;
    private String chatFile;
    private java.time.LocalDateTime createdAt;
}
