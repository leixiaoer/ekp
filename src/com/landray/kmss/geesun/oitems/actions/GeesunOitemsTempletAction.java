package com.landray.kmss.geesun.oitems.actions;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.constant.SysAuthConstant;
import com.landray.kmss.geesun.oitems.forms.GeesunOitemsTempletForm;
import com.landray.kmss.geesun.oitems.interfaces.Constants;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsTemplet;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsTempletService;
import com.landray.kmss.sys.log.util.UserOperHelper;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

/**
 * 创建日期 2010-二月-26
 * 
 * @author 陈伟
 */
public class GeesunOitemsTempletAction extends ExtendAction

{
	protected IGeesunOitemsTempletService geesunOitemsTempletService;

	protected IGeesunOitemsTempletService getServiceImp(HttpServletRequest request) {
		if (geesunOitemsTempletService == null)
			geesunOitemsTempletService = (IGeesunOitemsTempletService) getBean("geesunOitemsTempletService");
		return geesunOitemsTempletService;
	}

	protected ActionForm createNewForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		super.createNewForm(mapping, form, request, response);
		GeesunOitemsTempletForm geesunOitemsTempletForm = (GeesunOitemsTempletForm) form;
		geesunOitemsTempletForm.setDocCreatorId(UserUtil.getUser().getFdId()
				.toString());
		geesunOitemsTempletForm.setDocCreatorName(UserUtil.getUser().getFdName());
		geesunOitemsTempletForm.setDocCreateTime(DateUtil.convertDateToString(
				new Date(), DateUtil.TYPE_DATETIME, request.getLocale()));
		String fdType = request.getParameter("type");
		if ("dept".equals(fdType)) {
			geesunOitemsTempletForm.setFdTempletType(Constants.GEESUNOITEMS_TYPE_DEPT);
		} else {
			geesunOitemsTempletForm
					.setFdTempletType(Constants.GEESUNOITEMS_TYPE_PERSON);
		}
		if(!UserUtil.getKMSSUser().isAdmin()){
			geesunOitemsTempletForm.setAuthEditorIds(UserUtil.getUser().getFdId());
			geesunOitemsTempletForm.setAuthEditorNames(UserUtil.getUser().getFdName());
		}
		return geesunOitemsTempletForm;
	}
	
	protected void changeFindPageHQLInfo(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		String fdType = request.getParameter("type");
		request.setAttribute("type", fdType);
		if ("dept".equals(fdType)) {
			hqlInfo.setWhereBlock("geesunOitemsTemplet.fdTempletType = " +Constants.GEESUNOITEMS_TYPE_DEPT);
		} else {
			hqlInfo.setWhereBlock("geesunOitemsTemplet.fdTempletType = " +Constants.GEESUNOITEMS_TYPE_PERSON);
		}
		CriteriaValue cv = new CriteriaValue(request);
		CriteriaUtil.buildHql(cv, hqlInfo, GeesunOitemsTemplet.class);
		// hqlInfo.setOrderBy("geesunOitemsTemplet.docCreateTime asc");
	}

	public ActionForward getTemp(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		String fdType = request.getParameter("fdType");
		JSONArray rtnArray = new JSONArray();
		try {
			HQLInfo hqlInfo = new HQLInfo();
			hqlInfo.setWhereBlock("geesunOitemsTemplet.fdTempletType = :fdTempletType");
			hqlInfo.setParameter("fdTempletType", Integer.parseInt(fdType));
			if (hqlInfo.getCheckParam(SysAuthConstant.CheckType.AllCheck) == null) {
				hqlInfo.setCheckParam(SysAuthConstant.CheckType.AllCheck,
						SysAuthConstant.AllCheck.DEFAULT);
			    hqlInfo.setAuthCheckType(SysAuthConstant.AUTH_CHECK_READER);
			}
		   List<GeesunOitemsTemplet> geesunOitemsTempletlist = getServiceImp(request).findList(hqlInfo);
			// 添加日志信息
			UserOperHelper.logFindAll(geesunOitemsTempletlist,
					getServiceImp(request).getModelName());
			for (int i = 0; i < geesunOitemsTempletlist.size(); i++) {
				GeesunOitemsTemplet geesunOitemsTemplet =  geesunOitemsTempletlist.get(i);
				JSONObject map = new JSONObject();
				map.put("fdId", geesunOitemsTemplet.getFdId());
				map.put("fdName", geesunOitemsTemplet.getFdName());
				rtnArray.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			messages.addError(e);
		}
		KmssReturnPage.getInstance(request).addMessages(messages).addButton(
				KmssReturnPage.BUTTON_RETURN).save(request);
		TimeCounter.logCurrentTime("Action-save", false, getClass());
		response.setCharacterEncoding("UTF-8");
		response.getWriter().append(rtnArray.toString());
		response.getWriter().flush();
		response.getWriter().close();
		return null;
	}

	
	
	/**
	protected void loadActionForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		form.reset(mapping, request);
		IExtendForm rtnForm = null;
		String fdType = request.getParameter("type");
		request.setAttribute("fdType", fdType);
		BaseModel baseModel = null;
		if ("dept".equals(fdType)) {
			List<GeesunOitemsTemplet> modelList = getServiceImp(request)
					.findList(
							"geesunOitemsTemplet.fdTempletType = "
									+ Constants.GEESUNOITEMS_TYPE_DEPT,
							"geesunOitemsTemplet.docCreateTime asc");
			if (modelList != null && modelList.size() > 0) {
				baseModel = modelList.get(0);
			}
		} else {
			List<GeesunOitemsTemplet> modelList = getServiceImp(request)
					.findList(
							"geesunOitemsTemplet.fdTempletType = "
									+ Constants.GEESUNOITEMS_TYPE_PERSON,
							"geesunOitemsTemplet.docCreateTime asc");
			if (modelList != null && modelList.size() > 0) {
				baseModel = modelList.get(0);
			}
		}
		if(baseModel!=null){
			rtnForm = getServiceImp(request).convertModelToForm(
					(IExtendForm) form, baseModel,
					new RequestContext(request));
			request.setAttribute(getFormName(rtnForm, request), rtnForm);
		}else{
			//无记录
			request.setAttribute("fdsize", 0);
		}
	}
**/
	
	/**
	@Override
	public ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-edit", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			form.reset(mapping, request);
			IExtendForm rtnForm = null;
			String fdId = request.getParameter("fdId");
			String fdType = request.getParameter("type");
			BaseModel baseModel = null;
			if (!StringUtil.isNull(fdId)) {
				baseModel = (BaseModel) getServiceImp(request)
						.findByPrimaryKey(fdId, null, true);
			}
			if (!StringUtil.isNull(fdType)) {
				if ("dept".equals(fdType)) {
					List<GeesunOitemsTemplet> modelList = getServiceImp(request)
							.findList(
									"geesunOitemsTemplet.fdTempletType = "
											+ Constants.GEESUNOITEMS_TYPE_DEPT,
									"geesunOitemsTemplet.docCreateTime asc");
					if (modelList != null && modelList.size() > 0) {
						baseModel = modelList.get(0);
					}
				} else {
					List<GeesunOitemsTemplet> modelList = getServiceImp(request)
							.findList(
									"geesunOitemsTemplet.fdTempletType = "
											+ Constants.GEESUNOITEMS_TYPE_PERSON,
									"geesunOitemsTemplet.docCreateTime asc");
					if (modelList != null && modelList.size() > 0) {
						baseModel = modelList.get(0);
					}
				}
			}
			if (baseModel == null) {
				GeesunOitemsTempletForm geesunOitemsTempletForm = (GeesunOitemsTempletForm) form;
				geesunOitemsTempletForm.setMethod_GET("add");
				geesunOitemsTempletForm.setMethod("add");
				return add(mapping, form, request, response);
			} else {
				rtnForm = getServiceImp(request).convertModelToForm(
						(IExtendForm) form, baseModel,
						new RequestContext(request));
			}
			if (rtnForm == null)
				throw new NoRecordException();
			request.setAttribute(getFormName(rtnForm, request), rtnForm);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-edit", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("edit", mapping, form, request, response);
		}
	}
**/

	@Override
	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-add", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			ActionForm newForm = createNewForm(mapping, form, request, response);
			if (newForm != form)
				request.setAttribute(getFormName(newForm, request), newForm);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-add", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("edit", mapping, form, request, response);
		}
	}

	@Override
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-save", true, getClass());
		KmssMessages messages = new KmssMessages();
		String id = null;
		try {
			if (!request.getMethod().equals("POST"))
				throw new UnexpectedRequestException();
			id = getServiceImp(request).add((IExtendForm) form,
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
			.addButton(
					"button.back",
					"/geesun/oitems/geesun_oitems_templet/geesunOitemsTemplet.do?method=edit&fdId="
							+ id, false).addButton(
					KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("success", mapping, form, request, response);
		}
	}

	@Override
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TimeCounter.logCurrentTime("Action-update", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			if (!request.getMethod().equals("POST"))
				throw new UnexpectedRequestException();
			getServiceImp(request).update((IExtendForm) form,
					new RequestContext(request));
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-update", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages).save(
					request);
			return getActionForward("edit", mapping, form, request, response);
		} else {
			KmssReturnPage.getInstance(request).addMessages(messages)
			.addButton(KmssReturnPage.BUTTON_RETURN).addButton(
					KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("success", mapping, form, request, response);
		}
	}

	protected String getParentProperty() {
		return "hbmParent";
	}
}
