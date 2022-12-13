package com.landray.kmss.geesun.ehr.bean;

/*
 *文件名: BackFromLeaveBean
 *创建者: zgf
 *描述: 新增销假单 bean
 */
public class BackFromLeaveBean {
    private String leaveOrderCode;
    private String code;
    private String beginDate;
    private String beginTime;
    private String endDate;
    private String endTime;
    private String totalHour;
    private String reason;
    private String createDate;
    private String empNo;
    private String totalDay;

    public String getLeaveOrderCode() {
        return leaveOrderCode;
    }

    public void setLeaveOrderCode(String leaveOrderCode) {
        this.leaveOrderCode = leaveOrderCode;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getTotalHour() {
        return totalHour;
    }

    public void setTotalHour(String totalHour) {
        this.totalHour = totalHour;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getTotalDay() {
        return totalDay;
    }

    public void setTotalDay(String totalDay) {
        this.totalDay = totalDay;
    }
}
