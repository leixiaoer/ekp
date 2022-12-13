package com.landray.kmss.geesun.base.service.spring;

import java.util.Date;
import com.landray.kmss.geesun.base.util.GeesunBaseUtil;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.geesun.base.service.IGeesunBaseProjectService;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.geesun.base.model.GeesunBaseProject;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.common.forms.IExtendForm;

/**
  * 项目号信息 服务实现
  */
public class GeesunBaseProjectServiceImp extends ExtendDataServiceImp implements IGeesunBaseProjectService {

    private ISysNotifyMainCoreService sysNotifyMainCoreService;

    public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context) throws Exception {
        model = super.convertBizFormToModel(form, model, context);
        if (model instanceof GeesunBaseProject) {
            GeesunBaseProject geesunBaseProject = (GeesunBaseProject) model;
        }
        return model;
    }

    public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
        GeesunBaseProject geesunBaseProject = new GeesunBaseProject();
        geesunBaseProject.setFdIsAvailable(Boolean.valueOf("true"));
        geesunBaseProject.setDocCreateTime(new Date());
        geesunBaseProject.setDocCreator(UserUtil.getUser());
        GeesunBaseUtil.initModelFromRequest(geesunBaseProject, requestContext);
        return geesunBaseProject;
    }

    public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext) throws Exception {
        GeesunBaseProject geesunBaseProject = (GeesunBaseProject) model;
    }

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }

    public void updateUpdateAllDisabled(String $id, RequestContext requestContext, IExtendForm $form) throws Exception {
        GeesunBaseProject geesunBaseProject = (GeesunBaseProject) findByPrimaryKey($id);
        if (geesunBaseProject != null && geesunBaseProject.getFdId() != null && geesunBaseProject.getFdId().equals($id)) {
            //
            geesunBaseProject.setFdIsAvailable(false);
            super.update(geesunBaseProject);
        }
    }

    public void updateallUpdateAllDisabled(String[] $ids, RequestContext requestContext, IExtendForm $form) throws Exception {
        for (String $id : $ids) {
            updateUpdateAllDisabled($id, requestContext, $form);
        }
    }
}
