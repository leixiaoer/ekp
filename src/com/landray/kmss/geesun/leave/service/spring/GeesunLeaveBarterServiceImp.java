package com.landray.kmss.geesun.leave.service.spring;

import java.util.Date;
import com.landray.kmss.geesun.leave.util.GeesunLeaveUtil;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.geesun.leave.service.IGeesunLeaveBarterService;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.geesun.leave.model.GeesunLeaveBarter;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.common.forms.IExtendForm;

public class GeesunLeaveBarterServiceImp extends ExtendDataServiceImp implements IGeesunLeaveBarterService {

	private ISysNotifyMainCoreService sysNotifyMainCoreService;

	public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context)
			throws Exception {
		model = super.convertBizFormToModel(form, model, context);
		if (model instanceof GeesunLeaveBarter) {
			GeesunLeaveBarter geesunLeaveBarter = (GeesunLeaveBarter) model;
		}
		return model;
	}

	public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
		GeesunLeaveBarter geesunLeaveBarter = new GeesunLeaveBarter();
		geesunLeaveBarter.setDocCreateTime(new Date());
		geesunLeaveBarter.setDocCreator(UserUtil.getUser());
		geesunLeaveBarter.setDocDept(UserUtil.getUser().getFdParent());
		GeesunLeaveUtil.initModelFromRequest(geesunLeaveBarter, requestContext);
		return geesunLeaveBarter;
	}

	public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext)
			throws Exception {
		GeesunLeaveBarter geesunLeaveBarter = (GeesunLeaveBarter) model;
	}

	public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
		if (sysNotifyMainCoreService == null) {
			sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
		}
		return sysNotifyMainCoreService;
	}
}
