package com.landray.kmss.geesun.annual.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.annual.forms.GeesunAnnualMainForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.quartz.interfaces.ISysQuartzModel;
import com.landray.kmss.sys.readlog.interfaces.ISysReadLogAutoSaveModel;
import com.landray.kmss.util.DateUtil;

/**
  * 年假记录表
  */
public class GeesunAnnualMain extends BaseModel implements ISysQuartzModel, ISysReadLogAutoSaveModel {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static ModelToFormPropertyMap toFormPropertyMap;

    private Date docCreateTime;

    private String fdOwnerNo;

    private Double fdTotal;

    private Double fdRemain;

    private Double fdFrozen;

    private Double fdUsed;

    private Long docReadCount;

    private Double fdLastTotal;

    private Double fdLastRemain;

    private Double fdLastFrozen;

    private Double fdLastUsed;

    private Date fdLastResetDate;
    
    private Date fdNextResetDate;

    private SysOrgPerson docCreator;

    private SysOrgPerson fdOwner;

    private SysOrgElement docDept;

    public Class<GeesunAnnualMainForm> getFormClass() {
        return GeesunAnnualMainForm.class;
    }

    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("docCreateTime", new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("fdNextResetDate", new ModelConvertor_Common("fdNextResetDate").setDateTimeType(DateUtil.TYPE_DATE));
            toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
            toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
            toFormPropertyMap.put("fdOwner.fdName", "fdOwnerName");
            toFormPropertyMap.put("fdOwner.fdId", "fdOwnerId");
            toFormPropertyMap.put("docDept.fdName", "docDeptName");
            toFormPropertyMap.put("docDept.fdId", "docDeptId");
        }
        return toFormPropertyMap;
    }

    public void recalculateFields() {
        super.recalculateFields();
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
     * 工号
     */
    public String getFdOwnerNo() {
        return this.fdOwnerNo;
    }

    /**
     * 工号
     */
    public void setFdOwnerNo(String fdOwnerNo) {
        this.fdOwnerNo = fdOwnerNo;
    }

    /**
     * 年假总额度
     */
    public Double getFdTotal() {
        return this.fdTotal;
    }

    /**
     * 年假总额度
     */
    public void setFdTotal(Double fdTotal) {
        this.fdTotal = fdTotal;
    }

    /**
     * 年假剩余额度
     */
    public Double getFdRemain() {
        return this.fdRemain;
    }

    /**
     * 年假剩余额度
     */
    public void setFdRemain(Double fdRemain) {
        this.fdRemain = fdRemain;
    }

    /**
     * 年假冻结额度
     */
    public Double getFdFrozen() {
        return this.fdFrozen;
    }

    /**
     * 年假冻结额度
     */
    public void setFdFrozen(Double fdFrozen) {
        this.fdFrozen = fdFrozen;
    }

    /**
     * 年假已用额度
     */
    public Double getFdUsed() {
        return this.fdUsed;
    }

    /**
     * 年假已用额度
     */
    public void setFdUsed(Double fdUsed) {
        this.fdUsed = fdUsed;
    }

    /**
     * 阅读次数
     */
    public Long getDocReadCount() {
        return this.docReadCount;
    }

    /**
     * 阅读次数
     */
    public void setDocReadCount(Long docReadCount) {
        this.docReadCount = docReadCount;
    }

    /**
     * 上一年度总额度
     */
    public Double getFdLastTotal() {
        return this.fdLastTotal;
    }

    /**
     * 上一年度总额度
     */
    public void setFdLastTotal(Double fdLastTotal) {
        this.fdLastTotal = fdLastTotal;
    }

    /**
     * 上一年度剩余额度
     */
    public Double getFdLastRemain() {
        return this.fdLastRemain;
    }

    /**
     * 上一年度剩余额度
     */
    public void setFdLastRemain(Double fdLastRemain) {
        this.fdLastRemain = fdLastRemain;
    }

    /**
     * 上一年度冻结额度
     */
    public Double getFdLastFrozen() {
        return this.fdLastFrozen;
    }

    /**
     * 上一年度冻结额度
     */
    public void setFdLastFrozen(Double fdLastFrozen) {
        this.fdLastFrozen = fdLastFrozen;
    }

    /**
     * 上一年度已用额度
     */
    public Double getFdLastUsed() {
        return this.fdLastUsed;
    }

    /**
     * 上一年度已用额度
     */
    public void setFdLastUsed(Double fdLastUsed) {
        this.fdLastUsed = fdLastUsed;
    }

    /**
     * 下一次年假额度重置时间
     */
    public Date getFdNextResetDate() {
        return this.fdNextResetDate;
    }

    /**
     * 下一次年假额度重置时间
     */
    public void setFdNextResetDate(Date fdNextResetDate) {
        this.fdNextResetDate = fdNextResetDate;
    }
    
    /**
     * 上一次年假额度重置时间
     */
    public Date getFdLastResetDate() {
        return this.fdLastResetDate;
    }

    /**
     * 上一次年假额度重置时间
     */
    public void setFdLastResetDate(Date fdLastResetDate) {
        this.fdLastResetDate = fdLastResetDate;
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
     * 归属人
     */
    public SysOrgPerson getFdOwner() {
        return this.fdOwner;
    }

    /**
     * 归属人
     */
    public void setFdOwner(SysOrgPerson fdOwner) {
        this.fdOwner = fdOwner;
    }

    /**
     * 所属部门
     */
    public SysOrgElement getDocDept() {
        return this.docDept;
    }

    /**
     * 所属部门
     */
    public void setDocDept(SysOrgElement docDept) {
        this.docDept = docDept;
    }

    public String getDocStatus() {
        return "30";
    }

    public void setDocStatus(String docStatus) {
    }
}
