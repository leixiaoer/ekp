package com.landray.kmss.geesun.oitems.model;

import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsReportListingForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;

/**
 * 统计领用明细表
 * 
 * @author
 * @version 1.0 2011-11-23
 */
public class GeesunOitemsReportListing extends BaseModel {

	/**
	 * 数量
	 */
	protected Long fdCount;

	/**
	 * @return 数量
	 */
	public Long getFdCount() {
		return fdCount;
	}

	/**
	 * @param fdCount
	 *            数量
	 */
	public void setFdCount(Long fdCount) {
		this.fdCount = fdCount;
	}

	/**
	 * 物品类别
	 */
	protected String fdCategory;

	/**
	 * @return 物品类别
	 */
	public String getFdCategory() {
		return fdCategory;
	}

	/**
	 * @param fdCategory
	 *            物品类别
	 */
	public void setFdCategory(String fdCategory) {
		this.fdCategory = fdCategory;
	}

	/**
	 * 名称
	 */
	protected String fdName;

	/**
	 * @return 名称
	 */
	public String getFdName() {
		return fdName;
	}

	/**
	 * @param fdName
	 *            名称
	 */
	public void setFdName(String fdName) {
		this.fdName = fdName;
	}

	/**
	 * 单价
	 */
	protected Double fdReferencePrice;

	/**
	 * @return 单价
	 */
	public Double getFdReferencePrice() {
		return fdReferencePrice;
	}

	/**
	 * @param fdReferencePrice
	 *            单价
	 */
	public void setFdReferencePrice(Double fdReferencePrice) {
		this.fdReferencePrice = fdReferencePrice;
	}

	/**
	 * 单位
	 */
	protected String fdUnit;

	/**
	 * @return 单位
	 */
	public String getFdUnit() {
		return fdUnit;
	}

	/**
	 * @param fdUnit
	 *            单位
	 */
	public void setFdUnit(String fdUnit) {
		this.fdUnit = fdUnit;
	}

	/**
	 * 金额
	 */
	protected Double fdAmount;

	/**
	 * @return 金额
	 */
	public Double getFdAmount() {
		return fdAmount;
	}

	/**
	 * @param fdAmount
	 *            金额
	 */
	public void setFdAmount(Double fdAmount) {
		this.fdAmount = fdAmount;
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
	 * 月统计表
	 */
	protected GeesunOitemsMonthReport fdMonthReport;

	/**
	 * @return 月统计表
	 */
	public GeesunOitemsMonthReport getFdMonthReport() {
		return fdMonthReport;
	}

	/**
	 * @param fdMonthReport
	 *            月统计表
	 */
	public void setFdMonthReport(GeesunOitemsMonthReport fdMonthReport) {
		this.fdMonthReport = fdMonthReport;
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

	public Class getFormClass() {
		return GeesunOitemsReportListingForm.class;
	}

	private static ModelToFormPropertyMap toFormPropertyMap;

	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdMonthReport.fdId", "fdMonthReportId");
			toFormPropertyMap.put("fdMonthReport.docSubject",
					"fdMonthReportName");
			toFormPropertyMap.put("docDept.fdId", "docDeptId");
			toFormPropertyMap.put("docDept.deptLevelNames", "docDeptName");
		}
		return toFormPropertyMap;
	}
}
