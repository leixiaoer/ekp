package com.landray.kmss.geesun.oitems.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.landray.kmss.common.convertor.ModelConvertor_ModelListToFormList;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsMonthReportForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;

/**
 * 月统计表
 * 
 * @author
 * @version 1.0 2011-11-23
 */
public class GeesunOitemsMonthReport extends BaseModel {

	/**
	 * 标题
	 */
	protected String docSubject;

	/**
	 * @return 标题
	 */
	public String getDocSubject() {
		return docSubject;
	}

	/**
	 * @param docSubject
	 *            标题
	 */
	public void setDocSubject(String docSubject) {
		this.docSubject = docSubject;
	}

	/**
	 * 创建时间
	 */
	protected Date docCreateTime;

	/**
	 * @return 创建时间
	 */
	public Date getDocCreateTime() {
		return docCreateTime;
	}

	/**
	 * @param docCreateTime
	 *            创建时间
	 */
	public void setDocCreateTime(Date docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	/**
	 * 最后修改时间
	 */
	protected Date docAlterTime;

	/**
	 * @return 最后修改时间
	 */
	public Date getDocAlterTime() {
		return docAlterTime;
	}

	/**
	 * @param docAlterTime
	 *            最后修改时间
	 */
	public void setDocAlterTime(Date docAlterTime) {
		this.docAlterTime = docAlterTime;
	}

	/**
	 * 更新时间
	 */
	protected Date fdLastModifiedTime;

	/**
	 * @return 更新时间
	 */
	public Date getFdLastModifiedTime() {
		return fdLastModifiedTime;
	}

	/**
	 * @param fdLastModifiedTime
	 *            更新时间
	 */
	public void setFdLastModifiedTime(Date fdLastModifiedTime) {
		this.fdLastModifiedTime = fdLastModifiedTime;
	}

	/**
	 * 统计类型
	 */
	protected String fdType;

	/**
	 * @return 统计类型
	 */
	public String getFdType() {
		return fdType;
	}

	/**
	 * @param fdType
	 *            统计类型
	 */
	public void setFdType(String fdType) {
		this.fdType = fdType;
	}

	/**
	 * 总计
	 */
	protected Double fdAmount;

	/**
	 * @return 总计
	 */
	public Double getFdAmount() {
		return fdAmount;
	}

	/**
	 * @param fdAmount
	 *            总计
	 */
	public void setFdAmount(Double fdAmount) {
		this.fdAmount = fdAmount;
	}

	/**
	 * 所属部门
	 */
	protected SysOrgElement docDept;

	/**
	 * @return 所属部门
	 */
	public SysOrgElement getDocDept() {
		return docDept;
	}

	/**
	 * @param docDept
	 *            所属部门
	 */
	public void setDocDept(SysOrgElement docDept) {
		this.docDept = docDept;
	}

	/**
	 * 创建人
	 */
	protected SysOrgElement docCreator;

	/**
	 * @return 创建人
	 */
	public SysOrgElement getDocCreator() {
		return docCreator;
	}

	/**
	 * @param docCreator
	 *            创建人
	 */
	public void setDocCreator(SysOrgElement docCreator) {
		this.docCreator = docCreator;
	}

	/**
	 * 统计领用明细表
	 */
	protected List<GeesunOitemsReportListing> geesunOitemsReportListing = new ArrayList<GeesunOitemsReportListing>();

	/**
	 * @return 统计领用明细表
	 */
	public List<GeesunOitemsReportListing> getGeesunOitemsReportListing() {
		return geesunOitemsReportListing;
	}

	/**
	 * @param geesunOitemsReportListing
	 *            统计领用明细表
	 */
	public void setGeesunOitemsReportListing(
			List<GeesunOitemsReportListing> geesunOitemsReportListing) {
		this.geesunOitemsReportListing = geesunOitemsReportListing;
	}

	public Class getFormClass() {
		return GeesunOitemsMonthReportForm.class;
	}

	private static ModelToFormPropertyMap toFormPropertyMap;

	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("docDept.fdId", "docDeptId");
			toFormPropertyMap.put("docDept.deptLevelNames", "docDeptName");
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("geesunOitemsReportListing",
					new ModelConvertor_ModelListToFormList(
							"geesunOitemsReportListingForms"));
		}
		return toFormPropertyMap;
	}

	/***
	 * 添加统计明细表
	 * 
	 * @param geesunOitemsReportListing
	 */
	public void addGeesunOitemsReportListing(
			GeesunOitemsReportListing geesunOitemsReportListing) {
		this.geesunOitemsReportListing.add(geesunOitemsReportListing);
	}
}
