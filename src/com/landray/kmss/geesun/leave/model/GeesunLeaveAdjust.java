package com.landray.kmss.geesun.leave.model;

import com.landray.kmss.common.convertor.ModelConvertor_Common;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.geesun.leave.forms.GeesunLeaveAdjustForm;
import com.landray.kmss.common.convertor.ModelConvertor_ModelListToString;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.sys.right.interfaces.ExtendAuthModel;

/**
 * 加班记录
 */
public class GeesunLeaveAdjust extends ExtendAuthModel implements IAttachment {

	private static ModelToFormPropertyMap toFormPropertyMap;

	private String docSubject;

	private String fdStartTime;

	private String fdEndTime;

	private Double fdLeaveHour;

	private SysOrgElement docDept;
	
	private String fdModelId;
	
	private String fdDetailId;

	private AutoHashMap attachmentForms = new AutoHashMap(AttachmentDetailsForm.class);

	public Class<GeesunLeaveAdjustForm> getFormClass() {
		return GeesunLeaveAdjustForm.class;
	}

	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("docCreateTime",
					new ModelConvertor_Common("docCreateTime").setDateTimeType(DateUtil.TYPE_DATETIME));
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
	 * 加班开始时间
	 */
	public String getFdStartTime() {
		return this.fdStartTime;
	}

	/**
	 * 加班开始时间
	 */
	public void setFdStartTime(String fdStartTime) {
		this.fdStartTime = fdStartTime;
	}

	/**
	 * 加班结束时间
	 */
	public String getFdEndTime() {
		return this.fdEndTime;
	}

	/**
	 * 加班结束时间
	 */
	public void setFdEndTime(String fdEndTime) {
		this.fdEndTime = fdEndTime;
	}

	/**
	 * 加班时数
	 */
	public Double getFdLeaveHour() {
		return this.fdLeaveHour;
	}

	/**
	 * 加班时数
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
     * 模型ID
     */
    public String getFdModelId() {
        return this.fdModelId;
    }

    /**
     * 模型ID
     */
    public void setFdModelId(String fdModelId) {
        this.fdModelId = fdModelId;
    }
    
    /**
     * 明细ID
     */
    public String getFdDetailId() {
        return this.fdDetailId;
    }

    /**
     * 明细ID
     */
    public void setFdDetailId(String fdDetailId) {
        this.fdDetailId = fdDetailId;
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
