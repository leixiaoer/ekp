package com.landray.kmss.common.actions;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import org.hibernate.Query;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.model.IBaseTreeModel;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.constant.SysAuthConstant.AreaIsolation;
import com.landray.kmss.sys.authorization.constant.ISysAuthConstant;
import com.landray.kmss.sys.authorization.interfaces.SysAuthAreaUtils;
import com.landray.kmss.sys.authorization.util.SysAuthAreaHelper;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.simplecategory.service.ISysSimpleCategoryService;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.sunbor.web.tag.Page;

public abstract class SimpleCategoryNodeAction extends ExtendAction {
	public abstract ISysSimpleCategoryService getSysSimpleCategoryService();

	protected abstract String getParentProperty();

	public ActionForward listChildren(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return listChildrenBase(mapping, form, request, response,
				"listChildren", null);
	}

	public ActionForward manageList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return listChildrenBase(mapping, form, request, response, "manageList",
				SysAuthConstant.AUTH_CHECK_NONE);
	}

	private ActionForward listChildrenBase(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response, String forwordPage, String checkAuth)
			throws Exception {
		KmssMessages messages = new KmssMessages();
		try {
			String s_pageno = request.getParameter("pageno");
			String s_rowsize = request.getParameter("rowsize");
			String orderby = request.getParameter("orderby");
			String ordertype = request.getParameter("ordertype");
			String parentId = request.getParameter("categoryId");
			String s_IsShowAll = request.getParameter("isShowAll");
			String excepteIds = request.getParameter("excepteIds");
			boolean isShowAll = true;
			if (StringUtil.isNotNull(s_IsShowAll)
					&& s_IsShowAll.equals("false"))
				isShowAll = false;
			boolean isReserve = false;
			if (ordertype != null && ordertype.equalsIgnoreCase("down")) {
				isReserve = true;
			}
			int pageno = 0;
			int rowsize = SysConfigParameters.getRowSize();
			if (s_pageno != null && s_pageno.length() > 0) {
				pageno = Integer.parseInt(s_pageno);
			}
			if (s_rowsize != null && s_rowsize.length() > 0) {
				rowsize = Integer.parseInt(s_rowsize);
			}
			if (isReserve)
				orderby += " desc";
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setOrderBy(orderby);
			hqlInfo.setPageNo(pageno);
			hqlInfo.setRowSize(rowsize);
			if (checkAuth != null)
				hqlInfo.setAuthCheckType(checkAuth);
			changeFindPageHQLInfo(request, hqlInfo);
			String whereBlock = hqlInfo.getWhereBlock();
			if (!StringUtil.isNull(parentId)) {
				if (StringUtil.isNull(whereBlock))
					whereBlock = "";
				else
					whereBlock = "(" + whereBlock + ") and ";
				String tableName = ModelUtil.getModelTableName(getServiceImp(
						request).getModelName());
				if (isShowAll) {
					IBaseTreeModel treeModel = (IBaseTreeModel) getSysSimpleCategoryService()
							.findByPrimaryKey(parentId);
					whereBlock += buildCategoryHQL(hqlInfo,treeModel,tableName);
				} else {
					whereBlock += tableName + "." + getParentProperty()
							+ ".fdId=:_treeParentId";
					hqlInfo.setParameter("_treeParentId", parentId);
				}
				if (StringUtil.isNotNull(excepteIds)) {
					whereBlock += " and "
							+ HQLUtil.buildLogicIN(tableName + ".fdId not",
									ArrayUtil.convertArrayToList(excepteIds
											.split("\\s*[;,]\\s*")));
				}
				if (("manageList").equals(forwordPage)) {
//					whereBlock += " and " + tableName
//							+ ".docStatus <> :_treeDocStatus";
//					hqlInfo.setParameter("_treeDocStatus",
//							SysDocConstant.DOC_STATUS_DRAFT);
				}
			}
			hqlInfo.setWhereBlock(whereBlock);
			Page page = getServiceImp(request).findPage(hqlInfo);
			UserOperHelper.logFindAll(page.getList(), getServiceImp(request).getModelName());
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return mapping.findForward("failure");
		} else {
			return getActionForward(forwordPage, mapping, form, request,
					response);
		}
	}
	
	/**
	 * 拼接分类HQL
	 */
	protected String buildCategoryHQL(HQLInfo hqlInfo, IBaseTreeModel treeModel,
			String tableName) {
		String whereBlock;
		if (StringUtil.isNull(treeModel.getFdHierarchyId())) {
			whereBlock = tableName + "." + getParentProperty()
					+ ".fdId=:_treeFdId";
			hqlInfo.setParameter("_treeFdId", treeModel.getFdId());
		} else {
			whereBlock = tableName + "." + getParentProperty()
					+ ".fdHierarchyId like :_treeHierarchyId";
			hqlInfo.setParameter("_treeHierarchyId", treeModel
					.getFdHierarchyId()
					+ "%");
		}
		return whereBlock;
	}
	

	/**
	 * 返回分类可使用者包含当前用户的分类(不限)
	 */
	protected List findReaderIds(IBaseService service,
			String modelName, String tableName) throws Exception {
		// 通过HQL查询有权限的ID
		String hql = "select distinct " + tableName + ".fdId from "
				+ modelName + " " + tableName + " left join " + tableName
				+ ".authAllEditors editors";
		hql += " left join " + tableName + ".authAllReaders readers";
		hql += " where (editors.fdId in (:orgIds)";
		hql += " or " + tableName
				+ ".authReaderFlag=1 or readers.fdId in (:orgIds))";
		AreaIsolation isolationType = SysAuthAreaUtils
				.getAreaIsolation(ISysAuthConstant.ISOLATION_SCENE_CATEGORY);
		Query query = SysAuthAreaHelper.queryWithArea(service, hql, modelName,
				tableName, isolationType);
		query.setParameterList("orgIds", UserUtil.getKMSSUser()
				.getUserAuthInfo().getAuthOrgIds());
		
		return query.list();
	}
	
	/**
	 * 返回分类可使用者包含当前用户的分类(带有分类Id)
	 */
	protected List findReaderIds(IBaseService service, String categoryId,
			String modelName, String tableName) throws Exception {

		String hql = "select " + tableName + ".fdId from " + modelName + " "
				+ tableName + " left join " + tableName
				+ ".authAllReaders readers  left join "+ tableName +".authAllEditors editors  where (";
		if (StringUtil.isNull(categoryId)) {
			hql += tableName + ".hbmParent is null and";
		} else if (!categoryId.equals("__all")) {
			hql += tableName + ".fdHierarchyId like :_treeHierarchyId ) and";
		}
		hql += " ( (editors.fdId in (:orgIds)) or ( " + tableName
				+ ".authReaderFlag=1 or readers.fdId in (:orgIds)) )";
		AreaIsolation isolationType = SysAuthAreaUtils
				.getAreaIsolation(ISysAuthConstant.ISOLATION_SCENE_CATEGORY);
		Query query = SysAuthAreaHelper.queryWithArea(service, hql, modelName,
				tableName, isolationType);
		if (StringUtil.isNotNull(categoryId) && !"__all".equals(categoryId)) {
			query.setParameter("_treeHierarchyId", "%"+categoryId+"%");
		}
		query.setParameterList("orgIds", UserUtil.getKMSSUser()
				.getUserAuthInfo().getAuthOrgIds());

		return query.list();
	}

}
