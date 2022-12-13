package com.landray.kmss.geesun.annual.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.annual.forms.GeesunAnnualResetForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.DateUtil;

/**
  * 年假重置执行日志
  */
public class GeesunAnnualReset extends BaseModel {

    private static ModelToFormPropertyMap toFormPropertyMap;

    private String fdHasExecute;

    private Date fdExecuteTime;

    private SysOrgElement fdOwner;

    private GeesunAnnualMain fdAnnual;

    public Class<GeesunAnnualResetForm> getFormClass() {
        return GeesunAnnualResetForm.class;
    }

    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("fdExecuteTime", new ModelConvertor_Common("fdExecuteTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("fdOwner.fdName", "fdOwnerName");
            toFormPropertyMap.put("fdOwner.fdId", "fdOwnerId");
            toFormPropertyMap.put("fdAnnual.fdId", "fdAnnualId");
        }
        return toFormPropertyMap;
    }

    public void recalculateFields() {
        super.recalculateFields();
    }

    /**
     * 是否已执行
     */
    public String getFdHasExecute() {
        return this.fdHasExecute;
    }

    /**
     * 是否已执行
     */
    public void setFdHasExecute(String fdHasExecute) {
        this.fdHasExecute = fdHasExecute;
    }

    /**
     * 最新一次执行时间
     */
    public Date getFdExecuteTime() {
        return this.fdExecuteTime;
    }

    /**
     * 最新一次执行时间
     */
    public void setFdExecuteTime(Date fdExecuteTime) {
        this.fdExecuteTime = fdExecuteTime;
    }

    /**
     * 归属人
     */
    public SysOrgElement getFdOwner() {
        return this.fdOwner;
    }

    /**
     * 归属人
     */
    public void setFdOwner(SysOrgElement fdOwner) {
        this.fdOwner = fdOwner;
    }

    /**
     * 年假表
     */
    public GeesunAnnualMain getFdAnnual() {
        return this.fdAnnual;
    }

    /**
     * 年假表
     */
    public void setFdAnnual(GeesunAnnualMain fdAnnual) {
        this.fdAnnual = fdAnnual;
    }

}
