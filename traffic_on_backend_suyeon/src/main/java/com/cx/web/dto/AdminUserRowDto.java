package com.cx.web.dto;

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

    public AdminUserRowDto() {}

    public String getMemID() { return memID; }
    public void setMemID(String memID) { this.memID = memID; }

    public String getMemName() { return memName; }
    public void setMemName(String memName) { this.memName = memName; }

    public String getMemEmail() { return memEmail; }
    public void setMemEmail(String memEmail) { this.memEmail = memEmail; }

    public String getMemPhone() { return memPhone; }
    public void setMemPhone(String memPhone) { this.memPhone = memPhone; }

    public String getMemGender() { return memGender; }
    public void setMemGender(String memGender) { this.memGender = memGender; }

    public Integer getWarnCnt() { return warnCnt; }
    public void setWarnCnt(Integer warnCnt) { this.warnCnt = warnCnt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getJoinedAtStr() { return joinedAtStr; }
    public void setJoinedAtStr(String joinedAtStr) { this.joinedAtStr = joinedAtStr; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getMemAddr() { return memAddr; }
    public void setMemAddr(String memAddr) { this.memAddr = memAddr; }

    public String getAgeGroup() { return ageGroup; }
    public void setAgeGroup(String ageGroup) { this.ageGroup = ageGroup; }
}