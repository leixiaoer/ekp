package com.landray.kmss.geesun.base.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_IDsToModelList;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.base.model.GeesunBaseBxsj;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.web.action.ActionMapping;

/**
  * 报销科目勾稽关系表
  */
public class GeesunBaseBxsjForm extends ExtendForm {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static FormToModelPropertyMap toModelPropertyMap;

    private String fdTwoAccountName;

    private String fdTwoAccountCode;

    private String fdRelateName;

    private String fdRelateCode;

    private String fdRelateType;

    private String docCreateTime;

    private String docAlterTime;

    private String docCreatorId;

    private String docCreatorName;

    private String docAlterorId;

    private String docAlterorName;
    
    private String fdFirstChargerIds;

    private String fdFirstChargerNames;
    
    private String fdSecondChargerIds;

    private String fdSecondChargerNames;

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        fdTwoAccountName = null;
        fdTwoAccountCode = null;
        fdRelateName = null;
        fdRelateCode = null;
        fdRelateType = null;
        docCreateTime = null;
        docAlterTime = null;
        docCreatorId = null;
        docCreatorName = null;
        docAlterorId = null;
        docAlterorName = null;
        fdFirstChargerIds = null;
        fdFirstChargerNames = null;
        fdSecondChargerIds = null;
        fdSecondChargerNames = null;
        super.reset(mapping, request);
    }

    public Class<GeesunBaseBxsj> getModelClass() {
        return GeesunBaseBxsj.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.addNoConvertProperty("docCreateTime");
            toModelPropertyMap.addNoConvertProperty("docAlterTime");
            toModelPropertyMap.put("fdFirstChargerIds", new FormConvertor_IDsToModelList("fdFirstCharger", SysOrgPerson.class));
            toModelPropertyMap.put("fdSecondChargerIds", new FormConvertor_IDsToModelList("fdSecondCharger", SysOrgPerson.class));
        }
        return toModelPropertyMap;
    }

    /**
     * 第一负责人
     */
    public String getFdFirstChargerIds() {
        return this.fdFirstChargerIds;
    }

    /**
     * 第一负责人
     */
    public void setFdFirstChargerIds(String fdFirstChargerIds) {
        this.fdFirstChargerIds = fdFirstChargerIds;
    }

    /**
     * 第一负责人
     */
    public String getFdFirstChargerNames() {
        return this.fdFirstChargerNames;
    }

    /**
     * 第一负责人
     */
    public void setFdFirstChargerNames(String fdFirstChargerNames) {
        this.fdFirstChargerNames = fdFirstChargerNames;
    }
    
    /**
     * 第二负责人
     */
    public String getFdSecondChargerIds() {
        return this.fdSecondChargerIds;
    }

    /**
     * 第二负责人
     */
    public void setFdSecondChargerIds(String fdSecondChargerIds) {
        this.fdSecondChargerIds = fdSecondChargerIds;
    }

    /**
     * 第二负责人
     */
    public String getFdSecondChargerNames() {
        return this.fdSecondChargerNames;
    }

    /**
     * 第二负责人
     */
    public void setFdSecondChargerNames(String fdSecondChargerNames) {
        this.fdSecondChargerNames = fdSecondChargerNames;
    }
    
    /**
     * 报销科目名称
     */
    public String getFdTwoAccountName() {
        return this.fdTwoAccountName;
    }

    /**
     * 报销科目名称
     */
    public void setFdTwoAccountName(String fdTwoAccountName) {
        this.fdTwoAccountName = fdTwoAccountName;
    }

    /**
     * 报销科目编码
     */
    public String getFdTwoAccountCode() {
        return this.fdTwoAccountCode;
    }

    /**
     * 报销科目编码
     */
    public void setFdTwoAccountCode(String fdTwoAccountCode) {
        this.fdTwoAccountCode = fdTwoAccountCode;
    }

    /**
     * 勾稽字段名称
     */
    public String getFdRelateName() {
        return this.fdRelateName;
    }

    /**
     * 勾稽字段名称
     */
    public void setFdRelateName(String fdRelateName) {
        this.fdRelateName = fdRelateName;
    }

    /**
     * 勾稽关系编码
     */
    public String getFdRelateCode() {
        return this.fdRelateCode;
    }

    /**
     * 勾稽关系编码
     */
    public void setFdRelateCode(String fdRelateCode) {
        this.fdRelateCode = fdRelateCode;
    }

    /**
     * 勾稽类型
     */
    public String getFdRelateType() {
        return this.fdRelateType;
    }

    /**
     * 勾稽类型
     */
    public void setFdRelateType(String fdRelateType) {
        this.fdRelateType = fdRelateType;
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
     * 更新时间
     */
    public String getDocAlterTime() {
        return this.docAlterTime;
    }

    /**
     * 更新时间
     */
    public void setDocAlterTime(String docAlterTime) {
        this.docAlterTime = docAlterTime;
    }

    /**
     * 创建人
     */
    public String getDocCreatorId() {
        return this.docCreatorId;
    }

    /**
     * 创建人
     */
    public void setDocCreatorId(String docCreatorId) {
        this.docCreatorId = docCreatorId;
    }

    /**
     * 创建人
     */
    public String getDocCreatorName() {
        return this.docCreatorName;
    }

    /**
     * 创建人
     */
    public void setDocCreatorName(String docCreatorName) {
        this.docCreatorName = docCreatorName;
    }

    /**
     * 修改人
     */
    public String getDocAlterorId() {
        return this.docAlterorId;
    }

    /**
     * 修改人
     */
    public void setDocAlterorId(String docAlterorId) {
        this.docAlterorId = docAlterorId;
    }

    /**
     * 修改人
     */
    public String getDocAlterorName() {
        return this.docAlterorName;
    }

    /**
     * 修改人
     */
    public void setDocAlterorName(String docAlterorName) {
        this.docAlterorName = docAlterorName;
    }

}
