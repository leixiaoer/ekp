
package com.landray.kmss.geesun.oitems.forms;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsShoppingTrolley;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.web.action.ActionMapping;
import com.landray.kmss.web.upload.FormFile;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 */
public class GeesunOitemsShoppingTrolleyForm extends ExtendForm {
	/*
	 * 数量
	 */
    private String fdApplicationNumber = null;
    /*
	 * 申请单Id
	 */
    private String kmApplicationId = null;
    private String fdApplicationId = null;
	public String getFdApplicationId() {
		return fdApplicationId;
	}

	public void setFdApplicationId(String fdApplicationId) {
		this.fdApplicationId = fdApplicationId;
	}

	public String getKmApplicationId() {
		return kmApplicationId;
	}

	public void setKmApplicationId(String kmApplicationId) {
		this.kmApplicationId = kmApplicationId;
	}
	
	 private String kmWarehousingRecordJoinListId = null;
	public String getKmWarehousingRecordJoinListId() {
		return kmWarehousingRecordJoinListId;
	}

	public void setKmWarehousingRecordJoinListId(
			String kmWarehousingRecordJoinListId) {
		this.kmWarehousingRecordJoinListId = kmWarehousingRecordJoinListId;
	}

	/*
	 * 用品清单ID
	 */
    private String fdListingId = null;
    /*
	 * 用品编号
	 */
    private String fdNo = null;
    /*
	 * 用品名称
	 */
    private String fdName = null;
    /*
	 * 用品类别名称
	 */
    private String fdCategoryName = null;
    /*
	 * 用品规格
	 */
    private String fdSpecification = null;
    /*
	 * 用品品牌
	 */
    private String fdBrand = null;
    /*
	 * 用品单位
	 */
    private String fdUnit = null;
    /*
	 * 用品价格
	 */
    private String fdReferencePrice = null;
    
    private String fdAmount = null;

	private String fdCurNum = null;

	public String getFdCurNum() {
		return fdCurNum;
	}

	public void setFdCurNum(String fdCurNum) {
		this.fdCurNum = fdCurNum;
	}

	/*
	 * 申请者
	 */
	protected String fdApplicantsId = null;
	protected String fdApplicantsName = null;
	
	/*
	 * 申请时间
	 */
	protected Date fdApplicantsTime = null;
	/*
	 * 申请类型
	 */
	protected String fdType = null;
	
	public String getFdAmount() {
		return this.fdAmount;
	}

	public void setFdAmount(String fdAmount) {
		this.fdAmount = fdAmount;
	}
	/**
	 * @return 返回 数量
	 */
	public String getFdApplicationNumber() {
		return fdApplicationNumber;
	}
	
	/**
	 * @param fdApplicationNumber 要设置的 数量
	 */
	public void setFdApplicationNumber(String fdApplicationNumber) {
		this.fdApplicationNumber = fdApplicationNumber;
	}
	/**
	 * @return 返回 用品清单ID
	 */
	public String getFdListingId() {
		return fdListingId;
	}
	
	/**
	 * @param fdListingId 要设置的 用品清单ID
	 */
	public void setFdListingId(String fdListingId) {
		this.fdListingId = fdListingId;
	}
	/*
	 * 入库时间
	 */
	protected String docInTime;

	public String getDocInTime() {
		return docInTime;
	}

	public void setDocInTime(String docInTime) {
		this.docInTime = docInTime;
	}

	public Class getModelClass() {
		return GeesunOitemsShoppingTrolley.class;
	}

	public String getFdNo() {
		return fdNo;
	}

	public void setFdNo(String fdNo) {
		this.fdNo = fdNo;
	}

	public String getFdName() {
		return fdName;
	}

	public void setFdName(String fdName) {
		this.fdName = fdName;
	}

	public String getFdCategoryName() {
		return fdCategoryName;
	}

	public void setFdCategoryName(String fdCategoryName) {
		this.fdCategoryName = fdCategoryName;
	}

	public String getFdSpecification() {
		return fdSpecification;
	}

	public void setFdSpecification(String fdSpecification) {
		this.fdSpecification = fdSpecification;
	}

	public String getFdBrand() {
		return fdBrand;
	}

	public void setFdBrand(String fdBrand) {
		this.fdBrand = fdBrand;
	}

	public String getFdUnit() {
		return fdUnit;
	}

	public void setFdUnit(String fdUnit) {
		this.fdUnit = fdUnit;
	}

	public String getFdReferencePrice() {
		return fdReferencePrice;
	}

	public void setFdReferencePrice(String fdReferencePrice) {
		this.fdReferencePrice = fdReferencePrice;
	}

	
	/*
	 *  （非 Javadoc）
	 * @see com.landray.kmss.web.action.ActionForm#reset(com.landray.kmss.web.action.ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
    public void reset(ActionMapping mapping, HttpServletRequest request) {
	    fdApplicationNumber = null; 
	    kmApplicationId = null;
	    kmWarehousingRecordJoinListId = null;
	    fdListingId = null;
	    fdNo = null;
	    fdName = null;
	    fdCategoryName = null;
	    fdSpecification = null;
	    fdBrand = null;
	    fdUnit = null;
	    fdReferencePrice = null;
		super.reset(mapping, request);
    }

	
	private static FormToModelPropertyMap toModelPropertyMap;

	public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
			toModelPropertyMap.put("fdListingId",
					new FormConvertor_IDToModel("geesunOitemsListing",
							GeesunOitemsListing.class));
			toModelPropertyMap.put("kmApplicationId",
					new FormConvertor_IDToModel("geesunOitemsBudgerApplication",
							GeesunOitemsBudgerApplication.class));
			toModelPropertyMap.put("kmWarehousingRecordJoinListId",
					new FormConvertor_IDToModel("geesunOitemsWarehousingRecordJoinList",
							GeesunOitemsWarehousingRecordJoinList.class));
		}
		return toModelPropertyMap;
	}

	/* 文件 */
	protected FormFile fdUploadFile = null;

	protected String fdUploadType = null;

	public FormFile getFdUploadFile() {
		return fdUploadFile;
	}

	public void setFdUploadFile(FormFile fdUploadFile) {
		this.fdUploadFile = fdUploadFile;
	}

	public String getFdUploadType() {
		return fdUploadType;
	}

	public void setFdUploadType(String fdUploadType) {
		this.fdUploadType = fdUploadType;
	}
}
