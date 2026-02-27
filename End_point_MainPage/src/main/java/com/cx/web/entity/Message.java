package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_message")
public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idx;

    @ManyToOne
    @JoinColumn(name = "croom_idx", nullable = false)
    private ChatRoom chatRoom;

    @Column(name = "chatter", length = 50)
    private String chatter;

    @Column(name = "chat_content")
    private String chatContent;

    @Column(name = "chat_emoticon")
    private String chatEmoticon;

    @Column(name = "chat_file")
    private String chatFile;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    // getter, setter
}
