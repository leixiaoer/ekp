package com.landray.kmss.geesun.oitems.service.spring;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.service.IXMLDataBean;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.constant.SysAuthConstant.AreaIsolation;
import com.landray.kmss.sys.authorization.constant.ISysAuthConstant;
import com.landray.kmss.sys.authorization.interfaces.SysAuthAreaUtils;
import com.landray.kmss.sys.authorization.util.SysAuthAreaHelper;
import com.landray.kmss.sys.config.dict.SysDataDict;
import com.landray.kmss.sys.config.dict.SysDictModel;
import com.landray.kmss.sys.language.utils.SysLangUtil;
import com.landray.kmss.sys.simplecategory.interfaces.SimpleCategoryUtil;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.IDGenerator;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;

public class GeesunOitemsManageMobileTreeService implements IXMLDataBean {

	private static final int SHOW_ALL = 0;
	private static final int SHOW_EDIT = 1;
	private static final int SHOW_READ = 2;

	/**
	 * 获取辅类别信息和获取辅类别的模板信息 categoryId 父辅类别ID，不传则获取根辅类别的ID authType
	 * 对节点的验证权限,0显示所有(00可以选中所有,01只能选中有维护权限的,02只能选中有使用权限的),1 只显示有维护权限的 2
	 * modelName 简单分类的域模型名 必须 filterUrl 简单分类过滤URL前缀 必须 extendPara 扩展参数
	 */
	public List<Map<String, Object>> getDataList(RequestContext xmlContext)
			throws Exception {
		String categoryId = xmlContext.getParameter("categoryId");
		String modelName = xmlContext.getParameter("modelName");
		String authType = xmlContext.getParameter("authType");
		String pAdmin = xmlContext.getParameter("pAdmin");
		String extendService = xmlContext.getParameter("extendService");
		String extProps = xmlContext.getParameter("extProps");
		boolean categoryIsNull = StringUtil.isNotNull(xmlContext
				.getParameter("categoryIsNull"));

		SysDictModel dict = SysDataDict.getInstance().getModel(modelName);
		int showType = getShowType(xmlContext, dict);

		IBaseService service = (IBaseService) SpringBeanUtil.getBean(dict
				.getServiceBean());
		String tableName = ModelUtil.getModelTableName(modelName);
		List<Map<String, Object>> rtnList = new ArrayList<Map<String, Object>>();
		List<Object[]> categoriesList = findAll(service, categoryId, modelName,
				tableName, xmlContext);
		List categoryEditList = null;
		List categoryReadList = null;
		switch (showType) {
		case SHOW_READ:
			categoryReadList = findReaderIds(service, categoryId, modelName,
					tableName);
			categoryEditList = findEditorIds(service, categoryId, modelName,
					tableName);
			break;
		case SHOW_EDIT:
			categoryEditList = findEditorIds(service, categoryId, modelName,
					tableName);
			break;
		}
		String baseBeanName = "sysSimpleCategoryTreeService";
		if (StringUtil.isNotNull(extendService)) {
			// 增加简单分类下展开该分类下的文档节点
			baseBeanName += ";" + extendService + "&extendService="
					+ URLEncoder.encode(extendService, "UTF-8");
		}
		if (StringUtil.isNotNull(extProps)) {
			baseBeanName += "&extProps=" + extProps;
		}

		ArrayList<String> rtnIds = "1"
				.equals(xmlContext.getParameter("isLoadChildren"))
						? new ArrayList<String>() : null;

		for (int i = 0; i < categoriesList.size(); i++) {
			Object[] info = (Object[]) categoriesList.get(i);
			String id = (String) info[1];
			boolean showValue = true;
			String beanName = baseBeanName;
			if (showType != SHOW_ALL) {
				showValue = "1".equals(pAdmin) || categoryEditList.contains(id);
				if (showValue) {
					beanName += "&pAdmin=1";
				} else {
					if (ISysAuthConstant.IS_AREA_ENABLED && info.length > 2
							&& info[2] != null) {
						String areaHierarchyId = (String) info[2];
						showValue = SimpleCategoryUtil.isAreaAdmin(dict
								.getModelName(), areaHierarchyId);
					} else {
						showValue = SimpleCategoryUtil.isAdmin(dict
								.getModelName());
					}
				}
			} else if ("1".equals(pAdmin)) {
				beanName += "&pAdmin=1";
			}
			if (showType == SHOW_READ && !showValue) {
				showValue = categoryReadList.contains(id);
			}

			HashMap<String, Object> node = new HashMap<String, Object>();
			node.put("text", info[0]);
			beanName += "&authType=" + authType + "&modelName=" + modelName
					+ "&categoryId=" + id;

			if (!showValue) {
				node.put("isShowCheckBox", "0");
				node.put("href", "");
			}
			// 用在elearning中的处理
			if (categoryIsNull) {
				node.put("href", "");
			}
			node.put("beanName", beanName + "&s_seq="
					+ IDGenerator.generateID());
			node.put("value", id);
			node.put("nodeType", "CATEGORY");

			rtnList.add(node);
			if (rtnIds != null) {
				rtnIds.add(id);
			}
		}
		if (!ArrayUtil.isEmpty(rtnIds)) {
			this.loadChildren(rtnIds, rtnList, xmlContext,
					showType, service, modelName, tableName);
		}

		return rtnList;
	}

	private int getShowType(RequestContext request, SysDictModel dict) {
		if (UserUtil.getKMSSUser().isAdmin()) {
			return SHOW_ALL;
		}
		if (dict.getPropertyMap().get("authAllEditors") == null
				|| dict.getPropertyMap().get("authAllReaders") == null) {
			return SHOW_ALL;
		}
		if ("1".equals(request.getParameter("pAdmin"))) {
			return SHOW_ALL;
		}
		String authType = request.getParameter("authType");
		if (StringUtil.isNull(authType)) {
			return SHOW_ALL;
		}
		if (authType.endsWith("1")) {
			return SHOW_EDIT;
		}
		if (authType.endsWith("2")) {
			return SHOW_READ;
		}
		return SHOW_ALL;
	}

	private List<Object[]> findAll(IBaseService service, String categoryId,
			String modelName, String tableName, RequestContext xmlContext)
			throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		hqlInfo.setDistinctType(HQLInfo.DISTINCT_YES);
		// 过滤场所数据
		if (ISysAuthConstant.IS_AREA_ENABLED
				&& ISysAuthConstant.IS_ISOLATION_ENABLED) {
			hqlInfo.setCheckParam(SysAuthConstant.CheckType.AreaCheck,
					SysAuthConstant.AreaCheck.YES);
			hqlInfo.setCheckParam(SysAuthConstant.CheckType.AreaIsolation,
					ISysAuthConstant.ISOLATION_SCENE_CATEGORY);
		}

		StringBuilder selectBlock = new StringBuilder().append(tableName)
				.append(".fdName, ").append(tableName).append(".fdId");

		if (SysAuthAreaUtils.isAreaEnabled(modelName)) {
			selectBlock.append(", ").append(tableName).append(".").append(
					ISysAuthConstant.AREA_FIELD_NAME).append(".").append(
							"fdHierarchyId");
		}

		String langFieldName = SysLangUtil.getLangFieldName(modelName,
				"fdName");
		String selectBlock_lang = "";

		if (StringUtil.isNotNull(langFieldName)) {
			selectBlock_lang = ", " + tableName + "."
					+ langFieldName;
		}
		selectBlock.append(selectBlock_lang);

		hqlInfo.setSelectBlock(selectBlock.toString());
		hqlInfo.setJoinBlock("left join " + tableName + ".authUses readers");
		String keyword = xmlContext.getParameter("keyword");
		if (StringUtil.isNotNull(keyword)) {
			hqlInfo.setWhereBlock(tableName + ".fdName like:searchText");

			hqlInfo.setParameter("searchText", "%" + keyword + "%");
		} else if (StringUtil.isNull(categoryId)) {
			hqlInfo.setWhereBlock(tableName + ".hbmParent is null");
		} else {
			hqlInfo.setWhereBlock(tableName + ".hbmParent.fdId=:categoryId");
			hqlInfo.setParameter("categoryId", categoryId);
		}
		String whereBlock = hqlInfo.getWhereBlock();
		if (!UserUtil.getKMSSUser().isAdmin()) {
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					"((readers.fdId in (:orgIds) or readers.fdId is null) and (" + tableName + ".authNotUseFlag=0 or "
							+ tableName + ".authNotUseFlag is null))");
			hqlInfo.setParameter("orgIds", UserUtil.getKMSSUser().getUserAuthInfo().getAuthOrgIds());
		}
		hqlInfo.setWhereBlock(whereBlock);
		hqlInfo.setOrderBy(tableName + ".fdOrder, " + tableName + ".fdId");
		String extProps = xmlContext.getParameter("extProps");
		if (StringUtil.isNotNull(extProps) && !"undefined".equals(extProps)) {
			buildHqlByTemplateType(extProps, hqlInfo, tableName);
		}
		List<Object[]> list = service.findValue(hqlInfo);
		if (list != null && StringUtil.isNotNull(langFieldName)) {
			for (Object[] o : list) {
				int pos = 2;
				if (SysAuthAreaUtils.isAreaEnabled(modelName)) {
					pos++;
				}
				String text = (String) o[pos];
				if (StringUtil.isNotNull(text)) {
					o[0] = text;
				}
			}
		}
		return list;
	}

	/**
	 * 根据模板类型构建类别查询hql对象
	 * 
	 * @param fdTemplateType
	 * @param hqlInfo
	 */
	public void buildHqlByTemplateType(String extProps, HQLInfo hqlInfo,
			String tableName) {
		String[] params = extProps.split(";");
		String __whereBlock = "";
		for (String s : params) {
			String[] val = s.split(":");
			if (val == null || val.length < 2) {
				continue;
			}
			String param = "kmss_ext_props_" + HQLUtil.getFieldIndex();
			__whereBlock = StringUtil.linkString(__whereBlock, " or ",
					tableName + "." + val[0] + "=:" + param);
			hqlInfo.setParameter(param, val[1]);
		}
		hqlInfo.setWhereBlock(StringUtil.linkString(hqlInfo.getWhereBlock(),
				" and ", "(" + __whereBlock + ")"));
	}

	private List findEditorIds(IBaseService service, String categoryId,
			String modelName, String tableName) throws Exception {
		String hql = "select " + tableName + ".fdId from " + modelName + " "
				+ tableName + " inner join " + tableName
				+ ".authAllEditors editors where ";
		if (StringUtil.isNull(categoryId)) {
			hql += tableName + ".hbmParent is null";
		} else {
			hql += tableName + ".hbmParent.fdId=:categoryId";
		}
		hql += " and editors.fdId in (:orgIds)";
		AreaIsolation isolationType = SysAuthAreaUtils
				.getAreaIsolation(ISysAuthConstant.ISOLATION_SCENE_CATEGORY);
		Query query = SysAuthAreaHelper.queryWithArea(service, hql, modelName,
				tableName, isolationType);
		if (StringUtil.isNotNull(categoryId)) {
			query.setParameter("categoryId", categoryId);
		}
		query.setParameterList("orgIds", UserUtil.getKMSSUser()
				.getUserAuthInfo().getAuthOrgIds());
		return query.list();
	}

	private List findReaderIds(IBaseService service, String categoryId,
			String modelName, String tableName) throws Exception {
		String hql = "select " + tableName + ".fdId from " + modelName + " "
				+ tableName + " left join " + tableName
				+ ".authUses readers where ";
		if (StringUtil.isNull(categoryId)) {
			hql += tableName + ".hbmParent is null";
		} else {
			hql += tableName + ".hbmParent.fdId=:categoryId";
		}
		hql += " and ((readers.fdId in (:orgIds) or readers.fdId is null) and ("
				+ tableName + ".authNotUseFlag=0 or " + tableName
				+ ".authNotUseFlag is null))";
		AreaIsolation isolationType = SysAuthAreaUtils
				.getAreaIsolation(ISysAuthConstant.ISOLATION_SCENE_CATEGORY);
		Query query = SysAuthAreaHelper.queryWithArea(service, hql, modelName,
				tableName, isolationType);
		if (StringUtil.isNotNull(categoryId)) {
			query.setParameter("categoryId", categoryId);
		}
		query.setParameterList("orgIds", UserUtil.getKMSSUser()
				.getUserAuthInfo().getAuthOrgIds());
		return query.list();
	}

	/********* 获取子分类 ****/
	private List findAll(IBaseService service,
			List<String> parentIds, String modelName, String tableName,
			RequestContext request) throws Exception {
		HQLInfo hqlInfo = new HQLInfo();
		// 过滤场所数据
		if (ISysAuthConstant.IS_AREA_ENABLED
				&& ISysAuthConstant.IS_ISOLATION_ENABLED) {
			hqlInfo.setCheckParam(SysAuthConstant.CheckType.AreaCheck,
					SysAuthConstant.AreaCheck.YES);
			hqlInfo.setCheckParam(SysAuthConstant.CheckType.AreaIsolation,
					ISysAuthConstant.ISOLATION_SCENE_CATEGORY);
		}

		StringBuilder selectBlock = new StringBuilder().append(tableName)
				.append(".fdId, ")
				.append(tableName).append(" .hbmParent.fdId");

		if (SysAuthAreaUtils.isAreaEnabled(modelName)) {
			selectBlock.append(", ").append(tableName).append(".").append(
					ISysAuthConstant.AREA_FIELD_NAME).append(".").append(
							"fdHierarchyId");
		}

		hqlInfo.setSelectBlock(selectBlock.toString());
		hqlInfo.setJoinBlock("left join " + tableName + ".authUses readers");
		if (ArrayUtil.isEmpty(parentIds)) {
			hqlInfo.setWhereBlock(tableName + ".hbmParent is null");
		} else {
			hqlInfo.setWhereBlock(
					tableName + ".hbmParent.fdId in(:categoryIds)");
			hqlInfo.setParameter("categoryIds", parentIds);
		}
		String whereBlock = hqlInfo.getWhereBlock();
		whereBlock = StringUtil.linkString(whereBlock, " and ",
				"((readers.fdId in (:orgIds) or readers.fdId is null) and ("
						+ tableName + ".authNotUseFlag=0 or " + tableName
						+ ".authNotUseFlag is null))");
		hqlInfo.setWhereBlock(whereBlock);
		hqlInfo.setParameter("orgIds",
				UserUtil.getKMSSUser().getUserAuthInfo().getAuthOrgIds());
		hqlInfo.setOrderBy(tableName + ".fdOrder, " + tableName + ".fdId");
		String extProps = request.getParameter("extProps");
		if (StringUtil.isNotNull(extProps) && !"undefined".equals(extProps)) {
			buildHqlByTemplateType(extProps, hqlInfo, tableName);
		}
		return service.findValue(hqlInfo);

		// HashMap<String, List<String[]>> rtnMap = new HashMap<String,
		// List<String[]>>();
		// for(Object obj : list) {
		// Object[] info = (Object[])obj;
		// String id = (String)info[0];
		// String parentId = (String)info[1];
		// List<String> tmpChildren = rtnMap.get(parentId);
		// if(tmpChildren == null) {
		// tmpChildren = new ArrayList<String>();
		// rtnMap.put(parentId, tmpChildren);
		// }
		// tmpChildren.add(id);
		// }
		//
		// return rtnMap;
	}

	private List findEditorIds(IBaseService service, List<String> parentIds,
			String modelName, String tableName) throws Exception {
		String hql = "select " + tableName + ".fdId from " + modelName + " "
				+ tableName + " inner join " + tableName
				+ ".authAllEditors editors where ";
		if (ArrayUtil.isEmpty(parentIds)) {
			hql += tableName + ".hbmParent is null";
		} else {
			hql += tableName + ".hbmParent.fdId in(:categoryIds)";
		}
		hql += " and editors.fdId in (:orgIds)";
		AreaIsolation isolationType = SysAuthAreaUtils
				.getAreaIsolation(ISysAuthConstant.ISOLATION_SCENE_CATEGORY);
		Query query = SysAuthAreaHelper.queryWithArea(service, hql, modelName,
				tableName, isolationType);
		if (!ArrayUtil.isEmpty(parentIds)) {
			query.setParameterList("categoryIds", parentIds);
		}
		query.setParameterList("orgIds", UserUtil.getKMSSUser()
				.getUserAuthInfo().getAuthOrgIds());
		return query.list();
	}

	private List findReaderIds(IBaseService service, List<String> parentIds,
			String modelName, String tableName) throws Exception {
		String hql = "select " + tableName + ".fdId from " + modelName + " "
				+ tableName + " left join " + tableName
				+ ".authUses readers where ";
		if (ArrayUtil.isEmpty(parentIds)) {
			hql += tableName + ".hbmParent is null";
		} else {
			hql += tableName + ".hbmParent.fdId in (:categoryIds)";
		}
		hql += " and ((readers.fdId in (:orgIds) or readers.fdId is null) and ("
				+ tableName + ".authNotUseFlag=0 or " + tableName
				+ ".authNotUseFlag is null))";
		AreaIsolation isolationType = SysAuthAreaUtils
				.getAreaIsolation(ISysAuthConstant.ISOLATION_SCENE_CATEGORY);
		Query query = SysAuthAreaHelper.queryWithArea(service, hql, modelName,
				tableName, isolationType);
		if (!ArrayUtil.isEmpty(parentIds)) {
			query.setParameterList("categoryIds", parentIds);
		}
		query.setParameterList("orgIds", UserUtil.getKMSSUser()
				.getUserAuthInfo().getAuthOrgIds());
		return query.list();
	}

	private void loadChildren(List<String> parentIds,
			List<Map<String, Object>> parentList,
			RequestContext request,
			int showType, IBaseService service, String modelName,
			String tableName) throws Exception {
		List categories = findAll(service, parentIds, modelName, tableName,
				request);
		List categoryEditList = null;
		List categoryReadList = null;
		switch (showType) {
		case SHOW_READ:
			categoryReadList = findReaderIds(service, parentIds, modelName,
					tableName);
			categoryEditList = findEditorIds(service, parentIds, modelName,
					tableName);
			break;
		case SHOW_EDIT:
			categoryEditList = findEditorIds(service, parentIds, modelName,
					tableName);
			break;
		}
		String pAdmin = request.getParameter("pAdmin");
		HashMap<String, Map> nodesMap = new HashMap<String, Map>();
		for (int i = 0; i < parentList.size(); i++) {
			Map m = parentList.get(i);
			nodesMap.put((String) m.get("value"), m);
		}
		for (int i = 0; i < categories.size(); i++) {
			Object[] info = (Object[]) categories.get(i);
			String id = (String) info[0];
			boolean showValue = true;
			if (showType != SHOW_ALL) {
				showValue = "1".equals(pAdmin) || categoryEditList.contains(id);
				if (!showValue) {
					if (ISysAuthConstant.IS_AREA_ENABLED && info.length > 2
							&& info[2] != null) {
						String areaHierarchyId = (String) info[2];
						showValue = SimpleCategoryUtil.isAreaAdmin(modelName,
								areaHierarchyId);
					} else {
						showValue = SimpleCategoryUtil.isAdmin(modelName);
					}
				}
			}
			if (showType == SHOW_READ && !showValue) {
				showValue = categoryReadList.contains(id);
			}

			HashMap<String, Object> node = new HashMap<String, Object>();
			if (!showValue) {
				node.put("isShowCheckBox", "0");
			}
			node.put("value", id);
			node.put("nodeType", "CATEGORY");

			String parentId = (String) info[1];
			Map parentMap = nodesMap.get(parentId);
			if (parentMap != null) {
				Object children = parentMap.get("child");
				if (children == null) {
					children = new ArrayList<Map>();
					parentMap.put("child", children);
				}
				((List) children).add(node);
			}
		}
	}

	/** 获取子分类结束 **/
}
