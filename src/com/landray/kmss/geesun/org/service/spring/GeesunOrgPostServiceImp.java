package com.landray.kmss.geesun.org.service.spring;

import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.geesun.org.service.IGeesunOrgPostService;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunOrgPostServiceImp extends BaseServiceImp implements IGeesunOrgPostService {

    private ISysNotifyMainCoreService sysNotifyMainCoreService;

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
}
