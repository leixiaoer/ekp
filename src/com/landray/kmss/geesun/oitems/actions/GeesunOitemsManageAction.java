
package com.landray.kmss.geesun.oitems.actions;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.constant.SysAuthConstant.AreaIsolation;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsManageForm;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsManageService;
import com.landray.kmss.geesun.oitems.service.spring.GeesunOitemsManageMobileTreeService;
import com.landray.kmss.sys.authorization.constant.ISysAuthConstant;
import com.landray.kmss.sys.authorization.interfaces.SysAuthAreaUtils;
import com.landray.kmss.sys.authorization.util.SysAuthAreaHelper;
import com.landray.kmss.sys.category.interfaces.ConfigUtil;
import com.landray.kmss.sys.config.dict.SysDataDict;
import com.landray.kmss.sys.config.dict.SysDictModel;
import com.landray.kmss.sys.simplecategory.actions.SysSimpleCategoryAction;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

import net.sf.json.JSONArray;


/**
 * 创建日期 2010-二月-26
 * @author 陈伟
 */
public class GeesunOitemsManageAction extends SysSimpleCategoryAction

{
	protected IGeesunOitemsManageService geesunOitemsManageService;

	protected IBaseService getServiceImp(HttpServletRequest request) {
		if(geesunOitemsManageService == null)
			geesunOitemsManageService = (IGeesunOitemsManageService)getBean("geesunOitemsManageService");
		return geesunOitemsManageService;
	}
	
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GeesunOitemsManageForm geesunOitemsManageForm = (GeesunOitemsManageForm)super.createNewForm(mapping, form, request, response);
		geesunOitemsManageForm.setDocCreatorId(UserUtil.getUser().getFdId().toString());
		geesunOitemsManageForm.setDocCreatorName(UserUtil.getUser().getFdName());
		geesunOitemsManageForm.setDocCreateTime(DateUtil.convertDateToString(
				new Date(), DateUtil.TYPE_DATETIME, request.getLocale()));
		return geesunOitemsManageForm;
	}
	
	protected String getFindPageOrderBy(HttpServletRequest request,
			String curOrderBy) throws Exception {
		if(StringUtil.isNull(curOrderBy)){
			curOrderBy  = "geesunOitemsManage.fdOrder";
		}
		return curOrderBy;
	}

	/**
	 * 新建和类别筛选时使用， 新建时，需要机型权限校验 导航时，根据全局分类权限配置决定是否需要权限校验
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward cateList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		KmssMessages messages = new KmssMessages();
		try {
			String authCateIds = request.getParameter("authCateIds");
			String authType = request.getParameter("authType");
			String modelName = request.getParameter("modelName");
			RequestContext req = new RequestContext();
			// 通过语句new RequestContext(request)构建的rq对象，不能修改parameter参数，故改用现用模式
			HashMap paraMap = new HashMap(request.getParameterMap());
			boolean readAll = "00".equals(authType);
			if ("03".equals(authType)) {// 权限由配置决定时的处理
				if (ConfigUtil.auth(modelName)) {
					paraMap.put("authType", new String[] { "02" });
				} else {
					paraMap.put("authType", new String[] { "00" });
					readAll = true;
				}
			}
			req.setParameterMap(paraMap);
			// 移动端需要，获取子分类做显示箭头用
			req.setParameter("isLoadChildren", "1");
			GeesunOitemsManageMobileTreeService geesunOitemsManageMobileTreeService = (GeesunOitemsManageMobileTreeService) SpringBeanUtil
					.getBean("geesunOitemsManageMobileTreeService");
			List<Map<String, Object>> cates = (List<Map<String, Object>>) geesunOitemsManageMobileTreeService
					.getDataList(req);
			if (!readAll) {
				List<String> authIds = new ArrayList<String>();
				if (StringUtil.isNotNull(authCateIds)) {
					authIds = ArrayUtil.convertArrayToList(authCateIds
							.split(";"));
				}
				List<Map<String, Object>> tmpCates = new ArrayList<Map<String, Object>>();
				for (int i = 0; i < cates.size(); i++) {
					Map<String, Object> tmpMap = (Map<String, Object>) cates
							.get(i);
					Boolean isShow = true;
					if ("0".equals(tmpMap.get("isShowCheckBox"))) {// 非可用分类信息，需要在authIds中包含或者存在可用的下级分类
						if ((!authIds.isEmpty()
								&& authIds.contains(tmpMap.get("value")))
								|| findAuthByCateId(
										(String) tmpMap.get("value"), modelName)
												.size() > 0) {
							System.out.println(findAuthByCateId(
									(String) tmpMap.get("value"), modelName));
							tmpCates.add(tmpMap);
						} else {
							isShow = false;
						}
						continue;
					} else {// 可用分类信息
						tmpCates.add(tmpMap);
					}
					if (isShow) {
						List children = (List) tmpMap.get("child");
						if (!ArrayUtil.isEmpty(children)) {
							Iterator itr = children.iterator();
							while (itr.hasNext()) {
								Map cmap = (Map) itr.next();
								if ("0".equals(cmap.get("isShowCheckBox"))) {
									if (!(!authIds.isEmpty()
											&& authIds.contains(
													cmap.get("value")))) {
										itr.remove();
									}
								}
							}
						}
					}
				}
				authIds.clear();
				authIds = null;
				cates = tmpCates;
			}
			request.setAttribute("lui-source",
					JSONArray.fromObject(cates).toString());
		} catch (Exception e) {
			messages.addError(e);
		}
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return mapping.findForward("failure");
		} else {
			return mapping.findForward("lui-source");
		}
	}

	/* 查找可用的下级分类 */
	public List findAuthByCateId(String cateId, String modelName)
			throws Exception {
		List cateList = new ArrayList();
		SysDictModel dict = SysDataDict.getInstance().getModel(modelName);
		IBaseService service = (IBaseService) SpringBeanUtil
				.getBean(dict.getServiceBean());
		String tableName = ModelUtil.getModelTableName(modelName);

		String hql = "select " + tableName + ".fdId from " + modelName + " "
				+ tableName + " left join " + tableName
				+ ".authUses readers where ";
		hql += tableName + ".hbmParent.fdId=:categoryId";
		hql += " and ((readers.fdId in (:orgIds) or readers.fdId is null) and ("
				+ tableName + ".authNotUseFlag=0 or " + tableName
				+ ".authNotUseFlag is null))";
		AreaIsolation isolationType = SysAuthAreaUtils
				.getAreaIsolation(ISysAuthConstant.ISOLATION_SCENE_CATEGORY);
		Query query = SysAuthAreaHelper.queryWithArea(service, hql, modelName,
				tableName, isolationType);
		query.setParameter("categoryId", cateId);
		query.setParameterList("orgIds",
				UserUtil.getKMSSUser().getUserAuthInfo().getAuthOrgIds());
		cateList = query.list();
		return cateList;
	}
}

