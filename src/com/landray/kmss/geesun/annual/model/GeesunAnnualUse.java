package com.landray.kmss.geesun.annual.model;

import java.util.Date;
import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.geesun.annual.forms.GeesunAnnualUseForm;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;

/**
  * 年假使用记录表
  */
public class GeesunAnnualUse extends BaseModel {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static ModelToFormPropertyMap toFormPropertyMap;

    private String docSubject;

    private Date docCreateTime;

    private String fdType;
    
    private String fdModelId;

    private String fdModelName;

    private Double fdUse;

    private Date fdBeginDate;

    private Date fdEndDate;

    private Date fdBeginTime;

    private Date fdEndTime;

    private SysOrgPerson docCreator;

    private GeesunAnnualMain fdAnnual;

    public Class<GeesunAnnualUseForm> getFormClass() {
        return GeesunAnnualUseForm.class;
    }

    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("docCreateTime", new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("fdBeginDate", new ModelConvertor_Common("fdBeginDate").setDateTimeType(DateUtil.TYPE_DATE));
            toFormPropertyMap.put("fdEndDate", new ModelConvertor_Common("fdEndDate").setDateTimeType(DateUtil.TYPE_DATE));
            toFormPropertyMap.put("fdBeginTime", new ModelConvertor_Common("fdBeginTime").setDateTimeType(DateUtil.TYPE_TIME));
            toFormPropertyMap.put("fdEndTime", new ModelConvertor_Common("fdEndTime").setDateTimeType(DateUtil.TYPE_TIME));
            toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
            toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
            toFormPropertyMap.put("fdAnnual.fdOwnerNo", "fdAnnualName");
            toFormPropertyMap.put("fdAnnual.fdId", "fdAnnualId");
        }
        return toFormPropertyMap;
    }

    public void recalculateFields() {
        super.recalculateFields();
    }

    /**
     * 标题
     */
    public String getDocSubject() {
        return this.docSubject;
    }

    /**
     * 标题
     */
    public void setDocSubject(String docSubject) {
        this.docSubject = docSubject;
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
     * 使用类型
     */
    public String getFdType() {
        return this.fdType;
    }

    /**
     * 使用类型
     */
    public void setFdType(String fdType) {
        this.fdType = fdType;
    }

    /**
     * 模型ID
     */
    public String getFdModelId() {
        return this.fdModelId;
    }

    /**
     * 模型ID
     */
    public void setFdModelId(String fdModelId) {
        this.fdModelId = fdModelId;
    }

    /**
     * 模型名称
     */
    public String getFdModelName() {
        return this.fdModelName;
    }

    /**
     * 模型名称
     */
    public void setFdModelName(String fdModelName) {
        this.fdModelName = fdModelName;
    }

    /**
     * 用时
     */
    public Double getFdUse() {
        return this.fdUse;
    }

    /**
     * 用时
     */
    public void setFdUse(Double fdUse) {
        this.fdUse = fdUse;
    }

    /**
     * 开始日期
     */
    public Date getFdBeginDate() {
        return this.fdBeginDate;
    }

    /**
     * 开始日期
     */
    public void setFdBeginDate(Date fdBeginDate) {
        this.fdBeginDate = fdBeginDate;
    }

    /**
     * 结束日期
     */
    public Date getFdEndDate() {
        return this.fdEndDate;
    }

    /**
     * 结束日期
     */
    public void setFdEndDate(Date fdEndDate) {
        this.fdEndDate = fdEndDate;
    }

    /**
     * 开始时间
     */
    public Date getFdBeginTime() {
        return this.fdBeginTime;
    }

    /**
     * 开始时间
     */
    public void setFdBeginTime(Date fdBeginTime) {
        this.fdBeginTime = fdBeginTime;
    }

    /**
     * 结束时间
     */
    public Date getFdEndTime() {
        return this.fdEndTime;
    }

    /**
     * 结束时间
     */
    public void setFdEndTime(Date fdEndTime) {
        this.fdEndTime = fdEndTime;
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
     * 对应年假记录
     */
    public GeesunAnnualMain getFdAnnual() {
        return this.fdAnnual;
    }

    /**
     * 对应年假记录
     */
    public void setFdAnnual(GeesunAnnualMain fdAnnual) {
        this.fdAnnual = fdAnnual;
    }

}
