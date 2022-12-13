package com.landray.kmss.geesun.base.actions;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import com.landray.kmss.geesun.base.model.GeesunBaseProject;
import com.landray.kmss.geesun.base.forms.GeesunBaseProjectForm;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.util.KmssReturnPage;
import com.landray.kmss.util.KmssMessage;
import com.landray.kmss.common.exception.UnexpectedRequestException;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.web.action.ActionForm;
import javax.servlet.http.HttpServletResponse;
import com.landray.kmss.geesun.base.util.GeesunBaseUtil;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.util.KmssMessages;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.web.action.ActionForward;
import com.landray.kmss.geesun.base.service.IGeesunBaseProjectService;
import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.util.HQLHelper;
import com.landray.kmss.web.action.ActionMapping;
import com.landray.kmss.common.test.TimeCounter;

/**
  * 项目号信息 Action
  */
public class GeesunBaseProjectAction extends ExtendAction {

    private IGeesunBaseProjectService geesunBaseProjectService;

    public IBaseService getServiceImp(HttpServletRequest request) {
        if (geesunBaseProjectService == null) {
            geesunBaseProjectService = (IGeesunBaseProjectService) getBean("geesunBaseProjectService");
        }
        return geesunBaseProjectService;
    }

    public void changeFindPageHQLInfo(HttpServletRequest request, HQLInfo hqlInfo) throws Exception {
        HQLHelper.by(request).buildHQLInfo(hqlInfo, GeesunBaseProject.class);
        hqlInfo.setOrderBy(getFindPageOrderBy(request, hqlInfo.getOrderBy()));
        com.landray.kmss.geesun.base.util.GeesunBaseUtil.buildHqlInfoDate(hqlInfo, request, com.landray.kmss.geesun.base.model.GeesunBaseProject.class);
        com.landray.kmss.geesun.base.util.GeesunBaseUtil.buildHqlInfoModel(hqlInfo, request);
    }

    public ActionForm createNewForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeesunBaseProjectForm geesunBaseProjectForm = (GeesunBaseProjectForm) super.createNewForm(mapping, form, request, response);
        ((IGeesunBaseProjectService) getServiceImp(request)).initFormSetting((IExtendForm) form, new RequestContext(request));
        return geesunBaseProjectForm;
    }

    /**
     * 更新批量置为无效
     */
    public ActionForward updateUpdateAllDisabled(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        TimeCounter.logCurrentTime("Action-updateUpdateAllDisabled", true, getClass());
        KmssMessages messages = new KmssMessages();
        GeesunBaseProjectForm $form = (GeesunBaseProjectForm) form;
        try {
            ((IGeesunBaseProjectService) this.getServiceImp(request)).updateUpdateAllDisabled($form.getFdId(), new RequestContext(request), $form);
            KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
            TimeCounter.logCurrentTime("Action-updateUpdateAllDisabled", false, getClass());
            return mapping.findForward("success");
        } catch (Exception e) {
            messages.addError(e);
        }
        KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
        TimeCounter.logCurrentTime("Action-updateUpdateAllDisabled", false, getClass());
        return mapping.findForward("failure");
    }

    /**
     * 批量更新批量置为无效
     */
    public ActionForward updateallUpdateAllDisabled(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        TimeCounter.logCurrentTime("Action-updateallUpdateAllDisabled", true, getClass());
        KmssMessages messages = new KmssMessages();
        try {
            if (!request.getMethod().equals("POST")) {
                throw new UnexpectedRequestException();
            }
            GeesunBaseProjectForm $form = (GeesunBaseProjectForm) form;
            String[] ids = request.getParameterValues("List_Selected");
            if (ids != null) {
                StringBuffer buf = new StringBuffer();
                for (String id : ids) {
                    if (UserUtil.checkAuthentication("/geesun/base/geesun_base_project/geesunBaseProject.do?method=updateUpdateAllDisabled&fdId=" + id, "post")) {
                        buf.append(id).append(';');
                    }
                }
                if (StringUtil.isNotNull(buf.toString())) {
                    String[] newids = buf.toString().split(";");
                    ((IGeesunBaseProjectService) getServiceImp(request)).updateallUpdateAllDisabled(newids, new RequestContext(request), $form);
                }
            }
        } catch (Exception e) {
            messages.addError(e);
        }
        KmssReturnPage.getInstance(request).addMessages(messages).addButton(KmssReturnPage.BUTTON_CLOSE).save(request);
        TimeCounter.logCurrentTime("Action-updateallUpdateAllDisabled", false, getClass());
        if (messages.hasError()) {
            return getActionForward("failure", mapping, form, request, response);
        } else {
            return getActionForward("success", mapping, form, request, response);
        }
    }
}
