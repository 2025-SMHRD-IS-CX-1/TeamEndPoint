package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_message")
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idx")
    private Long idx;

    @Column(name = "croom_idx")
    private Long croomIdx;

    @Column(name = "chatter", length = 50)
    private String chatter;

    @Column(name = "chat_content", length = 255)
    private String chatContent;

    @Column(name = "chat_emoticon", length = 255)
    private String chatEmoticon;

    @Column(name = "chat_file", length = 255)
    private String chatFile;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    // Getter/Setter
    public Long getIdx() { return idx; }
    public void setIdx(Long idx) { this.idx = idx; }

    public Long getCroomIdx() { return croomIdx; }
    public void setCroomIdx(Long croomIdx) { this.croomIdx = croomIdx; }

    public String getChatter() { return chatter; }
    public void setChatter(String chatter) { this.chatter = chatter; }

    public String getChatContent() { return chatContent; }
    public void setChatContent(String chatContent) { this.chatContent = chatContent; }

    public String getChatEmoticon() { return chatEmoticon; }
    public void setChatEmoticon(String chatEmoticon) { this.chatEmoticon = chatEmoticon; }

    public String getChatFile() { return chatFile; }
    public void setChatFile(String chatFile) { this.chatFile = chatFile; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}