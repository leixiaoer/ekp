package com.landray.kmss.geesun.org.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_Common;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.org.model.GeesunOrgPerson;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.web.action.ActionMapping;

/**
  * 人员中间表
  */
public class GeesunOrgPersonForm extends ExtendForm {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static FormToModelPropertyMap toModelPropertyMap;

    private String fdPersonId;

    private String fdEmpNo;

    private String fdEmpName;

    private String fdParentId;

    private String fdPostId;

    private String fdSex;

    private String fdBirthDate;

    private String fdMobile;

    private String fdAddress;

    private String fdCountry;

    private String fdSuperPostId;

    private String fdSuperDeptId;

    private String fdRank;

    private String fdEmail;

    private String fdIdCard;

    private String fdEntryDate;

    private String fdLeaveDate;

    private String fdCity;

    private String fdSubjectName;

    private String fdWorkState;

    private String fdNewDate;

    private String docCreateTime;
    
    private String fdEstimateTime;
    
    public void reset(ActionMapping mapping, HttpServletRequest request) {
        fdPersonId = null;
        fdEmpNo = null;
        fdEmpName = null;
        fdParentId = null;
        fdPostId = null;
        fdSex = null;
        fdBirthDate = null;
        fdMobile = null;
        fdAddress = null;
        fdCountry = null;
        fdSuperPostId = null;
        fdSuperDeptId = null;
        fdRank = null;
        fdEmail = null;
        fdIdCard = null;
        fdEntryDate = null;
        fdLeaveDate = null;
        fdCity = null;
        fdSubjectName = null;
        fdWorkState = null;
        fdNewDate = null;
        docCreateTime = null;
        fdEstimateTime = null;
        super.reset(mapping, request);
    }

    public Class<GeesunOrgPerson> getModelClass() {
        return GeesunOrgPerson.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.put("fdNewDate", new FormConvertor_Common("fdNewDate").setDateTimeType(DateUtil.TYPE_DATETIME));
            toModelPropertyMap.addNoConvertProperty("docCreateTime");
            toModelPropertyMap.put("fdEstimateTime", new FormConvertor_Common("fdEstimateTime").setDateTimeType(DateUtil.TYPE_DATE));
        }
        return toModelPropertyMap;
    }

    /**
     * 人员ID
     */
    public String getFdPersonId() {
        return this.fdPersonId;
    }

    /**
     * 人员ID
     */
    public void setFdPersonId(String fdPersonId) {
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
    public String getFdParentId() {
        return this.fdParentId;
    }

    /**
     * 部门ID
     */
    public void setFdParentId(String fdParentId) {
        this.fdParentId = fdParentId;
    }

    /**
     * 岗位ID
     */
    public String getFdPostId() {
        return this.fdPostId;
    }

    /**
     * 岗位ID
     */
    public void setFdPostId(String fdPostId) {
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
    public String getFdSuperPostId() {
        return this.fdSuperPostId;
    }

    /**
     * 上级岗位ID
     */
    public void setFdSuperPostId(String fdSuperPostId) {
        this.fdSuperPostId = fdSuperPostId;
    }

    /**
     * 上级部门ID
     */
    public String getFdSuperDeptId() {
        return this.fdSuperDeptId;
    }

    /**
     * 上级部门ID
     */
    public void setFdSuperDeptId(String fdSuperDeptId) {
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
    public String getFdNewDate() {
        return this.fdNewDate;
    }

    /**
     * 更新时间
     */
    public void setFdNewDate(String fdNewDate) {
        this.fdNewDate = fdNewDate;
    }

    /**
     * 创建时间
     */
    public String getDocCreateTime() {
        return this.docCreateTime;
    }

    /**
     * 创建时间
     */
    public void setDocCreateTime(String docCreateTime) {
        this.docCreateTime = docCreateTime;
    }
    
    /**
     * 预计试用期结束时间
     */
    public String getFdEstimateTime() {
        return this.fdEstimateTime;
    }

    /**
     * 预计试用期结束时间
     */
    public void setFdEstimateTime(String fdEstimateTime) {
        this.fdEstimateTime = fdEstimateTime;
    }

}
