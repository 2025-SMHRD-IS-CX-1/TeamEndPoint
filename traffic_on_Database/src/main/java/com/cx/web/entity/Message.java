package com.cx.web.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_message")
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "msg_id")
    private Long msgId;   // PK

    @Column(name = "sender_id", length = 50)
    private String senderId;   // 발신자 ID

    @Column(name = "receiver_id", length = 50)
    private String receiverId; // 수신자 ID

    @Column(name = "content", length = 1000)
    private String content;    // 메시지 내용

    @Column(name = "sent_at")
    private LocalDateTime sentAt; // 발송 시각

    // ✅ Getter/Setter
    public Long getMsgId() { return msgId; }
    public void setMsgId(Long msgId) { this.msgId = msgId; }

    public String getSenderId() { return senderId; }
    public void setSenderId(String senderId) { this.senderId = senderId; }

    public String getReceiverId() { return receiverId; }
    public void setReceiverId(String receiverId) { this.receiverId = receiverId; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public LocalDateTime getSentAt() { return sentAt; }
    public void setSentAt(LocalDateTime sentAt) { this.sentAt = sentAt; }
}
