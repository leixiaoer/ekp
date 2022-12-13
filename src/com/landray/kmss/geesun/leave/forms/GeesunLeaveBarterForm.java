package com.landray.kmss.geesun.leave.forms;

import com.landray.kmss.util.DateUtil;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.util.AutoHashMap;
import javax.servlet.http.HttpServletRequest;
import com.landray.kmss.common.convertor.FormConvertor_Common;
import com.landray.kmss.common.convertor.FormConvertor_IDsToModelList;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.geesun.leave.model.GeesunLeaveBarter;
import com.landray.kmss.sys.right.interfaces.ExtendAuthForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.web.action.ActionMapping;

/**
 * 调休记录
 */
public class GeesunLeaveBarterForm extends ExtendAuthForm implements IAttachmentForm {

	private static FormToModelPropertyMap toModelPropertyMap;

	private String docSubject;

	private String docCreateTime;

	private String fdStartTime;

	private String fdEndTime;

	private String fdLeaveHour;

	private String docCreatorId;

	private String docCreatorName;

	private String docDeptId;

	private String docDeptName;

	private AutoHashMap attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);
		docSubject = null;
		docCreateTime = null;
		fdStartTime = null;
		fdEndTime = null;
		fdLeaveHour = null;
		docCreatorId = null;
		docCreatorName = null;
		docDeptId = null;
		docDeptName = null;
		super.reset(mapping, request);
	}

	public Class<GeesunLeaveBarter> getModelClass() {
		return GeesunLeaveBarter.class;
	}

	public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
			toModelPropertyMap.addNoConvertProperty("docCreateTime");
			toModelPropertyMap.put("fdStartTime",
					new FormConvertor_Common("fdStartTime").setDateTimeType(DateUtil.TYPE_DATETIME));
			toModelPropertyMap.put("fdEndTime",
					new FormConvertor_Common("fdEndTime").setDateTimeType(DateUtil.TYPE_DATETIME));
			toModelPropertyMap.put("docDeptId", new FormConvertor_IDToModel("docDept", SysOrgElement.class));
			toModelPropertyMap.put("authReaderIds",
					new FormConvertor_IDsToModelList("authReaders", SysOrgElement.class));
		}
		return toModelPropertyMap;
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
	 * 创建时间
	 */
	public String getDocCreateTime() {
		return this.docCreateTime;
	}

	/**
	 * 创建时间
	 */
	public void setDocCreateTime(String docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	/**
	 * 调休开始时间
	 */
	public String getFdStartTime() {
		return this.fdStartTime;
	}

	/**
	 * 调休开始时间
	 */
	public void setFdStartTime(String fdStartTime) {
		this.fdStartTime = fdStartTime;
	}

	/**
	 * 调休结束时间
	 */
	public String getFdEndTime() {
		return this.fdEndTime;
	}

	/**
	 * 调休结束时间
	 */
	public void setFdEndTime(String fdEndTime) {
		this.fdEndTime = fdEndTime;
	}

	/**
	 * 调休时数
	 */
	public String getFdLeaveHour() {
		return this.fdLeaveHour;
	}

	/**
	 * 调休时数
	 */
	public void setFdLeaveHour(String fdLeaveHour) {
		this.fdLeaveHour = fdLeaveHour;
	}

	/**
	 * 申请人
	 */
	public String getDocCreatorId() {
		return this.docCreatorId;
	}

	/**
	 * 申请人
	 */
	public void setDocCreatorId(String docCreatorId) {
		this.docCreatorId = docCreatorId;
	}

	/**
	 * 申请人
	 */
	public String getDocCreatorName() {
		return this.docCreatorName;
	}

	/**
	 * 申请人
	 */
	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}

	/**
	 * 所属部门
	 */
	public String getDocDeptId() {
		return this.docDeptId;
	}

	/**
	 * 所属部门
	 */
	public void setDocDeptId(String docDeptId) {
		this.docDeptId = docDeptId;
	}

	/**
	 * 所属部门
	 */
	public String getDocDeptName() {
		return this.docDeptName;
	}

	/**
	 * 所属部门
	 */
	public void setDocDeptName(String docDeptName) {
		this.docDeptName = docDeptName;
	}

	public AutoHashMap getAttachmentForms() {
		return attachmentForms;
	}

	public String getAuthReaderNoteFlag() {
		return "2";
	}
}
