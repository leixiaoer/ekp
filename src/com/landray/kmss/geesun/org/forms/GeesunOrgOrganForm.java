package com.landray.kmss.geesun.org.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_Common;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.org.model.GeesunOrgOrgan;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.web.action.ActionMapping;

/**
  * 组织部门中间表
  */
public class GeesunOrgOrganForm extends ExtendForm {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static FormToModelPropertyMap toModelPropertyMap;

    private String fdDeptId;

    private String fdDeptNo;
    
    private String fdDeptName;

    private String fdParentId;

    private String fdSetupDate;

    private String fdIsDel;

    private String fdNewDate;

    private String docCreateTime;
    
    private String fdRemark;
    
    private String fdChargeMan;

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        fdDeptId = null;
        fdDeptNo = null;
        fdDeptName = null;
        fdParentId = null;
        fdSetupDate = null;
        fdIsDel = null;
        fdNewDate = null;
        docCreateTime = null;
        fdRemark = null;
        fdChargeMan = null;
        super.reset(mapping, request);
    }

    public Class<GeesunOrgOrgan> getModelClass() {
        return GeesunOrgOrgan.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.put("fdSetupDate", new FormConvertor_Common("fdSetupDate").setDateTimeType(DateUtil.TYPE_DATE));
            toModelPropertyMap.put("fdNewDate", new FormConvertor_Common("fdNewDate").setDateTimeType(DateUtil.TYPE_DATETIME));
            toModelPropertyMap.addNoConvertProperty("docCreateTime");
        }
        return toModelPropertyMap;
    }

    /**
     * 部门ID
     */
    public String getFdDeptId() {
        return this.fdDeptId;
    }

    /**
     * 部门ID
     */
    public void setFdDeptId(String fdDeptId) {
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
    public String getFdParentId() {
        return this.fdParentId;
    }

    /**
     * 上级部门ID
     */
    public void setFdParentId(String fdParentId) {
        this.fdParentId = fdParentId;
    }

    /**
     * 生效时间
     */
    public String getFdSetupDate() {
        return this.fdSetupDate;
    }

    /**
     * 生效时间
     */
    public void setFdSetupDate(String fdSetupDate) {
        this.fdSetupDate = fdSetupDate;
    }

    /**
     * 是否删除
     */
    public String getFdIsDel() {
        return this.fdIsDel;
    }

    /**
     * 是否删除
     */
    public void setFdIsDel(String fdIsDel) {
        this.fdIsDel = fdIsDel;
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
    public String getFdChargeMan() {
        return this.fdChargeMan;
    }

    /**
     * 部门领导
     */
    public void setFdChargeMan(String fdChargeMan) {
        this.fdChargeMan = fdChargeMan;
    }

}
