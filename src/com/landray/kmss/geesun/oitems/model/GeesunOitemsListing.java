package com.landray.kmss.geesun.oitems.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.landray.kmss.common.convertor.ModelConvertor_ModelListToFormList;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsListingForm;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.right.interfaces.ExtendAuthModel;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.UserUtil;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟 用品清单管理
 */
public class GeesunOitemsListing extends ExtendAuthModel implements IAttachment {

	/*
	 * 编号
	 */
	protected String fdNo;

	/*
	 * 物品名称
	 */
	protected String fdName;
	/*
	 * 是否有效,true为有效，false为无效
	 */
	public Boolean fdIsAbandon;

	public Boolean getFdIsAbandon() {
		if (fdIsAbandon == null)
			fdIsAbandon = Boolean.TRUE;
		return fdIsAbandon;
	}

	public void setFdIsAbandon(Boolean fdIsAbandon) {
		this.fdIsAbandon = fdIsAbandon;
	}

	/*
	 * 规格
	 */
	protected String fdSpecification;

	/*
	 * 品牌
	 */
	protected String fdBrand;

	/*
	 * 单价
	 */
	protected Double fdReferencePrice;

	/*
	 * 单位
	 */
	protected String fdUnit;

	/*
	 * 备注
	 */
	protected String fdRemark;

	/*
	 * 库存量
	 */
	protected Integer fdAmount;

	/*
	 * 创建时间
	 */
	protected Date docCreateTime;

	/*
	 * 用品类别管理
	 */
	protected GeesunOitemsManage fdCategory = null;

	/*
	 * 系统组织架构
	 */
	protected SysOrgElement docCreator = null;

	/*
	 * 库存
	 */
	protected List geesunOitemsWarehousingRecordList = new ArrayList();
	protected List geesunOitemsWarehousingRecordJoinListList = new ArrayList();

	public List getGeesunOitemsWarehousingRecordJoinListList() {
		return geesunOitemsWarehousingRecordJoinListList;
	}

	public void setGeesunOitemsWarehousingRecordJoinListList(
			List geesunOitemsWarehousingRecordJoinListList) {
		this.geesunOitemsWarehousingRecordJoinListList = geesunOitemsWarehousingRecordJoinListList;
	}

	public GeesunOitemsListing() {
		super();
	}

	/**
	 * @return 返回 编号
	 */
	public String getFdNo() {
		return fdNo;
	}

	/**
	 * @param fdNo
	 *            要设置的 编号
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
	 * @param fdName
	 *            要设置的 物品名称
	 */
	public void setFdName(String fdName) {
		this.fdName = fdName;
	}

	/**
	 * @return 返回 规格
	 */
	public String getFdSpecification() {
		return fdSpecification;
	}

	/**
	 * @param fdSpecification
	 *            要设置的 规格
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
	 * @param fdBrand
	 *            要设置的 品牌
	 */
	public void setFdBrand(String fdBrand) {
		this.fdBrand = fdBrand;
	}

	/**
	 * @return 返回 单价
	 */
	public Double getFdReferencePrice() {
		return fdReferencePrice;
	}

	/**
	 * @param fdReferencePrice
	 *            要设置的 单价
	 */
	public void setFdReferencePrice(Double fdReferencePrice) {
		this.fdReferencePrice = fdReferencePrice;
	}

	/**
	 * @return 返回 单位
	 */
	public String getFdUnit() {
		return fdUnit;
	}

	/**
	 * @param fdUnit
	 *            要设置的 单位
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
	 * @param fdRemark
	 *            要设置的 备注
	 */
	public void setFdRemark(String fdRemark) {
		this.fdRemark = fdRemark;
	}

	/**
	 * @return 返回 库存量
	 */
	public Integer getFdAmount() {
		return fdAmount;
	}

	/**
	 * @param fdAmount
	 *            要设置的 库存量
	 */
	public void setFdAmount(Integer fdAmount) {
		this.fdAmount = fdAmount;
	}

	/**
	 * @return 返回 创建时间
	 */
	public Date getDocCreateTime() {
		return docCreateTime;
	}

	/**
	 * @param docCreateTime
	 *            要设置的 创建时间
	 */
	public void setDocCreateTime(Date docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	public GeesunOitemsManage getFdCategory() {
		return fdCategory;
	}

	public void setFdCategory(GeesunOitemsManage fdCategory) {
		this.fdCategory = fdCategory;
	}


	public Class getFormClass() {
		return GeesunOitemsListingForm.class;
	}
	
	public Boolean getAuthReaderFlag() {
		if (ArrayUtil.isEmpty(getAuthReaders()))
			authReaderFlag = new Boolean(true);
		else
			authReaderFlag = new Boolean(false);
		return authReaderFlag;
	}

	protected static ModelToFormPropertyMap toFormPropertyMap;
	
	protected void recalculateReaderField() {
		// 重新计算可阅读者
		if (authAllReaders == null)
			authAllReaders = new ArrayList();
		else
			authAllReaders.clear();

		if (getAuthReaderFlag().booleanValue()) {
			// everyone
			authAllReaders.add(UserUtil.getEveryoneUser());
			return;
		}

		authAllReaders.add(getDocCreator());

		List tmpList = getAuthReaders();
		if (tmpList != null) {
			ArrayUtil.concatTwoList(tmpList, authAllReaders);
		}
		ArrayUtil.concatTwoList(authAllEditors, authAllReaders);
	}

	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdCategory.fdId", "fdCategoryId");
			toFormPropertyMap.put("fdCategory.fdName", "fdCategoryName");
			toFormPropertyMap.put("geesunOitemsWarehousingRecordList",
					new ModelConvertor_ModelListToFormList(
							"geesunOitemsWarehousingRecordList"));
			toFormPropertyMap.put("geesunOitemsWarehousingRecordJoinListList",
					new ModelConvertor_ModelListToFormList(
							"geesunOitemsWarehousingRecordJoinListList"));
		}
		return toFormPropertyMap;
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

	@Override
	public String getDocSubject() {
		// TODO 自动生成的方法存根
		return null;
	}
}
