
package com.landray.kmss.geesun.oitems.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.oitems.converter.FormConverter_String2Double;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecord;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 */
public class GeesunOitemsWarehousingRecordForm extends ExtendForm {
	/*
	 * 物品清单ID
	 */
    private String fdListingId = null;
    
    private String fdListingName = null;
    
    private String fdListingNo = null;
    
    private String fdAccountNumber = null;
	/*
	 * 数量
	 */
    private String fdNumber = null;
	/*
	 * 单价
	 */
    private String fdPrice = null;
	/*
	 * 入库总金额
	 */
    private String fdAccountPrice = null;
    /*
	 * 品牌
	 */
    private String fdBrand = null;
	/*
	 * 入库时间
	 */
    private String docCreateTime = null;
	/*
	 * 录入者
	 */
    private String docCreatorId = null;
    
    private String docCreatorName = null;

	/**
	 * @return 返回 物品清单ID
	 */
	public String getFdListingId() {
		return fdListingId;
	}
	
	/**
	 * @param fdListingId 要设置的 物品清单ID
	 */
	public void setFdListingId(String fdListingId) {
		this.fdListingId = fdListingId;
	}
	/**
	 * @return 返回 数量
	 */
	public String getFdNumber() {
		return fdNumber;
	}
	
	/**
	 * @param fdNumber 要设置的 数量
	 */
	public void setFdNumber(String fdNumber) {
		this.fdNumber = fdNumber;
	}
	/**
	 * @return 返回 单价
	 */
	public String getFdPrice() {
		return fdPrice;
	}
	
	/**
	 * @param fdPrice 要设置的 单价
	 */
	public void setFdPrice(String fdPrice) {
		this.fdPrice = fdPrice;
	}
	/**
	 * @return 返回 入库总金额
	 */
	public String getFdAccountPrice() {
		return fdAccountPrice;
	}
	
	/**
	 * @param fdAccountPrice 要设置的 入库总金额
	 */
	public void setFdAccountPrice(String fdAccountPrice) {
		this.fdAccountPrice = fdAccountPrice;
	}	
	public String getFdBrand() {
		return fdBrand;
	}

	public void setFdBrand(String fdBrand) {
		this.fdBrand = fdBrand;
	}
	/*
	 *  （非 Javadoc）
	 * @see com.landray.kmss.web.action.ActionForm#reset(com.landray.kmss.web.action.ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
    public void reset(ActionMapping mapping, HttpServletRequest request) {
	    fdListingId = null;
	    fdNumber = null;
	    fdPrice = null;
	    fdBrand=null;
	    fdAccountPrice = null;
	    docCreateTime = null;
	    docCreatorId = null;
			super.reset(mapping, request);
    }

	public Class getModelClass() {
		return GeesunOitemsWarehousingRecord.class;
	}

	public String getDocCreateTime() {
		return docCreateTime;
	}

	public void setDocCreateTime(String docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	public String getDocCreatorId() {
		return docCreatorId;
	}

	public void setDocCreatorId(String docCreatorId) {
		this.docCreatorId = docCreatorId;
	}

	public String getDocCreatorName() {
		return docCreatorName;
	}

	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}

	public String getFdListingName() {
		return this.fdListingName;
	}

	public void setFdListingName(String fdListingName) {
		this.fdListingName = fdListingName;
	}

	public String getFdListingNo() {
		return this.fdListingNo;
	}

	public void setFdListingNo(String fdListingNo) {
		this.fdListingNo = fdListingNo;
	}

	public String getFdAccountNumber() {
		return this.fdAccountNumber;
	}

	public void setFdAccountNumber(String fdAccountNumber) {
		this.fdAccountNumber = fdAccountNumber;
	}
	
	private static FormToModelPropertyMap  toModelPropertyMap  = null;

	public  FormToModelPropertyMap getToModelPropertyMap() {
		if(toModelPropertyMap == null){
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.put("fdPrice", new FormConverter_String2Double("fdPrice"));
			toModelPropertyMap.put("fdAccountPrice", new FormConverter_String2Double("fdAccountPrice"));
			toModelPropertyMap.put("fdListingId", new FormConvertor_IDToModel("geesunOitemsListing",GeesunOitemsListing.class));
		}
		return toModelPropertyMap;
	}
	
	

}
