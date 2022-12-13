package com.landray.kmss.geesun.annual.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.test.TimeCounter;
import com.landray.kmss.geesun.annual.forms.GeesunAnnualAlterForm;
import com.landray.kmss.geesun.annual.model.GeesunAnnualAlter;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualAlterService;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;
import com.sunbor.web.tag.Page;

public class GeesunAnnualAlterAction extends ExtendAction {

    private IGeesunAnnualAlterService geesunAnnualAlterService;

    public IGeesunAnnualAlterService getServiceImp(HttpServletRequest request) {
        if (geesunAnnualAlterService == null) {
            geesunAnnualAlterService = (IGeesunAnnualAlterService) getBean("geesunAnnualAlterService");
        }
        return geesunAnnualAlterService;
    }

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunAnnualAlter.class);
        String whereBlock = hqlInfo.getWhereBlock();
		String fdModelId = request.getParameter("modelId");
		if (StringUtil.isNotNull(fdModelId)) {
			if (StringUtil.isNull(whereBlock)) {
				whereBlock = " geesunAnnualAlter.fdModelId=:fdModelId";
			} else {
				whereBlock += " and geesunAnnualAlter.fdModelId=:fdModelId";
			}
			hqlInfo.setParameter("fdModelId", fdModelId);
		}
		hqlInfo.setWhereBlock(whereBlock);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.annual.util.GeesunAnnualUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.annual.model.GeesunAnnualAlter.class);
        com.landray.kmss.geesun.annual.util.GeesunAnnualUtil.buildHqlInfoModel(hqlInfo, request);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunAnnualAlterForm geesunAnnualAlterForm = (GeesunAnnualAlterForm) super.createNewForm(mapping, form, request, response);
        ((IGeesunAnnualAlterService) getServiceImp(request)).initFormSetting((IExtendForm) form, new RequestContext(request));
        return geesunAnnualAlterForm;
    }
    
    public ActionForward show(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Page page = getServiceImp(request).findAlterFieldRecord(new RequestContext(request));
		request.setAttribute("queryPage", page);
		return mapping.findForward("show");
	}
    
    public ActionForward listShow(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TimeCounter.logCurrentTime("Action-listShow", true, getClass());
		KmssMessages messages = new KmssMessages();
		try {
			Page page = getServiceImp(request).findAlterFieldRecord(new RequestContext(request));
			request.setAttribute("queryPage", page);
		} catch (Exception e) {
			messages.addError(e);
		}

		TimeCounter.logCurrentTime("Action-listShow", false, getClass());
		if (messages.hasError()) {
			KmssReturnPage.getInstance(request).addMessages(messages)
					.addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
			return getActionForward("failure", mapping, form, request, response);
		} else {
			return getActionForward("list", mapping, form, request, response);
		}
	}
    
    public ActionForward listdata(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		super.list(mapping, form, request, response);
		return mapping.findForward("data");
	}
    
}
