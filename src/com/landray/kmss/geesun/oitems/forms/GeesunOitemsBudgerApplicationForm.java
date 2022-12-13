package com.landray.kmss.geesun.oitems.forms;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_FormListToModelList;
import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsTemplet;
import com.landray.kmss.sys.attachment.forms.AttachmentDetailsForm;
import com.landray.kmss.sys.attachment.forms.IAttachmentForm;
import com.landray.kmss.sys.doc.forms.SysDocBaseInfoForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.print.forms.SysPrintLogForm;
import com.landray.kmss.sys.print.interfaces.ISysPrintLogForm;
import com.landray.kmss.sys.workflow.interfaces.ISysWfMainForm;
import com.landray.kmss.sys.workflow.interfaces.SysWfBusinessForm;
import com.landray.kmss.util.AutoArrayList;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.web.action.ActionMapping;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟
 */
public class GeesunOitemsBudgerApplicationForm extends SysDocBaseInfoForm implements
		ISysWfMainForm, IAttachmentForm, ISysPrintLogForm {
	
	// 申请单编号
	private String docNumber;

	public String getDocNumber() {
		return docNumber;
	}

	public void setDocNumber(String docNumber) {
		this.docNumber = docNumber;
	}

	private String titleRegulation = null;
	public String getTitleRegulation() {
		return titleRegulation;
	}

	public void setTitleRegulation(String titleRegulation) {
		this.titleRegulation = titleRegulation;
	}
	/*
	 * 所属模板Id
	 */
	private String fdTemplateId = null;
	/*
	 * 所属模板Name
	 */
	private String fdTemplateName = null;
	/*
	 * 申请者Id
	 */
	private String fdApplicantsId = null;
	/*
	 * 申请者Name
	 */
	private String fdApplicantsName = null;
	/*
	 * 申请事由
	 */
	private String fdReason = null;
	/*
	 * 总金额
	 */
	private String fdTotalAmount = null;

	public String getFdTotalAmount() {
		return fdTotalAmount;
	}

	public void setFdTotalAmount(String fdTotalAmount) {
		this.fdTotalAmount = fdTotalAmount;
	}
	/*
	 * 申请说明
	 */
	private String fdDesc = null;
	public String getFdDesc() {
		return fdDesc;
	}

	public void setFdDesc(String fdDesc) {
		this.fdDesc = fdDesc;
	}
	/*
	 * 创建者
	 */
	private String docCreatorId = null;
	/*
	 * 发放状态
	 */
	private String fdOutStatus = null;

	/*
	 * 类型
	 */
	protected String fdType;

	public String getFdType() {
		return fdType;
	}

	public void setFdType(String fdType) {
		this.fdType = fdType;
	}

	/*
	 * 物品申请清单
	 */
	protected List geesunOitemsShoppingTrolleyFormList = new AutoArrayList(
			GeesunOitemsShoppingTrolleyForm.class);
	
	/**
	 * @return 返回 申请者
	 */
	public String getFdApplicantsId() {
		return fdApplicantsId;
	}

	/**
	 * @param fdApplicantsId
	 *            要设置的 申请者
	 */
	public void setFdApplicantsId(String fdApplicantsId) {
		this.fdApplicantsId = fdApplicantsId;
	}

	/**
	 * @return 返回 申请事由
	 */
	public String getFdReason() {
		return fdReason;
	}

	/**
	 * @param fdReason
	 *            要设置的 申请事由
	 */
	public void setFdReason(String fdReason) {
		this.fdReason = fdReason;
	}

	/**
	 * @return 返回 创建者
	 */
	public String getDocCreatorId() {
		return docCreatorId;
	}

	/**
	 * @param docCreatorId
	 *            要设置的 创建者
	 */
	public void setDocCreatorId(String docCreatorId) {
		this.docCreatorId = docCreatorId;
	}

	/*
	 * （非 Javadoc）
	 * 
	 * @seecom.landray.kmss.web.action.ActionForm#reset(org.apache.struts.action.
	 * ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		docNumber = null;
		docSubject = null;
		titleRegulation = null;
		fdTemplateId = null;
		fdTemplateName = null;
		fdApplicantsName = null;
		fdApplicantsId = null;
		fdReason = null;
		docCreatorId = null;
		docCreatorName = null;
		docCreateTime = null;
		fdOutStatus = null;
		fdTotalAmount = null;
		sysWfBusinessForm = new SysWfBusinessForm();
		super.reset(mapping, request);
	}

	public Class getModelClass() {
		return GeesunOitemsBudgerApplication.class;
	}

	private static FormToModelPropertyMap toModelPropertyMap = null;

	public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
			toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel(
					"docCreator", SysOrgPerson.class));
			toModelPropertyMap.put("fdTemplateId", new FormConvertor_IDToModel(
					"fdTemplate", GeesunOitemsTemplet.class));
			toModelPropertyMap.put("fdApplicantsId",
					new FormConvertor_IDToModel("fdApplyor",
							SysOrgElement.class));

			toModelPropertyMap.put("geesunOitemsShoppingTrolleyFormList",
					new FormConvertor_FormListToModelList(
							"geesunOitemsShoppingTrolleyList",
							"geesunOitemsBudgerApplication"));
		}
		return toModelPropertyMap;
	}

	// ********** 以下的代码为流程需要的代码，请直接拷贝 **********
	private SysWfBusinessForm sysWfBusinessForm = new SysWfBusinessForm();

	public SysWfBusinessForm getSysWfBusinessForm() {
		return sysWfBusinessForm;
	}

	/**
	 * @return 返回 文档状态
	 */
	public String getDocStatus() {
		return docStatus;
	}

	public String getFdTemplateId() {
		return fdTemplateId;
	}

	public void setFdTemplateId(String fdTemplateId) {
		this.fdTemplateId = fdTemplateId;
	}

	public String getFdTemplateName() {
		return fdTemplateName;
	}

	public void setFdTemplateName(String fdTemplateName) {
		this.fdTemplateName = fdTemplateName;
	}

	public String getFdApplicantsName() {
		return fdApplicantsName;
	}

	public void setFdApplicantsName(String fdApplicantsName) {
		this.fdApplicantsName = fdApplicantsName;
	}

	public List getGeesunOitemsShoppingTrolleyFormList() {
		return geesunOitemsShoppingTrolleyFormList;
	}

	public void setGeesunOitemsShoppingTrolleyFormList(
			List geesunOitemsShoppingTrolleyFormList) {
		this.geesunOitemsShoppingTrolleyFormList = geesunOitemsShoppingTrolleyFormList;
	}

	public String getFdOutStatus() {
		return fdOutStatus;
	}

	public void setFdOutStatus(String fdOutStatus) {
		this.fdOutStatus = fdOutStatus;
	}
	
	/*
	 * 附件机制
	 */
	private AutoHashMap attachmentForms = new AutoHashMap(
			AttachmentDetailsForm.class);

	public AutoHashMap getAttachmentForms() {
		return attachmentForms;
	}

	// 打印机制日志
	private SysPrintLogForm sysPrintLogForm = new SysPrintLogForm();

	@Override
	public SysPrintLogForm getSysPrintLogForm() {
		return sysPrintLogForm;
	}

	@Override
	public void setSysPrintLogForm(SysPrintLogForm sysPrintLogForm) {
		this.sysPrintLogForm = sysPrintLogForm;
	}

}
