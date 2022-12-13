
package com.landray.kmss.geesun.oitems.forms;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.web.action.ActionMapping;

import com.landray.kmss.common.convertor.FormConvertor_IDToModel;
import com.landray.kmss.common.convertor.FormConvertor_IDsToModelList;
import com.landray.kmss.common.convertor.FormToModelPropertyMap;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsManage;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.simplecategory.forms.SysSimpleCategoryAuthTmpForm;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 */
public class GeesunOitemsManageForm extends SysSimpleCategoryAuthTmpForm {
	/*
	 * 排序号
	 */
    private String fdOrder = null;
	/*
	 * 类别名称
	 */
    private String fdName = null;
	/*
	 * 层级
	 */
    private String fdHierarchyId = null;
	/*
	 * 创建时间
	 */
    private String docCreateTime = null;
	/*
	 * 创建者Id
	 */
    private String docCreatorId = null;
    /*
	 * 创建者Name
	 */
    private String docCreatorName = null;
    
    /*
	 * 父类ID
	 */
    private String fdParentId = null;
    /*
	 * 父类名称
	 */
    private String fdParentName = null;

	/**
	 * @return 返回 排序号
	 */
	public String getFdOrder() {
		return fdOrder;
	}
	
	/**
	 * @param fdOrder 要设置的 排序号
	 */
	public void setFdOrder(String fdOrder) {
		this.fdOrder = fdOrder;
	}

	/**
	 * @return 返回 类别名称
	 */
	public String getFdName() {
		return fdName;
	}
	
	/**
	 * @param fdName 要设置的 类别名称
	 */
	public void setFdName(String fdName) {
		this.fdName = fdName;
	}
	/**
	 * @return 返回 层级
	 */
	public String getFdHierarchyId() {
		return fdHierarchyId;
	}
	
	/**
	 * @param fdHierarchyId 要设置的 层级
	 */
	public void setFdHierarchyId(String fdHierarchyId) {
		this.fdHierarchyId = fdHierarchyId;
	}

    
	public String getDocCreateTime() {
		return docCreateTime;
	}

	public void setDocCreateTime(String docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	public String getDocCreatorId() {
		return docCreatorId;
	}

	public void setDocCreatorId(String docCreatorId) {
		this.docCreatorId = docCreatorId;
	}

	public String getFdParentId() {
		return fdParentId;
	}

	public void setFdParentId(String fdParentId) {
		this.fdParentId = fdParentId;
	}

	public String getFdParentName() {
		return fdParentName;
	}

	public void setFdParentName(String fdParentName) {
		this.fdParentName = fdParentName;
	}

	/*
	 *  （非 Javadoc）
	 * @see com.landray.kmss.web.action.ActionForm#reset(com.landray.kmss.web.action.ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
    public void reset(ActionMapping mapping, HttpServletRequest request) {
	    fdOrder = null;
	    fdName = null;
	    fdHierarchyId = null;
	    docCreateTime = null;
	    docCreatorId = null;
	    fdParentId = null;
	    fdParentName = null;
	    docCreatorName = null;
		authUseIds = null;
		authUseNames = null;
		super.reset(mapping, request);
    }

	public Class getModelClass() {
		return GeesunOitemsManage.class;
	}
	
	private static FormToModelPropertyMap toModelPropertyMap = null;

	public FormToModelPropertyMap getToModelPropertyMap() {
		if (toModelPropertyMap == null) {
			toModelPropertyMap = new FormToModelPropertyMap();
			toModelPropertyMap.putAll(super.getToModelPropertyMap());
			toModelPropertyMap.put("docCreatorId",
					new FormConvertor_IDToModel("docCreator",
							SysOrgPerson.class));
			toModelPropertyMap.put("fdParentId", new FormConvertor_IDToModel(
					"fdParent", GeesunOitemsManage.class));
			toModelPropertyMap.put("authUseIds", new FormConvertor_IDsToModelList("authUses", SysOrgElement.class));
		}
		return toModelPropertyMap;
	}

	public String getDocCreatorName() {
		return docCreatorName;
	}

	public void setDocCreatorName(String docCreatorName) {
		this.docCreatorName = docCreatorName;
	}

	/*
	 * 所有人不可阅读标记
	 */
	protected String authNotUseFlag = "false";

	public String getAuthNotUseFlag() {
		return authNotUseFlag;
	}

	public void setAuthNotUseFlag(String authNotUseFlag) {
		this.authNotUseFlag = authNotUseFlag;
	}

	/*
	 * 模板可使用者者
	 */
	protected String authUseIds = null;

	/*
	 * 模板可使用者名称
	 */
	protected String authUseNames = null;

	public String getAuthUseIds() {
		return authUseIds;
	}

	public void setAuthUseIds(String authUseIds) {
		this.authUseIds = authUseIds;
	}

	public String getAuthUseNames() {
		return authUseNames;
	}

	public void setAuthUseNames(String authUseNames) {
		this.authUseNames = authUseNames;
	}

}
