package com.landray.kmss.geesun.oitems.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.landray.kmss.common.convertor.ModelConvertor_ModelListToFormList;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsBudgerApplicationForm;
import com.landray.kmss.sys.attachment.model.IAttachment;
import com.landray.kmss.sys.doc.model.SysDocBaseInfo;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.print.interfaces.ISysPrintLogModel;
import com.landray.kmss.sys.print.model.SysPrintLog;
import com.landray.kmss.sys.workflow.interfaces.ISysWfMainModel;
import com.landray.kmss.sys.workflow.interfaces.SysWfBusinessModel;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟 部门预算申请
 */
public class GeesunOitemsBudgerApplication extends SysDocBaseInfo implements
		ISysWfMainModel, IAttachment, ISysPrintLogModel {
	
	// 申请单编号
	private String docNumber;

	public String getDocNumber() {
		return docNumber;
	}

	public void setDocNumber(String docNumber) {
		this.docNumber = docNumber;
	}

	//标题规则
	private String titleRegulation;

	public String getTitleRegulation() {
		return titleRegulation;
	}

	public void setTitleRegulation(String titleRegulation) {
		this.titleRegulation = titleRegulation;
	}

	/*
	 * 申请事由
	 */
	protected String fdReason;
	/*
	 * 申请说明
	 */
	protected String fdDesc;

	public String getFdDesc() {
		return fdDesc;
	}

	public void setFdDesc(String fdDesc) {
		this.fdDesc = fdDesc;
	}

	/*
	 * 创建时间
	 */
	protected Date docCreateTime;
	/*
	 * 发放状态
	 */
	protected String fdOutStatus;

	/*
	 * 领取时间
	 */
	protected Date fdOutTime;

	public Date getFdOutTime() {
		return fdOutTime;
	}

	public void setFdOutTime(Date fdOutTime) {
		this.fdOutTime = fdOutTime;
	}

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
	 * 创建者
	 */
	protected SysOrgPerson docCreator = null;

	/*
	 * 申请者
	 */
	protected SysOrgElement fdApplyor = null;

	/*
	 * 流程模板
	 */
	protected GeesunOitemsTemplet fdTemplate = null;
	
	/*
	 * 总金额
	 */
	protected Double fdTotalAmount;

	public Double getFdTotalAmount() {
		return fdTotalAmount;
	}

	public void setFdTotalAmount(Double fdTotalAmount) {
		this.fdTotalAmount = fdTotalAmount;
	}

	/**
	 * @return 返回 所有人可阅读标记
	 */
	public java.lang.Boolean getAuthReaderFlag() {
		if (authReaderFlag == null) {
			return new Boolean(false);
		}
		return authReaderFlag;
	}

	/**
	 * @param authReaderFlag
	 *            要设置的 所有人可阅读标记
	 */
	public void setAuthReaderFlag(java.lang.Boolean authReaderFlag) {
		this.authReaderFlag = authReaderFlag;
	}

	/*
	 * 购物列表
	 */
	protected List geesunOitemsShoppingTrolleyList = new ArrayList();

	public GeesunOitemsBudgerApplication() {
		super();
	}

	public List getGeesunOitemsShoppingTrolleyList() {
		return geesunOitemsShoppingTrolleyList;
	}

	public void setGeesunOitemsShoppingTrolleyList(List geesunOitemsShoppingTrolleyList) {
		this.geesunOitemsShoppingTrolleyList = geesunOitemsShoppingTrolleyList;
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
	 * @return 返回 创建时间
	 */
	public Date getDocCreateTime() {
		return docCreateTime;
	}

	/**
	 * @param docCreateTime
	 *            要设置的 创建时间
	 */
	public void setDocCreateTime(Date docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	public SysOrgElement getFdApplyor() {
		return fdApplyor;
	}

	public void setFdApplyor(SysOrgElement fdApplyor) {
		this.fdApplyor = fdApplyor;
	}

	public GeesunOitemsTemplet getFdTemplate() {
		return fdTemplate;
	}

	public void setFdTemplate(GeesunOitemsTemplet fdTemplate) {
		this.fdTemplate = fdTemplate;
	}

	protected static ModelToFormPropertyMap toFormPropertyMap;

	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("fdApplyor.fdId", "fdApplicantsId");
			toFormPropertyMap.put("fdApplyor.fdName", "fdApplicantsName");
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdTemplate.fdId", "fdTemplateId");
			toFormPropertyMap.put("fdTemplate.fdName", "fdTemplateName");
			toFormPropertyMap.put("geesunOitemsShoppingTrolleyList",
					new ModelConvertor_ModelListToFormList(
							"geesunOitemsShoppingTrolleyFormList"));
		}
		return toFormPropertyMap;
	}

	public Class getFormClass() {
		return GeesunOitemsBudgerApplicationForm.class;
	}

	// ********** 以下的代码为流程需要的代码，请直接拷贝 **********
	private SysWfBusinessModel sysWfBusinessModel = new SysWfBusinessModel();

	public SysWfBusinessModel getSysWfBusinessModel() {
		return sysWfBusinessModel;
	}

	/*
	 * @return 返回 文档状态
	 */
	public java.lang.String getDocStatus() {
		return docStatus;
	}

	public SysOrgPerson getDocCreator() {
		return docCreator;
	}

	public void setDocCreator(SysOrgPerson docCreator) {
		this.docCreator = docCreator;
	}

	public String getFdOutStatus() {
		return fdOutStatus;
	}

	public void setFdOutStatus(String fdOutStatus) {
		this.fdOutStatus = fdOutStatus;
	}

	public Boolean getAuthEditorFlag() {
		return false;
	}

	// 打印机制日志
	private SysPrintLog sysPrintLog = null;

	@Override
	public SysPrintLog getSysPrintLog() {
		return sysPrintLog;
	}

	@Override
	public void setSysPrintLog(SysPrintLog sysPrintLog) {
		this.sysPrintLog = sysPrintLog;
	}

	@Override
	protected void recalculateReaderField() {
		super.recalculateReaderField();
		if (fdApplyor.getFdOrgType() == 8
				&& !authAllReaders.contains(fdApplyor))
			authAllReaders.add(fdApplyor);
	}

}
