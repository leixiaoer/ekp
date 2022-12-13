package com.landray.kmss.geesun.org.service.spring;

import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.geesun.org.service.IGeesunOrgOrganService;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.util.SpringBeanUtil;

public class GeesunOrgOrganServiceImp extends BaseServiceImp implements IGeesunOrgOrganService {

    private ISysNotifyMainCoreService sysNotifyMainCoreService;

    public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
        if (sysNotifyMainCoreService == null) {
            sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
        }
        return sysNotifyMainCoreService;
    }
}
