package com.landray.kmss.geesun.oitems.model;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsWarehousingRecordJoinListForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;

/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 * 人库记录
 */
public class GeesunOitemsWarehousingRecordJoinList  extends BaseModel {


	/*
	 * 数量
	 */
	protected Integer fdNumber;
	/*
	 * 当前数量
	 */
	protected Integer fdCurNumber;
	
	public Integer getFdCurNumber() {
		return fdCurNumber;
	}


	public void setFdCurNumber(Integer fdCurNumber) {
		this.fdCurNumber = fdCurNumber;
	}

	/*
	 * 单价
	 */
	protected Double fdPrice;
	
	/*
	 * 品牌
	 */
	protected String fdBrand;
	
	public String getFdBrand() {
		return fdBrand;
	}


	public void setFdBrand(String fdBrand) {
		this.fdBrand = fdBrand;
	}
		
	/*
	 * 用品清单管理
	 */		
	protected GeesunOitemsListing	geesunOitemsListing = null;
	
	/*
	 * 系统组织架构3
	 */		
	protected SysOrgElement	docCreator = null;
	
	public GeesunOitemsWarehousingRecordJoinList() {
		super();
	}
	
	
	/**
	 * @return 返回 数量
	 */
	public Integer getFdNumber() {
		return fdNumber;
	}
	
	/**
	 * @param fdNumber 要设置的 数量
	 */
	public void setFdNumber(Integer fdNumber) {
		this.fdNumber = fdNumber;
	}
	
	/**
	 * @return 返回 单价
	 */
	public Double getFdPrice() {
		return fdPrice;
	}
	
	/**
	 * @param fdPrice 要设置的 单价
	 */
	public void setFdPrice(Double fdPrice) {
		this.fdPrice = fdPrice;
	}
	
	/**
	 * @return 返回 用品清单管理
	 */	
	public GeesunOitemsListing getGeesunOitemsListing() {
		return geesunOitemsListing;
	}
	/**
	 * @param geesunOitemsListing 要设置的 用品清单管理
	 */
	public void setGeesunOitemsListing(GeesunOitemsListing geesunOitemsListing) {
		this.geesunOitemsListing = geesunOitemsListing;
	}
	/**
	 * @return 返回 系统组织架构3
	 */	

	public Class getFormClass() {
		return GeesunOitemsWarehousingRecordJoinListForm.class;
	}


	public SysOrgElement getDocCreator() {
		return docCreator;
	}


	public void setDocCreator(SysOrgElement docCreator) {
		this.docCreator = docCreator;
	}
	
	private static ModelToFormPropertyMap toFormPropertyMap = null;

	public  ModelToFormPropertyMap getToFormPropertyMap() {
		if(toFormPropertyMap == null){
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("geesunOitemsListing.fdId", "fdListingId");
			toFormPropertyMap.put("geesunOitemsListing.fdName", "fdListingName");
			toFormPropertyMap.put("geesunOitemsListing.fdNo", "fdListingNo");
		}
		return toFormPropertyMap;
	}
	
	
}
