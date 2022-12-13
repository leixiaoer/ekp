package com.landray.kmss.geesun.base.service;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataService;
import com.landray.kmss.common.forms.IExtendForm;

/**
  * 项目号信息 服务接口
  */
public interface IGeesunBaseProjectService extends IExtendDataService {

    public abstract void updateUpdateAllDisabled(String id, RequestContext requestContext, IExtendForm $form) throws Exception;

    public abstract void updateallUpdateAllDisabled(String[] ids, RequestContext requestContext, IExtendForm $form) throws Exception;
}
