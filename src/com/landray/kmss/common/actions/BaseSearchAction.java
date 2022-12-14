package com.landray.kmss.common.actions;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.BooleanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;

import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.constant.SysAuthConstant.AuthCheck;
import com.landray.kmss.constant.SysAuthConstant.CheckType;
import com.landray.kmss.sys.config.design.SysCfgSearch;
import com.landray.kmss.sys.config.design.SysConfigs;
import com.landray.kmss.sys.config.dict.SysDataDict;
import com.landray.kmss.sys.config.dict.SysDictModel;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.log.util.oper.UserOperContentHelper;
import com.landray.kmss.sys.search.SearchHQLUtil;
import com.landray.kmss.sys.search.model.SysSearchMain;
import com.landray.kmss.sys.search.service.ISysSearchMainService;
import com.landray.kmss.sys.search.web.SearchCondition;
import com.landray.kmss.sys.search.web.SearchOrderBy;
import com.landray.kmss.sys.search.web.SearchResult;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.excel.ExcelOutput;
import com.landray.kmss.util.excel.ExcelOutputImp;
import com.landray.kmss.util.excel.WorkBook;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

public abstract class BaseSearchAction extends BaseAction {
	private Log logger = LogFactory.getLog(BaseSearchAction.class);

	private ISysSearchMainService searchMainService;

	protected ISysSearchMainService getSysSearchMainService() {
		if (searchMainService == null)
			searchMainService = (ISysSearchMainService) getBean("sysSearchMainService");
		return searchMainService;
	}

	/**
	 * ????????????CRUD???????????????service???
	 * 
	 * @return Action?????????CRUD?????????service
	 */
	protected abstract IBaseService getServiceImp(HttpServletRequest request);

	protected String getSearchPageWhereBlock(HttpServletRequest request)
			throws Exception {
		return null;
	}

	protected String getSearchPageOrderBy(HttpServletRequest request,
			String curOrderBy) throws Exception {
		/*
		 * ??????????????????getSearchModel(request) != null????????????????????????????????? ?????? 2007???5???28???
		 */
		if (getSearchModel(request) == null && curOrderBy == null) {
			String className = getServiceImp(request).getModelName();
			if (StringUtil.isNull(className))
				return null;
			SysDictModel model = SysDataDict.getInstance().getModel(className);
			if (model == null)
				return null;
			String modelName = ModelUtil.getModelTableName(className);
			Map propertyMap = model.getPropertyMap();
			logger.debug("modelNme=" + modelName);
			/*
			 * ??????fdOrder?????????????????????fdOrder???fdName??????????????????????????? ??????????????????fdId??????????????????????????????
			 */
			curOrderBy = "";
			if (propertyMap.get("fdOrder") != null) {
				curOrderBy += modelName + ".fdOrder";
				if (propertyMap.get("fdName") != null)
					curOrderBy += "," + modelName + ".fdName";
			} else if (propertyMap.get("fdId") != null)
				curOrderBy += modelName + ".fdId desc";
			logger.debug("curOrderBy=" + curOrderBy);
		}
		return curOrderBy;
	}

	protected void changeSearchPageHQLInfo(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		hqlInfo.setWhereBlock(getSearchPageWhereBlock(request));
		hqlInfo.setOrderBy(getSearchPageOrderBy(request, hqlInfo.getOrderBy()));
	}

	protected SysSearchMain getSearchModel(HttpServletRequest request)
			throws Exception {
		String searchId = request.getParameter("searchId");
		if (StringUtil.isNull(searchId))
			return null;
		return (SysSearchMain) getSysSearchMainService().findByPrimaryKey(
				searchId);
	}

	protected SearchCondition getSearchCondition(HttpServletRequest request,
			SysCfgSearch cfgSearch, SysSearchMain searchModel) throws Exception {
		return new SearchCondition(cfgSearch, request.getLocale(), searchModel);
	}

	protected SearchOrderBy getSearchOrderBy(HttpServletRequest request,
			SysCfgSearch cfgSearch, SysSearchMain searchModel) throws Exception {
		return new SearchOrderBy(searchModel, cfgSearch, request.getLocale());
	}

	protected SearchResult getSearchResult(HttpServletRequest request,
			SysCfgSearch cfgSearch, SysSearchMain searchModel) throws Exception {
		return new SearchResult(searchModel, cfgSearch, request.getLocale());
	}

	protected ActionForward getActionForward(String defaultForward,
			ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		String para = request.getParameter("forward");
		if (!StringUtil.isNull(para))
			defaultForward = para;
		return mapping.findForward(defaultForward);
	}

	public ActionForward condition(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		KmssMessages messages = new KmssMessages();
		try {
			IBaseService baseService = getServiceImp(request);
			SysCfgSearch cfgSearch = SysConfigs.getInstance().getSearch(
					baseService.getModelName());
			if (cfgSearch == null)
				throw new UnexpectedRequestException();
			
			request.setAttribute("searchConditionInfo", getSearchCondition(
					request, cfgSearch, getSearchModel(request)));

		} catch (Exception e) {
			messages.addError(e);
		}
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("searchCondition", mapping, form, request,
					response);
		}
	}

	/**
	 * ?????????????????????<br>
	 * ??????????????????HTTP???GET???????????????
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ?????????????????????search?????????????????????failure??????
	 * @throws Exception
	 */
	public ActionForward result(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		long starTime = System.currentTimeMillis();
		TimeCounter.logCurrentTime("Action-search", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			String s_pageno = request.getParameter("pageno");
			String s_rowsize = request.getParameter("rowsize");
			String orderby = request.getParameter("orderby");
			String ordertype = request.getParameter("ordertype");
			boolean isReserve = false;
			if (ordertype != null && ordertype.equalsIgnoreCase("down")) {
				isReserve = true;
			}
			int pageno = 0;
			int rowsize = 0;
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
			if (logger.isDebugEnabled()) {
				logger.debug("from request, Order By=" + hqlInfo.getOrderBy());
			}
			hqlInfo.setPageNo(pageno);
			hqlInfo.setRowSize(rowsize);
			changeSearchPageHQLInfo(request, hqlInfo);
			if (logger.isDebugEnabled()) {
				logger.debug("after call changeSearchPageHQLInfo(), Order By="
						+ hqlInfo.getOrderBy());
			}

			IBaseService baseService = getServiceImp(request);
			String modelName = baseService.getModelName();
			SysCfgSearch cfgSearch = SysConfigs.getInstance().getSearch(
			        modelName);
			
			if (cfgSearch == null)
				throw new UnexpectedRequestException();

			SysSearchMain searchModel = getSearchModel(request);
			if (logger.isDebugEnabled()) {
				/*
				 * ???????????????searchModel != null ???????????????resultUrl?????????
				 */
				logger.debug("searchModel=" + searchModel);
				logger.debug("cfgSearch.getResultUrl()=["
						+ cfgSearch.getResultUrl() + "]");
			}
			if (searchModel != null
					|| StringUtil.isNull(cfgSearch.getResultUrl())) {
				request.setAttribute("searchResultInfo", getSearchResult(
						request, cfgSearch, searchModel));
			}
			SearchHQLUtil.buildHQLInfo(baseService,
					new RequestContext(request), hqlInfo, getSearchCondition(
							request, cfgSearch, searchModel));
			SearchHQLUtil.buildHQLOrderBy(baseService, new RequestContext(
					request), hqlInfo, getSearchOrderBy(request, cfgSearch,
					searchModel));
			if (logger.isDebugEnabled()) {
				logger.debug("before findPage(), Order By="
						+ hqlInfo.getOrderBy());
			}
			// ??????????????????????????????
			if (searchModel != null
					&& BooleanUtils.isFalse(searchModel.getFdAuthEnabled())) {
				// ??????????????????
				hqlInfo.setCheckParam(CheckType.AuthCheck, AuthCheck.SYS_NONE);
			}
			Page page = baseService.findPage(hqlInfo);
			List list = page.getList();
			UserOperHelper.setModelNameAndModelDesc(modelName);
			UserOperContentHelper.putFinds(list);
			request.setAttribute("queryPage", page);

			String queryString = request.getQueryString();
			queryString = queryString.replaceAll("method=result",
					"method=exportResult");
			String exportURL = request.getRequestURI() + "?" + queryString;
			request.setAttribute("exportURL", exportURL);
		} catch (Exception e) {
			messages.addError(e);
		}
		long endTime = System.currentTimeMillis();
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(endTime - starTime);
		// m???????????????s?????????
		long m = c.get(c.MILLISECOND);
		Double s = (double) m / 1000;
		request.setAttribute("c", s);
		TimeCounter.logCurrentTime("Action-search", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("searchResult", mapping, form, request,
					response);
		}
	}

	public ActionForward exportResult(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		KmssMessages messages = new KmssMessages();
		try {
			String orderby = request.getParameter("orderby");
			String ordertype = request.getParameter("ordertype");
			boolean isReserve = false;
			if (ordertype != null && ordertype.equalsIgnoreCase("down")) {
				isReserve = true;
			}
			if (isReserve)
				orderby += " desc";
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setOrderBy(orderby);
			hqlInfo.setAuthCheckType(HQLInfo.AUTH_CHECK_READER);
			changeSearchPageHQLInfo(request, hqlInfo);

			IBaseService baseService = getServiceImp(request);
			String modelName = baseService.getModelName();
			SysCfgSearch cfgSearch = SysConfigs.getInstance().getSearch(modelName);
			if (cfgSearch == null)
				throw new UnexpectedRequestException();

			SysSearchMain searchModel = getSearchModel(request);
			SearchHQLUtil.buildHQLInfo(baseService,
					new RequestContext(request), hqlInfo, getSearchCondition(
							request, cfgSearch, searchModel));
			SearchHQLUtil.buildHQLOrderBy(baseService, new RequestContext(
					request), hqlInfo, getSearchOrderBy(request, cfgSearch,
					searchModel));
			// ????????????
			String s_rowsize = request.getParameter("fdNum");
			// ??????????????????
			String s_rowsizeStart = request.getParameter("fdNumStart");
			// ??????????????????
			String s_rowsizeEnd = request.getParameter("fdNumEnd");
			//???????????????
			String s_checkIdValues = request.getParameter("checkIdValues");
			String [] arrIds =null;
			if (StringUtil.isNotNull(s_checkIdValues)){
				arrIds = s_checkIdValues.split("[;\\|]");
			}
			
			// ??????????????????????????????
			if (searchModel != null
					&& BooleanUtils.isFalse(searchModel.getFdAuthEnabled())) {
				// ??????????????????
				hqlInfo.setCheckParam(CheckType.AuthCheck, AuthCheck.SYS_NONE);
			}

			// ?????????????????????
			List exportList = null;
			
			// ??????????????????3?????????
			// 1.????????????????????????
			// 2.?????????????????????
			// 3.????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
			if (arrIds != null && arrIds.length > 0) { // ??????????????????????????????????????????????????????????????????
				exportList = baseService.findByPrimaryKeys(arrIds);
			} else if (StringUtil.isNotNull(s_rowsizeStart)
					&& StringUtil.isNotNull(s_rowsizeEnd)) { //?????????????????????
				int rowsizeStart = Integer.parseInt(s_rowsizeStart) - 1;
				int rowsizeEnd = Integer.parseInt(s_rowsizeEnd);
				if (rowsizeEnd < rowsizeStart) {
					throw new Exception("????????????????????????????????????????????????????????????");
				}
				int max = rowsizeEnd - rowsizeStart;
				if (max > 5000) {
					logger.warn("?????????????????????5000????????????????????????????????????????????????????????????5000");
					max = 5000;
				}
				
				hqlInfo.setModelName(baseService.getModelName());
				Query query = getSysSearchMainService().createHbmQuery(hqlInfo);
				query.setFirstResult(rowsizeStart);
				query.setMaxResults(max);
				exportList = query.list();
			} else { //????????????
				int rowsize = Integer.parseInt(s_rowsize);
				// ?????????????????????????????????????????????5000????????????????????????5000
				if (rowsize > 5000)
					rowsize = 5000;
				hqlInfo.setRowSize(rowsize);
				exportList = baseService.findPage(hqlInfo).getList();
			}
			
			ExcelOutput output = new ExcelOutputImp();
            UserOperHelper.setModelNameAndModelDesc(modelName);
            UserOperContentHelper.putFinds(exportList);
			String userAgent = request.getHeader("User-Agent");
			if (userAgent.contains("Edge")) {// #89015 edge??????????????????????????????
				ExcelOutputImp excelOutput = (ExcelOutputImp) output;
				excelOutput.output(getExportWorkBook(form, request, exportList),
						request, response);
			} else {
				output.output(getExportWorkBook(form, request, exportList),
						response);
			}

			return null;
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-search", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("searchResult", mapping, form, request,
					response);
		}
	}

	protected WorkBook getExportWorkBook(ActionForm form,
			HttpServletRequest request, List modelList) throws Exception {
		return getSysSearchMainService().buildWorkBook(null,
				new RequestContext(request), modelList);
	}
}
