package com.landray.kmss.geesun.org.actions;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import com.landray.kmss.geesun.org.model.GeesunOrgPost;
import com.landray.kmss.geesun.org.forms.GeesunOrgPostForm;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.geesun.org.service.IGeesunOrgPostService;
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

public class GeesunOrgPostAction extends ExtendAction {

    private IGeesunOrgPostService geesunOrgPostService;

    public IBaseService getServiceImp(HttpServletRequest request) {
        if (geesunOrgPostService == null) {
            geesunOrgPostService = (IGeesunOrgPostService) getBean("geesunOrgPostService");
        }
        return geesunOrgPostService;
    }

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunOrgPost.class);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.org.util.GeesunOrgUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.org.model.GeesunOrgPost.class);
        com.landray.kmss.geesun.org.util.GeesunOrgUtil.buildHqlInfoModel(hqlInfo, request);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunOrgPostForm geesunOrgPostForm = (GeesunOrgPostForm) super.createNewForm(mapping, form, request, response);
        return geesunOrgPostForm;
    }
}
