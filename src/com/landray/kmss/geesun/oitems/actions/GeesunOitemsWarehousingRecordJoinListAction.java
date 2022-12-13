package com.landray.kmss.geesun.oitems.actions;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsManage;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsBudgerApplicationService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsListingService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsManageService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordJoinListService;
import com.landray.kmss.sys.config.model.SysConfigParameters;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

import net.sf.json.JSONObject;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟
 */
public class GeesunOitemsWarehousingRecordJoinListAction extends ExtendAction

{
	protected IGeesunOitemsWarehousingRecordJoinListService geesunOitemsWarehousingRecordJoinListService;
	protected IGeesunOitemsWarehousingRecordJoinListService getServiceImp(HttpServletRequest request) {
		if (geesunOitemsWarehousingRecordJoinListService == null)
			geesunOitemsWarehousingRecordJoinListService = (IGeesunOitemsWarehousingRecordJoinListService) getBean("geesunOitemsWarehousingRecordJoinListService");
		return geesunOitemsWarehousingRecordJoinListService;
	}

	protected IGeesunOitemsListingService geesunOitemsListingService;

	protected IGeesunOitemsListingService getGeesunOitemsListingService(HttpServletRequest request) {
		if (geesunOitemsListingService == null)
			geesunOitemsListingService = (IGeesunOitemsListingService) getBean("geesunOitemsListingService");
		return geesunOitemsListingService;
	}
	
	protected IGeesunOitemsBudgerApplicationService geesunOitemsBudgerApplicationService;

	public IGeesunOitemsBudgerApplicationService getGeesunOitemsBudgerApplicationService() {
		if (geesunOitemsBudgerApplicationService == null) {
			geesunOitemsBudgerApplicationService = (IGeesunOitemsBudgerApplicationService) getBean("geesunOitemsBudgerApplicationService");
		}
		return geesunOitemsBudgerApplicationService;
	}
	protected void changeFindPageHQLInfo(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		String whereBlock = hqlInfo.getWhereBlock();
		if (StringUtil.isNull(whereBlock)) {
			whereBlock = " 1=1 ";
		}
		String fdListingId = request.getParameter("fdListingId");
		if (StringUtil.isNotNull(fdListingId)) {
			whereBlock += " and geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdId=:fdListingId ";
			hqlInfo.setParameter("fdListingId", fdListingId);
	    }
		String fdCategoryId = request.getParameter("categoryId");
		if (StringUtil.isNotNull(fdCategoryId)) {
			GeesunOitemsManage geesunOitemsManage = (GeesunOitemsManage) ((IGeesunOitemsManageService) getBean("geesunOitemsManageService"))
					.findByPrimaryKey(fdCategoryId);
			whereBlock += " and geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdCategory.fdHierarchyId like '%"
					+ geesunOitemsManage.getFdHierarchyId() + "%'";
		}
		hqlInfo.setWhereBlock(whereBlock.toString());
	}
	
	public ActionForward checkNum(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		String geesunOitemsListingId = request.getParameter("geesunOitemsListingId");
		String moreThanOne = "false";
		JSONObject json = new JSONObject();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setWhereBlock("geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdId= :geesunOitemsListingId and geesunOitemsWarehousingRecordJoinList.fdCurNumber>0");
			hqlInfo.setParameter("geesunOitemsListingId", geesunOitemsListingId);
			List<GeesunOitemsWarehousingRecordJoinList>  geesunOitemsWarehousingRecordJoinList =getServiceImp(request).findList(hqlInfo);
			if(geesunOitemsWarehousingRecordJoinList.size()>1){
				moreThanOne="true";
			}else if(geesunOitemsWarehousingRecordJoinList.size()==1){
				json.put("geesunOitemsWarehousingRecordJoinListId", geesunOitemsWarehousingRecordJoinList.get(0).getFdId());
				json.put("fdPrice", geesunOitemsWarehousingRecordJoinList.get(0).getFdPrice());
				json.put("curNum", geesunOitemsWarehousingRecordJoinList.get(0).getFdCurNumber());
				json.put("geesunOitemsListingId", geesunOitemsWarehousingRecordJoinList.get(0).getGeesunOitemsListing().getFdId());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			messages.addError(e);
		}
		
		json.put("moreThanOne", moreThanOne);
		
		
		response.setCharacterEncoding("UTF-8");
		response.getWriter().append(json.toString());
		response.getWriter().flush();
		response.getWriter().close();
		return null;

	}
	
	public ActionForward listRecord(ActionMapping mapping, ActionForm form,
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
			changeFindPageHQLInfo(request, hqlInfo);
			String whereBlock=hqlInfo.getWhereBlock();
			if(whereBlock==null)
			whereBlock="1=1";
			whereBlock+=" and geesunOitemsWarehousingRecordJoinList.fdCurNumber > 0";
			hqlInfo.setWhereBlock(whereBlock);
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
			return getActionForward("listRecord", mapping, form, request, response);
		}
	}
}

