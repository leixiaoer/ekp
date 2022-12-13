package com.landray.kmss.geesun.oitems.actions;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.springframework.dao.DataIntegrityViolationException;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.NoRecordException;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.ICoreOuterService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.constant.SysAuthConstant.AllCheck;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsListingForm;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsWarehousingRecordForm;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsWarehousingRecordJoinListForm;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsManage;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReceiveContext;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecord;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsBudgerApplicationService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsListingService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsManageService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordJoinListService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordService;
import com.landray.kmss.geesun.oitems.util.UploadResultBean;
import com.landray.kmss.sys.authorization.constant.ISysAuthConstant;
import com.landray.kmss.sys.authorization.interfaces.SysAuthAreaUtils;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.language.utils.SysLangUtil;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.log.util.oper.UserOperContentHelper;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.KmssMessage;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.landray.kmss.web.upload.FormFile;
import com.sunbor.web.tag.Page;

import net.sf.json.JSONObject;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟
 */
public class GeesunOitemsListingAction extends ExtendAction

{
	protected IGeesunOitemsListingService geesunOitemsListingService;

	protected IGeesunOitemsListingService getServiceImp(HttpServletRequest request) {
		if (geesunOitemsListingService == null)
			geesunOitemsListingService = (IGeesunOitemsListingService) getBean("geesunOitemsListingService");
		return geesunOitemsListingService;
	}

	protected IGeesunOitemsManageService geesunOitemsManageService;

	public IGeesunOitemsManageService getGeesunOitemsManageService() {
		if (geesunOitemsManageService == null) {
			geesunOitemsManageService = (IGeesunOitemsManageService) getBean("geesunOitemsManageService");
		}
		return geesunOitemsManageService;
	}

	protected IGeesunOitemsWarehousingRecordService geesunOitemsWarehousingRecordService;
	protected IGeesunOitemsWarehousingRecordJoinListService geesunOitemsWarehousingRecordJoinListService;

	public IGeesunOitemsWarehousingRecordService getGeesunOitemsWarehousingRecordService() {
		if (geesunOitemsWarehousingRecordService == null) {
			geesunOitemsWarehousingRecordService = (IGeesunOitemsWarehousingRecordService) getBean("geesunOitemsWarehousingRecordService");
		}
		return geesunOitemsWarehousingRecordService;
	}

	public IGeesunOitemsWarehousingRecordJoinListService getGeesunOitemsWarehousingRecordJoinListService() {
		if (geesunOitemsWarehousingRecordJoinListService == null) {
			geesunOitemsWarehousingRecordJoinListService = (IGeesunOitemsWarehousingRecordJoinListService) getBean("geesunOitemsWarehousingRecordJoinListService");
		}
		return geesunOitemsWarehousingRecordJoinListService;
	}

	protected IGeesunOitemsBudgerApplicationService geesunOitemsBudgerApplicationService;

	public IGeesunOitemsBudgerApplicationService getGeesunOitemsBudgerApplicationService() {
		if (geesunOitemsBudgerApplicationService == null) {
			geesunOitemsBudgerApplicationService = (IGeesunOitemsBudgerApplicationService) getBean("geesunOitemsBudgerApplicationService");
		}
		return geesunOitemsBudgerApplicationService;
	}

	// 重写 save 方法 张文添 增加记录首次入库记录功能
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		GeesunOitemsListingForm geesunOitemsListingForm = (GeesunOitemsListingForm) form;
		GeesunOitemsWarehousingRecordForm geesunOitemsWarehousingRecordForm = new GeesunOitemsWarehousingRecordForm();
		GeesunOitemsWarehousingRecordJoinListForm geesunOitemsWarehousingRecordJoinListForm = new GeesunOitemsWarehousingRecordJoinListForm();
		geesunOitemsWarehousingRecordForm.setFdNumber(geesunOitemsListingForm
				.getFdAmount());
		geesunOitemsWarehousingRecordForm.setFdPrice(geesunOitemsListingForm
				.getFdReferencePrice());
		geesunOitemsWarehousingRecordForm.setFdListingId(geesunOitemsListingForm
				.getFdId());
		Integer fdAmount = Integer.parseInt(geesunOitemsListingForm.getFdAmount());
		Double fdReferencePrice = Double.parseDouble(geesunOitemsListingForm
				.getFdReferencePrice());
		geesunOitemsWarehousingRecordForm.setFdAccountPrice(String.valueOf(fdAmount
				* fdReferencePrice));

		geesunOitemsWarehousingRecordJoinListForm.setFdNumber(geesunOitemsListingForm
				.getFdAmount());
		geesunOitemsWarehousingRecordJoinListForm
				.setFdCurNumber(geesunOitemsListingForm.getFdAmount());
		geesunOitemsWarehousingRecordJoinListForm.setFdPrice(geesunOitemsListingForm
				.getFdReferencePrice());
		geesunOitemsWarehousingRecordJoinListForm
				.setFdListingId(geesunOitemsListingForm.getFdId());
		try {
			if (!request.getMethod().equals("POST"))
				throw new UnexpectedRequestException();
			getServiceImp(request).add((IExtendForm) form,
					new RequestContext(request));
			getGeesunOitemsWarehousingRecordService().add(geesunOitemsWarehousingRecordForm, new RequestContext(request));
			getGeesunOitemsWarehousingRecordJoinListService().add(
					geesunOitemsWarehousingRecordJoinListForm,
					new RequestContext(request));
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-save", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).save(
					request);
			return getActionForward("edit", mapping, form, request, response);
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("success", mapping, form, request, response);
		}
	}

	// 重写saveadd方法增加记录首次入库记录功能 张文添
	public ActionForward saveadd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-saveadd", true, getClass());
		KmssMessages messages = new KmssMessages();
		GeesunOitemsListingForm geesunOitemsListingForm = (GeesunOitemsListingForm) form;
		GeesunOitemsWarehousingRecordForm geesunOitemsWarehousingRecordForm = new GeesunOitemsWarehousingRecordForm();
		GeesunOitemsWarehousingRecordJoinListForm geesunOitemsWarehousingRecordJoinListForm = new GeesunOitemsWarehousingRecordJoinListForm();

		geesunOitemsWarehousingRecordForm.setFdNumber(geesunOitemsListingForm
				.getFdAmount());
		geesunOitemsWarehousingRecordForm.setFdPrice(geesunOitemsListingForm
				.getFdReferencePrice());
		geesunOitemsWarehousingRecordForm.setFdListingId(geesunOitemsListingForm
				.getFdId());
		Integer fdAmount = Integer.parseInt(geesunOitemsListingForm.getFdAmount());
		Double fdReferencePrice = Double.parseDouble(geesunOitemsListingForm
				.getFdReferencePrice());
		geesunOitemsWarehousingRecordForm.setFdAccountPrice(String.valueOf(fdAmount
				* fdReferencePrice));

		geesunOitemsWarehousingRecordJoinListForm.setFdNumber(geesunOitemsListingForm
				.getFdAmount());
		geesunOitemsWarehousingRecordJoinListForm
				.setFdCurNumber(geesunOitemsListingForm.getFdAmount());
		geesunOitemsWarehousingRecordJoinListForm.setFdPrice(geesunOitemsListingForm
				.getFdReferencePrice());
		geesunOitemsWarehousingRecordJoinListForm
				.setFdListingId(geesunOitemsListingForm.getFdId());
		try {
			if (!request.getMethod().equals("POST"))
				throw new UnexpectedRequestException();
			getServiceImp(request).add((IExtendForm) form,
					new RequestContext(request));
			getGeesunOitemsWarehousingRecordService().add(
					geesunOitemsWarehousingRecordForm, new RequestContext(request));
			getGeesunOitemsWarehousingRecordJoinListService().add(
					geesunOitemsWarehousingRecordJoinListForm,
					new RequestContext(request));
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-saveadd", false, getClass());
		KmssReturnPage.getInstance(request).addMessages(messages).save(request);
		if (messages.hasError())
			return getActionForward("edit", mapping, form, request, response);
		else
			return add(mapping, form, request, response);
	}
	
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-delete", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!request.getMethod().equals("GET"))
				throw new UnexpectedRequestException();
			String id = request.getParameter("fdId");
			if (StringUtil.isNull(id))
				messages.addError(new NoRecordException());
			else
				getServiceImp(request).delete(id);
		} catch (Exception e) {
			if (e instanceof DataIntegrityViolationException) {

				messages.addError(new KmssMessage(
						"geesun-oitems:geesunOitemsListing.dataIntegrityViolation.message")
						.setThrowable(e).setMessageType(
								KmssMessage.MESSAGE_ERROR));
			} else {
				messages.addError(e);
			}
		}

		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_CLOSE).save(request);
		TimeCounter.logCurrentTime("Action-delete", false, getClass());
		if (messages.hasError())
			return getActionForward("failure", mapping, form, request, response);
		else
			return getActionForward("success", mapping, form, request, response);
	}

	public ActionForward deleteall(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-deleteall", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!request.getMethod().equals("POST"))
				throw new UnexpectedRequestException();
			String[] ids = request.getParameterValues("List_Selected");

			if (ISysAuthConstant.IS_AREA_ENABLED) {
				String[] authIds = SysAuthAreaUtils.removeNoAuthIds(ids,
						request, "method=delete&fdId=${id}");
				int noAuthIdNum = ids.length - authIds.length;
				if (noAuthIdNum > 0) {
					messages.addMsg(new KmssMessage(
							"sys-authorization:area.batch.operation.info",
							noAuthIdNum));
				}

				if (!ArrayUtils.isEmpty(authIds))
					getServiceImp(request).delete(authIds);
			} else if (ids != null) {
				getServiceImp(request).delete(ids);
			}

		} catch (Exception e) {
			if (e instanceof DataIntegrityViolationException) {

				messages.addError(new KmssMessage(
						"geesun-oitems:geesunOitemsListing.dataIntegrityViolation.message")
						.setThrowable(e).setMessageType(
								KmssMessage.MESSAGE_ERROR));
			} else {
				messages.addError(e);
			}
		}

		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_RETURN).save(request);
		TimeCounter.logCurrentTime("Action-deleteall", false, getClass());
		if (messages.hasError())
			return getActionForward("failure", mapping, form, request, response);
		else
			return getActionForward("success", mapping, form, request, response);
	}
	

	private ICoreOuterService dispatchCoreService;
	protected ICoreOuterService getDispatchCoreService() {
		if (dispatchCoreService == null) {
			dispatchCoreService = (ICoreOuterService) getBean("dispatchCoreService");
		}
		return dispatchCoreService;
	}
	
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GeesunOitemsListingForm geesunOitemsListingForm = (GeesunOitemsListingForm) super
				.createNewForm(mapping, form, request, response);
		String fdCategoryId = request.getParameter("categoryId");
		if (StringUtil.isNotNull(fdCategoryId)) {
			GeesunOitemsManage geesunOitemsManage = (GeesunOitemsManage) getGeesunOitemsManageService()
					.findByPrimaryKey(fdCategoryId);
			geesunOitemsListingForm.setFdCategoryId(fdCategoryId);
			geesunOitemsListingForm
					.setFdCategoryName(getCategoryPathName(geesunOitemsManage));
		
		geesunOitemsListingForm.setDocCreatorId(UserUtil.getUser().getFdId()
				.toString());
		geesunOitemsListingForm.setDocCreatorName(UserUtil.getUser().getFdName());
		geesunOitemsListingForm.setDocCreateTime(DateUtil.convertDateToString(
				new Date(), DateUtil.TYPE_DATETIME, request.getLocale()));
		getDispatchCoreService().initFormSetting(geesunOitemsListingForm, "",
					geesunOitemsManage, "", new RequestContext(request));
		}
		return geesunOitemsListingForm;
	}

	/*
	 * (non-Javadoc)用品管理
	 */
	public ActionForward recordList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-list", true, getClass());
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
			if(StringUtil.isNull(ordertype)) {
				orderby = " geesunOitemsListing.fdNo desc ";
			}
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setAuthCheckType(SysAuthConstant.AUTH_CHECK_READER);
			hqlInfo.setOrderBy(orderby);
			hqlInfo.setPageNo(pageno);
			hqlInfo.setRowSize(rowsize);
			String whereBlock = getFindPageRecordWhereBlock(request, hqlInfo);
			hqlInfo.setWhereBlock(whereBlock);
			List rtnlist = getServiceImp(request).findList(hqlInfo);
			// 添加日志信息
			UserOperHelper.logFindAll(rtnlist,
					getServiceImp(request).getModelName());
			request.setAttribute("rtnList", rtnlist);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-list", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("recordListData", mapping, form, request,
					response);
		}
	}

	public ActionForward showRecordList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return getActionForward("recordList", mapping, form, request, response);
	}


	/**
	 * 入库统计
	 */
	public ActionForward inCount(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		if (StringUtil.isNull(fdStartTime)) {
			fdStartTime = DateUtil.convertDateToString(calendar.getTime(),
					DateUtil.TYPE_DATE, Locale.getDefault());

		}
		if (StringUtil.isNull(fdEndTime)) {
			fdEndTime = DateUtil.convertDateToString(nowDate,
					DateUtil.TYPE_DATE, Locale.getDefault());
		}
		String fdCategoryId = request.getParameter("fdCategoryId");
		String fdCategoryName = request.getParameter("fdCategoryName");
		request.setAttribute("fdStartTime", fdStartTime);
		request.setAttribute("fdEndTime", fdEndTime);
		request.setAttribute("fdCategoryId", fdCategoryId);
		request.setAttribute("fdCategoryName", fdCategoryName);
		// 查询入库记录
		LinkedHashMap geesunOitemsWarehousingRecordMap = getServiceImp(request).inCount(
				request);

		request.setAttribute("geesunOitemsWarehousingRecordMap",
				geesunOitemsWarehousingRecordMap);
		return getActionForward("inCount", mapping, form, request, response);
	}

	public ActionForward inCountData(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		if (StringUtil.isNull(fdStartTime)) {
			fdStartTime = DateUtil.convertDateToString(calendar.getTime(), DateUtil.TYPE_DATE, Locale.getDefault());

		}
		if (StringUtil.isNull(fdEndTime)) {
			fdEndTime = DateUtil.convertDateToString(nowDate, DateUtil.TYPE_DATE, Locale.getDefault());
		}
		String fdCategoryId = request.getParameter("fdCategoryId");
		String fdCategoryName = request.getParameter("fdCategoryName");
		request.setAttribute("fdStartTime", fdStartTime);
		request.setAttribute("fdEndTime", fdEndTime);
		request.setAttribute("fdCategoryId", fdCategoryId);
		request.setAttribute("fdCategoryName", fdCategoryName);
		// 查询入库记录
		LinkedHashMap geesunOitemsWarehousingRecordMap = getServiceImp(request).inCount(request);

		request.setAttribute("geesunOitemsWarehousingRecordMap", geesunOitemsWarehousingRecordMap);
		return getActionForward("inCountData", mapping, form, request, response);
	}

	public ActionForward showInCount(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return getActionForward("inCount", mapping, form, request, response);
	}
	/**
	 * 打开列表页面。<br>
	 * 该操作一般以HTTP的GET方式触发。
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return 执行成功，返回listChileren页面，否则返回failure页面
	 * @throws Exception
	 */
	public ActionForward listChileren(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-list", true, getClass());
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
			int rowsize = SysConfigParameters.getRowSize();
			if (s_pageno != null && s_pageno.length() > 0 && Integer.parseInt(s_pageno) > 0) {
				pageno = Integer.parseInt(s_pageno);
			}
			if (s_rowsize != null && s_rowsize.length() > 0 && Integer.parseInt(s_rowsize) > 0) {
				rowsize = Integer.parseInt(s_rowsize);
			}

			// 按多语言字段排序
			if (StringUtil.isNotNull(orderby) && form instanceof IExtendForm) {
				Class<?> modelClass = ((IExtendForm) form).getModelClass();
				if (modelClass != null) {
					String langFieldName = SysLangUtil
							.getLangFieldName(modelClass.getName(), orderby);
					if (StringUtil.isNotNull(langFieldName)) {
						orderby = langFieldName;
					}
				}
			}
			if (isReserve)
				orderby += " desc";
			if(StringUtil.isNull(ordertype)) {
				orderby = " geesunOitemsListing.fdNo desc ";
			}
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setOrderBy(orderby);
			hqlInfo.setPageNo(pageno);
			hqlInfo.setRowSize(rowsize);
			changeFindPageHQLInfo(request, hqlInfo);
			Page page = getServiceImp(request).findPage(hqlInfo);
			// 添加日志信息
			UserOperHelper.logFindAll(page.getList(),
					getServiceImp(request).getModelName());
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-list", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("listChileren", mapping, form, request, response);
		}
	}


	/**
	 * 入库统计导出
	 */
	public void inCountExport(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 查询入库记录
		LinkedHashMap geesunOitemsWarehousingRecordMap = getServiceImp(request).inCount(
				request);
		SimpleDateFormat format = new SimpleDateFormat(ResourceUtil
				.getString("date.format.date"));
		String title = ResourceUtil.getString("geesunOitemsListing.in.count",
				"geesun-oitems")
				+ format.format(new Date());
		getGeesunOitemsBudgerApplicationService().exportInCount(response,
				geesunOitemsWarehousingRecordMap, title);
	}

	/**
	 * 出库统计
	 */
	public ActionForward outCount(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		if (StringUtil.isNull(fdStartTime)) {
			fdStartTime = DateUtil.convertDateToString(calendar.getTime(),
					DateUtil.TYPE_DATE, Locale.getDefault());
		}
		if (StringUtil.isNull(fdEndTime)) {
			fdEndTime = DateUtil.convertDateToString(nowDate,
					DateUtil.TYPE_DATE, Locale.getDefault());
		}
		String fdCategoryId = request.getParameter("fdCategoryId");
		String fdCategoryName = request.getParameter("fdCategoryName");
		String fdDeptId = request.getParameter("fdDeptId");
		String fdDeptName = request.getParameter("fdDeptName");
		String fdRadioValue = request.getParameter("radio_id");
		request.setAttribute("fdStartTime", fdStartTime);
		request.setAttribute("fdEndTime", fdEndTime);
		request.setAttribute("fdCategoryId", fdCategoryId);
		request.setAttribute("fdCategoryName", fdCategoryName);
		request.setAttribute("fdDeptId", fdDeptId);
		request.setAttribute("fdDeptName", fdDeptName);
		request.setAttribute("fdRadioValue", fdRadioValue);
		LinkedHashMap geesunOitemsShoppingTrolley = getServiceImp(request).outCount(request);
		request
				.setAttribute("geesunOitemsShoppingTrolley",
						geesunOitemsShoppingTrolley);
		return getActionForward("outCount", mapping, form, request, response);
	}

	public ActionForward outCountData(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		if (StringUtil.isNull(fdStartTime)) {
			fdStartTime = DateUtil.convertDateToString(calendar.getTime(), DateUtil.TYPE_DATE, Locale.getDefault());
		}
		if (StringUtil.isNull(fdEndTime)) {
			fdEndTime = DateUtil.convertDateToString(nowDate, DateUtil.TYPE_DATE, Locale.getDefault());
		}
		String fdCategoryId = request.getParameter("fdCategoryId");
		String fdCategoryName = request.getParameter("fdCategoryName");
		String fdDeptId = request.getParameter("fdDeptId");
		String fdDeptName = request.getParameter("fdDeptName");
		String fdRadioValue = request.getParameter("radio_id");
		request.setAttribute("fdStartTime", fdStartTime);
		request.setAttribute("fdEndTime", fdEndTime);
		request.setAttribute("fdCategoryId", fdCategoryId);
		request.setAttribute("fdCategoryName", fdCategoryName);
		request.setAttribute("fdDeptId", fdDeptId);
		request.setAttribute("fdDeptName", fdDeptName);
		request.setAttribute("fdRadioValue", fdRadioValue);
		LinkedHashMap geesunOitemsShoppingTrolley = getServiceImp(request).outCount(request);
		request.setAttribute("geesunOitemsShoppingTrolley", geesunOitemsShoppingTrolley);
		return getActionForward("outCountData", mapping, form, request, response);
	}

	public ActionForward showOutCount(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return getActionForward("outCount", mapping, form, request, response);
	}
	

	/**
	 * 出库统计导出
	 */
	public void outCountExport(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 查询入库记录
		LinkedHashMap geesunOitemsShoppingTrolleyMap = getServiceImp(request).outCount(
				request);
		SimpleDateFormat format = new SimpleDateFormat(ResourceUtil
				.getString("date.format.date"));
		String title = ResourceUtil.getString("geesunOitemsListing.out.count",
				"geesun-oitems")
				+ format.format(new Date());
		getGeesunOitemsBudgerApplicationService().exportOutCount(response,
				geesunOitemsShoppingTrolleyMap, title);
	}

	public ActionForward showStockCount(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map geesunOitemsListingMap = new HashMap();
		request.setAttribute("geesunOitemsListingMap", geesunOitemsListingMap);
		return getActionForward("stockCount", mapping, form, request, response);
	}

	/**
	 * 库存统计
	 */
	public ActionForward stockCount(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String fdCategoryId = request.getParameter("fdCategoryId");
		String fdCategoryName = request.getParameter("fdCategoryName");
		String fdOitemsName = request.getParameter("fdOitemsName");
		String fdOitemsNumber = request.getParameter("fdOitemsNumber");

		request.setAttribute("fdCategoryId", fdCategoryId);
		request.setAttribute("fdCategoryName", fdCategoryName);
		request.setAttribute("fdOitemsName", fdOitemsName);
		request.setAttribute("fdOitemsNumber", fdOitemsNumber);
		List geesunOitemsListingList = new ArrayList();

		HQLInfo hqlInfo = new HQLInfo();
		String whereBlock = "";
		if (StringUtil.isNotNull(fdCategoryId)) {
			String[] fdCategoryIds = fdCategoryId.split(";");
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					buiidCateHql(fdCategoryIds,hqlInfo));
			// fdCategoryId = fdCategoryId.replace(";", "','");
			// hqlInfo.setWhereBlock("geesunOitemsListing.fdCategory.fdId in ('"
			// + fdCategoryId + "')");
		} else {
			HQLInfo hql = new HQLInfo();
			hql.setAuthCheckType(SysAuthConstant.AUTH_CHECK_READER);
			hql.setSelectBlock(" fdId ");
			List<String> list = getGeesunOitemsManageService().findList(hql);
			if (null != list && list.size() > 0) {
				String[] fdCategoryIds = (String[]) list.toArray(new String[list.size()]);
				whereBlock = StringUtil.linkString(whereBlock, " and ", buiidCateHql(fdCategoryIds, hqlInfo));
			} else {
				whereBlock = StringUtil.linkString(whereBlock, " and ", " 1=0 ");
			}
		}
		if (StringUtil.isNotNull(fdOitemsName)) {
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					"geesunOitemsListing.fdName like :fdOitemsName");
			hqlInfo.setParameter("fdOitemsName", "%" + fdOitemsName + "%");
		}
		if (StringUtil.isNotNull(fdOitemsNumber)) {
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					"LOWER(geesunOitemsListing.fdNo) like:fdOitemsNumber");
			hqlInfo.setParameter("fdOitemsNumber", "%" + fdOitemsNumber.trim().toLowerCase() + "%");
		}
		whereBlock = StringUtil
				.linkString(
						whereBlock,
						" and ",
						"(geesunOitemsListing.fdIsAbandon = :fdIsAbandon or geesunOitemsListing.fdIsAbandon is null)");
		hqlInfo.setParameter("fdIsAbandon", Boolean.TRUE);
		hqlInfo.setAuthCheckType(SysAuthConstant.AUTH_CHECK_READER);
		hqlInfo.setWhereBlock(whereBlock);
		hqlInfo.setOrderBy(" geesunOitemsListing.fdNo desc");
		geesunOitemsListingList = getServiceImp(request).findList(hqlInfo);
		// 添加日志信息
		UserOperHelper.logFindAll(geesunOitemsListingList,
				getServiceImp(request).getModelName());
		LinkedHashMap geesunOitemsListingMap = new LinkedHashMap();
		for (int i = 0; i < geesunOitemsListingList.size(); i++) {
			GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) geesunOitemsListingList
					.get(i);
			geesunOitemsListingMap.put(geesunOitemsListing.getFdId(), geesunOitemsListing);
		}
		request.setAttribute("geesunOitemsListingMap", geesunOitemsListingMap);
		return getActionForward("stockCountData", mapping, form, request, response);
	}

	private String buiidCateHql(String[] cate,HQLInfo hqlInfo) {
		String whereBlock = "";
		for (int i = 0; i < cate.length; i++) {
			whereBlock = StringUtil.linkString(whereBlock, " or ",
					" geesunOitemsListing.fdCategory.fdHierarchyId like :cate"+i);
			hqlInfo.setParameter("cate"+i, "%"+cate[i]+"%");
		}
		return " (" + whereBlock + ") ";

	}

	public ActionForward receiveCount(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String fdCategoryId = request.getParameter("fdCategoryId");
		String fdCategoryName = request.getParameter("fdCategoryName");
		request.setAttribute("fdCategoryId", fdCategoryId);
		request.setAttribute("fdCategoryName", fdCategoryName);
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		if (StringUtil.isNull(fdStartTime)) {
			fdStartTime = DateUtil.convertDateToString(calendar.getTime(),
					DateUtil.TYPE_DATE, Locale.getDefault());

		}
		if (StringUtil.isNull(fdEndTime)) {
			fdEndTime = DateUtil.convertDateToString(nowDate,
					DateUtil.TYPE_DATE, Locale.getDefault());
		}
		request.setAttribute("fdStartTime", fdStartTime);
		request.setAttribute("fdEndTime", fdEndTime);
		String fdDeptId = request.getParameter("fdDeptId");
		String fdDeptName = request.getParameter("fdDeptName");
		request.setAttribute("fdDeptId", fdDeptId);
		request.setAttribute("fdDeptName", fdDeptName); 
		if (StringUtil.isNotNull(fdCategoryId)) {
			fdCategoryId = fdCategoryId.replace(";", "','");
			request.setAttribute("fdCategoryId", fdCategoryId);
		}
		List<GeesunOitemsReceiveContext> rtnList = getServiceImp(request)
				.findReceiveCount(request);
		// 添加日志信息
		for (GeesunOitemsReceiveContext geesunOitemsReceiveContext : rtnList) {
			UserOperHelper.logFind(geesunOitemsReceiveContext
					.getGeesunOitemsWarehousingRecordJoinList()
					.getGeesunOitemsListing());
		}
		request.setAttribute("receiveContextList", rtnList);
		return getActionForward("receiveCount", mapping, form, request,
				response);
	}

	public ActionForward receiveCountData(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String fdCategoryId = request.getParameter("fdCategoryId");
		String fdCategoryName = request.getParameter("fdCategoryName");
		request.setAttribute("fdCategoryId", fdCategoryId);
		request.setAttribute("fdCategoryName", fdCategoryName);
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		java.util.Date nowDate = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(nowDate);
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		if (StringUtil.isNull(fdStartTime)) {
			fdStartTime = DateUtil.convertDateToString(calendar.getTime(), DateUtil.TYPE_DATE, Locale.getDefault());

		}
		if (StringUtil.isNull(fdEndTime)) {
			fdEndTime = DateUtil.convertDateToString(nowDate, DateUtil.TYPE_DATE, Locale.getDefault());
		}
		request.setAttribute("fdStartTime", fdStartTime);
		request.setAttribute("fdEndTime", fdEndTime);
		String fdDeptId = request.getParameter("fdDeptId");
		String fdDeptName = request.getParameter("fdDeptName");
		request.setAttribute("fdDeptId", fdDeptId);
		request.setAttribute("fdDeptName", fdDeptName);
		HQLInfo hqlInfo = new HQLInfo();
		if (StringUtil.isNotNull(fdCategoryId)) {
			fdCategoryId = fdCategoryId.replace(";", "','");
			request.setAttribute("fdCategoryId", fdCategoryId);
		}
		List<GeesunOitemsReceiveContext> rtnList = getServiceImp(request).findReceiveCount(request);
		// 添加日志信息
		for (GeesunOitemsReceiveContext geesunOitemsReceiveContext : rtnList) {
			UserOperHelper.logFind(geesunOitemsReceiveContext.getGeesunOitemsWarehousingRecordJoinList().getGeesunOitemsListing());
		}
		request.setAttribute("receiveContextList", rtnList);
		return getActionForward("receiveCountData", mapping, form, request, response);
	}

	public void receiveCountExport(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String fdCategoryId = request.getParameter("fdCategoryId");
		String fdCategoryName = request.getParameter("fdCategoryName");
		request.setAttribute("fdCategoryId", fdCategoryId);
		request.setAttribute("fdCategoryName", fdCategoryName);
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		request.setAttribute("fdStartTime", fdStartTime);
		request.setAttribute("fdEndTime", fdEndTime);
		String fdDeptId = request.getParameter("fdDeptId");
		String fdDeptName = request.getParameter("fdDeptName");
		request.setAttribute("fdDeptId", fdDeptId);
		request.setAttribute("fdDeptName", fdDeptName);
		HQLInfo hqlInfo = new HQLInfo();
		if (StringUtil.isNotNull(fdCategoryId)) {
			fdCategoryId = fdCategoryId.replace(";", "','");
			request.setAttribute("fdCategoryId", fdCategoryId);
		}
		List<GeesunOitemsReceiveContext> rtnList = getServiceImp(request)
				.findReceiveCount(request);
		// 添加日志信息
		for (GeesunOitemsReceiveContext geesunOitemsReceiveContext : rtnList) {
			UserOperHelper.logFind(geesunOitemsReceiveContext
					.getGeesunOitemsWarehousingRecordJoinList()
					.getGeesunOitemsListing());
		}
		SimpleDateFormat format = new SimpleDateFormat(ResourceUtil
				.getString("date.format.date"));
		String title = ResourceUtil.getString("geesunOitems.tree.reporting3",
				"geesun-oitems")
				+ format.format(new Date());
		getGeesunOitemsBudgerApplicationService().exportReceive(response, rtnList,
				title);

		// return getActionForward("receiveCount", mapping, form, request,
		// response);
	}

	/**
	 * 库存统计导出
	 */
	public void stockCountExport(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 查询库存记录
		String fdCategoryId = request.getParameter("fdCategoryId");
		String fdCategoryName = request.getParameter("fdCategoryName");
		String fdOitemsName = request.getParameter("fdOitemsName");
		String fdOitemsNumber = request.getParameter("fdOitemsNumber");
		List geesunOitemsListingList = new ArrayList();
		HQLInfo hqlInfo = new HQLInfo();
		String whereBlock = "1=1";
		if (StringUtil.isNotNull(fdCategoryId)) {
			String[] fdCategoryIds = fdCategoryId.split(";");
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					buiidCateHql(fdCategoryIds,hqlInfo));
		} else {
			HQLInfo hql = new HQLInfo();
			hql.setAuthCheckType(SysAuthConstant.AUTH_CHECK_READER);
			hql.setSelectBlock(" fdId ");
			List<String> list = getGeesunOitemsManageService().findList(hql);
			if (null != list && list.size() > 0) {
				String[] fdCategoryIds = (String[]) list.toArray(new String[list.size()]);
				whereBlock = StringUtil.linkString(whereBlock, " and ", buiidCateHql(fdCategoryIds, hqlInfo));
			} else {
				whereBlock = StringUtil.linkString(whereBlock, " and ", " 1=0 ");
			}
		}
		if (StringUtil.isNotNull(fdOitemsName)) {
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					"geesunOitemsListing.fdName like :fdOitemsName");
			hqlInfo.setParameter("fdOitemsName", "%" + fdOitemsName + "%");
		}
		if (StringUtil.isNotNull(fdOitemsNumber)) {
			whereBlock = StringUtil.linkString(whereBlock, " and ",
					"LOWER(geesunOitemsListing.fdNo) like :fdOitemsNumber");
			hqlInfo.setParameter("fdOitemsNumber", "%" + fdOitemsNumber.trim().toLowerCase() + "%");
		}
		whereBlock = StringUtil
				.linkString(
						whereBlock,
						" and ",
						"(geesunOitemsListing.fdIsAbandon = :fdIsAbandon or geesunOitemsListing.fdIsAbandon is null)");
		hqlInfo.setParameter("fdIsAbandon", Boolean.TRUE);

		hqlInfo.setWhereBlock(whereBlock);
		hqlInfo.setOrderBy(" geesunOitemsListing.fdNo desc");
		geesunOitemsListingList = getServiceImp(request).findList(hqlInfo);
		// 添加日志信息
		UserOperHelper.logFindAll(geesunOitemsListingList,
				getServiceImp(request).getModelName());
		LinkedHashMap geesunOitemsListingMap = new LinkedHashMap();
		for (int i = 0; i < geesunOitemsListingList.size(); i++) {
			GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) geesunOitemsListingList
					.get(i);
			geesunOitemsListingMap.put(geesunOitemsListing.getFdId(), geesunOitemsListing);
		}
		SimpleDateFormat format = new SimpleDateFormat(ResourceUtil
				.getString("date.format.date"));
		String title = ResourceUtil.getString("geesunOitemsListing.stock.count",
				"geesun-oitems")
				+ format.format(new Date());
		getGeesunOitemsBudgerApplicationService().export(response,
				geesunOitemsListingMap, title);
	}

	/*
	 * (non-Javadoc)申请选择用品
	 */
	public ActionForward checkOitemsList(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-list", true, getClass());
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
			hqlInfo.setPageNo(pageno);
			hqlInfo.setRowSize(rowsize);
			checkFindPageHQLInfo(request, hqlInfo);
			Page page = getServiceImp(request).findPage(hqlInfo);
			// 添加日志信息
			UserOperHelper.logFindAll(page.getList(),
					getServiceImp(request).getModelName());
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-list", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("checkOitemsList", mapping, form, request,
					response);
		}
	}
	protected void checkFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
		super.changeFindPageHQLInfo(request, hqlInfo);
		String whereBlock = null;
		String fdCategoryId = request.getParameter("categoryId");
		request.setAttribute("fdCategoryId", fdCategoryId);
		String fdApplicationId = request.getParameter("fdApplicationId");
		if (StringUtil.isNotNull(fdCategoryId)) {
			GeesunOitemsManage geesunOitemsManage = (GeesunOitemsManage) ((IGeesunOitemsManageService) getBean("geesunOitemsManageService"))
					.findByPrimaryKey(fdCategoryId);
			whereBlock = " geesunOitemsListing.fdCategory.fdHierarchyId like :fdHierarchyId ";
			hqlInfo.setParameter("fdHierarchyId", "%" + geesunOitemsManage.getFdHierarchyId() + "%");
		} else {
			whereBlock = "1=1";
		}

		// 用品申请时只查询有效的用品
		if (StringUtil.isNotNull(fdApplicationId)) {
			whereBlock += " and (geesunOitemsListing.fdIsAbandon = :fdIsAbandon or geesunOitemsListing.fdIsAbandon is null) and geesunOitemsListing.fdAmount > 0 ";
			hqlInfo.setParameter("fdIsAbandon", Boolean.TRUE);
		}

		CriteriaValue cv = new CriteriaValue(request);
		String keywords = request.getParameter("keywords");
		if (StringUtil.isNull(keywords)) {
			keywords = cv.poll("keywords");
		}
		if (StringUtil.isNotNull(keywords)) {
			whereBlock = StringUtil.linkString(whereBlock, "and",
					" (geesunOitemsListing.fdName like :keywords1 or LOWER(geesunOitemsListing.fdNo) like :keywords2)");
			hqlInfo.setParameter("keywords1", "%" + keywords + "%");
			hqlInfo.setParameter("keywords2", "%" + keywords.trim().toLowerCase() + "%");
		}
		// 兼容旧数据，如果为空也为有效
		String fdIsAbandon = cv.poll("fdIsAbandon");
		if (StringUtil.isNotNull(fdIsAbandon)) {
			if (fdIsAbandon.equals("true")) {
				whereBlock += " and (geesunOitemsListing.fdIsAbandon=1 or geesunOitemsListing.fdIsAbandon=null)";
			} else {
				whereBlock += " and geesunOitemsListing.fdIsAbandon=0";
			}
		}
		if (!UserUtil.getKMSSUser().isAdmin()) {
			//根据办公用品类别可使用者过滤数据
			String joinBlock = " left join geesunOitemsListing.fdCategory.authUses use";
			hqlInfo.setJoinBlock(joinBlock);
			whereBlock += " and (geesunOitemsListing.fdCategory.authUseFlag = 1" + " or " + getFindPageAuthUsesWhereBlock()
					+ ")";
		}
		hqlInfo.setWhereBlock(whereBlock);
		CriteriaUtil.buildHql(cv, hqlInfo, GeesunOitemsListing.class);
	}

	private String getFindPageAuthUsesWhereBlock() throws Exception {
		List authOrgIds = new ArrayList();
		authOrgIds = UserUtil.getKMSSUser().getUserAuthInfo().getAuthOrgIds();
		String rtnWhereBlock = HQLUtil.buildLogicIN("use.fdId", authOrgIds);
		return rtnWhereBlock;
	}

	/**
	 * 导入用品
	 */
	public ActionForward importOitems(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		boolean status = true;
		String[] oitems = request.getParameterValues("List_Selected");
		for (int i = 0; i < oitems.length; i++) {
			String[] strs = oitems[i].split("_");
			GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) getServiceImp(
					request).findByPrimaryKey(strs[0]);
			String fdNumber = request.getParameter("fdNumber" + strs[1]);
			String fdPrice = request.getParameter("fdPrice" + strs[1]);
			String fdAccountPrice = request.getParameter("fdAccountPrice"
					+ strs[1]);
			if (StringUtil.isNotNull(fdNumber)) {
				GeesunOitemsWarehousingRecord geesunOitemsWarehousingRecord = new GeesunOitemsWarehousingRecord();
				geesunOitemsWarehousingRecord.setGeesunOitemsListing(geesunOitemsListing);
				geesunOitemsWarehousingRecord.setFdNumber(Integer
						.parseInt(fdNumber));
				if (fdPrice != null) {
					geesunOitemsWarehousingRecord.setFdPrice(Double
							.parseDouble(fdPrice));
				}
				geesunOitemsWarehousingRecord.setFdAccountPrice(Double
						.parseDouble(fdAccountPrice));

				geesunOitemsWarehousingRecord.setDocCreateTime(new Date());
				geesunOitemsWarehousingRecord.setDocCreator(UserUtil.getUser());
				getGeesunOitemsWarehousingRecordService().add(
						geesunOitemsWarehousingRecord);
				HQLInfo hqlInfo = new HQLInfo();
				String whereBlock = hqlInfo.getWhereBlock();
				if (whereBlock == null)
					whereBlock = "1=1";
				whereBlock += " and geesunOitemsWarehousingRecordJoinList.fdPrice="
						+ fdPrice
						+ " and geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdId='"
						+ geesunOitemsListing.getFdId() + "'";
				hqlInfo.setWhereBlock(whereBlock);
				List<GeesunOitemsWarehousingRecordJoinList> list = getGeesunOitemsWarehousingRecordJoinListService()
						.findList(hqlInfo);
				BigDecimal Num = new BigDecimal(fdNumber);
				BigDecimal Price = new BigDecimal(fdPrice);
				if (list.size() == 0) {
					GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = new GeesunOitemsWarehousingRecordJoinList();
					geesunOitemsWarehousingRecordJoinList
							.setGeesunOitemsListing(geesunOitemsListing);
					geesunOitemsWarehousingRecordJoinList
							.setDocCreator(com.landray.kmss.util.UserUtil
									.getUser());
					geesunOitemsWarehousingRecordJoinList
							.setFdBrand(geesunOitemsListing.getFdBrand());
					geesunOitemsWarehousingRecordJoinList.setFdCurNumber(Num
							.intValue());
					geesunOitemsWarehousingRecordJoinList.setFdNumber(Num
							.intValue());
					geesunOitemsWarehousingRecordJoinList.setFdPrice(Price
							.doubleValue());
					getGeesunOitemsWarehousingRecordJoinListService().add(
							geesunOitemsWarehousingRecordJoinList);
				} else {
					GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = list
							.get(0);
					geesunOitemsWarehousingRecordJoinList
							.setFdNumber(geesunOitemsWarehousingRecordJoinList
									.getFdNumber()
									+ Num.intValue());
					geesunOitemsWarehousingRecordJoinList
							.setFdCurNumber(geesunOitemsWarehousingRecordJoinList
									.getFdCurNumber()
									+ Num.intValue());
					getGeesunOitemsWarehousingRecordJoinListService().update(
							geesunOitemsWarehousingRecordJoinList);
				}
				Double oldPrice = geesunOitemsListing.getFdReferencePrice();
				Integer oldAmount = geesunOitemsListing.getFdAmount();
				// 更改用品清单价格，库存
				geesunOitemsListing
						.setFdReferencePrice(Double.parseDouble(fdPrice));
				if (null != geesunOitemsListing.getFdAmount()) {
					geesunOitemsListing.setFdAmount(geesunOitemsListing.getFdAmount()
							+ Integer.parseInt(fdNumber));
				} else {
					geesunOitemsListing.setFdAmount(Integer.parseInt(fdNumber));
				}
				// 添加日志信息
				if (UserOperHelper.allowLogOper("importOitems",
						getServiceImp(request).getModelName())) {
					UserOperContentHelper.putUpdate(geesunOitemsListing)
							.putSimple("fdReferencePrice", oldPrice,
									geesunOitemsListing.getFdReferencePrice())
							.putSimple("fdAmount", oldAmount,
									geesunOitemsListing.getFdAmount());
				}
				getServiceImp(request).update(geesunOitemsListing);
			}
		}
		TimeCounter.logCurrentTime("Action-update", true, getClass());
		KmssMessages messages = new KmssMessages();
		TimeCounter.logCurrentTime("Action-update", false, getClass());
		if (messages.hasError()) {
			status = false;
		}
		JSONObject json = new JSONObject();
		json.put("status", status);// 执行结果
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-type", "text/json;charset=UTF-8");
		response.getWriter().write(json.toString());
		return null;
	}

	/**
	 * 下载导入模板
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward downloadExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		KmssMessages messages = new KmssMessages();
		try {
			if (UserOperHelper.allowLogOper("downloadExcel",
					getServiceImp(request).getModelName())) {
				UserOperHelper.setEventType(ResourceUtil
						.getString("geesun-oitems:geesunOitemsWarehousingRecord.down"));
			}
			getServiceImp(request).downloadTemplate(request, response);
		} catch (Exception e) {
			messages.addError(e);
		}
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).save(
					request);
			return getActionForward("failure", mapping, form, request,
					response);
		}
		return null;
	}

	/*
	 * (non-Javadoc) 导入excel
	 */
	public ActionForward saveExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		KmssMessages messages = new KmssMessages();
		try {
			if (!request.getMethod().equals("POST"))
				throw new UnexpectedRequestException();
			GeesunOitemsListingForm formbean = (GeesunOitemsListingForm) form;
			FormFile file = formbean.getFile();
			String isAdd = request.getParameter("isAdd");
			boolean isAddFlag = "true".equals(isAdd) || "on".equals(isAdd);
			UploadResultBean result = new UploadResultBean();// 操作结果集
			if (file.getFileSize() == 0) {
				KmssMessage error = new KmssMessage(
						"geesun-oitems:geesunOitemsWarehousingRecord.upload.excel.empty");
				messages.addError(error);
			} else {
				POIFSFileSystem fs = new POIFSFileSystem(file.getInputStream());
				HSSFWorkbook wb = new HSSFWorkbook(fs);
				HSSFSheet sheet = wb.getSheetAt(0);
				// 数据必须大于7列，且不能少于2行
				if (sheet.getLastRowNum() < 1
						|| sheet.getRow(0).getLastCellNum() < 7) {
					messages
							.addError(new KmssMessage(
									"geesun-oitems:geesunOitemsWarehousingRecord.upload.excel.error"));
				} else {
					for (int i = 1, n = sheet.getLastRowNum(); i <= n; i++) {
						boolean canSave = true;
						GeesunOitemsListing geesunOitemsListing = new GeesunOitemsListing();
						GeesunOitemsManage geesunOitemsManage = null;
						String whereBlock = "";
						if (skipBlankLine(sheet.getRow(i)))
							continue;
						// 用品编号
						HSSFCell categoryCell = sheet.getRow(i).getCell(
								(short) 0);// 读取用品编号
						if (categoryCell != null) {
							String fdNo = categoryCell.getStringCellValue();
							if (StringUtil.isNotNull(fdNo)) {
								geesunOitemsListing.setFdNo(fdNo);
								whereBlock = "geesunOitemsListing.fdNo = '" + fdNo + "'";
								if ("true".equals(getServiceImp(request).checkUnique(fdNo, ""))
										&& !isAddFlag) {
									String fdArgs[] = { "" + (i + 1),
											ResourceUtil.getString("geesunOitemsListing.fdNo", "geesun-oitems"),
											ResourceUtil.getString("geesunOitems.import.codeError", "geesun-oitems") };
									result.addErrorMsg(ResourceUtil.getString("geesunOitems.import.message3", "geesun-oitems",
											null, fdArgs));
									result.addFailCount();
									canSave = false;
									continue;
								}
							} else {
								String fdArgs[] = {
										"" + (i + 1),
										ResourceUtil.getString(
												"geesunOitemsListing.fdNo",
												"geesun-oitems"),
										ResourceUtil
												.getString(
														"geesunOitems.import.required",
														"geesun-oitems") };
								result.addErrorMsg(ResourceUtil.getString(
										"geesunOitems.import.message3",
										"geesun-oitems", null, fdArgs));
								result.addFailCount();
								canSave = false;
								continue;
							}
						} else {
							String fdArgs[] = {
									"" + (i + 1),
									ResourceUtil.getString(
											"geesunOitemsListing.fdNo",
											"geesun-oitems"),
									ResourceUtil
											.getString(
													"geesunOitems.import.required",
													"geesun-oitems") };
							result.addErrorMsg(ResourceUtil.getString(
									"geesunOitems.import.message3",
									"geesun-oitems", null, fdArgs));
							result.addFailCount();
							canSave = false;
							continue;
						}
						// 读取名称
						HSSFCell subjectCell = sheet.getRow(i).getCell(
								(short) 1);// 读取名称
						if (subjectCell!=null && StringUtil.isNotNull(subjectCell
								.getStringCellValue())) {
							geesunOitemsListing.setFdName(subjectCell
									.getStringCellValue());
						} else {
							String fdArgs[] = {
									"" + (i + 1),
									ResourceUtil.getString(
											"geesunOitemsListing.fdName",
											"geesun-oitems"),
									ResourceUtil
											.getString(
													"geesunOitems.import.required",
													"geesun-oitems") };
							result.addErrorMsg(ResourceUtil.getString(
									"geesunOitems.import.message3",
									"geesun-oitems", null, fdArgs));
							result.addFailCount();
							canSave = false;
							continue;
						}
						String fdCategoryName = "";
						HSSFCell answerCell = sheet.getRow(i)
								.getCell((short) 2);// 读取用品类别
						if (answerCell!=null && StringUtil.isNotNull(answerCell
								.getStringCellValue())) {
							geesunOitemsManage = findCategory(answerCell
									.getStringCellValue());
							if (geesunOitemsManage != null) {

							} else {
								String fdArgs[] = {
										"" + (i + 1),
										ResourceUtil.getString(
												"geesunOitemsListing.fdCategoryId",
												"geesun-oitems"),
										ResourceUtil
												.getString(
														"geesunOitems.import.error",
														"geesun-oitems") };
								result.addErrorMsg(ResourceUtil.getString(
										"geesunOitems.import.message3",
										"geesun-oitems", null, fdArgs));
								result.addFailCount();
								canSave = false;
								continue;
							}
							fdCategoryName = answerCell.getStringCellValue();
						} else {
							String fdArgs[] = {
									"" + (i + 1),
									ResourceUtil.getString(
											"geesunOitemsListing.fdCategoryId",
											"geesun-oitems"),
									ResourceUtil
											.getString(
													"geesunOitems.import.error",
													"geesun-oitems") };
							result.addErrorMsg(ResourceUtil.getString(
									"geesunOitems.import.message3",
									"geesun-oitems", null, fdArgs));
							result.addFailCount();
							canSave = false;
							continue;
						}

						// 读取规格
						HSSFCell typeCell = sheet.getRow(i).getCell((short) 3);// 读取规格
						if (typeCell != null) {

							geesunOitemsListing.setFdSpecification(typeCell
									.getStringCellValue());
						}
						// 读取品牌
						HSSFCell fdBrandCell = sheet.getRow(i).getCell(
								(short) 4);// 读取品牌
						if (fdBrandCell != null) {
							geesunOitemsListing.setFdBrand(fdBrandCell
									.getStringCellValue());
						}
						// 读取单位
						HSSFCell fdUnitCell = sheet.getRow(i)
								.getCell((short) 5);// 读取单位
						if (fdUnitCell != null) {
							geesunOitemsListing.setFdUnit(fdUnitCell
									.getStringCellValue());
						}
						// 读取数量
						HSSFCell fdNumberCell = sheet.getRow(i).getCell(
								(short) 6);// 读取数量
						System.out.println();
						int fdNumber = 0;
						//if (fdNumberCell.getNumericCellValue() > 0) {
						try {

							fdNumber = Integer.parseInt(fdNumberCell.getStringCellValue());
							if (fdNumber < 0) {
								String[] fdArgs = { "" + (i + 1),
										ResourceUtil.getString(
												"geesunOitemsListing.number",
												"geesun-oitems"),
										ResourceUtil.getString(
												"GeesunOitemsListing.fdAmount.positive",
												"geesun-oitems") };
								result.addErrorMsg(ResourceUtil.getString(
										"geesunOitems.import.message3", "geesun-oitems",
										null, fdArgs));
								result.addFailCount();
								canSave = false;
								continue;
							}

						} catch (Exception e) {
							String fdArgs[] = {
									"" + (i + 1),
									ResourceUtil.getString(
											"geesunOitemsListing.number",
											"geesun-oitems"),
									ResourceUtil
											.getString(
													"geesunOitems.import.number",
													"geesun-oitems") };
							result.addErrorMsg(ResourceUtil.getString(
									"geesunOitems.import.message3",
									"geesun-oitems", null, fdArgs));
							result.addFailCount();
							canSave = false;
							continue;
						}
						//} else {
						//	canSave = false;
						//}
						// 读取价格
						HSSFCell fdPriceCell = sheet.getRow(i).getCell(
								(short) 7);// 读取价格
						double fdPrice = 0.0d;
						//if (fdPriceCell.getNumericCellValue() > 0) {
						try {
							String priceStr = fdPriceCell.getStringCellValue();
							if (StringUtil.isNotNull(priceStr)) {
								//priceStr = priceStr.substring(0, priceStr.indexOf(".") + 3);
								BigDecimal bd = new BigDecimal(priceStr);
								BigDecimal setScale = bd.setScale(2, bd.ROUND_DOWN);
								fdPrice = setScale.doubleValue();
							}
						} catch (Exception e) {
							String fdArgs[] = {
									"" + (i + 1),
									ResourceUtil.getString(
											"geesunOitemsListing.fdReferencePrice",
											"geesun-oitems"),
									ResourceUtil
											.getString(
													"geesunOitems.import.number",
													"geesun-oitems") };
							result.addErrorMsg(ResourceUtil.getString(
									"geesunOitems.import.message3",
									"geesun-oitems", null, fdArgs));
							result.addFailCount();
							canSave = false;
							continue;
						}
						//} else {
						//	canSave = false;
						//}
						if (canSave) {
							HQLInfo hqlInfo = new HQLInfo();
							hqlInfo.setWhereBlock(whereBlock);
							List geesunOitemsList = getServiceImp(request)
									.findList(hqlInfo);
							if (geesunOitemsList.size() > 0) {
								GeesunOitemsListing geesunOitemsListImp = (GeesunOitemsListing) geesunOitemsList
										.get(0);
								GeesunOitemsManage oldCategory = geesunOitemsListImp
										.getFdCategory();
								if (geesunOitemsManage != null && !geesunOitemsManage
										.equals(oldCategory)) {
									String fdArgs[] = { "" + (i + 1),
											geesunOitemsListImp.getFdNo(),
											geesunOitemsManage.getFdName(),
											oldCategory.getFdName() };
									result.addErrorMsg(ResourceUtil.getString(
											"geesunOitems.import.message4",
											"geesun-oitems", null, fdArgs));
									result.addFailCount();
									continue;
								} else {
									// 添加库存
									GeesunOitemsWarehousingRecord geesunOitemsWarehousingRecord = new GeesunOitemsWarehousingRecord();
									geesunOitemsWarehousingRecord
											.setGeesunOitemsListing(
													geesunOitemsListImp);
									geesunOitemsWarehousingRecord
											.setFdNumber(fdNumber);
									geesunOitemsWarehousingRecord
											.setFdPrice(fdPrice);
									geesunOitemsWarehousingRecord
											.setFdAccountPrice(
													fdPrice * fdNumber);
									geesunOitemsWarehousingRecord
											.setDocCreateTime(new Date());
									geesunOitemsWarehousingRecord
											.setDocCreator(UserUtil.getUser());
									getGeesunOitemsWarehousingRecordService().add(
											geesunOitemsWarehousingRecord);

									HQLInfo hqlInfox = new HQLInfo();
									String whereBlockx = hqlInfox
											.getWhereBlock();
									if (whereBlockx == null)
										whereBlockx = "1=1";
									whereBlockx += " and geesunOitemsWarehousingRecordJoinList.fdPrice="
											+ fdPrice
											+ " and geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdId='"
											+ geesunOitemsListImp.getFdId() + "'";
									hqlInfox.setWhereBlock(whereBlockx);
									List<GeesunOitemsWarehousingRecordJoinList> list = getGeesunOitemsWarehousingRecordJoinListService()
											.findList(hqlInfox);
									if (list.size() == 0) {
										GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = new GeesunOitemsWarehousingRecordJoinList();
										geesunOitemsWarehousingRecordJoinList
												.setGeesunOitemsListing(
														geesunOitemsListImp);
										geesunOitemsWarehousingRecordJoinList
												.setDocCreator(
														com.landray.kmss.util.UserUtil
																.getUser());
										geesunOitemsWarehousingRecordJoinList
												.setFdBrand(geesunOitemsListImp
														.getFdBrand());
										geesunOitemsWarehousingRecordJoinList
												.setFdCurNumber(fdNumber);
										geesunOitemsWarehousingRecordJoinList
												.setFdNumber(fdNumber);
										geesunOitemsWarehousingRecordJoinList
												.setFdPrice(fdPrice);
										getGeesunOitemsWarehousingRecordJoinListService()
												.add(
														geesunOitemsWarehousingRecordJoinList);
									} else {
										GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = list
												.get(0);
										geesunOitemsWarehousingRecordJoinList
												.setFdNumber(
														geesunOitemsWarehousingRecordJoinList
																.getFdNumber()
																+ fdNumber);
										geesunOitemsWarehousingRecordJoinList
												.setFdCurNumber(
														geesunOitemsWarehousingRecordJoinList
																.getFdCurNumber()
																+ fdNumber);
										getGeesunOitemsWarehousingRecordJoinListService()
												.update(
														geesunOitemsWarehousingRecordJoinList);
									}
									// 更改用品清单价格，库存
									geesunOitemsListImp
											.setFdReferencePrice(fdPrice);
									int number = 0;
									if (null != geesunOitemsListImp.getFdAmount()) {
										number = geesunOitemsListImp.getFdAmount()
												+ fdNumber;
									}
									geesunOitemsListImp.setFdAmount(number);
									getServiceImp(request)
											.update(geesunOitemsListImp);
								}
							} else if (!StringUtil.isNotNull(fdCategoryName)) {
								messages
										.addError(new KmssMessage(
												"geesun-oitems:geesunOitemsWarehousingRecord.upload.excel.noCategory",
												new Integer(i + 1)));
							} else {
								// 没有查到清单，则添加清单
								// 类别不为空，查找类别
								if (geesunOitemsManage == null) {
									messages
											.addError(new KmssMessage(
													"geesun-oitems:geesunOitemsWarehousingRecord.upload.excel.noCategory",
													new Integer(i + 1)));
								} else {
									geesunOitemsListing
											.setFdCategory(geesunOitemsManage);
									//设置用品权限
									List readerList = new ArrayList();
									List editorsList = new ArrayList();
									readerList.addAll(geesunOitemsManage.getAuthTmpReaders());
									editorsList.addAll(geesunOitemsManage.getAuthTmpEditors());
									geesunOitemsListing.setAuthChangeReaderFlag(geesunOitemsManage.getAuthChangeReaderFlag());
									geesunOitemsListing.setAuthReaders(readerList);
									geesunOitemsListing.setAuthChangeEditorFlag(geesunOitemsManage.getAuthChangeEditorFlag());
									geesunOitemsListing.setAuthEditors(editorsList);
								}
								geesunOitemsListing.setFdReferencePrice(fdPrice);
								geesunOitemsListing.setFdAmount(fdNumber);
								geesunOitemsListing.setDocCreator(UserUtil
										.getUser());
								geesunOitemsListing.setDocCreateTime(new Date());
								if (geesunOitemsManage != null) {
									// 添加日志信息
									if (UserOperHelper.allowLogOper("saveExcel",
											getServiceImp(request).getModelName())) {
										UserOperContentHelper
												.putAdd(geesunOitemsListing, "fdNo","fdName",
														"fdSpecification","fdBrand","fdUnit",
														"fdCategory","authReaders","authEditors",
														"fdReferencePrice","fdAmount","docCreateTime");
									}
									getServiceImp(request).add(geesunOitemsListing);
								}
								// 添加库存
								GeesunOitemsWarehousingRecord geesunOitemsWarehousingRecord = new GeesunOitemsWarehousingRecord();
								geesunOitemsWarehousingRecord
										.setGeesunOitemsListing(geesunOitemsListing);
								geesunOitemsWarehousingRecord.setFdNumber(fdNumber);
								geesunOitemsWarehousingRecord.setFdPrice(fdPrice);
								geesunOitemsWarehousingRecord
										.setFdAccountPrice(fdPrice * fdNumber);
								geesunOitemsWarehousingRecord
										.setDocCreateTime(new Date());
								geesunOitemsWarehousingRecord
										.setDocCreator(UserUtil.getUser());
								if (geesunOitemsManage != null) {
									getGeesunOitemsWarehousingRecordService().add(
											geesunOitemsWarehousingRecord);
								}
								GeesunOitemsWarehousingRecordJoinList geesunOitemsWarehousingRecordJoinList = new GeesunOitemsWarehousingRecordJoinList();
								geesunOitemsWarehousingRecordJoinList
										.setGeesunOitemsListing(geesunOitemsListing);
								geesunOitemsWarehousingRecordJoinList
										.setDocCreator(com.landray.kmss.util.UserUtil
												.getUser());
								geesunOitemsWarehousingRecordJoinList
										.setFdBrand(geesunOitemsListing
												.getFdBrand());
								geesunOitemsWarehousingRecordJoinList
										.setFdCurNumber(fdNumber);
								geesunOitemsWarehousingRecordJoinList
										.setFdNumber(fdNumber);
								geesunOitemsWarehousingRecordJoinList
										.setFdPrice(geesunOitemsListing
												.getFdReferencePrice());
								if (geesunOitemsManage != null) {
									getGeesunOitemsWarehousingRecordJoinListService()
											.add(
													geesunOitemsWarehousingRecordJoinList);
								}
							}
							result.addSuccessCount();
						} else {
							if (geesunOitemsManage != null) {
								messages
										.addError(new KmssMessage(
												"geesun-oitems:geesunOitemsWarehousingRecord.upload.excel.error1",
												new Integer(i + 1)));
							}
						}
					}
				}
			}
			request.setAttribute("result", result);
			
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		return mapping.findForward("saveExcel");
	}

	/*
	 * 查找类别
	 */
	public GeesunOitemsManage findCategory(String fdCategoryName) throws Exception {
		String[] cateNameArray = fdCategoryName.split("/");
		String categoryNames = "";
		String path = "";
		GeesunOitemsManage cate = null;
		categoryNames = "'" + cateNameArray[0] + "'";
		String whereblock1 = "geesunOitemsManage.fdName =" + categoryNames;
		HQLInfo hqlInfo1 = new HQLInfo();
		hqlInfo1.setWhereBlock(whereblock1);
		if (!UserUtil.checkRole("ROLE_GEESUNOITEMS_GOODS_ADMIN")) {
			hqlInfo1.setAuthCheckType(SysAuthConstant.AUTH_CHECK_READER);
		} else {
			hqlInfo1.setAuthCheckType(SysAuthConstant.AUTH_CHECK_NONE);
		}
		List<GeesunOitemsManage> geesunOitemsManageList1 = getGeesunOitemsManageService()
				.findList(hqlInfo1);
		if (geesunOitemsManageList1.size() != 0) {
			if (cateNameArray.length > 1) {
				if (geesunOitemsManageList1.size() > 0) {
					path = cateNameArray[0];
					for (GeesunOitemsManage geesunOitemsManage : geesunOitemsManageList1) {
						cate = geesunOitemsManage;
						int i = 1;
						while (i < cateNameArray.length) {
							String whereblock2 = "geesunOitemsManage.hbmParent.fdId = '"
									+ cate.getFdId()
									+ "' and geesunOitemsManage.fdName = '"
									+ cateNameArray[i] + "'";
							HQLInfo hqlInfo2 = new HQLInfo();
							hqlInfo2.setWhereBlock(whereblock2);
							List<GeesunOitemsManage> geesunOitemsManageList2 = getGeesunOitemsManageService()
									.findList(hqlInfo2);
							if (geesunOitemsManageList2.size() > 0) {
								path += "/"
										+ geesunOitemsManageList2.get(0)
												.getFdName();
								cate = geesunOitemsManageList2.get(0);
								i++;
							} else {
								cate = null;
								break;
							}
						}
						if (path.contains(fdCategoryName))
							continue;
					}
				}
			} else {
				cate = geesunOitemsManageList1.get(0);
			}
		} else {
			return null;
		}
		return cate;
	}

	/*
	 * 所有行为空则跳过
	 */
	private boolean skipBlankLine(HSSFRow row) {
		HSSFCell cell1 = row.getCell((short) 0);
		HSSFCell cell2 = row.getCell((short) 1);
		HSSFCell cell3 = row.getCell((short) 2);
		HSSFCell cell4 = row.getCell((short) 3);
		HSSFCell cell5 = row.getCell((short) 4);
		HSSFCell cell6 = row.getCell((short) 5);
		HSSFCell cell7 = row.getCell((short) 6);
		HSSFCell cell8 = row.getCell((short) 7);
		if (cell1 != null) {
			cell1.setCellType(Cell.CELL_TYPE_STRING);
		}
		if (cell2 != null) {
			cell2.setCellType(Cell.CELL_TYPE_STRING);
		}
		if (cell3 != null) {
			cell3.setCellType(Cell.CELL_TYPE_STRING);
		}
		if (cell4 != null) {
			cell4.setCellType(Cell.CELL_TYPE_STRING);
		}
		if (cell5 != null) {
			cell5.setCellType(Cell.CELL_TYPE_STRING);
		}
		if (cell6 != null) {
			cell6.setCellType(Cell.CELL_TYPE_STRING);
		}
		if (cell7 != null) {
			cell7.setCellType(Cell.CELL_TYPE_STRING);
		}
		if (cell8 != null) {
			cell8.setCellType(Cell.CELL_TYPE_STRING);
		}

		// String fdNo = "";
		// if (cell1.getCellType() == Cell.CELL_TYPE_STRING) {
		// fdNo = cell1.getStringCellValue();
		// } else if (cell1.getCellType() == Cell.CELL_TYPE_NUMERIC) {
		// double d = cell1.getNumericCellValue();
		// fdNo = String.valueOf(d);
		// }
		return (cell1 == null || StringUtil.isNull(cell1.getStringCellValue()))
				&& (cell2 == null || StringUtil.isNull(cell2
						.getStringCellValue()))
				&& (cell3 == null || StringUtil.isNull(cell3
						.getStringCellValue()))
				&& (cell4 == null || StringUtil.isNull(cell4
						.getStringCellValue()))
				&& (cell5 == null || StringUtil.isNull(cell5
						.getStringCellValue()))
				&& (cell6 == null || StringUtil.isNull(cell6
						.getStringCellValue()))
				&& (cell7 == null || StringUtil.isNull(cell7
						.getStringCellValue()))
				&& (cell8 == null || StringUtil.isNull(cell8
						.getStringCellValue()));
	}

	@Override
	protected String getFindPageOrderBy(HttpServletRequest request,
			String curOrderBy) throws Exception {
		if (StringUtil.isNull(curOrderBy)) {
			curOrderBy = "geesunOitemsListing.fdNo desc";
		}
		return curOrderBy;
	}

	protected void changeFindPageHQLInfo(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		super.changeFindPageHQLInfo(request, hqlInfo);
		String method = request.getParameter("method");
		String whereBlock = null;
		String fdCategoryId = request.getParameter("categoryId");
		request.setAttribute("fdCategoryId", fdCategoryId);
		String fdApplicationId = request.getParameter("fdApplicationId");
		if (StringUtil.isNotNull(fdCategoryId)) {
			GeesunOitemsManage geesunOitemsManage = (GeesunOitemsManage) ((IGeesunOitemsManageService) getBean("geesunOitemsManageService"))
					.findByPrimaryKey(fdCategoryId);
			whereBlock = " geesunOitemsListing.fdCategory.fdHierarchyId like :fdHierarchyId ";
			hqlInfo.setParameter("fdHierarchyId", "%"
					+ geesunOitemsManage.getFdHierarchyId() + "%");
		} else {
			//whereBlock = "1=1";
			//add按类别管理员过滤用品
			HQLInfo hql = new HQLInfo();
			hql.setAuthCheckType(SysAuthConstant.AUTH_CHECK_READER);
			hql.setSelectBlock(" fdId ");
			hqlInfo.setAuthCheckType(AllCheck.AUTH_CHECK_DEFAULT);
			List<String> list = getGeesunOitemsManageService().findList(hql);
			if (null != list && list.size() > 0) {
				String[] fdCategoryIds = (String[]) list.toArray(new String[list.size()]);
				whereBlock = StringUtil.linkString(whereBlock, " and ", buiidCateHql(fdCategoryIds, hqlInfo));
			} else {
				if (method.equals("list")) {
					whereBlock = StringUtil.linkString(whereBlock, " and ", " 1=1 ");
				} else {
					whereBlock = StringUtil.linkString(whereBlock, " and ", " 1=0 ");
				}
			}
		}

		// 用品申请时只查询有效的用品
		if (StringUtil.isNotNull(fdApplicationId)) {
			whereBlock += " and (geesunOitemsListing.fdIsAbandon = :fdIsAbandon or geesunOitemsListing.fdIsAbandon is null) and geesunOitemsListing.fdAmount > 0 ";
			hqlInfo.setParameter("fdIsAbandon", Boolean.TRUE);
		}
		
		CriteriaValue cv = new CriteriaValue(request);
		String keywords = request.getParameter("keywords");
		if(StringUtil.isNull(keywords)){
			keywords = cv.poll("keywords");
		}
		if (StringUtil.isNotNull(keywords)) {
			whereBlock = StringUtil.linkString(whereBlock, "and",
					" (geesunOitemsListing.fdName like :keywords1 or LOWER(geesunOitemsListing.fdNo) like :keywords2)");
			hqlInfo.setParameter("keywords1", "%" + keywords + "%");
			hqlInfo.setParameter("keywords2", "%" + keywords.trim().toLowerCase() + "%");
		}
		// 兼容旧数据，如果为空也为有效
		String fdIsAbandon = cv.poll("fdIsAbandon");
		if (StringUtil.isNotNull(fdIsAbandon)) {
			if (fdIsAbandon.equals("true")) {
				whereBlock += " and (geesunOitemsListing.fdIsAbandon=1 or geesunOitemsListing.fdIsAbandon=null)";
			} else {
				whereBlock += " and geesunOitemsListing.fdIsAbandon=0";
			}
		}
		hqlInfo.setWhereBlock(whereBlock);

		CriteriaUtil.buildHql(cv, hqlInfo, GeesunOitemsListing.class);
	}

	protected String getFindPageRecordWhereBlock(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		String whereBlock = null;
		String fdCategoryId = request.getParameter("fdCategoryId");
		if (StringUtil.isNotNull(fdCategoryId)) {
			request.setAttribute("fdCategoryId", fdCategoryId);
			request.setAttribute("fdCategoryName", request
					.getParameter("fdCategoryName"));
			// fdCategoryId = fdCategoryId.replace(";", "','");
			// fdCategoryId = "'" + fdCategoryId + "'";
			if (StringUtil.isNotNull(fdCategoryId)) {
				String[] fdCategoryIds = fdCategoryId.split(";");
				whereBlock = StringUtil.linkString(whereBlock, " and ",
						buiidCateHql(fdCategoryIds,hqlInfo));
			}
			// HQLWrapper hqlWrapper =
			// HQLUtil.buildPreparedLogicIN(" geesunOitemsListing.fdCategory.fdId ",
			// Arrays.asList(fdCategoryId.split(";")));
			// whereBlock = hqlWrapper.getHql();
			// hqlInfo.setParameter(hqlWrapper.getParameterList());
		} else {
			HQLInfo hql = new HQLInfo();
			hql.setAuthCheckType(SysAuthConstant.AUTH_CHECK_READER);
			hql.setSelectBlock(" fdId ");
			List<String> list = getGeesunOitemsManageService().findList(hql);
			if (null != list && list.size() > 0) {
				String[] fdCategoryIds = (String[]) list.toArray(new String[list.size()]);
				whereBlock = StringUtil.linkString(whereBlock, " and ", buiidCateHql(fdCategoryIds, hqlInfo));
			} else {
				whereBlock = StringUtil.linkString(whereBlock, " and ", " 1=0 ");
			}
		}

		String fdOitemsName = request.getParameter("fdOitemsName");
		if (StringUtil.isNotNull(fdOitemsName)) {
			whereBlock = StringUtil.linkString(
					" geesunOitemsListing.fdName like :fdOitemsName ", " and ",
					whereBlock);
			hqlInfo.setParameter("fdOitemsName", "%" + fdOitemsName + "%");
			request.setAttribute("fdOitemsName", fdOitemsName);
		}

		String fdOitemsNumber = request.getParameter("fdOitemsNumber");
		if (StringUtil.isNotNull(fdOitemsNumber)) {
			whereBlock = StringUtil.linkString(
					" LOWER(geesunOitemsListing.fdNo) like :fdOitemsNumber ", " and ",
					whereBlock);
			hqlInfo.setParameter("fdOitemsNumber", "%" + fdOitemsNumber.trim().toLowerCase() + "%");
			request.setAttribute("fdOitemsNumber", fdOitemsNumber);
		}
		whereBlock = StringUtil
				.linkString(
						whereBlock,
						" and ",
						"(geesunOitemsListing.fdIsAbandon = :fdIsAbandon or geesunOitemsListing.fdIsAbandon is null)");
		hqlInfo.setParameter("fdIsAbandon", Boolean.TRUE);

		return whereBlock;
	}

	protected void loadActionForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		form.reset(mapping, request);
		IExtendForm rtnForm = null;
		String id = request.getParameter("fdId");
		if (!StringUtil.isNull(id)) {
			IBaseModel model = getServiceImp(request).findByPrimaryKey(id,
					null, true);
			if (model != null)
				UserOperHelper.logFind(model);// 添加日志信息
				rtnForm = getServiceImp(request).convertModelToForm(
						(IExtendForm) form, model, new RequestContext(request));
		}
		if (rtnForm == null) {
			throw new NoRecordException();
		} else {
			String categoryId = ((GeesunOitemsListingForm) rtnForm)
					.getFdCategoryId();
			if (StringUtil.isNotNull(categoryId)) {
				GeesunOitemsManage geesunOitemsManage = (GeesunOitemsManage) getGeesunOitemsManageService()
						.findByPrimaryKey(categoryId);
				if (geesunOitemsManage != null) {
					((GeesunOitemsListingForm) form)
							.setFdCategoryName(getCategoryPathName(geesunOitemsManage));
				}
			}
		}
		request.setAttribute(getFormName(rtnForm, request), rtnForm);
	}

	public String getCategoryPathName(GeesunOitemsManage geesunOitemsManage) {
		String str = "";
		GeesunOitemsManage parentgeesunOitemsManage = (GeesunOitemsManage) geesunOitemsManage
				.getFdParent();
		if (parentgeesunOitemsManage != null) {
			do {
				str = parentgeesunOitemsManage.getFdName() + "/" + str;
				parentgeesunOitemsManage = (GeesunOitemsManage) parentgeesunOitemsManage
						.getFdParent();
			} while (parentgeesunOitemsManage != null);
			str = str + geesunOitemsManage.getFdName();
		} else {
			str = str + geesunOitemsManage.getFdName();
		}
		return str;
	}
	
	public ActionForward checkUnique(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		String fdNo = request.getParameter("fdNo");
		String fdListingId = request.getParameter("fdListingId");
		String repeat = "false";
		try {
			if (StringUtil.isNotNull(fdNo)) {
				repeat = getServiceImp(request).checkUnique(fdNo,fdListingId);
			}
		} catch (Exception e) {
			e.printStackTrace();
			messages.addError(e);
		}
		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_RETURN).save(request);
		TimeCounter.logCurrentTime("Action-save", false, getClass());
		JSONObject json = new JSONObject();
		json.put("repeat", repeat);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().append(json.toString());
		response.getWriter().flush();
		response.getWriter().close();
		return null;
	}

}
