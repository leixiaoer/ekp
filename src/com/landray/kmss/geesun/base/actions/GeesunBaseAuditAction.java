package com.landray.kmss.geesun.base.actions;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import com.landray.kmss.geesun.base.model.GeesunBaseAudit;
import com.landray.kmss.geesun.base.forms.GeesunBaseAuditForm;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.geesun.base.service.IGeesunBaseAuditService;
import javax.servlet.http.HttpServletRequest;
import com.landray.kmss.web.action.ActionForm;
import javax.servlet.http.HttpServletResponse;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.geesun.base.util.GeesunBaseUtil;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunBaseAuditAction extends ExtendAction {

    private IGeesunBaseAuditService geesunBaseAuditService;

    public IBaseService getServiceImp(HttpServletRequest request) {
        if (geesunBaseAuditService == null) {
            geesunBaseAuditService = (IGeesunBaseAuditService) getBean("geesunBaseAuditService");
        }
        return geesunBaseAuditService;
    }

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunBaseAudit.class);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.base.util.GeesunBaseUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.base.model.GeesunBaseAudit.class);
        com.landray.kmss.geesun.base.util.GeesunBaseUtil.buildHqlInfoModel(hqlInfo, request);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunBaseAuditForm geesunBaseAuditForm = (GeesunBaseAuditForm) super.createNewForm(mapping, form, request, response);
        ((IGeesunBaseAuditService) getServiceImp(request)).initFormSetting((IExtendForm) form, new RequestContext(request));
        return geesunBaseAuditForm;
    }
}
