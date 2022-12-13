package com.landray.kmss.geesun.oitems.model;

/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 * 用品清单管理
 */
public class GeesunOitemsReceiveContext {



	/*
	 * 库存量
	 */
	protected Integer fdAmount;
	
	/*
	 * 领取量
	 */
	protected Integer fdReceiveAmount;
	

	/*
	 * 用品类别管理
	 */		
	protected GeesunOitemsListing	geesunOitemsListing  = null;
	protected GeesunOitemsWarehousingRecordJoinList	geesunOitemsWarehousingRecordJoinList  = null;
	

	public GeesunOitemsWarehousingRecordJoinList getGeesunOitemsWarehousingRecordJoinList() {
		return geesunOitemsWarehousingRecordJoinList;
	}


	public void setGeesunOitemsWarehousingRecordJoinList(
			GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList) {
		this.geesunOitemsWarehousingRecordJoinList = geesunOitemsWarehousingRecordJoinList;
	}


	public GeesunOitemsReceiveContext() {
		super();
	}


	public Integer getFdAmount() {
		return fdAmount;
	}


	public void setFdAmount(Integer fdAmount) {
		this.fdAmount = fdAmount;
	}


	public Integer getFdReceiveAmount() {
		return fdReceiveAmount;
	}


	public void setFdReceiveAmount(Integer fdReceiveAmount) {
		this.fdReceiveAmount = fdReceiveAmount;
	}


	public GeesunOitemsListing getGeesunOitemsListing() {
		return geesunOitemsListing;
	}


	public void setGeesunOitemsListing(GeesunOitemsListing geesunOitemsListing) {
		this.geesunOitemsListing = geesunOitemsListing;
	}
	
}
