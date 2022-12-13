package com.landray.kmss.geesun.annual.service.spring;

import com.landray.kmss.geesun.annual.util.GeesunAnnualUtil;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.geesun.annual.service.IGeesunAnnualResetService;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.convertor.ConvertorContext;
import java.util.List;
import com.landray.kmss.geesun.annual.model.GeesunAnnualReset;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.common.forms.IExtendForm;
import com.landray.kmss.geesun.annual.model.GeesunAnnualMain;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.common.actions.RequestContext;

public class GeesunAnnualResetServiceImp extends ExtendDataServiceImp implements IGeesunAnnualResetService {

    private ISysNotifyMainCoreService sysNotifyMainCoreService;

    public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof GeesunAnnualReset) {
            GeesunAnnualReset geesunAnnualReset = (GeesunAnnualReset) model;
        }
        return model;
    }

    public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
        GeesunAnnualReset geesunAnnualReset = new GeesunAnnualReset();
        GeesunAnnualUtil.initModelFromRequest(geesunAnnualReset, requestContext);
        return geesunAnnualReset;
    }

    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        GeesunAnnualReset geesunAnnualReset = (GeesunAnnualReset) model;
    }

    public List<GeesunAnnualReset> findByFdAnnual(GeesunAnnualMain fdAnnual) throws Exception {
        HQLInfo hqlInfo = new HQLInfo();
        hqlInfo.setWhereBlock("geesunAnnualReset.fdAnnual.fdId=:fdId");
        hqlInfo.setParameter("fdId", fdAnnual.getFdId());
        return this.findList(hqlInfo);
    }

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
}
