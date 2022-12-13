package com.landray.kmss.geesun.oitems.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsMonthReport;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReportListing;
import com.landray.kmss.sys.organization.model.SysOrgElement;

/**
 * 统计领用明细表 Form
 * 
 * @author
 * @version 1.0 2011-11-23
 */
public class GeesunOitemsReportListingForm extends ExtendForm {

	/**
	 * 数量
	 */
	protected String fdCount = null;

	/**
	 * @return 数量
	 */
	public String getFdCount() {
		return fdCount;
	}

	/**
	 * @param fdCount
	 *            数量
	 */
	public void setFdCount(String fdCount) {
		this.fdCount = fdCount;
	}

	/**
	 * 物品类别
	 */
	protected String fdCategory = null;

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
	protected String fdName = null;

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
	protected String fdReferencePrice = null;

	/**
	 * @return 单价
	 */
	public String getFdReferencePrice() {
		return fdReferencePrice;
	}

	/**
	 * @param fdReferencePrice
	 *            单价
	 */
	public void setFdReferencePrice(String fdReferencePrice) {
		this.fdReferencePrice = fdReferencePrice;
	}

	/**
	 * 单位
	 */
	protected String fdUnit = null;

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
	protected String fdAmount = null;

	/**
	 * @return 金额
	 */
	public String getFdAmount() {
		return fdAmount;
	}

	/**
	 * @param fdAmount
	 *            金额
	 */
	public void setFdAmount(String fdAmount) {
		this.fdAmount = fdAmount;
	}

	/**
	 * 创建人的ID
	 */
	protected String docCreatorId = null;

	/**
	 * @return 创建人的ID
	 */
	public String getDocCreatorId() {
		return docCreatorId;
	}

	/**
	 * @param docCreatorId
	 *            创建人的ID
	 */
	public void setDocCreatorId(String docCreatorId) {
		this.docCreatorId = docCreatorId;
	}

	/**
	 * 创建人的名称
	 */
	protected String docCreatorName = null;

	/**
	 * @return 创建人的名称
	 */
	public String getDocCreatorName() {
		return docCreatorName;
	}

	/**
	 * @param docCreatorName
	 *            创建人的名称
	 */
	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}

	/**
	 * 月统计表的ID
	 */
	protected String fdMonthReportId = null;

	/**
	 * @return 月统计表的ID
	 */
	public String getFdMonthReportId() {
		return fdMonthReportId;
	}

	/**
	 * @param fdMonthReportId
	 *            月统计表的ID
	 */
	public void setFdMonthReportId(String fdMonthReportId) {
		this.fdMonthReportId = fdMonthReportId;
	}

	/**
	 * 月统计表的名称
	 */
	protected String fdMonthReportName = null;

	/**
	 * @return 月统计表的名称
	 */
	public String getFdMonthReportName() {
		return fdMonthReportName;
	}

	/**
	 * @param fdMonthReportName
	 *            月统计表的名称
	 */
	public void setFdMonthReportName(String fdMonthReportName) {
		this.fdMonthReportName = fdMonthReportName;
	}

	/**
	 * 所属部门的ID
	 */
	protected String docDeptId = null;

	/**
	 * @return 所属部门的ID
	 */
	public String getDocDeptId() {
		return docDeptId;
	}

	/**
	 * @param docDeptId
	 *            所属部门的ID
	 */
	public void setDocDeptId(String docDeptId) {
		this.docDeptId = docDeptId;
	}

	/**
	 * 所属部门的名称
	 */
	protected String docDeptName = null;

	/**
	 * @return 所属部门的名称
	 */
	public String getDocDeptName() {
		return docDeptName;
	}

	/**
	 * @param docDeptName
	 *            所属部门的名称
	 */
	public void setDocDeptName(String docDeptName) {
		this.docDeptName = docDeptName;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		fdCount = null;
		fdCategory = null;
		fdName = null;
		fdReferencePrice = null;
		fdUnit = null;
		fdAmount = null;
		docCreatorId = null;
		docCreatorName = null;
		fdMonthReportId = null;
		fdMonthReportName = null;
		docDeptId = null;
		docDeptName = null;

		super.reset(mapping, request);
	}

	public Class getModelClass() {
		return GeesunOitemsReportListing.class;
	}

	private static FormToModelPropertyMap toModelPropertyMap;

	public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
			toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel(
					"docCreator", SysOrgElement.class));
			toModelPropertyMap.put("fdMonthReportId",
					new FormConvertor_IDToModel("fdMonthReport",
							GeesunOitemsMonthReport.class));
			toModelPropertyMap.put("docDeptId", new FormConvertor_IDToModel(
					"docDept", SysOrgElement.class));
		}
		return toModelPropertyMap;
	}
}
