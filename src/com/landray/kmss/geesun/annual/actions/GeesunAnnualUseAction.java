package com.landray.kmss.geesun.annual.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.constant.SysDocConstant;
import com.landray.kmss.geesun.annual.forms.GeesunAnnualUseForm;
import com.landray.kmss.geesun.annual.model.GeesunAnnualUse;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualUseService;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunAnnualUseAction extends ExtendAction {

    private IGeesunAnnualUseService geesunAnnualUseService;

    public IBaseService getServiceImp(HttpServletRequest request) {
        if (geesunAnnualUseService == null) {
            geesunAnnualUseService = (IGeesunAnnualUseService) getBean("geesunAnnualUseService");
        }
        return geesunAnnualUseService;
    }

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunAnnualUse.class);
        String whereBlock = hqlInfo.getWhereBlock();
        String type = request.getParameter("type");
		String fdModelId = request.getParameter("modelId");
		if (StringUtil.isNotNull(fdModelId)) {
			whereBlock = StringUtil.linkString(whereBlock, " and ", "geesunAnnualUse.fdAnnual.fdId=:fdModelId");
			hqlInfo.setParameter("fdModelId", fdModelId);
		}
		if (StringUtil.isNotNull(type)) {
			hqlInfo.setJoinBlock(", com.landray.kmss.km.review.model.KmReviewMain kmReviewMain");
			whereBlock = StringUtil.linkString(whereBlock, " and ", "geesunAnnualUse.fdModelId = kmReviewMain.fdId and kmReviewMain.docStatus=:docStatus");
			hqlInfo.setParameter("docStatus", "using".equals(type)?SysDocConstant.DOC_STATUS_EXAMINE:SysDocConstant.DOC_STATUS_PUBLISH);
		}
		hqlInfo.setWhereBlock(whereBlock);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.annual.util.GeesunAnnualUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.annual.model.GeesunAnnualUse.class);
        com.landray.kmss.geesun.annual.util.GeesunAnnualUtil.buildHqlInfoModel(hqlInfo, request);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunAnnualUseForm geesunAnnualUseForm = (GeesunAnnualUseForm) super.createNewForm(mapping, form, request, response);
        ((IGeesunAnnualUseService) getServiceImp(request)).initFormSetting((IExtendForm) form, new RequestContext(request));
        return geesunAnnualUseForm;
    }
    
    public ActionForward listdata(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		super.list(mapping, form, request, response);
		return mapping.findForward("data");
	}
    
}
