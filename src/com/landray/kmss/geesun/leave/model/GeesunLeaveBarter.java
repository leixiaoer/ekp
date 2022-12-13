package com.landray.kmss.geesun.leave.model;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import java.util.Date;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.sys.right.interfaces.ExtendAuthModel;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.common.convertor.ModelConvertor_ModelListToString;
import com.landray.kmss.geesun.leave.forms.GeesunLeaveBarterForm;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;

/**
 * 调休记录
 */
public class GeesunLeaveBarter extends ExtendAuthModel implements IAttachment {

	private static ModelToFormPropertyMap toFormPropertyMap;

	private String docSubject;

	private Date fdStartTime;

	private Date fdEndTime;

	private Double fdLeaveHour;

	private SysOrgElement docDept;

	private AutoHashMap attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);

	public Class<GeesunLeaveBarterForm> getFormClass() {
		return GeesunLeaveBarterForm.class;
	}

	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("docCreateTime",
					new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
			toFormPropertyMap.put("fdStartTime",
					new ModelConvertor_Common("fdStartTime").setDateTimeType(DateUtil.TYPE_DATETIME));
			toFormPropertyMap.put("fdEndTime",
					new ModelConvertor_Common("fdEndTime").setDateTimeType(DateUtil.TYPE_DATETIME));
			toFormPropertyMap.addNoConvertProperty("authReaderFlag");
			toFormPropertyMap.addNoConvertProperty("authEditorFlag");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docDept.fdName", "docDeptName");
			toFormPropertyMap.put("docDept.fdId", "docDeptId");
			toFormPropertyMap.put("authReaders", new ModelConvertor_ModelListToString("authReaderIds:authReaderNames",
					"fdId:fdName"));
		}
		return toFormPropertyMap;
	}

	public void recalculateFields() {
		super.recalculateFields();
		if (!getAuthReaderFlag()) {
		}
	}

	/**
	 * 主题
	 */
	public String getDocSubject() {
		return this.docSubject;
	}

	/**
	 * 主题
	 */
	public void setDocSubject(String docSubject) {
		this.docSubject = docSubject;
	}

	/**
	 * 调休开始时间
	 */
	public Date getFdStartTime() {
		return this.fdStartTime;
	}

	/**
	 * 调休开始时间
	 */
	public void setFdStartTime(Date fdStartTime) {
		this.fdStartTime = fdStartTime;
	}

	/**
	 * 调休结束时间
	 */
	public Date getFdEndTime() {
		return this.fdEndTime;
	}

	/**
	 * 调休结束时间
	 */
	public void setFdEndTime(Date fdEndTime) {
		this.fdEndTime = fdEndTime;
	}

	/**
	 * 调休时数
	 */
	public Double getFdLeaveHour() {
		return this.fdLeaveHour;
	}

	/**
	 * 调休时数
	 */
	public void setFdLeaveHour(Double fdLeaveHour) {
		this.fdLeaveHour = fdLeaveHour;
	}

	/**
	 * 所属部门
	 */
	public SysOrgElement getDocDept() {
		return this.docDept;
	}

	/**
	 * 所属部门
	 */
	public void setDocDept(SysOrgElement docDept) {
		this.docDept = docDept;
	}

	public AutoHashMap getAttachmentForms() {
		return attachmentForms;
	}

	/**
	 * 返回 所有人可阅读标记
	 */
	public Boolean getAuthReaderFlag() {
		return false;
	}

	public String getDocStatus() {
		return "30";
	}
}
