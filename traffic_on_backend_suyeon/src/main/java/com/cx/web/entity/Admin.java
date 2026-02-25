package com.cx.web.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="t_admin")
@Getter @Setter
@NoArgsConstructor
public class Admin {

	@Id
	@Column(name = "mem_id", length = 50)
	private String memId;
	
	@MapsId
	@OneToOne
	@JoinColumn(name ="mem_id")
	private Member member;
	
	@Column(name = "biz_num", length = 20, nullable = false)
	private String bizNum;
	
	@Column(name = "agency_num", length = 10, nullable = false)
	private String agencyNum;
	
	@Column(name = "ceo_name", length = 50, nullable = false)
	private String ceoName;
	
	@Column(name = "open_date", length = 10, nullable = false)
	private LocalDate openDate;
	
	@CreationTimestamp
	@Column(name = "created_at", updatable = false)
	private LocalDateTime createdAt;
}
