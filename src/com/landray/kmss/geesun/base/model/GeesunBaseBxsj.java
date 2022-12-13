package com.landray.kmss.geesun.base.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.convertor.ModelConvertor_ModelListToString;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.base.forms.GeesunBaseBxsjForm;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.DateUtil;

/**
  * 报销科目勾稽关系表
  */
public class GeesunBaseBxsj extends BaseModel {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static ModelToFormPropertyMap toFormPropertyMap;

    private String fdTwoAccountName;

    private String fdTwoAccountCode;

    private String fdRelateName;

    private String fdRelateCode;

    private String fdRelateType;

    private Date docCreateTime;

    private Date docAlterTime;

    private SysOrgPerson docCreator;

    private SysOrgPerson docAlteror;
    
    private List<SysOrgPerson> fdFirstCharger = new ArrayList<SysOrgPerson>();
    
    private List<SysOrgPerson> fdSecondCharger = new ArrayList<SysOrgPerson>();

    public Class<GeesunBaseBxsjForm> getFormClass() {
        return GeesunBaseBxsjForm.class;
    }

    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("fdFirstCharger", new ModelConvertor_ModelListToString("fdFirstChargerIds:fdFirstChargerNames", "fdId:fdName"));
            toFormPropertyMap.put("fdSecondCharger", new ModelConvertor_ModelListToString("fdSecondChargerIds:fdSecondChargerNames", "fdId:fdName"));
            toFormPropertyMap.put("docCreateTime", new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("docAlterTime", new ModelConvertor_Common("docAlterTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
            toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
            toFormPropertyMap.put("docAlteror.fdName", "docAlterorName");
            toFormPropertyMap.put("docAlteror.fdId", "docAlterorId");
        }
        return toFormPropertyMap;
    }

    public void recalculateFields() {
        super.recalculateFields();
    }
    
    /**
     * 第一负责人
     */
    public List<SysOrgPerson> getFdFirstCharger() {
        return this.fdFirstCharger;
    }

    /**
     * 第一负责人
     */
    public void setFdFirstCharger(List<SysOrgPerson> fdFirstCharger) {
        this.fdFirstCharger = fdFirstCharger;
    }
    
    /**
     * 第二负责人
     */
    public List<SysOrgPerson> getFdSecondCharger() {
        return this.fdSecondCharger;
    }

    /**
     * 第二负责人
     */
    public void setFdSecondCharger(List<SysOrgPerson> fdSecondCharger) {
        this.fdSecondCharger = fdSecondCharger;
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
     * 更新时间
     */
    public Date getDocAlterTime() {
        return this.docAlterTime;
    }

    /**
     * 更新时间
     */
    public void setDocAlterTime(Date docAlterTime) {
        this.docAlterTime = docAlterTime;
    }

    /**
     * 创建人
     */
    public SysOrgPerson getDocCreator() {
        return this.docCreator;
    }

    /**
     * 创建人
     */
    public void setDocCreator(SysOrgPerson docCreator) {
        this.docCreator = docCreator;
    }

    /**
     * 修改人
     */
    public SysOrgPerson getDocAlteror() {
        return this.docAlteror;
    }

    /**
     * 修改人
     */
    public void setDocAlteror(SysOrgPerson docAlteror) {
        this.docAlteror = docAlteror;
    }

}
