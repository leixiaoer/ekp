package com.landray.kmss.geesun.oitems.model;

import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsShoppingTrolleyForm;
import com.landray.kmss.util.ObjectUtil;
import com.landray.kmss.util.StringUtil;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟 购物车
 */
public class GeesunOitemsShoppingTrolley extends BaseModel {

	/*
	 * 数量
	 */
	protected Integer fdApplicationNumber;

	/*
	 * 用品清单管理
	 */
	protected GeesunOitemsListing geesunOitemsListing = null;
	protected GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList=null;



	public GeesunOitemsWarehousingRecordJoinList getGeesunOitemsWarehousingRecordJoinList() {
		return geesunOitemsWarehousingRecordJoinList;
	}

	public void setGeesunOitemsWarehousingRecordJoinList(
			GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList) {
		this.geesunOitemsWarehousingRecordJoinList = geesunOitemsWarehousingRecordJoinList;
	}

	/*
	 * 预算申请编号
	 */
	protected String fdApplicationId;

	/*
	 * 编号
	 */
	protected String fdNo;

	public String getFdNo() {
		if (fdNo == null && getGeesunOitemsListing() != null)
			return getGeesunOitemsListing().getFdNo();
		else

			return fdNo;
	}

	public void setFdNo(String fdNo) {
		this.fdNo = fdNo;
	}

	/*
	 * 物品名称
	 */
	protected String fdName;

	public String getFdName() {
		if (fdName == null && getGeesunOitemsListing() != null)
			return getGeesunOitemsListing().getFdName();
		else

			return fdName;
	}

	public void setFdName(String fdName) {
		this.fdName = fdName;
	}

	/*
	 * 类别名称
	 */
	protected String fdCategoryName;

	public String getFdCategoryName() {
		if (fdCategoryName == null && getGeesunOitemsListing() != null)
			return getGeesunOitemsListing().getFdCategory().getFdName();
		else
			return fdCategoryName;
	}

	public void setFdCategoryName(String fdCategoryName) {
		this.fdCategoryName = fdCategoryName;
	}

	/*
	 * 规格
	 */
	protected String fdSpecification;

	public String getFdSpecification() {
		if (fdSpecification == null && getGeesunOitemsListing() != null)
			return StringUtil.isNotNull(getGeesunOitemsListing().getFdSpecification())?getGeesunOitemsListing().getFdSpecification():"";
		else
			return fdSpecification;
	}

	public void setFdSpecification(String fdSpecification) {
		this.fdSpecification = fdSpecification;
	}

	/*
	 * 品牌
	 */
	protected String fdBrand;

	public String getFdBrand() {
		if (fdBrand == null && getGeesunOitemsListing() != null)
			return StringUtil.isNotNull(getGeesunOitemsListing().getFdBrand())?getGeesunOitemsListing().getFdBrand():"";
		else
			return fdBrand;
	}

	public void setFdBrand(String fdBrand) {
		this.fdBrand = fdBrand;
	}

	/*
	 * 单位
	 */
	protected String fdUnit;

	public String getFdUnit() {
		if (fdUnit == null && getGeesunOitemsListing() != null)
			return StringUtil.isNotNull(getGeesunOitemsListing().getFdUnit())?getGeesunOitemsListing().getFdUnit():"";
		else
			return fdUnit;
	}

	public void setFdUnit(String fdUnit) {
		this.fdUnit = fdUnit;
	}

	/*
	 * 库存量
	 */
	protected Integer fdAmount;

	public Integer getFdAmount() {
		if (fdAmount == null && getGeesunOitemsListing() != null)
			return getGeesunOitemsListing().getFdAmount();
		else
			return fdAmount;
	}

	public void setFdAmount(Integer fdAmount) {
		this.fdAmount = fdAmount;
	}

	/*
	 * 单价
	 */
	protected Double fdReferencePrice;

	public Double getFdReferencePrice() {
		if (fdReferencePrice == null && getGeesunOitemsListing() != null)
			return getGeesunOitemsListing().getFdReferencePrice();
		else
			return fdReferencePrice;
	}

	public void setFdReferencePrice(Double fdReferencePrice) {
		this.fdReferencePrice = fdReferencePrice;
	}

	/*
	 * 部门预算申请
	 */
	protected GeesunOitemsBudgerApplication geesunOitemsBudgerApplication = null;

	public String getFdApplicationId() {
		return fdApplicationId;
	}

	public void setFdApplicationId(String fdApplicationId) {
		this.fdApplicationId = fdApplicationId;
	}

	public GeesunOitemsBudgerApplication getGeesunOitemsBudgerApplication() {
		return geesunOitemsBudgerApplication;
	}

	public void setGeesunOitemsBudgerApplication(
			GeesunOitemsBudgerApplication geesunOitemsBudgerApplication) {
		this.geesunOitemsBudgerApplication = geesunOitemsBudgerApplication;
	}

	public GeesunOitemsShoppingTrolley() {
		super();
	}

	protected static ModelToFormPropertyMap toFormPropertyMap;

	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("geesunOitemsListing.fdId", "fdListingId");
			toFormPropertyMap.put("geesunOitemsBudgerApplication.fdId", "kmApplicationId");
			toFormPropertyMap.put("geesunOitemsWarehousingRecordJoinList.fdId", "kmWarehousingRecordJoinListId");
			toFormPropertyMap.put("geesunOitemsWarehousingRecordJoinList.fdCurNumber", "fdCurNum");

		}
		return toFormPropertyMap;
	}

	/**
	 * @return 返回 数量
	 */
	public Integer getFdApplicationNumber() {
		return fdApplicationNumber;
	}

	/**
	 * @param fdApplicationNumber
	 *            要设置的 数量
	 */
	public void setFdApplicationNumber(Integer fdApplicationNumber) {
		this.fdApplicationNumber = fdApplicationNumber;
	}

	/**
	 * @return 返回 用品清单管理
	 */
	public GeesunOitemsListing getGeesunOitemsListing() {
		return geesunOitemsListing;
	}

	/**
	 * @param geesunOitemsListing
	 *            要设置的 用品清单管理
	 */
	public void setGeesunOitemsListing(GeesunOitemsListing geesunOitemsListing) {
		this.geesunOitemsListing = geesunOitemsListing;
	}

	public Class getFormClass() {
		return GeesunOitemsShoppingTrolleyForm.class;
	}

	@Override
	public boolean equals(Object object) {
		if (this == object)
			return true;
		if (object == null)
			return false;
		if (!(object instanceof GeesunOitemsShoppingTrolley))
			return false;
		GeesunOitemsShoppingTrolley trolley = (GeesunOitemsShoppingTrolley) object;
		if (StringUtil.isNotNull(trolley.getFdApplicationId())) {
			return ObjectUtil.equals(trolley.getFdApplicationId(),
					this.getFdApplicationId(), false)
					&& ObjectUtil.equals(
							trolley.getGeesunOitemsWarehousingRecordJoinList(),
							this.getGeesunOitemsWarehousingRecordJoinList(), false);
		}
		return super.equals(trolley);
	}

	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return super.hashCode();
	}

}
