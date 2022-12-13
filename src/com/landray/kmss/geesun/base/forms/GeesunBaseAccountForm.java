package com.landray.kmss.geesun.base.forms;

import javax.servlet.http.HttpServletRequest;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.web.action.ActionMapping;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.geesun.base.model.GeesunBaseAccount;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;

/**
  * 账号信息表
  */
public class GeesunBaseAccountForm extends ExtendForm {

    private static FormToModelPropertyMap toModelPropertyMap;

    private String fdBankName;

    private String fdAccount;

    private String docCreateTime;

    private String fdOwnerId;

    private String fdOwnerName;

    private String docCreatorId;

    private String docCreatorName;

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        fdBankName = null;
        fdAccount = null;
        docCreateTime = null;
        fdOwnerId = null;
        fdOwnerName = null;
        docCreatorId = null;
        docCreatorName = null;
        fdReviewId = null;
        super.reset(mapping, request);
    }

    public Class<GeesunBaseAccount> getModelClass() {
        return GeesunBaseAccount.class;
    }

    public FormToModelPropertyMap getToModelPropertyMap() {
        if (toModelPropertyMap == null) {
            toModelPropertyMap = new FormToModelPropertyMap();
            toModelPropertyMap.putAll(super.getToModelPropertyMap());
            toModelPropertyMap.addNoConvertProperty("docCreateTime");
            toModelPropertyMap.put("fdOwnerId", new FormConvertor_IDToModel("fdOwner", SysOrgPerson.class));
        }
        return toModelPropertyMap;
    }

    /**
     * 开户行
     */
    public String getFdBankName() {
        return this.fdBankName;
    }

    /**
     * 开户行
     */
    public void setFdBankName(String fdBankName) {
        this.fdBankName = fdBankName;
    }

    /**
     * 账号
     */
    public String getFdAccount() {
        return this.fdAccount;
    }

    /**
     * 账号
     */
    public void setFdAccount(String fdAccount) {
        this.fdAccount = fdAccount;
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
	 * review process的ID
	 */
	private String fdReviewId = null;
	
	/**
	 * @return review process的ID
	 */
	public String getFdReviewId() {
		return this.fdReviewId;
	}
	
	/**
	 * @param fdReviewId review process的ID
	 */
	public void setFdReviewId(String fdReviewId) {
		this.fdReviewId = fdReviewId;
	}

}
