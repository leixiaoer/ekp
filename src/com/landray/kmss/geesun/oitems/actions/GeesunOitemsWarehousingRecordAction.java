package com.landray.kmss.geesun.oitems.actions;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsWarehousingRecordForm;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsListing;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsManage;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsListingService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsManageService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordJoinListService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordService;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

import net.sf.json.JSONObject;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟
 */
public class GeesunOitemsWarehousingRecordAction extends ExtendAction

{
	protected IGeesunOitemsWarehousingRecordService geesunOitemsWarehousingRecordService;

	protected IGeesunOitemsWarehousingRecordService getServiceImp(HttpServletRequest request) {
		if (geesunOitemsWarehousingRecordService == null)
			geesunOitemsWarehousingRecordService = (IGeesunOitemsWarehousingRecordService) getBean("geesunOitemsWarehousingRecordService");
		return geesunOitemsWarehousingRecordService;
	}

	protected IGeesunOitemsWarehousingRecordJoinListService geesunOitemsWarehousingRecordJoinListService;

	protected IGeesunOitemsWarehousingRecordJoinListService getGeesunOitemsWarehousingRecordJoinListService(
			HttpServletRequest request) {
		if (geesunOitemsWarehousingRecordJoinListService == null)
			geesunOitemsWarehousingRecordJoinListService = (IGeesunOitemsWarehousingRecordJoinListService) getBean("geesunOitemsWarehousingRecordJoinListService");
		return geesunOitemsWarehousingRecordJoinListService;
	}

	protected IGeesunOitemsListingService geesunOitemsListingService;

	protected IBaseService getGeesunOitemsListingService(HttpServletRequest request) {
		if (geesunOitemsListingService == null)
			geesunOitemsListingService = (IGeesunOitemsListingService) getBean("geesunOitemsListingService");
		return geesunOitemsListingService;
	}

	@Override
	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GeesunOitemsWarehousingRecordForm geesunOitemsWarehousingRecordForm = (GeesunOitemsWarehousingRecordForm) super
				.createNewForm(mapping, form, request, response);
		String fdOitemsId = request.getParameter("fdOitemsId");
		if (StringUtil.isNotNull(fdOitemsId)) {
			GeesunOitemsListing geesunOitemsListing = (GeesunOitemsListing) getGeesunOitemsListingService(
					request).findByPrimaryKey(fdOitemsId);
			geesunOitemsWarehousingRecordForm.setFdListingName(geesunOitemsListing
					.getFdName());
			geesunOitemsWarehousingRecordForm.setFdListingId(geesunOitemsListing
					.getFdId());
			geesunOitemsWarehousingRecordForm.setFdListingNo(geesunOitemsListing
					.getFdNo());
			geesunOitemsWarehousingRecordForm.setFdAccountNumber(geesunOitemsListing
					.getFdAmount().toString());
			geesunOitemsWarehousingRecordForm.setFdPrice(geesunOitemsListing
					.getFdReferencePrice().toString());

		}
		return geesunOitemsWarehousingRecordForm;

	}
	public ActionForward checkNumByPrice(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		String res = "false";
		String msg = "";
		try {
				if (!request.getMethod().equals("POST"))
				throw new UnexpectedRequestException();
				String fdPrice = request.getParameter("fdPrice");
				String fdNumber = request.getParameter("fdNumber");
				String fdListingId = request.getParameter("fdListingId");
				HQLInfo hqlInfo = new HQLInfo();
				hqlInfo.setWhereBlock("geesunOitemsWarehousingRecordJoinList.fdPrice="
					+ fdPrice+" and geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdId='"+fdListingId+"'");
				List<GeesunOitemsWarehousingRecordJoinList> list = getGeesunOitemsWarehousingRecordJoinListService(request).findList(
						hqlInfo);
				if(list.size()>0){
					if(list.get(0).getFdCurNumber()+ Integer.parseInt(fdNumber)<0){
				    	res = "true";
				    	msg = "over";
					}
			    }else{
			    	if(Integer.parseInt(fdNumber)<0){
			    		res = "true";
			    		msg = "notExist";
			    	}
			    }
		} catch (Exception e) {
			e.printStackTrace();
			messages.addError(e);
		}
		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_RETURN).save(request);
		TimeCounter.logCurrentTime("Action-save", false, getClass());
		JSONObject json = new JSONObject();
		json.put("value", res);
		json.put("msg", msg);
		response.getWriter().append(json.toString());
		response.getWriter().flush();
		response.getWriter().close();
		return null;
	}
	
	@Override
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			getServiceImp(request).addRecord((IExtendForm) form,
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
 

	protected void changeFindPageHQLInfo(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		String whereBlock = hqlInfo.getWhereBlock();
		if (StringUtil.isNull(whereBlock)) {
			whereBlock = " 1=1 ";
		}
		String fdListingId = request.getParameter("fdListingId");
		String fdPrice=request.getParameter("fdPrice");
		if (StringUtil.isNotNull(fdListingId)) {
			whereBlock += " and geesunOitemsWarehousingRecord.geesunOitemsListing.fdId=:fdListingId ";
			hqlInfo.setParameter("fdListingId", fdListingId);
		}		
		String fdStartTime = request.getParameter("fdStartTime");
		String fdEndTime = request.getParameter("fdEndTime");
		if (fdStartTime != null && fdEndTime != null) {
			whereBlock = StringUtil.linkString(
					"geesunOitemsWarehousingRecord.docCreateTime>=:fdStartTime",
					" and ", whereBlock);
			whereBlock = StringUtil.linkString(
					"geesunOitemsWarehousingRecord.docCreateTime<=:fdEndTime",
					" and ", whereBlock);
			fdStartTime += " 00:00:00";
			fdEndTime += " 23:59:59";
			hqlInfo.setParameter("fdStartTime", new SimpleDateFormat(ResourceUtil
					.getString("date.format.datetime")).parse(fdStartTime));
			hqlInfo.setParameter("fdEndTime", new SimpleDateFormat(ResourceUtil
					.getString("date.format.datetime")).parse(fdEndTime));
		}
		String fdCategoryId = request.getParameter("categoryId");
		if (StringUtil.isNotNull(fdCategoryId)) {
			GeesunOitemsManage geesunOitemsManage = (GeesunOitemsManage) ((IGeesunOitemsManageService) getBean("geesunOitemsManageService"))
					.findByPrimaryKey(fdCategoryId);
			whereBlock += " and geesunOitemsWarehousingRecord.geesunOitemsListing.fdCategory.fdHierarchyId like :FdHierarchyId "; 
			hqlInfo.setParameter("FdHierarchyId", "%" + geesunOitemsManage.getFdHierarchyId() + "%");
		}
		if (StringUtil.isNotNull(fdPrice)) {
			whereBlock =whereBlock+ " and geesunOitemsWarehousingRecord.fdPrice=:fdPrice";
			hqlInfo.setParameter("fdPrice", Double.parseDouble(fdPrice));
		}

		hqlInfo.setWhereBlock(whereBlock); 
		hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
	}
}
