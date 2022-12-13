package com.landray.kmss.geesun.base.model;

import java.util.Date;
import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.geesun.base.forms.GeesunBaseAccountForm;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;

/**
  * 账号信息表
  */
public class GeesunBaseAccount extends BaseModel {

    private static ModelToFormPropertyMap toFormPropertyMap;

    private String fdBankName;

    private String fdAccount;

    private Date docCreateTime;

    private SysOrgPerson fdOwner;

    private SysOrgPerson docCreator;

    public Class<GeesunBaseAccountForm> getFormClass() {
        return GeesunBaseAccountForm.class;
    }

    public ModelToFormPropertyMap getToFormPropertyMap() {
        if (toFormPropertyMap == null) {
            toFormPropertyMap = new ModelToFormPropertyMap();
            toFormPropertyMap.putAll(super.getToFormPropertyMap());
            toFormPropertyMap.put("docCreateTime", new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
            toFormPropertyMap.put("fdOwner.fdName", "fdOwnerName");
            toFormPropertyMap.put("fdOwner.fdId", "fdOwnerId");
            toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
            toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
        }
        return toFormPropertyMap;
    }

    public void recalculateFields() {
        super.recalculateFields();
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
