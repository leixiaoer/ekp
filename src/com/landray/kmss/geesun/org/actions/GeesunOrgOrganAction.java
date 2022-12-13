package com.landray.kmss.geesun.org.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.org.forms.GeesunOrgOrganForm;
import com.landray.kmss.geesun.org.model.GeesunOrgOrgan;
import com.landray.kmss.geesun.org.service.IGeesunOrgOrganService;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunOrgOrganAction extends ExtendAction {

    private IGeesunOrgOrganService geesunOrgOrganService;

    public IBaseService getServiceImp(HttpServletRequest request) {
        if (geesunOrgOrganService == null) {
            geesunOrgOrganService = (IGeesunOrgOrganService) getBean("geesunOrgOrganService");
        }
        return geesunOrgOrganService;
    }

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunOrgOrgan.class);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.org.util.GeesunOrgUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.org.model.GeesunOrgOrgan.class);
        com.landray.kmss.geesun.org.util.GeesunOrgUtil.buildHqlInfoModel(hqlInfo, request);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunOrgOrganForm geesunOrgOrganForm = (GeesunOrgOrganForm) super.createNewForm(mapping, form, request, response);
        return geesunOrgOrganForm;
    }
}
