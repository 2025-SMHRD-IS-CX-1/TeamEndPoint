package com.cx.web.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminUserRowDto {
	
	 private String memID;
	  private String memName;
	  private String memEmail;
	  private String memPhone;
	  private String memGender;
	  private Integer warnCnt;
	  private String status;
	  private String joinedAtStr;
	  private String district;
	  private String memAddr;
	  private String ageGroup;
}
