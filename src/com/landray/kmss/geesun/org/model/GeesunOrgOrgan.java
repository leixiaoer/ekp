package com.landray.kmss.geesun.org.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.org.forms.GeesunOrgOrganForm;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.DateUtil;

/**
  * 组织部门中间表
  */
public class GeesunOrgOrgan extends BaseModel {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static ModelToFormPropertyMap toFormPropertyMap;

    private Integer fdDeptId;

    private String fdDeptNo;
    
    private String fdDeptName;

    private Integer fdParentId;

    private Date fdSetupDate;

    private Integer fdIsDel;

    private Date fdNewDate;

    private Date docCreateTime;
    
    private String fdRemark;
    
    private Integer fdChargeMan;

    public Class<GeesunOrgOrganForm> getFormClass() {
        return GeesunOrgOrganForm.class;
    }

    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("fdSetupDate", new ModelConvertor_Common("fdSetupDate").setDateTimeType(DateUtil.TYPE_DATE));
            toFormPropertyMap.put("fdNewDate", new ModelConvertor_Common("fdNewDate").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("docCreateTime", new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
        }
        return toFormPropertyMap;
    }

    public void recalculateFields() {
        super.recalculateFields();
    }

    /**
     * 部门ID
     */
    public Integer getFdDeptId() {
        return this.fdDeptId;
    }

    /**
     * 部门ID
     */
    public void setFdDeptId(Integer fdDeptId) {
        this.fdDeptId = fdDeptId;
    }
    
    /**
     * 部门编号
     */
    public String getFdDeptNo() {
        return this.fdDeptNo;
    }

    /**
     * 部门编号
     */
    public void setFdDeptNo(String fdDeptNo) {
        this.fdDeptNo = fdDeptNo;
    }

    /**
     * 部门名称
     */
    public String getFdDeptName() {
        return this.fdDeptName;
    }

    /**
     * 部门名称
     */
    public void setFdDeptName(String fdDeptName) {
        this.fdDeptName = fdDeptName;
    }

    /**
     * 上级部门ID
     */
    public Integer getFdParentId() {
        return this.fdParentId;
    }

    /**
     * 上级部门ID
     */
    public void setFdParentId(Integer fdParentId) {
        this.fdParentId = fdParentId;
    }

    /**
     * 生效时间
     */
    public Date getFdSetupDate() {
        return this.fdSetupDate;
    }

    /**
     * 生效时间
     */
    public void setFdSetupDate(Date fdSetupDate) {
        this.fdSetupDate = fdSetupDate;
    }

    /**
     * 是否删除
     */
    public Integer getFdIsDel() {
        return this.fdIsDel;
    }

    /**
     * 是否删除
     */
    public void setFdIsDel(Integer fdIsDel) {
        this.fdIsDel = fdIsDel;
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
     * 备注
     */
    public String getFdRemark() {
        return this.fdRemark;
    }

    /**
     * 备注
     */
    public void setFdRemark(String fdRemark) {
        this.fdRemark = fdRemark;
    }
    
    /**
     * 部门领导
     */
    public Integer getFdChargeMan() {
        return this.fdChargeMan;
    }

    /**
     * 部门领导
     */
    public void setFdChargeMan(Integer fdChargeMan) {
        this.fdChargeMan = fdChargeMan;
    }
    
}
