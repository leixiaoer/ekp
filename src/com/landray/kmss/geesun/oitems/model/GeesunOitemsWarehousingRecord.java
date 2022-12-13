package com.landray.kmss.geesun.oitems.model;
import java.util.Date;

import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsWarehousingRecordForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;

/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 * 人库记录
 */
public class GeesunOitemsWarehousingRecord  extends BaseModel {


	/*
	 * 数量
	 */
	protected Integer fdNumber;
	
	/*
	 * 单价
	 */
	protected Double fdPrice;
	
	/*
	 * 入库总金额
	 */
	protected Double fdAccountPrice;
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
	 * 入库时间
	 */
	protected Date docCreateTime;
	
	
	
	/*
	 * 用品清单管理
	 */		
	protected GeesunOitemsListing	geesunOitemsListing = null;
	
	/*
	 * 系统组织架构3
	 */		
	protected SysOrgElement	docCreator = null;
	
	public GeesunOitemsWarehousingRecord() {
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
	 * @return 返回 入库总金额
	 */
	public Double getFdAccountPrice() {
		return fdAccountPrice;
	}
	
	/**
	 * @param fdAccountPrice 要设置的 入库总金额
	 */
	public void setFdAccountPrice(Double fdAccountPrice) {
		this.fdAccountPrice = fdAccountPrice;
	}
	
	
	
	public Date getDocCreateTime() {
		return docCreateTime;
	}


	public void setDocCreateTime(Date docCreateTime) {
		this.docCreateTime = docCreateTime;
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
		return GeesunOitemsWarehousingRecordForm.class;
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
