package com.landray.kmss.geesun.oitems.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.landray.kmss.common.convertor.ModelConvertor_ModelListToString;
import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.common.model.IBaseTreeModel;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsManageForm;
import com.landray.kmss.sys.simplecategory.model.SysSimpleCategoryAuthTmpModel;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.ObjectUtil;
import com.landray.kmss.util.UserUtil;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟 用品类别管理
 */
public class GeesunOitemsManage extends SysSimpleCategoryAuthTmpModel {

	/*
	 * 创建时间
	 */
	protected Date docCreateTime;

	/*
	 * 父类别
	 */
	private IBaseTreeModel fdParent;

	/*
	 * 系统组织架构
	 */

	public IBaseTreeModel getFdParent() {
		return getHbmParent();
	}

	public void setFdParent(IBaseTreeModel parent) {
		if (!ObjectUtil.equals(getHbmParent(), parent)) {
			ModelUtil.checkTreeCycle(this, parent, "fdParent");
			setHbmParent(parent);
		}
	}

	public String getFdParentsName() {
		return getFdParentsName(">>");
	}

	public String getFdParentsName(String splitStr) {
		String fdParentsName = "";
		List list = new ArrayList();
		if (fdParent != null) {
			try {
				IBaseTreeModel parent = fdParent;
				while (parent != null) {
					list.add(parent);
					parent = parent.getFdParent();
				}
			} catch (Exception ex) {
			}
		}
		for (int i = list.size() - 1; i >= 0; i--) {
			fdParentsName += ((GeesunOitemsManage) list.get(i)).getFdName();
			if (i > 0)
				fdParentsName += splitStr;
		}
		return fdParentsName;
	}

	public IBaseTreeModel getHbmParent() {
		return fdParent;
	}

	public void setHbmParent(IBaseTreeModel parent) {
		this.fdParent = parent;
	}



	public GeesunOitemsManage() {
		super();
	}

	protected static ModelToFormPropertyMap toFormPropertyMap;

	public ModelToFormPropertyMap getToFormPropertyMap() {
		if (toFormPropertyMap == null) {
			toFormPropertyMap = new ModelToFormPropertyMap();
			toFormPropertyMap.putAll(super.getToFormPropertyMap());
			toFormPropertyMap.put("docCreator.fdId", "docCreatorId");
			toFormPropertyMap.put("docCreator.fdName", "docCreatorName");
			toFormPropertyMap.put("fdParent.fdId", "fdParentId");
			toFormPropertyMap.put("fdParent.fdName", "fdParentName");
			toFormPropertyMap.put("authUses",
					new ModelConvertor_ModelListToString("authUseIds:authUseNames", "fdId:deptLevelNames"));
		}
		return toFormPropertyMap;
	}

	public Class getFormClass() {
		return GeesunOitemsManageForm.class;
	}

	public Date getDocCreateTime() {
		return docCreateTime;
	}

	public void setDocCreateTime(Date docCreateTime) {
		this.docCreateTime = docCreateTime;
	}

	/*
	 * 可使用者
	 */

	protected List authUses = new ArrayList();

	public List getAuthUses() {
		return authUses;
	}

	public void setAuthUses(List authUses) {
		this.authUses = authUses;
	}

	/*
	 * 所有人不可使用者标记
	 */
	private Boolean authNotUseFlag = new Boolean(false);

	public Boolean getAuthNotUseFlag() {
		return authNotUseFlag;
	}

	public void setAuthNotUseFlag(Boolean authNotUseFlag) {
		this.authNotUseFlag = authNotUseFlag;
	}

	/*
	 * 所有人可使用者标记
	 */
	protected Boolean authUseFlag;

	public Boolean getAuthUseFlag() {
		if (getAuthNotUseFlag() != null && getAuthNotUseFlag().booleanValue()) {
			return new Boolean(false);
		}
		if (ArrayUtil.isEmpty(getAuthUses()))
			return new Boolean(true);
		else
			return new Boolean(false);
	}

	public void setAuthUseFlag(Boolean authUseFlag) {
		this.authUseFlag = authUseFlag;
	}

	public void recalculateFields() {
		super.recalculateFields();
		if (getAuthNotUseFlag().booleanValue()) {
			getAuthUses().clear();
		}
		//类别管理员为空则只有父类别仓库管理员和模块管理员可维护
		if (!getAuthNotReaderFlag().booleanValue() && null != this.getHbmParent()) {
			if (getAuthReaders() == null || getAuthReaders().size() <= 0) {
				authOtherReaders.addAll(((GeesunOitemsManage) this.getHbmParent()).getAuthReaders());
			}
		}
		//移除所有可阅读者
		authAllReaders.remove(UserUtil.getEveryoneUser());
	}

	public Boolean getAuthReaderFlag() {
		return new Boolean(false);
	}

	public void setAuthReaderFlag(Boolean authReaderFlag) {
		this.authReaderFlag = false;
	}

}
