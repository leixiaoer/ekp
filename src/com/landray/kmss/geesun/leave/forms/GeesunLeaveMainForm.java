package com.landray.kmss.geesun.leave.forms;

import com.landray.kmss.util.DateUtil;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.sys.readlog.forms.ReadLogForm;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_Common;
import com.landray.kmss.common.convertor.FormConvertor_IDsToModelList;
import com.landray.kmss.sys.readlog.interfaces.ISysReadLogForm;
import com.landray.kmss.web.action.ActionMapping;
import com.landray.kmss.web.upload.FormFile;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.sys.right.interfaces.ExtendAuthForm;
import com.landray.kmss.geesun.leave.model.GeesunLeaveMain;

/**
 * 调休额度
 */
public class GeesunLeaveMainForm extends ExtendAuthForm implements IAttachmentForm, ISysReadLogForm {

	private static FormToModelPropertyMap toModelPropertyMap;

	private String docCreateTime;

	private String fdTime;

	private String fdSurplusLeave;

	private String fdUseLeave;

	private String fdSunLeave;

	private String docFailureTime;

	private String fdOwnerNo;

	private String docReadCount;

	private String docCreatorId;

	private String docCreatorName;

	private String docDeptId;

	private String docDeptName;

	private AutoHashMap attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);

	private ReadLogForm readLogForm = new ReadLogForm();

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);
		docCreateTime = null;
		fdTime = null;
		fdSurplusLeave = null;
		fdUseLeave = null;
		fdSunLeave = null;
		docFailureTime = null;
		fdOwnerNo = null;
		docReadCount = null;
		docCreatorId = null;
		docCreatorName = null;
		docDeptId = null;
		docDeptName = null;
		super.reset(mapping, request);
	}

	public Class<GeesunLeaveMain> getModelClass() {
		return GeesunLeaveMain.class;
	}

	public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
			toModelPropertyMap.addNoConvertProperty("docCreateTime");
			toModelPropertyMap.put("docFailureTime",
					new FormConvertor_Common("docFailureTime").setDateTimeType(DateUtil.TYPE_DATE));
			toModelPropertyMap.addNoConvertProperty("docReadCount");
			toModelPropertyMap.put("docDeptId", new FormConvertor_IDToModel("docDept", SysOrgElement.class));
			toModelPropertyMap.put("authReaderIds",
					new FormConvertor_IDsToModelList("authReaders", SysOrgElement.class));
		}
		return toModelPropertyMap;
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
	public String getFdSurplusLeave() {
		return this.fdSurplusLeave;
	}

	/**
	 * 剩余调休时数
	 */
	public void setFdSurplusLeave(String fdSurplusLeave) {
		this.fdSurplusLeave = fdSurplusLeave;
	}

	/**
	 * 已用调休时数
	 */
	public String getFdUseLeave() {
		return this.fdUseLeave;
	}

	/**
	 * 已用调休时数
	 */
	public void setFdUseLeave(String fdUseLeave) {
		this.fdUseLeave = fdUseLeave;
	}

	/**
	 * 调休时数总计
	 */
	public String getFdSunLeave() {
		return this.fdSunLeave;
	}

	/**
	 * 调休时数总计
	 */
	public void setFdSunLeave(String fdSunLeave) {
		this.fdSunLeave = fdSunLeave;
	}

	/**
	 * 失效时间
	 */
	public String getDocFailureTime() {
		return this.docFailureTime;
	}

	/**
	 * 失效时间
	 */
	public void setDocFailureTime(String docFailureTime) {
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
	public String getDocReadCount() {
		return this.docReadCount;
	}

	/**
	 * 阅读次数
	 */
	public void setDocReadCount(String docReadCount) {
		this.docReadCount = docReadCount;
	}

	/**
	 * 姓名
	 */
	public String getDocCreatorId() {
		return this.docCreatorId;
	}

	/**
	 * 姓名
	 */
	public void setDocCreatorId(String docCreatorId) {
		this.docCreatorId = docCreatorId;
	}

	/**
	 * 姓名
	 */
	public String getDocCreatorName() {
		return this.docCreatorName;
	}

	/**
	 * 姓名
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

	public ReadLogForm getReadLogForm() {
		return readLogForm;
	}

	public void setReadLogForm(ReadLogForm readLogForm) {
		this.readLogForm = readLogForm;
	}

	protected FormFile theFile;

	public FormFile getTheFile() {
		return theFile;
	}

	public void setTheFile(FormFile theFile) {
		this.theFile = theFile;
	}
}
