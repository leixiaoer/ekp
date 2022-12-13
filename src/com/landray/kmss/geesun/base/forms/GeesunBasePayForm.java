package com.landray.kmss.geesun.base.forms;

import javax.servlet.http.HttpServletRequest;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.web.action.ActionMapping;
import com.landray.kmss.common.convertor.FormConvertor_Common;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.geesun.base.model.GeesunBasePay;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;

/**
  * 付款确认表
  */
public class GeesunBasePayForm extends ExtendForm {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static FormToModelPropertyMap toModelPropertyMap;

    private String docCreateTime;

    private String fdYwDate;

    private String fdPayDate;

    private String fdPeriod;

    private String fdPayBank1;

    private String fdPayBank2;

    private String fdPayBank3;

    private String fdAccountId;
    
    private String fdAccountCode;

    private String fdAccountName;

    private String fdDemo;

    private String fdPayMoney;

    private String fdRemark;

    private String docCreatorId;

    private String docCreatorName;

    private String fdReviewId;

    private String fdReviewName;
    
    private String fdOrderId;

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        docCreateTime = null;
        fdYwDate = null;
        fdPayDate = null;
        fdPeriod = null;
        fdPayBank1 = null;
        fdPayBank2 = null;
        fdPayBank3 = null;
        fdAccountId = null;
        fdAccountCode = null;
        fdAccountName = null;
        fdDemo = null;
        fdPayMoney = null;
        fdRemark = null;
        docCreatorId = null;
        docCreatorName = null;
        fdReviewId = null;
        fdReviewName = null;
        fdOrderId = null;
        super.reset(mapping, request);
    }

    public Class<GeesunBasePay> getModelClass() {
        return GeesunBasePay.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.addNoConvertProperty("docCreateTime");
            toModelPropertyMap.put("fdYwDate", new FormConvertor_Common("fdYwDate").setDateTimeType(DateUtil.TYPE_DATE));
            toModelPropertyMap.put("fdPayDate", new FormConvertor_Common("fdPayDate").setDateTimeType(DateUtil.TYPE_DATE));
            toModelPropertyMap.put("fdReviewId", new FormConvertor_IDToModel("fdReview", KmReviewMain.class));
        }
        return toModelPropertyMap;
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
     * 业务日期
     */
    public String getFdYwDate() {
        return this.fdYwDate;
    }

    /**
     * 业务日期
     */
    public void setFdYwDate(String fdYwDate) {
        this.fdYwDate = fdYwDate;
    }

    /**
     * 付款日期
     */
    public String getFdPayDate() {
        return this.fdPayDate;
    }

    /**
     * 付款日期
     */
    public void setFdPayDate(String fdPayDate) {
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
    public String getFdPayMoney() {
        return this.fdPayMoney;
    }

    /**
     * 付款金额
     */
    public void setFdPayMoney(String fdPayMoney) {
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
     * 关联申请单
     */
    public String getFdReviewId() {
        return this.fdReviewId;
    }

    /**
     * 关联申请单
     */
    public void setFdReviewId(String fdReviewId) {
        this.fdReviewId = fdReviewId;
    }

    /**
     * 关联申请单
     */
    public String getFdReviewName() {
        return this.fdReviewName;
    }

    /**
     * 关联申请单
     */
    public void setFdReviewName(String fdReviewName) {
        this.fdReviewName = fdReviewName;
    }

	public String getFdOrderId() {
		return fdOrderId;
	}

	public void setFdOrderId(String fdOrderId) {
		this.fdOrderId = fdOrderId;
	}
    

}
