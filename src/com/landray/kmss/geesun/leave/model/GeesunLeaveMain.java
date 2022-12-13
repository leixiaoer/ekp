package com.landray.kmss.geesun.leave.model;

import java.util.Date;
import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.sys.right.interfaces.ExtendAuthModel;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.common.convertor.ModelConvertor_ModelListToString;
import com.landray.kmss.geesun.leave.forms.GeesunLeaveMainForm;
import com.landray.kmss.sys.readlog.interfaces.ISysReadLogAutoSaveModel;

/**
 * 调休额度
 */
public class GeesunLeaveMain extends ExtendAuthModel implements IAttachment, ISysReadLogAutoSaveModel {

	private static ModelToFormPropertyMap toFormPropertyMap;

	private String fdTime;

	private Double fdSurplusLeave;

	private Double fdUseLeave;

	private Double fdSunLeave;

	private Date docFailureTime;

	private String fdOwnerNo;

	private Long docReadCount;

	private SysOrgElement docDept;

	private AutoHashMap attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);

	public Class<GeesunLeaveMainForm> getFormClass() {
		return GeesunLeaveMainForm.class;
	}

	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("docCreateTime",
					new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
			toFormPropertyMap.put("docFailureTime",
					new ModelConvertor_Common("docFailureTime").setDateTimeType(DateUtil.TYPE_DATE));
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
	 * 年份
	 */
	public String getFdTime() {
		return this.fdTime;
	}

	/**
	 * 年份
	 */
	public void setFdTime(String fdTime) {
		this.fdTime = fdTime;
	}

	/**
	 * 剩余调休时数
	 */
	public Double getFdSurplusLeave() {
		return this.fdSurplusLeave;
	}

	/**
	 * 剩余调休时数
	 */
	public void setFdSurplusLeave(Double fdSurplusLeave) {
		this.fdSurplusLeave = fdSurplusLeave;
	}

	/**
	 * 已用调休时数
	 */
	public Double getFdUseLeave() {
		return this.fdUseLeave;
	}

	/**
	 * 已用调休时数
	 */
	public void setFdUseLeave(Double fdUseLeave) {
		this.fdUseLeave = fdUseLeave;
	}

	/**
	 * 调休时数总计
	 */
	public Double getFdSunLeave() {
		return this.fdSunLeave;
	}

	/**
	 * 调休时数总计
	 */
	public void setFdSunLeave(Double fdSunLeave) {
		this.fdSunLeave = fdSunLeave;
	}

	/**
	 * 失效时间
	 */
	public Date getDocFailureTime() {
		return this.docFailureTime;
	}

	/**
	 * 失效时间
	 */
	public void setDocFailureTime(Date docFailureTime) {
		this.docFailureTime = docFailureTime;
	}

	/**
	 * 工号
	 */
	public String getFdOwnerNo() {
		return this.fdOwnerNo;
	}

	/**
	 * 工号
	 */
	public void setFdOwnerNo(String fdOwnerNo) {
		this.fdOwnerNo = fdOwnerNo;
	}

	/**
	 * 阅读次数
	 */
	public Long getDocReadCount() {
		return this.docReadCount;
	}

	/**
	 * 阅读次数
	 */
	public void setDocReadCount(Long docReadCount) {
		this.docReadCount = docReadCount;
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

	public String getDocSubject() {
		return getFdTime();
	}

	public void setDocStatus(String docStatus) {
	}
}
