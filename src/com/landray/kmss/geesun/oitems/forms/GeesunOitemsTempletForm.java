
package com.landray.kmss.geesun.oitems.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormConvertor_IDsToModelList;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsTemplet;
import com.landray.kmss.sys.authorization.interfaces.ISysAuthAreaForm;
import com.landray.kmss.sys.authorization.model.SysAuthArea;
import com.landray.kmss.sys.number.forms.SysNumberMainMappForm;
import com.landray.kmss.sys.number.interfaces.ISysNumberForm;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.workflow.base.forms.SysWfTemplateForm;
import com.landray.kmss.sys.workflow.interfaces.ISysWfTemplateForm;
import com.landray.kmss.util.AutoHashMap;
import com.landray.kmss.web.action.ActionMapping;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 */
public class GeesunOitemsTempletForm extends ExtendForm
		implements ISysWfTemplateForm, ISysAuthAreaForm, ISysNumberForm {
	/*
	 * 模板名称
	 */
	private String fdName = null;
	/*
	 * 模板类型
	 */
    private String fdTempletType = null;
    /*
	 * 创建者Id
	 */
	private String docCreatorId = null;
	/*
	 * 创建者name
	 */
	private String docCreatorName = null;
	/*
	 * 创建时间
	 */
    private String docCreateTime = null;
    
    private String titleRegulation = null;
    public String getTitleRegulation() {
		return titleRegulation;
	}

	public void setTitleRegulation(String titleRegulation) {
		this.titleRegulation = titleRegulation;
	}


	private String titleRegulationName = null;

	public String getTitleRegulationName() {
		return titleRegulationName;
	}

	public void setTitleRegulationName(String titleRegulationName) {
		this.titleRegulationName = titleRegulationName;
	}

	/**
	 * @return 返回 模板类型
	 */
	public String getFdTempletType() {
		return fdTempletType;
	}
	
	/**
	 * @param fdTempletType 要设置的 模板类型
	 */
	public void setFdTempletType(String fdTempletType) {
		this.fdTempletType = fdTempletType;
	}
	/**
	 * @return 返回 创建者
	 */
	public String getDocCreatorId() {
		return docCreatorId;
	}
	
	/**
	 * @param docCreatorId 要设置的 创建者
	 */
	public void setDocCreatorId(String docCreatorId) {
		this.docCreatorId = docCreatorId;
	}
	/**
	 * @return 返回 创建时间
	 */
	public String getDocCreateTime() {
		return docCreateTime;
	}
	
	/**
	 * @param docCreateTime 要设置的 创建时间
	 */
	public void setDocCreateTime(String docCreateTime) {
		this.docCreateTime = docCreateTime;
	}
	

	// 所属场所ID
	protected String authAreaId = null;

	public String getAuthAreaId() {
		return authAreaId;
	}

	public void setAuthAreaId(String authAreaId) {
		this.authAreaId = authAreaId;
	}

	// 所属场所名称
	protected String authAreaName = null;

	public String getAuthAreaName() {
		return authAreaName;
	}

	public void setAuthAreaName(String authAreaName) {
		this.authAreaName = authAreaName;
	}

	/*
	 * 可阅读者
	 */
	protected String authReaderIds = null;

	public String getAuthReaderIds() {
		return authReaderIds;
	}

	public void setAuthReaderIds(String authReaderIds) {
		this.authReaderIds = authReaderIds;
	}

	/*
	 * 可阅读者名称
	 */
	protected String authReaderNames = null;

	public String getAuthReaderNames() {
		return authReaderNames;
	}

	public void setAuthReaderNames(String authReaderNames) {
		this.authReaderNames = authReaderNames;
	}

	/*
	 * 可编辑者
	 */
	protected String authEditorIds = null;

	public String getAuthEditorIds() {
		return authEditorIds;
	}

	public void setAuthEditorIds(String authEditorIds) {
		this.authEditorIds = authEditorIds;
	}

	/*
	 * 可编辑者名称
	 */
	protected String authEditorNames = null;

	public String getAuthEditorNames() {
		return authEditorNames;
	}

	public void setAuthEditorNames(String authEditorNames) {
		this.authEditorNames = authEditorNames;
	}

	
	/*
	 * 所有人不可阅读标记
	 */
	protected String authNotReaderFlag = "false";

	public String getAuthNotReaderFlag() {
		return authNotReaderFlag;
	}
	
	public void setAuthNotReaderFlag(String authNotReaderFlag) {
		this.authNotReaderFlag = authNotReaderFlag;
	}
    
	/*
	 *  （非 Javadoc）
	 * @see com.landray.kmss.web.action.ActionForm#reset(com.landray.kmss.web.action.ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
    public void reset(ActionMapping mapping, HttpServletRequest request) {
	    fdTempletType = null;
	    docCreatorId = null;
	    docCreateTime = null;
	    titleRegulation = null;
	    titleRegulationName = null;
	    fdName = null;
	    authReaderIds = null;
		authReaderNames = null;
		authEditorIds = null;
		authEditorNames = null;
		authAreaId = null;
		authAreaName = null;
	    sysWfTemplateForms.clear();
	    super.reset(mapping, request);
		
    }

	public Class getModelClass() {
		return GeesunOitemsTemplet.class;
	}
	
	private static FormToModelPropertyMap toModelPropertyMap = null;

	public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();			
			toModelPropertyMap.put("docCreatorId", new FormConvertor_IDToModel(
					"docCreator", SysOrgPerson.class));
			toModelPropertyMap.put("authReaderIds",
					new FormConvertor_IDsToModelList("authReaders",
							SysOrgElement.class));
			toModelPropertyMap.put("authEditorIds",
					new FormConvertor_IDsToModelList("authEditors",
							SysOrgElement.class));
			toModelPropertyMap.put("authAreaId", new FormConvertor_IDToModel(
					"authArea", SysAuthArea.class));


		}
		return toModelPropertyMap;
	}
	
	/*
	 * 流程模板
	 */
	private AutoHashMap sysWfTemplateForms = new AutoHashMap(
			SysWfTemplateForm.class);

	public AutoHashMap getSysWfTemplateForms() {
		return sysWfTemplateForms;
	}

	public String getDocCreatorName() {
		return docCreatorName;
	}

	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}

	public String getFdName() {
		return fdName;
	}

	public void setFdName(String fdName) {
		this.fdName = fdName;
	}

	// 编号机制
	private SysNumberMainMappForm sysNumberMainMappForm = new SysNumberMainMappForm();

	public SysNumberMainMappForm getSysNumberMainMappForm() {
		return sysNumberMainMappForm;
	}
	
	public void setSysNumberMainMappForm(SysNumberMainMappForm frm) {
		sysNumberMainMappForm = frm;
	}

}
