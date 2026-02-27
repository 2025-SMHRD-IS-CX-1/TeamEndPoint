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
	

}
