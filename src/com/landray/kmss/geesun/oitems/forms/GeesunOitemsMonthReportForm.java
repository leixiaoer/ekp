package com.landray.kmss.geesun.oitems.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_FormListToModelList;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsMonthReport;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoArrayList;

/**
 * 月统计表 Form
 * 
 * @author
 * @version 1.0 2011-11-23
 */
public class GeesunOitemsMonthReportForm extends ExtendForm {

	/**
	 * 标题
	 */
	protected String docSubject = null;

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
	protected String docCreateTime = null;

	/**
	 * @return 创建时间
	 */
	public String getDocCreateTime() {
		return docCreateTime;
	}

	/**
	 * @param docCreateTime
	 *            创建时间
	 */
	public void setDocCreateTime(String docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	/**
	 * 最后修改时间
	 */
	protected String docAlterTime = null;

	/**
	 * @return 最后修改时间
	 */
	public String getDocAlterTime() {
		return docAlterTime;
	}

	/**
	 * @param docAlterTime
	 *            最后修改时间
	 */
	public void setDocAlterTime(String docAlterTime) {
		this.docAlterTime = docAlterTime;
	}

	/**
	 * 更新时间
	 */
	protected String fdLastModifiedTime = null;

	/**
	 * @return 更新时间
	 */
	public String getFdLastModifiedTime() {
		return fdLastModifiedTime;
	}

	/**
	 * @param fdLastModifiedTime
	 *            更新时间
	 */
	public void setFdLastModifiedTime(String fdLastModifiedTime) {
		this.fdLastModifiedTime = fdLastModifiedTime;
	}

	/**
	 * 统计类型
	 */
	protected String fdType = null;

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
	protected String fdAmount = null;

	/**
	 * @return 总计
	 */
	public String getFdAmount() {
		return fdAmount;
	}

	/**
	 * @param fdAmount
	 *            总计
	 */
	public void setFdAmount(String fdAmount) {
		this.fdAmount = fdAmount;
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
	 * 月统计表的表单
	 */
	protected AutoArrayList geesunOitemsReportListingForms = new AutoArrayList(
			GeesunOitemsReportListingForm.class);

	/**
	 * @return 月统计表的表单
	 */
	public AutoArrayList getGeesunOitemsReportListingForms() {
		return geesunOitemsReportListingForms;
	}

	/**
	 * @param geesunOitemsReportListingForms
	 *            月统计表的表单
	 */
	public void setGeesunOitemsReportListingForms(
			AutoArrayList geesunOitemsReportListingForms) {
		this.geesunOitemsReportListingForms = geesunOitemsReportListingForms;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		docSubject = null;
		docCreateTime = null;
		docAlterTime = null;
		fdLastModifiedTime = null;
		fdType = null;
		fdAmount = null;
		docDeptId = null;
		docDeptName = null;
		docCreatorId = null;
		docCreatorName = null;
		geesunOitemsReportListingForms = new AutoArrayList(
				GeesunOitemsReportListingForm.class);
		super.reset(mapping, request);
	}

	public Class getModelClass() {
		return GeesunOitemsMonthReport.class;
	}

	private static FormToModelPropertyMap toModelPropertyMap;

	public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
			toModelPropertyMap.put("docDeptId", new FormConvertor_IDToModel(
					"docDept", SysOrgElement.class));
			toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel(
					"docCreator", SysOrgElement.class));
			toModelPropertyMap.put("geesunOitemsReportListingForms",
					new FormConvertor_FormListToModelList(
							"geesunOitemsReportListing", "fdMonthReport"));
		}
		return toModelPropertyMap;
	}
}
