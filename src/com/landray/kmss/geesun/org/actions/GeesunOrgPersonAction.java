package com.landray.kmss.geesun.org.actions;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import com.landray.kmss.geesun.org.model.GeesunOrgPerson;
import com.landray.kmss.geesun.org.forms.GeesunOrgPersonForm;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.geesun.org.service.IGeesunOrgPersonService;
import javax.servlet.http.HttpServletRequest;
import com.landray.kmss.web.action.ActionForm;
import javax.servlet.http.HttpServletResponse;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.geesun.org.util.GeesunOrgUtil;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunOrgPersonAction extends ExtendAction {

    private IGeesunOrgPersonService geesunOrgPersonService;

    public IBaseService getServiceImp(HttpServletRequest request) {
        if (geesunOrgPersonService == null) {
            geesunOrgPersonService = (IGeesunOrgPersonService) getBean("geesunOrgPersonService");
        }
        return geesunOrgPersonService;
    }

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunOrgPerson.class);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.org.util.GeesunOrgUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.org.model.GeesunOrgPerson.class);
        com.landray.kmss.geesun.org.util.GeesunOrgUtil.buildHqlInfoModel(hqlInfo, request);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunOrgPersonForm geesunOrgPersonForm = (GeesunOrgPersonForm) super.createNewForm(mapping, form, request, response);
        return geesunOrgPersonForm;
    }
}
