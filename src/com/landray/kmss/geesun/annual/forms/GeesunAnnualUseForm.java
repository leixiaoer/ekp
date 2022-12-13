package com.landray.kmss.geesun.annual.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_Common;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.geesun.annual.model.GeesunAnnualUse;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.web.action.ActionMapping;

/**
  * 年假使用记录表
  */
public class GeesunAnnualUseForm extends ExtendForm {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static FormToModelPropertyMap toModelPropertyMap;

    private String docSubject;

    private String docCreateTime;
    
    private String fdType;

    private String fdModelId;

    private String fdModelName;

    private String fdUse;

    private String fdBeginDate;

    private String fdEndDate;

    private String fdBeginTime;

    private String fdEndTime;

    private String docCreatorId;

    private String docCreatorName;

    private String fdAnnualId;

    private String fdAnnualName;

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        docSubject = null;
        docCreateTime = null;
        fdType = null;
        fdModelId = null;
        fdModelName = null;
        fdUse = null;
        fdBeginDate = null;
        fdEndDate = null;
        fdBeginTime = null;
        fdEndTime = null;
        docCreatorId = null;
        docCreatorName = null;
        fdAnnualId = null;
        fdAnnualName = null;
        super.reset(mapping, request);
    }

    public Class<GeesunAnnualUse> getModelClass() {
        return GeesunAnnualUse.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.addNoConvertProperty("docCreateTime");
            toModelPropertyMap.put("fdBeginDate", new FormConvertor_Common("fdBeginDate").setDateTimeType(DateUtil.TYPE_DATE));
            toModelPropertyMap.put("fdEndDate", new FormConvertor_Common("fdEndDate").setDateTimeType(DateUtil.TYPE_DATE));
            toModelPropertyMap.put("fdBeginTime", new FormConvertor_Common("fdBeginTime").setDateTimeType(DateUtil.TYPE_TIME));
            toModelPropertyMap.put("fdEndTime", new FormConvertor_Common("fdEndTime").setDateTimeType(DateUtil.TYPE_TIME));
            toModelPropertyMap.put("fdAnnualId", new FormConvertor_IDToModel("fdAnnual", GeesunAnnualMain.class));
        }
        return toModelPropertyMap;
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
    public String getFdUse() {
        return this.fdUse;
    }

    /**
     * 用时
     */
    public void setFdUse(String fdUse) {
        this.fdUse = fdUse;
    }

    /**
     * 开始日期
     */
    public String getFdBeginDate() {
        return this.fdBeginDate;
    }

    /**
     * 开始日期
     */
    public void setFdBeginDate(String fdBeginDate) {
        this.fdBeginDate = fdBeginDate;
    }

    /**
     * 结束日期
     */
    public String getFdEndDate() {
        return this.fdEndDate;
    }

    /**
     * 结束日期
     */
    public void setFdEndDate(String fdEndDate) {
        this.fdEndDate = fdEndDate;
    }

    /**
     * 开始时间
     */
    public String getFdBeginTime() {
        return this.fdBeginTime;
    }

    /**
     * 开始时间
     */
    public void setFdBeginTime(String fdBeginTime) {
        this.fdBeginTime = fdBeginTime;
    }

    /**
     * 结束时间
     */
    public String getFdEndTime() {
        return this.fdEndTime;
    }

    /**
     * 结束时间
     */
    public void setFdEndTime(String fdEndTime) {
        this.fdEndTime = fdEndTime;
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
     * 对应年假记录
     */
    public String getFdAnnualId() {
        return this.fdAnnualId;
    }

    /**
     * 对应年假记录
     */
    public void setFdAnnualId(String fdAnnualId) {
        this.fdAnnualId = fdAnnualId;
    }

    /**
     * 对应年假记录
     */
    public String getFdAnnualName() {
        return this.fdAnnualName;
    }

    /**
     * 对应年假记录
     */
    public void setFdAnnualName(String fdAnnualName) {
        this.fdAnnualName = fdAnnualName;
    }

}
