package com.landray.kmss.geesun.leave.actions;

import com.landray.kmss.geesun.leave.model.GeesunLeaveBarter;
import com.landray.kmss.geesun.leave.forms.GeesunLeaveBarterForm;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.geesun.leave.service.IGeesunLeaveBarterService;
import javax.servlet.http.HttpServletRequest;
import com.landray.kmss.web.action.ActionForm;
import javax.servlet.http.HttpServletResponse;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunLeaveBarterAction extends ExtendAction {

	private IGeesunLeaveBarterService geesunLeaveBarterService;

	public IBaseService getServiceImp(HttpServletRequest request) {
		if (geesunLeaveBarterService == null) {
			geesunLeaveBarterService = (IGeesunLeaveBarterService) getBean("geesunLeaveBarterService");
		}
		return geesunLeaveBarterService;
	}

	public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
		HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunLeaveBarter.class);
		hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
		com.landray.kmss.geesun.leave.util.GeesunLeaveUtil.buildHqlInfoDate(hqlInfo, request,
				com.landray.kmss.geesun.leave.model.GeesunLeaveBarter.class);
		com.landray.kmss.geesun.leave.util.GeesunLeaveUtil.buildHqlInfoModel(hqlInfo, request);
	}

	public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		GeesunLeaveBarterForm geesunLeaveBarterForm = (GeesunLeaveBarterForm) super.createNewForm(mapping, form,
				request, response);
		((IGeesunLeaveBarterService) getServiceImp(request)).initFormSetting((IExtendForm) form, new RequestContext(
				request));
		return geesunLeaveBarterForm;
	}
}
