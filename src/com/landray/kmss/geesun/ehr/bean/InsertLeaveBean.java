package com.landray.kmss.geesun.ehr.bean;

/**
 * 新增请假单接口bean
 *
 * @author huangzhuanglai
 */
public class InsertLeaveBean {
    private String beginDate;//请假开始日期 "2022-05-18"
    private String empNo;// 员工工号 "SY0004"
    private String empName;//员工姓名
    private String code; //单号"L20220518005"
    private String endDate; //请假结束日期 "2022-05-18"
    private String beginTime; //开始时间"10:30"
    private String endTime; //结束时间"12:00"
    private String reason; //请假原因 "测试2",
    private String leaveCategoryName;// "事假",
    private String leaveWay; //请假方式 "4"


    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getLeaveCategoryName() {
        return leaveCategoryName;
    }

    public void setLeaveCategoryName(String leaveCategoryName) {
        this.leaveCategoryName = leaveCategoryName;
    }

    public String getLeaveWay() {
        return leaveWay;
    }

    public void setLeaveWay(String leaveWay) {
        this.leaveWay = leaveWay;
    }


}
