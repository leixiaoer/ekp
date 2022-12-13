package com.landray.kmss.geesun.annual.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_Common;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.geesun.annual.model.GeesunAnnualReset;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.web.action.ActionMapping;

/**
  * 年假重置执行日志
  */
public class GeesunAnnualResetForm extends ExtendForm {

    private static FormToModelPropertyMap toModelPropertyMap;

    private String fdHasExecute;

    private String fdExecuteTime;

    private String fdOwnerId;

    private String fdOwnerName;

    private String fdAnnualId;

    private String fdAnnualName;

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        fdHasExecute = null;
        fdExecuteTime = null;
        fdOwnerId = null;
        fdOwnerName = null;
        fdAnnualId = null;
        fdAnnualName = null;
        super.reset(mapping, request);
    }

    public Class<GeesunAnnualReset> getModelClass() {
        return GeesunAnnualReset.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.put("fdExecuteTime", new FormConvertor_Common("fdExecuteTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toModelPropertyMap.put("fdOwnerId", new FormConvertor_IDToModel("fdOwner", SysOrgElement.class));
            toModelPropertyMap.put("fdAnnualId", new FormConvertor_IDToModel("fdAnnual", GeesunAnnualMain.class));
        }
        return toModelPropertyMap;
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
    public String getFdExecuteTime() {
        return this.fdExecuteTime;
    }

    /**
     * 最新一次执行时间
     */
    public void setFdExecuteTime(String fdExecuteTime) {
        this.fdExecuteTime = fdExecuteTime;
    }

    /**
     * 归属人
     */
    public String getFdOwnerId() {
        return this.fdOwnerId;
    }

    /**
     * 归属人
     */
    public void setFdOwnerId(String fdOwnerId) {
        this.fdOwnerId = fdOwnerId;
    }

    /**
     * 归属人
     */
    public String getFdOwnerName() {
        return this.fdOwnerName;
    }

    /**
     * 归属人
     */
    public void setFdOwnerName(String fdOwnerName) {
        this.fdOwnerName = fdOwnerName;
    }

    /**
     * 年假表
     */
    public String getFdAnnualId() {
        return this.fdAnnualId;
    }

    /**
     * 年假表
     */
    public void setFdAnnualId(String fdAnnualId) {
        this.fdAnnualId = fdAnnualId;
    }

    /**
     * 年假表
     */
    public String getFdAnnualName() {
        return this.fdAnnualName;
    }

    /**
     * 年假表
     */
    public void setFdAnnualName(String fdAnnualName) {
        this.fdAnnualName = fdAnnualName;
    }

}
