package com.cx.web.entity;
import java.time.LocalDate;
import java.time.LocalDateTime;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="t_member")
@Getter @Setter
@NoArgsConstructor
public class Member {
	
	@Id
	@Column(name = "mem_id", length = 50, nullable = false)
	private String memID;
	
	@Column(name = "mem_pw", length = 255, nullable = false)
	private String memPW;
	
	@Column(name = "mem_name", length = 50, nullable = false)
	private String memName;
	
	@Column(name = "mem_email", length = 50, nullable = false)
	private String memEmail;
	
	@Column(name = "mem_phone", length = 20, nullable = false)
	private String memPhone;
	
	@Column(name = "mem_addr", length = 10, nullable = true)
	private String memAddr;

	@Column(name = "mem_gender", length = 2, nullable = true)
	private String memGender;

	@Column(name = "mem_birthdate", nullable = true)
	private LocalDate memBirthdate;
	
	@Column(name = "mem_type", length = 10, nullable = false)
	private String memType;
	
	@Column(name = "joined_at", nullable = false)
	private LocalDateTime joinedAt;
	
	@Column(name = "last_login_at", nullable = true)
	private LocalDateTime lastLoginAt;
	
	@Column(name = "warn_cnt", nullable = false)
	private Integer warnCnt;
	
	@Column(name = "status", length = 10, nullable = false)
	private String status;

	// ✅ 수동 Getter
	public String getMemID()        { return memID; }
	public String getMemPW()        { return memPW; }
	public String getMemName()      { return memName; }
	public String getMemEmail()     { return memEmail; }
	public String getMemPhone()     { return memPhone; }
	public String getMemAddr()      { return memAddr; }
	public String getMemGender()    { return memGender; }
	public LocalDate getMemBirthdate() { return memBirthdate; }
	public String getMemType()      { return memType; }
	public LocalDateTime getJoinedAt()    { return joinedAt; }
	public LocalDateTime getLastLoginAt() { return lastLoginAt; }
	public Integer getWarnCnt()     { return warnCnt; }
	public String getStatus()       { return status; }

	// ✅ 수동 Setter
	public void setMemID(String memID)           { this.memID = memID; }
	public void setMemPW(String memPW)           { this.memPW = memPW; }
	public void setMemName(String memName)       { this.memName = memName; }
	public void setMemEmail(String memEmail)     { this.memEmail = memEmail; }
	public void setMemPhone(String memPhone)     { this.memPhone = memPhone; }
	public void setMemAddr(String memAddr)       { this.memAddr = memAddr; }
	public void setMemGender(String memGender)   { this.memGender = memGender; }
	public void setMemBirthdate(LocalDate memBirthdate) { this.memBirthdate = memBirthdate; }
	public void setMemType(String memType)       { this.memType = memType; }
	public void setJoinedAt(LocalDateTime joinedAt)    { this.joinedAt = joinedAt; }
	public void setLastLoginAt(LocalDateTime lastLoginAt) { this.lastLoginAt = lastLoginAt; }
	public void setWarnCnt(Integer warnCnt)      { this.warnCnt = warnCnt; }
	public void setStatus(String status)         { this.status = status; }

	public int getWarnCntSafe() {
		return warnCnt == null ? 0 : warnCnt;
	}
}