
package com.landray.kmss.geesun.oitems.forms;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;
import com.landray.kmss.web.upload.FormFile;

import com.landray.kmss.common.convertor.FormConvertor_FormListToModelList;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.geesun.oitems.converter.FormConverter_String2Double;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsManage;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.right.interfaces.ExtendAuthForm;
import com.landray.kmss.util.AutoArrayList;
import com.landray.kmss.util.AutoHashMap;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 */
public class GeesunOitemsListingForm extends ExtendAuthForm implements
		IAttachmentForm {
	/*
	 * 编号
	 */
    private String fdNo = null;
	/*
	 * 物品名称
	 */
    private String fdName = null;
    /*
	 * 是否有效
	 */
	private String fdIsAbandon = "true";
	public String getFdIsAbandon() {
		return fdIsAbandon;
	}

	public void setFdIsAbandon(String fdIsAbandon) {
		this.fdIsAbandon = fdIsAbandon;
	}
	/*
	 * 所属类别Id
	 */
    private String fdCategoryId = null;
    /*
	 * 所属类别Id
	 */
    private String fdCategoryName = null;
	/*
	 * 规格
	 */
    private String fdSpecification = null;
	/*
	 * 品牌
	 */
    private String fdBrand = null;
	/*
	 * 单价
	 */
    private String fdReferencePrice = null;
	/*
	 * 单位
	 */
    private String fdUnit = null;
	/*
	 * 备注
	 */
    private String fdRemark = null;
	/*
	 * 库存量
	 */
    private String fdAmount = null;
	/*
	 * 创建者Id
	 */
    private String docCreatorId = null;
    /*
	 * 创建者Name
	 */
    private String docCreatorName = null;
	/*
	 * 创建时间
	 */
    private String docCreateTime = null;
    
	/* 文件 */
	protected FormFile file = null;
	
    /*
	 * 商品清单
	 */
	protected List geesunOitemsWarehousingRecordList = new AutoArrayList(
			GeesunOitemsWarehousingRecordForm.class);
	protected List geesunOitemsWarehousingRecordJoinListList = new AutoArrayList(
			GeesunOitemsWarehousingRecordJoinListForm.class);



	public List getGeesunOitemsWarehousingRecordJoinListList() {
		return geesunOitemsWarehousingRecordJoinListList;
	}

	public void setGeesunOitemsWarehousingRecordJoinListList(
			List geesunOitemsWarehousingRecordJoinListList) {
		this.geesunOitemsWarehousingRecordJoinListList = geesunOitemsWarehousingRecordJoinListList;
	}

	public FormFile getFile() {
		return file;
	}

	public void setFile(FormFile file) {
		this.file = file;
	}

	/**
	 * @return 返回 编号
	 */
	public String getFdNo() {
		return fdNo;
	}
	
	/**
	 * @param fdNo 要设置的 编号
	 */
	public void setFdNo(String fdNo) {
		this.fdNo = fdNo;
	}
	/**
	 * @return 返回 物品名称
	 */
	public String getFdName() {
		return fdName;
	}
	
	/**
	 * @param fdName 要设置的 物品名称
	 */
	public void setFdName(String fdName) {
		this.fdName = fdName;
	}
	/**
	 * @return 返回 所属类别
	 */
	public String getFdCategoryId() {
		return fdCategoryId;
	}
	
	/**
	 * @param fdCategoryId 要设置的 所属类别
	 */
	public void setFdCategoryId(String fdCategoryId) {
		this.fdCategoryId = fdCategoryId;
	}
	/**
	 * @return 返回 规格
	 */
	public String getFdSpecification() {
		return fdSpecification;
	}
	
	/**
	 * @param fdSpecification 要设置的 规格
	 */
	public void setFdSpecification(String fdSpecification) {
		this.fdSpecification = fdSpecification;
	}
	/**
	 * @return 返回 品牌
	 */
	public String getFdBrand() {
		return fdBrand;
	}
	
	/**
	 * @param fdBrand 要设置的 品牌
	 */
	public void setFdBrand(String fdBrand) {
		this.fdBrand = fdBrand;
	}
	/**
	 * @return 返回 单价
	 */
	public String getFdReferencePrice() {
		return fdReferencePrice;
	}
	
	/**
	 * @param fdReferencePrice 要设置的 单价
	 */
	public void setFdReferencePrice(String fdReferencePrice) {
		this.fdReferencePrice = fdReferencePrice;
	}
	/**
	 * @return 返回 单位
	 */
	public String getFdUnit() {
		return fdUnit;
	}
	
	/**
	 * @param fdUnit 要设置的 单位
	 */
	public void setFdUnit(String fdUnit) {
		this.fdUnit = fdUnit;
	}
	/**
	 * @return 返回 备注
	 */
	public String getFdRemark() {
		return fdRemark;
	}
	
	/**
	 * @param fdRemark 要设置的 备注
	 */
	public void setFdRemark(String fdRemark) {
		this.fdRemark = fdRemark;
	}
	/**
	 * @return 返回 库存量
	 */
	public String getFdAmount() {
		return fdAmount;
	}
	
	/**
	 * @param fdAmount 要设置的 库存量
	 */
	public void setFdAmount(String fdAmount) {
		this.fdAmount = fdAmount;
	}
	/**
	 * @return 返回 创建者
	 */
	public String getDocCreatorId() {
		return docCreatorId;
	}
	
	/**
	 * @param docCreatorId 要设置的 创建者
	 */
	public void setDocCreatorId(String docCreatorId) {
		this.docCreatorId = docCreatorId;
	}
	/**
	 * @return 返回 创建时间
	 */
	public String getDocCreateTime() {
		return docCreateTime;
	}
	
	/**
	 * @param docCreateTime 要设置的 创建时间
	 */
	public void setDocCreateTime(String docCreateTime) {
		this.docCreateTime = docCreateTime;
	}
    
	/*
	 *  （非 Javadoc）
	 * @see com.landray.kmss.web.action.ActionForm#reset(com.landray.kmss.web.action.ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
    public void reset(ActionMapping mapping, HttpServletRequest request) {
	    fdNo = null;
	    fdName = null;
	    docCreatorId = null;
	    docCreatorName = null;
	    fdIsAbandon = "true";
	    fdCategoryId = null;
	    fdSpecification = null;
	    fdBrand = null;
	    fdReferencePrice = null;
	    fdUnit = null;
	    fdRemark = null;
	    fdAmount = null;
	    docCreateTime = null;
	    fdCategoryName = null;
	    geesunOitemsWarehousingRecordList.clear();
	    geesunOitemsWarehousingRecordJoinListList.clear();
	    autoHashMap.clear();
			super.reset(mapping, request);
    }

	public Class getModelClass() {
		return GeesunOitemsListing.class;
	}

	public String getFdCategoryName() {
		return fdCategoryName;
	}

	public void setFdCategoryName(String fdCategoryName) {
		this.fdCategoryName = fdCategoryName;
	}

	public String getDocCreatorName() {
		return docCreatorName;
	}

	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}
	
	private static FormToModelPropertyMap toModelPropertyMap = null;

	public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
			toModelPropertyMap.put("fdReferencePrice", new FormConverter_String2Double("fdReferencePrice"));
			toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel(
					"docCreator", SysOrgPerson.class));
			toModelPropertyMap.put("fdCategoryId",
					new FormConvertor_IDToModel("fdCategory",
							GeesunOitemsManage.class));
			toModelPropertyMap.put("geesunOitemsWarehousingRecordList",
					new FormConvertor_FormListToModelList("geesunOitemsWarehousingRecordList",
							"geesunOitemsListing"));
			toModelPropertyMap.put("geesunOitemsWarehousingRecordJoinListList",
					new FormConvertor_FormListToModelList("geesunOitemsWarehousingRecordJoinListList",
							"geesunOitemsListing"));
		}
		return toModelPropertyMap;
	}
	
	/**
     * 附件实现
     */
	AutoHashMap autoHashMap = new AutoHashMap(AttachmentDetailsForm.class);
	public AutoHashMap getAttachmentForms() {
		return autoHashMap;
	}

	public List getGeesunOitemsWarehousingRecordList() {
		return geesunOitemsWarehousingRecordList;
	}

	public void setGeesunOitemsWarehousingRecordList(
			List geesunOitemsWarehousingRecordList) {
		this.geesunOitemsWarehousingRecordList = geesunOitemsWarehousingRecordList;
	}

}
