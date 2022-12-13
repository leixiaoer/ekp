package com.landray.kmss.geesun.base.model;

import java.util.Date;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.geesun.base.forms.GeesunBasePayForm;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.sys.attachment.model.IAttachment;

/**
  * 付款确认表
  */
public class GeesunBasePay extends BaseModel {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static ModelToFormPropertyMap toFormPropertyMap;

    private Date docCreateTime;

    private Date fdYwDate;

    private Date fdPayDate;

    private String fdPeriod;

    private String fdPayBank1;

    private String fdPayBank2;

    private String fdPayBank3;

    private String fdAccountId;
    
    private String fdAccountCode;

    private String fdAccountName;

    private String fdDemo;

    private Double fdPayMoney;
    
    private Integer fdOrderId;

    private String fdRemark;

    private SysOrgPerson docCreator;

    private KmReviewMain fdReview;

    public Class<GeesunBasePayForm> getFormClass() {
        return GeesunBasePayForm.class;
    }

    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("docCreateTime", new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("fdYwDate", new ModelConvertor_Common("fdYwDate").setDateTimeType(DateUtil.TYPE_DATE));
            toFormPropertyMap.put("fdPayDate", new ModelConvertor_Common("fdPayDate").setDateTimeType(DateUtil.TYPE_DATE));
            toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
            toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
            toFormPropertyMap.put("fdReview.docSubject", "fdReviewName");
            toFormPropertyMap.put("fdReview.fdId", "fdReviewId");
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
     * 业务日期
     */
    public Date getFdYwDate() {
        return this.fdYwDate;
    }

    /**
     * 业务日期
     */
    public void setFdYwDate(Date fdYwDate) {
        this.fdYwDate = fdYwDate;
    }

    /**
     * 付款日期
     */
    public Date getFdPayDate() {
        return this.fdPayDate;
    }

    /**
     * 付款日期
     */
    public void setFdPayDate(Date fdPayDate) {
        this.fdPayDate = fdPayDate;
    }

    /**
     * 期间
     */
    public String getFdPeriod() {
        return this.fdPeriod;
    }

    /**
     * 期间
     */
    public void setFdPeriod(String fdPeriod) {
        this.fdPeriod = fdPeriod;
    }

    /**
     * 付款银行
     */
    public String getFdPayBank1() {
        return this.fdPayBank1;
    }

    /**
     * 付款银行
     */
    public void setFdPayBank1(String fdPayBank1) {
        this.fdPayBank1 = fdPayBank1;
    }

    /**
     * 付款银行科目
     */
    public String getFdPayBank2() {
        return this.fdPayBank2;
    }

    /**
     * 付款银行科目
     */
    public void setFdPayBank2(String fdPayBank2) {
        this.fdPayBank2 = fdPayBank2;
    }

    /**
     * 付款银行名称
     */
    public String getFdPayBank3() {
        return this.fdPayBank3;
    }

    /**
     * 付款银行名称
     */
    public void setFdPayBank3(String fdPayBank3) {
        this.fdPayBank3 = fdPayBank3;
    }
    
    /**
     * 科目ID
     */
    public String getFdAccountId() {
        return this.fdAccountId;
    }

    /**
     * 科目ID
     */
    public void setFdAccountId(String fdAccountId) {
        this.fdAccountId = fdAccountId;
    }

    /**
     * 科目代码
     */
    public String getFdAccountCode() {
        return this.fdAccountCode;
    }

    /**
     * 科目代码
     */
    public void setFdAccountCode(String fdAccountCode) {
        this.fdAccountCode = fdAccountCode;
    }

    /**
     * 科目名称
     */
    public String getFdAccountName() {
        return this.fdAccountName;
    }

    /**
     * 科目名称
     */
    public void setFdAccountName(String fdAccountName) {
        this.fdAccountName = fdAccountName;
    }

    /**
     * 摘要
     */
    public String getFdDemo() {
        return this.fdDemo;
    }

    /**
     * 摘要
     */
    public void setFdDemo(String fdDemo) {
        this.fdDemo = fdDemo;
    }

    /**
     * 付款金额
     */
    public Double getFdPayMoney() {
        return this.fdPayMoney;
    }

    /**
     * 付款金额
     */
    public void setFdPayMoney(Double fdPayMoney) {
        this.fdPayMoney = fdPayMoney;
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
     * 关联申请单
     */
    public KmReviewMain getFdReview() {
        return this.fdReview;
    }

    /**
     * 关联申请单
     */
    public void setFdReview(KmReviewMain fdReview) {
        this.fdReview = fdReview;
    }

	public Integer getFdOrderId() {
		return fdOrderId;
	}

	public void setFdOrderId(Integer fdOrderId) {
		this.fdOrderId = fdOrderId;
	}

    
}
