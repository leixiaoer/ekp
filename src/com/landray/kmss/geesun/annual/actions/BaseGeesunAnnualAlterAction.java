package com.landray.kmss.geesun.annual.actions;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.geesun.annual.interfaces.IGeesunAnnualAlterForm;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualAlterService;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

public abstract class BaseGeesunAnnualAlterAction extends ExtendAction {

	private IGeesunAnnualAlterService geesunAnnualAlterService;

    public IGeesunAnnualAlterService getGeesunAnnualAlterService() {
        if (geesunAnnualAlterService == null) {
            geesunAnnualAlterService = (IGeesunAnnualAlterService) getBean("geesunAnnualAlterService");
        }
        return geesunAnnualAlterService;
    }
	
	@Override
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		if(form instanceof IGeesunAnnualAlterForm) {
			getGeesunAnnualAlterService().updateAlterFieldRecord((IGeesunAnnualAlterForm)form);
		}
		return super.update(mapping, form, request, response);
	}
	
	@Override
	public ActionForward view(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ActionForward actionForward= super.view(mapping, form, request, response);
		this.setHistoryAlter(mapping, form, request, response);
		return actionForward;
	}
	
	protected void setHistoryAlter(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		if(form instanceof IGeesunAnnualAlterForm) {
			IGeesunAnnualAlterForm hisForm=(IGeesunAnnualAlterForm)form;
			request.setAttribute("formName", super.getFormName(form, request));
			RequestContext context=new RequestContext(request);
			context.setParameter("modelName",hisForm.getModelClass().getName());
			context.setParameter("modelId",request.getParameter("fdId"));
			int size =getGeesunAnnualAlterService().findAlterFieldRecordSize(context);
			hisForm.setHistoryRowsSize(size);
		}
	}
	
}
