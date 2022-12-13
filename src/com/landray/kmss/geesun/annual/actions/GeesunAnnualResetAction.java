package com.landray.kmss.geesun.annual.actions;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import com.landray.kmss.geesun.annual.model.GeesunAnnualReset;
import com.landray.kmss.geesun.annual.forms.GeesunAnnualResetForm;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualResetService;
import javax.servlet.http.HttpServletRequest;
import com.landray.kmss.web.action.ActionForm;
import javax.servlet.http.HttpServletResponse;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.geesun.annual.util.GeesunAnnualUtil;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunAnnualResetAction extends ExtendAction {

    private IGeesunAnnualResetService geesunAnnualResetService;

    public IBaseService getServiceImp(HttpServletRequest request) {
        if (geesunAnnualResetService == null) {
            geesunAnnualResetService = (IGeesunAnnualResetService) getBean("geesunAnnualResetService");
        }
        return geesunAnnualResetService;
    }

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunAnnualReset.class);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.annual.util.GeesunAnnualUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.annual.model.GeesunAnnualReset.class);
        com.landray.kmss.geesun.annual.util.GeesunAnnualUtil.buildHqlInfoModel(hqlInfo, request);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunAnnualResetForm geesunAnnualResetForm = (GeesunAnnualResetForm) super.createNewForm(mapping, form, request, response);
        ((IGeesunAnnualResetService) getServiceImp(request)).initFormSetting((IExtendForm) form, new RequestContext(request));
        return geesunAnnualResetForm;
    }
}
