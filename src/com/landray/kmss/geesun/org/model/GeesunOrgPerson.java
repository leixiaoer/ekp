package com.landray.kmss.geesun.org.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.org.forms.GeesunOrgPersonForm;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.DateUtil;

/**
  * 人员中间表
  */
public class GeesunOrgPerson extends BaseModel {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static ModelToFormPropertyMap toFormPropertyMap;

    private Integer fdPersonId;

    private String fdEmpNo;

    private String fdEmpName;

    private Integer fdParentId;

    private Integer fdPostId;

    private String fdSex;

    private String fdBirthDate;

    private String fdMobile;

    private String fdAddress;

    private String fdCountry;

    private Integer fdSuperPostId;

    private Integer fdSuperDeptId;

    private String fdRank;

    private String fdEmail;

    private String fdIdCard;

    private String fdEntryDate;

    private String fdLeaveDate;

    private String fdCity;

    private String fdSubjectName;

    private String fdWorkState;

    private Date fdNewDate;

    private Date docCreateTime;
    
    private Date fdEstimateTime;
    
    private String fdEmpCategory;
    
    private String fdEducation;
    
    private String fdKQCategory;
    
    public Class<GeesunOrgPersonForm> getFormClass() {
        return GeesunOrgPersonForm.class;
    }

    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("fdNewDate", new ModelConvertor_Common("fdNewDate").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("docCreateTime", new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
        }
        return toFormPropertyMap;
    }

    public void recalculateFields() {
        super.recalculateFields();
    }

    /**
     * 人员ID
     */
    public Integer getFdPersonId() {
        return this.fdPersonId;
    }

    /**
     * 人员ID
     */
    public void setFdPersonId(Integer fdPersonId) {
        this.fdPersonId = fdPersonId;
    }

    /**
     * 工号
     */
    public String getFdEmpNo() {
        return this.fdEmpNo;
    }

    /**
     * 工号
     */
    public void setFdEmpNo(String fdEmpNo) {
        this.fdEmpNo = fdEmpNo;
    }

    /**
     * 姓名
     */
    public String getFdEmpName() {
        return this.fdEmpName;
    }

    /**
     * 姓名
     */
    public void setFdEmpName(String fdEmpName) {
        this.fdEmpName = fdEmpName;
    }

    /**
     * 部门ID
     */
    public Integer getFdParentId() {
        return this.fdParentId;
    }

    /**
     * 部门ID
     */
    public void setFdParentId(Integer fdParentId) {
        this.fdParentId = fdParentId;
    }

    /**
     * 岗位ID
     */
    public Integer getFdPostId() {
        return this.fdPostId;
    }

    /**
     * 岗位ID
     */
    public void setFdPostId(Integer fdPostId) {
        this.fdPostId = fdPostId;
    }

    /**
     * 性别
     */
    public String getFdSex() {
        return this.fdSex;
    }

    /**
     * 性别
     */
    public void setFdSex(String fdSex) {
        this.fdSex = fdSex;
    }

    /**
     * 生日
     */
    public String getFdBirthDate() {
        return this.fdBirthDate;
    }

    /**
     * 生日
     */
    public void setFdBirthDate(String fdBirthDate) {
        this.fdBirthDate = fdBirthDate;
    }

    /**
     * 手机号
     */
    public String getFdMobile() {
        return this.fdMobile;
    }

    /**
     * 手机号
     */
    public void setFdMobile(String fdMobile) {
        this.fdMobile = fdMobile;
    }

    /**
     * 地址
     */
    public String getFdAddress() {
        return this.fdAddress;
    }

    /**
     * 地址
     */
    public void setFdAddress(String fdAddress) {
        this.fdAddress = fdAddress;
    }

    /**
     * 国家
     */
    public String getFdCountry() {
        return this.fdCountry;
    }

    /**
     * 国家
     */
    public void setFdCountry(String fdCountry) {
        this.fdCountry = fdCountry;
    }

    /**
     * 上级岗位ID
     */
    public Integer getFdSuperPostId() {
        return this.fdSuperPostId;
    }

    /**
     * 上级岗位ID
     */
    public void setFdSuperPostId(Integer fdSuperPostId) {
        this.fdSuperPostId = fdSuperPostId;
    }

    /**
     * 上级部门ID
     */
    public Integer getFdSuperDeptId() {
        return this.fdSuperDeptId;
    }

    /**
     * 上级部门ID
     */
    public void setFdSuperDeptId(Integer fdSuperDeptId) {
        this.fdSuperDeptId = fdSuperDeptId;
    }

    /**
     * 职级
     */
    public String getFdRank() {
        return this.fdRank;
    }

    /**
     * 职级
     */
    public void setFdRank(String fdRank) {
        this.fdRank = fdRank;
    }

    /**
     * 邮箱
     */
    public String getFdEmail() {
        return this.fdEmail;
    }

    /**
     * 邮箱
     */
    public void setFdEmail(String fdEmail) {
        this.fdEmail = fdEmail;
    }

    /**
     * 身份证号
     */
    public String getFdIdCard() {
        return this.fdIdCard;
    }

    /**
     * 身份证号
     */
    public void setFdIdCard(String fdIdCard) {
        this.fdIdCard = fdIdCard;
    }

    /**
     * 入职时间
     */
    public String getFdEntryDate() {
        return this.fdEntryDate;
    }

    /**
     * 入职时间
     */
    public void setFdEntryDate(String fdEntryDate) {
        this.fdEntryDate = fdEntryDate;
    }

    /**
     * 离职时间
     */
    public String getFdLeaveDate() {
        return this.fdLeaveDate;
    }

    /**
     * 离职时间
     */
    public void setFdLeaveDate(String fdLeaveDate) {
        this.fdLeaveDate = fdLeaveDate;
    }

    /**
     * 城市
     */
    public String getFdCity() {
        return this.fdCity;
    }

    /**
     * 城市
     */
    public void setFdCity(String fdCity) {
        this.fdCity = fdCity;
    }

    /**
     * 科目
     */
    public String getFdSubjectName() {
        return this.fdSubjectName;
    }

    /**
     * 科目
     */
    public void setFdSubjectName(String fdSubjectName) {
        this.fdSubjectName = fdSubjectName;
    }

    /**
     * 在职状态
     */
    public String getFdWorkState() {
        return this.fdWorkState;
    }

    /**
     * 在职状态
     */
    public void setFdWorkState(String fdWorkState) {
        this.fdWorkState = fdWorkState;
    }

    /**
     * 更新时间
     */
    public Date getFdNewDate() {
        return this.fdNewDate;
    }

    /**
     * 更新时间
     */
    public void setFdNewDate(Date fdNewDate) {
        this.fdNewDate = fdNewDate;
    }

    /**
     * 创建时间
     */
    public Date getDocCreateTime() {
        return this.docCreateTime;
    }

    /**
     * 创建时间
     */
    public void setDocCreateTime(Date docCreateTime) {
        this.docCreateTime = docCreateTime;
    }
    
    /**
     * 入职时间
     */
    public Date getFdEstimateTime() {
        return this.fdEstimateTime;
    }

    /**
     * 入职时间
     */
    public void setFdEstimateTime(Date fdEstimateTime) {
        this.fdEstimateTime = fdEstimateTime;
    }
    
    /**
     * 员工类型
     */
    public String getFdEmpCategory() {
        return this.fdEmpCategory;
    }

    /**
     * 员工类型
     */
    public void setFdEmpCategory(String fdEmpCategory) {
        this.fdEmpCategory = fdEmpCategory;
    }
    
    /**
     * 学历
     */
    public String getFdEducation() {
        return this.fdEducation;
    }

    /**
     * 学历
     */
    public void setFdEducation(String fdEducation) {
        this.fdEducation = fdEducation;
    }
    
    /**
     * 考勤类型
     */
    public String getFdKQCategory() {
        return this.fdKQCategory;
    }

    /**
     * 考勤类型
     */
    public void setFdKQCategory(String fdKQCategory) {
        this.fdKQCategory = fdKQCategory;
    }
    

}
