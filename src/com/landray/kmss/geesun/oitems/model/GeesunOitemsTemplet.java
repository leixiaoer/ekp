package com.landray.kmss.geesun.oitems.model;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.landray.kmss.common.convertor.ModelConvertor_ModelListToString;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.BaseModel;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsTempletForm;
import com.landray.kmss.sys.authorization.interfaces.ISysAuthAreaModel;
import com.landray.kmss.sys.authorization.model.SysAuthArea;
import com.landray.kmss.sys.language.utils.SysLangUtil;
import com.landray.kmss.sys.number.interfaces.ISysNumberModel;
import com.landray.kmss.sys.number.model.SysNumberMainMapp;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.workflow.interfaces.ISysWfTemplateModel;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.UserUtil;

/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 * 流程模板
 */
public class GeesunOitemsTemplet extends BaseModel
		implements ISysWfTemplateModel, ISysAuthAreaModel, ISysNumberModel {

	
	/*
	 * 模板名称
	 */
	protected String fdName;
	
	/*
	 * 模板类型
	 */
	protected Integer fdTempletType;
	
	/*
	 * 创建时间
	 */
	protected Date docCreateTime;

	/*
	 * 系统组织架构2
	 */		
	protected SysOrgPerson	docCreator = null;
	
	/*
	 * 标题规则
	 */
	protected String titleRegulation;
	public String getTitleRegulation() {
		return titleRegulation;
	}


	public void setTitleRegulation(String titleRegulation) {
		this.titleRegulation = titleRegulation;
	}

	protected String titleRegulationName;
	
	public String getTitleRegulationName() {
		return titleRegulationName;
	}


	public void setTitleRegulationName(String titleRegulationName) {
		this.titleRegulationName = titleRegulationName;
	}


	public GeesunOitemsTemplet() {
		super();
	}
	
	
	/**
	 * @return 返回 模板类型
	 */
	public Integer getFdTempletType() {
		return fdTempletType;
	}
	
	/**
	 * @param fdTempletType 要设置的 模板类型
	 */
	public void setFdTempletType(Integer fdTempletType) {
		this.fdTempletType = fdTempletType;
	}
	
	/**
	 * @return 返回 创建时间
	 */
	public Date getDocCreateTime() {
		return docCreateTime;
	}
	
	/**
	 * @param docCreateTime 要设置的 创建时间
	 */
	public void setDocCreateTime(Date docCreateTime) {
		this.docCreateTime = docCreateTime;
	}
	
	public SysOrgPerson getDocCreator() {
		return docCreator;
	}


	public void setDocCreator(SysOrgPerson docCreator) {
		this.docCreator = docCreator;
	}
	
	/*
	 * 所有人可阅读标记
	 */
	protected Boolean authReaderFlag;

	public Boolean getAuthReaderFlag() {
		if (getAuthNotReaderFlag() != null
				&& getAuthNotReaderFlag().booleanValue()) {
			return new Boolean(false);
		}
		if (ArrayUtil.isEmpty(getAuthReaders()))
			return new Boolean(true);
		else
			return new Boolean(false);
	}

	public void setAuthReaderFlag(Boolean authReaderFlag) {
	}

	/*
	 * 所有人不可阅读标记
	 */
	private Boolean authNotReaderFlag = new Boolean(false);

	public Boolean getAuthNotReaderFlag() {
		return authNotReaderFlag;
	}

	public void setAuthNotReaderFlag(Boolean authNotReaderFlag) {
		this.authNotReaderFlag = authNotReaderFlag;
	}


	/*
	 * 可阅读者
	 */
	protected List authReaders = new ArrayList();

	public List getAuthReaders() {
		return authReaders;
	}

	public void setAuthReaders(List authReaders) {
		this.authReaders = authReaders;
	}

	/*
	 * 可编辑者
	 */
	protected List authEditors = new ArrayList();

	public List getAuthEditors() {
		return authEditors;
	}

	public void setAuthEditors(List authEditors) {
		this.authEditors = authEditors;
	}
	/*
	 * 所有可阅读者
	 */
	protected List authAllReaders = new ArrayList();

	public List getAuthAllReaders() {
		return authAllReaders;
	}

	public void setAuthAllReaders(List authAllReaders) {
		this.authAllReaders = authAllReaders;
	}

	/*
	 * 所有可编辑者
	 */
	protected List authAllEditors = new ArrayList();

	public List getAuthAllEditors() {
		return authAllEditors;
	}

	public void setAuthAllEditors(List authAllEditors) {
		this.authAllEditors = authAllEditors;
	}


	/*
	 * 所属场所
	 */
	protected SysAuthArea authArea;

	public SysAuthArea getAuthArea() {
		return authArea;
	}

	public void setAuthArea(SysAuthArea authArea) {
		this.authArea = authArea;
	}
	
	
	public void recalculateFields() {
		recalculateEditorField();
		recalculateReaderField();
	}

	
	protected void recalculateEditorField() {
		// 重新计算可编辑者
		if (authAllEditors == null)
			authAllEditors = new ArrayList();
		else
			authAllEditors.clear();
		
		List tmpList = getAuthEditors();
		if (tmpList != null) {
			ArrayUtil.concatTwoList(tmpList, authAllEditors);
		}
	}

	protected void recalculateReaderField() {
		// 重新计算可阅读者
		if (authAllReaders == null)
			authAllReaders = new ArrayList();
		else
			authAllReaders.clear();
		if (getAuthNotReaderFlag() != null
				&& getAuthNotReaderFlag().booleanValue()) {
			getAuthReaders().clear();
		} else {
			if (getAuthReaderFlag().booleanValue()) {
				// everyone
				authAllReaders.add(UserUtil.getEveryoneUser());
				return;
			}
		}
		List tmpList = getAuthReaders();
		if (tmpList != null) {
			ArrayUtil.concatTwoList(tmpList, authAllReaders);
		}
		ArrayUtil.concatTwoList(authAllEditors, authAllReaders);
	}

	public Class getFormClass() {
		return GeesunOitemsTempletForm.class;
	}
	
	protected static ModelToFormPropertyMap toFormPropertyMap;

	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("authReaders",
					new ModelConvertor_ModelListToString(
							"authReaderIds:authReaderNames", "fdId:fdName"));
			toFormPropertyMap.put("authEditors",
					new ModelConvertor_ModelListToString(
							"authEditorIds:authEditorNames", "fdId:fdName"));
			toFormPropertyMap.put("authArea.fdId", "authAreaId");
			toFormPropertyMap.put("authArea.fdName", "authAreaName");
		}
		return toFormPropertyMap;
	}
	
	/**
	 * 流程模板
	 */
	private List sysWfTemplateModels;

	public List getSysWfTemplateModels() {
		return sysWfTemplateModels;
	}

	public void setSysWfTemplateModels(List sysWfTemplateModels) {
		this.sysWfTemplateModels = sysWfTemplateModels;
	}


	public String getFdName() {
		//return fdName;
		return SysLangUtil.getPropValue(this, "fdName", fdName);
	}


	public void setFdName(String fdName) {
		this.fdName = fdName;
	}

	// 编号机制
	private SysNumberMainMapp sysNumberMainMapp = new SysNumberMainMapp();

	public SysNumberMainMapp getSysNumberMainMappModel() {
		return sysNumberMainMapp;
	}

	public void
			setSysNumberMainMappModel(SysNumberMainMapp sysNumberMainMapp1) {
		this.sysNumberMainMapp = sysNumberMainMapp1;
	}

}
