package com.landray.kmss.geesun.org.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.org.forms.GeesunOrgRecordForm;
import com.landray.kmss.geesun.org.model.GeesunOrgRecord;
import com.landray.kmss.geesun.org.service.IGeesunOrgRecordService;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.web.action.ActionForm;
import com.landray.kmss.web.action.ActionMapping;

public class GeesunOrgRecordAction extends ExtendAction {

    private IGeesunOrgRecordService geesunOrgRecordService;

    public IBaseService getServiceImp(HttpServletRequest request) {
        if (geesunOrgRecordService == null) {
            geesunOrgRecordService = (IGeesunOrgRecordService) getBean("geesunOrgRecordService");
        }
        return geesunOrgRecordService;
    }

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunOrgRecord.class);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.org.util.GeesunOrgUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.org.model.GeesunOrgRecord.class);
        com.landray.kmss.geesun.org.util.GeesunOrgUtil.buildHqlInfoModel(hqlInfo, request);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunOrgRecordForm geesunOrgRecordForm = (GeesunOrgRecordForm) super.createNewForm(mapping, form, request, response);
        return geesunOrgRecordForm;
    }
}
