package com.landray.kmss.geesun.base.service.spring;

import java.util.Date;
import com.landray.kmss.geesun.base.util.GeesunBaseUtil;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.geesun.base.service.IGeesunBaseAuditService;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.geesun.base.model.GeesunBaseAudit;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.common.forms.IExtendForm;

public class GeesunBaseAuditServiceImp extends ExtendDataServiceImp implements IGeesunBaseAuditService {

    private ISysNotifyMainCoreService sysNotifyMainCoreService;

    public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof GeesunBaseAudit) {
            GeesunBaseAudit geesunBaseAudit = (GeesunBaseAudit) model;
            geesunBaseAudit.setDocAlterTime(new Date());
            geesunBaseAudit.setDocAlteror(UserUtil.getUser());
        }
        return model;
    }

    public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
        GeesunBaseAudit geesunBaseAudit = new GeesunBaseAudit();
        geesunBaseAudit.setDocCreateTime(new Date());
        geesunBaseAudit.setDocAlterTime(new Date());
        geesunBaseAudit.setDocCreator(UserUtil.getUser());
        geesunBaseAudit.setDocAlteror(UserUtil.getUser());
        GeesunBaseUtil.initModelFromRequest(geesunBaseAudit, requestContext);
        return geesunBaseAudit;
    }

    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        GeesunBaseAudit geesunBaseAudit = (GeesunBaseAudit) model;
    }

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
}
