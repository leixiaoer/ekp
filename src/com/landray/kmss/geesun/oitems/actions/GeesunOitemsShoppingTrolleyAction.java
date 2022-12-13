package com.landray.kmss.geesun.oitems.actions;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.NoRecordException;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsShoppingTrolleyForm;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsManage;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsShoppingTrolley;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsListingService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsShoppingTrolleyService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordJoinListService;
import com.landray.kmss.geesun.oitems.service.spring.GeesunOitemsListingServiceImp;
import com.landray.kmss.geesun.oitems.util.UploadResultBean;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.sys.log.util.oper.UserOperContentHelper;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgGroup;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
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

public class GeesunOitemsShoppingTrolleyAction extends ExtendAction {

	private IGeesunOitemsWarehousingRecordJoinListService geesunOitemsWarehousingRecordJoinListService = null;
	private IGeesunOitemsShoppingTrolleyService geesunOitemsShoppingTrolleyService = null;
	private IGeesunOitemsListingService geesunOitemsListingService = null;

	protected IGeesunOitemsWarehousingRecordJoinListService
			getGeesunOitemsWarehousingRecordJoinListService(
					HttpServletRequest request) {
		if (geesunOitemsWarehousingRecordJoinListService == null) {
			geesunOitemsWarehousingRecordJoinListService = (IGeesunOitemsWarehousingRecordJoinListService) getBean(
					"geesunOitemsWarehousingRecordJoinListService");
		}
		return geesunOitemsWarehousingRecordJoinListService;
	}

	protected IGeesunOitemsListingService getGeesunOitemsListingServiceImp(
			HttpServletRequest request) {
		if (geesunOitemsListingService == null) {
			geesunOitemsListingService = (IGeesunOitemsListingService) getBean("geesunOitemsListingTarget");
		}
		return geesunOitemsListingService;
	}

	@Override
	protected IGeesunOitemsShoppingTrolleyService getServiceImp(
			HttpServletRequest request) {
		if (geesunOitemsShoppingTrolleyService == null) {
			geesunOitemsShoppingTrolleyService = (IGeesunOitemsShoppingTrolleyService) getBean("geesunOitemsShoppingTrolleyService");
		}
		return geesunOitemsShoppingTrolleyService;
	}

	public ActionForward addOitems(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-addOitems", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			((IGeesunOitemsShoppingTrolleyService) getServiceImp(request))
					.addOitems((IExtendForm) form, new RequestContext(request));
		} catch (Exception e) {
			e.printStackTrace();
		}

		TimeCounter.logCurrentTime("Action-addOitems", false, getClass());
		return null;
	}

	protected void changeFindPageHQLInfo(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		String fdListingId = request.getParameter("fdListingId");
		String fdPrice = request.getParameter("fdPrice");
		String fdApplicationId = request.getParameter("fdApplicationId");
		// String fdCategoryId = request.getParameter("fdCategoryId");
		String fdDeptId = request.getParameter("fdDeptId");
		String whereBlock = "1=1";
		if (StringUtil.isNotNull(fdApplicationId)) {
			SysOrgElement person = UserUtil.getUser();
			whereBlock = " geesunOitemsShoppingTrolley.fdApplicationId = :fdApplicationId ";
			hqlInfo.setWhereBlock(whereBlock);
			hqlInfo.setParameter("fdApplicationId", fdApplicationId);
			return;
		}
		if (StringUtil.isNotNull(fdListingId)) {

			whereBlock = " geesunOitemsShoppingTrolley.geesunOitemsListing.fdId = '"
					+ fdListingId
					+ "' and geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdOutTime>=:fdStartTime"
					+ " and geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.fdOutTime<=:fdEndTime"
					+ " and geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.docStatus ='31'"
					+ " and geesunOitemsShoppingTrolley.fdReferencePrice=:fdPrice";
			hqlInfo.setParameter("fdPrice", Double.parseDouble(fdPrice));
			if (StringUtil.isNotNull(fdDeptId) && !fdDeptId.equals("")) {
				whereBlock = StringUtil
						.linkString(
								((GeesunOitemsListingServiceImp) getGeesunOitemsListingServiceImp(request))
										.getWhereBlockByFdDeptId(request),
								" and ", whereBlock);
			}
		}
		String warehouseId = request.getParameter("warehouseId");
		if (StringUtil.isNotNull(warehouseId)) {
			whereBlock += " and geesunOitemsShoppingTrolley.geesunOitemsWarehousingRecordJoinList.fdId=:fdWarehouseId and geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication is not null and geesunOitemsShoppingTrolley.geesunOitemsBudgerApplication.docStatus = '31'";
			hqlInfo.setParameter("fdWarehouseId", warehouseId);
		}
		hqlInfo.setWhereBlock(whereBlock);
	}

	// 列出详细的出库记录
	public ActionForward listForFdListingId(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-listForListing", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			String s_pageno = request.getParameter("pageno");
			String s_rowsize = request.getParameter("rowsize");
			String orderby = request.getParameter("orderby");
			String ordertype = request.getParameter("ordertype");
			String fdStartTime = request.getParameter("fdStartTime");
			String fdEndTime = request.getParameter("fdEndTime");
			String fdListingId = request.getParameter("fdListingId");
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
			changeFindPageByFdListingIdHQLInfo(request, hqlInfo);
			if (StringUtil.isNotNull(fdListingId)) {
				fdStartTime += " 00:00:00";
				fdEndTime += " 23:59:59";
				Date startDate = DateUtil.convertStringToDate(fdStartTime,
						DateUtil.TYPE_DATETIME, Locale.getDefault());
				Date endDate = DateUtil.convertStringToDate(fdEndTime,
						DateUtil.TYPE_DATETIME, Locale.getDefault());
				hqlInfo.setParameter("fdStartTime", startDate);
				hqlInfo.setParameter("fdEndTime", endDate);
			}
			Page page = getServiceImp(request).findPage(hqlInfo);
			// 添加日志信息
			UserOperHelper.logFindAll(page.getList(),
					getServiceImp(request).getModelName());
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-listForApplication", false,
				getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("listForFdListingId", mapping, form,
					request, response);
		}
	}

	protected void changeFindPageByFdListingIdHQLInfo(
			HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
		changeFindPageHQLInfo(request, hqlInfo);
		hqlInfo.setWhereBlock(hqlInfo.getWhereBlock());
		hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
	}

	public ActionForward cancle(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-cancle", true, getClass());
		KmssMessages messages = new KmssMessages();
		String operation = request.getParameter("operation");
		try {

			if (!request.getMethod().equals("GET"))
				throw new UnexpectedRequestException();
			String id = request.getParameter("fdId");
			if (StringUtil.isNull(id))
				messages.addError(new NoRecordException());
			else
				getServiceImp(request).delete(id);

		} catch (Exception e) {
			messages.addError(e);
		}

		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_CLOSE).save(request);
		TimeCounter.logCurrentTime("Action-cancle", false, getClass());
		if (messages.hasError())
			return getActionForward("failure", mapping, form, request, response);
		else if (StringUtil.isNull(operation)) {
			return list(mapping, form, request, response);
		} else {
			return listForApplication(mapping, form, request, response);
		}
	}

	public ActionForward listForApplication(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-listForApplication", true,
				getClass());
		KmssMessages messages = new KmssMessages();
		try {
			String opertype = request.getParameter("opertype");
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
			changeFindPageHQLInfo(request, hqlInfo);
			List valueList = getServiceImp(request).findList(hqlInfo);
			// 添加日志信息
			UserOperHelper.logFindAll(valueList,
					getServiceImp(request).getModelName());
			request.setAttribute("valueList", valueList);
			request.setAttribute("size", valueList.size());
			request.setAttribute("opertype", opertype);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-listForApplication", false,
				getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("listForApplication", mapping, form,
					request, response);
		}
	}
	
	public ActionForward deleteTrolley(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-deleteTrolley", true,
				getClass());
		KmssMessages messages = new KmssMessages();
		try {
			String trolleyId = request.getParameter("trolleyId");
			GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley = (GeesunOitemsShoppingTrolley)getServiceImp(request).findByPrimaryKey(trolleyId);
			String oldValue = geesunOitemsShoppingTrolley.getFdApplicationId();
			geesunOitemsShoppingTrolley.setFdApplicationId("");
			// 添加日志信息
			if (UserOperHelper.allowLogOper("deleteTrolley",
					getServiceImp(request).getModelName())) {
				UserOperContentHelper.putUpdate(geesunOitemsShoppingTrolley)
						.putSimple("fdApplicationId", oldValue,
								geesunOitemsShoppingTrolley.getFdApplicationId());
			}
			getServiceImp(request).update(geesunOitemsShoppingTrolley);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().flush();
			response.getWriter().close();
		} catch (Exception e) {
			messages.addError(e);
		}
		return null;
	}
	
	public ActionForward loadTrolley(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-listForApplication", true,
				getClass());
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
			changeFindPageHQLInfo(request, hqlInfo);
			List valueList = getServiceImp(request).findList(hqlInfo);
			// 添加日志信息
			UserOperHelper.logFindAll(valueList,
					getServiceImp(request).getModelName());
			JSONArray jsonArr = toDataArray(valueList);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().append(jsonArr.toString());
			response.getWriter().flush();
			response.getWriter().close();
		} catch (Exception e) {
			messages.addError(e);
		}
		return null;
	}
	
	/**
	 * 转换数据成JSON
	 * 
	 * @param request
	 * @param kList
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private JSONArray toDataArray(List kList)
			throws Exception {

		JSONArray rtnArray = new JSONArray();
		for (int i = 0; i < kList.size(); i++) {
			GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley = (GeesunOitemsShoppingTrolley) kList.get(i);
			JSONObject map = new JSONObject();
			map.put("trolleyId", geesunOitemsShoppingTrolley.getFdId());
			map.put("fdListingId", geesunOitemsShoppingTrolley.getGeesunOitemsListing().getFdId());
			map.put("kmWarehousingRecordJoinListId", geesunOitemsShoppingTrolley.getGeesunOitemsWarehousingRecordJoinList().getFdId());
			map.put("fdNo", geesunOitemsShoppingTrolley.getFdNo());
			map.put("fdName", geesunOitemsShoppingTrolley.getFdName());
			map.put("fdCategoryName", geesunOitemsShoppingTrolley.getFdCategoryName());
			map.put("fdSpecification", geesunOitemsShoppingTrolley.getFdSpecification());
			map.put("fdBrand", geesunOitemsShoppingTrolley.getFdBrand());
			map.put("fdUnit", geesunOitemsShoppingTrolley.getFdUnit());
			map.put("fdReferencePrice", geesunOitemsShoppingTrolley.getFdReferencePrice());
			map.put("fdAmount", geesunOitemsShoppingTrolley.getFdAmount());
			map.put("fdApplicationNumber", geesunOitemsShoppingTrolley.getFdApplicationNumber());
			map.put("fdApplicationId",
					geesunOitemsShoppingTrolley.getFdApplicationId());
			rtnArray.add(map);
		}
		return rtnArray;
	}


	/**
	 * 添加申请数量
	 */
	public void addNumber(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String fdApplicationListingId = request
				.getParameter("fdApplicationListingId");
		String fdNumber = request.getParameter("fdNumber");
		if (StringUtil.isNotNull(fdApplicationListingId)) {
			GeesunOitemsShoppingTrolley geesunOitemsShoppingTrolley = (GeesunOitemsShoppingTrolley) getServiceImp(
					request).findByPrimaryKey(fdApplicationListingId);
			Integer oldValue = geesunOitemsShoppingTrolley.getFdApplicationNumber();
			geesunOitemsShoppingTrolley.setFdApplicationNumber(Integer
					.parseInt(fdNumber));
			if (UserOperHelper.allowLogOper("addNumber",
					getServiceImp(request).getModelName())) {
				UserOperContentHelper.putUpdate(geesunOitemsShoppingTrolley)
						.putSimple("fdApplicationNumber", oldValue,
								geesunOitemsShoppingTrolley
										.getFdApplicationNumber());
			}
			getServiceImp(request).update(geesunOitemsShoppingTrolley);
		}
	}

	public ActionForward saveExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		KmssMessages messages = new KmssMessages();
		try {
			GeesunOitemsShoppingTrolleyForm trolleyForm = (GeesunOitemsShoppingTrolleyForm) form;
			FormFile fdUploadFile = trolleyForm.getFdUploadFile();
			String fdUploadType = trolleyForm.getFdUploadType();
			String fdAppId = trolleyForm.getFdApplicationId();
			if ("replace".equals(fdUploadType)) {
				getServiceImp(request).deleteShoppingTrolley(fdAppId);
			}
			UploadResultBean result = new UploadResultBean();// 操作结果集
			if (fdUploadFile.getFileSize() == 0) {
				KmssMessage error = new KmssMessage(
						"geesun-oitems:geesunOitemsWarehousingRecord.upload.excel.empty");
				messages.addError(error);
			} else {
				List<GeesunOitemsShoppingTrolley> shops = new ArrayList<GeesunOitemsShoppingTrolley>();
				POIFSFileSystem fs = new POIFSFileSystem(
						fdUploadFile.getInputStream());
				HSSFWorkbook wb = new HSSFWorkbook(fs);
				HSSFSheet sheet = wb.getSheetAt(0);
				for (int i = 1, n = sheet.getLastRowNum(); i <= n; i++) {
					boolean canSave = true;
					HSSFCell c1 = sheet.getRow(i).getCell((short) 0);// 读取用品编号
					GeesunOitemsListing oitem = null;
					if (c1 != null) {
						String fdNo = c1.getStringCellValue();
						oitem = getGeesunOitemsListingServiceImp(
								request).findByFdNo(fdNo);
						if (oitem == null) {
							String[] args = { "" + (i + 1), fdNo };
							result.addErrorMsg(ResourceUtil.getString(
									"geesunOitemsShoppingTrolley.import.msg1",
									"geesun-oitems", null, args));
							canSave = false;
							continue;
						} else {
							
							if (!UserUtil.getKMSSUser().isAdmin()) {
							SysOrgPerson curUser = UserUtil.getUser();
							GeesunOitemsManage fdCategory = oitem.getFdCategory();
								// 权限过滤
								boolean flag = getFlag(fdCategory, curUser,
										oitem);
							if (!flag) {
								String[] args = { "" + (i + 1), fdNo };
								result.addErrorMsg(ResourceUtil.getString(
										"geesunOitemsShoppingTrolley.import.msg6",
										"geesun-oitems", null, args));
								canSave = false;
								continue;
							}
						}
						if (!oitem.getFdIsAbandon()) {
							String[] args = { "" + (i + 1), fdNo };
							result.addErrorMsg(ResourceUtil.getString("geesunOitemsShoppingTrolley.import.msg5",
									"geesun-oitems", null, args));
							canSave = false;
							continue;
							}
						}
					} else {
						String fdArgs[] = { "" + (i + 1),
								ResourceUtil.getString("geesunOitemsListing.fdNo",
										"geesun-oitems"),
								ResourceUtil.getString(
										"geesunOitems.import.required",
										"geesun-oitems") };
						result.addErrorMsg(ResourceUtil.getString(
								"geesunOitems.import.message3",
								"geesun-oitems", null, fdArgs));
						canSave = false;
						continue;
					}
					HSSFCell c3 = sheet.getRow(i).getCell((short) 2);
					Double price = null;
					if (c3 != null
							&& Math.abs(c3.getNumericCellValue() - 0.0) > Math
									.pow(10, -9)) {
						price = Double.valueOf(c3.getNumericCellValue());
					} else {
						price = oitem.getFdReferencePrice();
					}
					GeesunOitemsWarehousingRecordJoinList record = getGeesunOitemsWarehousingRecordJoinListService(
							request).findByOitemPrice(oitem, price);
					if (record == null) {
						String[] args = { "" + (i + 1), oitem.getFdNo(),
								price.toString() };
						result.addErrorMsg(ResourceUtil.getString(
								"geesunOitemsShoppingTrolley.import.msg2",
								"geesun-oitems", null, args));
						canSave = false;
						continue;
					}
					if (!getServiceImp(request).checkShop(fdAppId, record)) {
						String[] args = { "" + (i + 1), oitem.getFdNo(),
								price.toString() };
						result.addErrorMsg(ResourceUtil.getString(
								"geesunOitemsShoppingTrolley.import.msg3",
								"geesun-oitems", null, args));
						canSave = false;
						continue;
					}
					HSSFCell c2 = sheet.getRow(i).getCell((short) 1); // 读取领用数量
					c2.setCellType(Cell.CELL_TYPE_STRING);
					Integer appNum = null;
					if (c2 != null
							&& StringUtil.isNotNull(c2.getStringCellValue())) {
						appNum = Integer.valueOf(c2.getStringCellValue());
						Integer curNum = record.getFdCurNumber();
						if (curNum < appNum) {
							String[] args = { "" + (i + 1), oitem.getFdNo() };
							result.addErrorMsg(ResourceUtil.getString(
									"geesunOitemsShoppingTrolley.import.msg4",
									"geesun-oitems", null, args));
							canSave = false;
							continue;
						}
					} else {
						String fdArgs[] = { "" + (i + 1),
								ResourceUtil.getString(
										"geesunOitemsReportListing.number",
										"geesun-oitems"),
								ResourceUtil.getString(
										"geesunOitems.import.required",
										"geesun-oitems") };
						result.addErrorMsg(ResourceUtil.getString(
								"geesunOitems.import.message3",
								"geesun-oitems", null, fdArgs));
						canSave = false;
						continue;
					}
					if (canSave) {
						GeesunOitemsShoppingTrolley shop = new GeesunOitemsShoppingTrolley();
						shop.setFdApplicationId(fdAppId);
						shop.setFdApplicationNumber(appNum);
						shop.setGeesunOitemsListing(oitem);
						shop.setGeesunOitemsWarehousingRecordJoinList(record);
						shop.setFdNo(oitem.getFdNo());
						shop.setFdName(oitem.getFdName());
						shop.setFdCategoryName(
								oitem.getFdCategory().getFdName());
						shop.setFdSpecification(oitem.getFdSpecification());
						shop.setFdBrand(oitem.getFdBrand());
						shop.setFdUnit(oitem.getFdUnit());
						shop.setFdAmount(record.getFdCurNumber());
						shop.setFdReferencePrice(record.getFdPrice());
						if (!shops.contains(shop))
							shops.add(shop);
					}
				}
				if (!messages.hasError() && result.getErrorMsgs().isEmpty()
						&& !shops.isEmpty()) {
					getServiceImp(request).addShops(shops, fdAppId);
				}
			}
			request.setAttribute("result", result);
		} catch (Exception e) {
			messages.addError(e);
			e.printStackTrace();
		}
		return mapping.findForward("saveExcel");
	}

	// 获取是否有导入的权限
	private boolean getFlag(GeesunOitemsManage fdCategory, SysOrgPerson curUser,
			GeesunOitemsListing oitem) {
		boolean flag = false;
		// 当前登录人所在组群
		List<SysOrgGroup> personGroups = curUser.getFdGroups();
		if (!ArrayUtil.isEmpty(personGroups)) {
			for (SysOrgGroup persongroup : personGroups) {
				if (oitem.getAuthReaders().contains(persongroup)) {
					flag = true;
				}
			}
		}
		// 当前登录人所在部门所在组群
		List<SysOrgGroup> parentGroups = curUser.getFdParent().getFdGroups();
		if (!ArrayUtil.isEmpty(parentGroups)) {
			for (SysOrgGroup parentgroup : parentGroups) {
				if (oitem.getAuthReaders().contains(parentgroup)) {
					flag = true;
				}
			}
		}
		if ((fdCategory.getAuthUseFlag()
				|| fdCategory.getAuthUses()
						.contains(curUser))
				&& oitem.getAuthReaderFlag()
				|| oitem.getAuthReaders().contains(curUser)) {
			flag = true;
		} else if (oitem.getAuthReaders().contains(curUser.getFdParent())) {
			flag = true;
		}
		return flag;
	}
}
