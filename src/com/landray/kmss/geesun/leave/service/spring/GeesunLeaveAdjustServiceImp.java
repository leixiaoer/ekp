package com.landray.kmss.geesun.leave.service.spring;

import java.util.Date;
import com.landray.kmss.geesun.leave.util.GeesunLeaveUtil;
import com.landray.kmss.geesun.leave.service.IGeesunLeaveAdjustService;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.convertor.ConvertorContext;
import com.landray.kmss.geesun.leave.model.GeesunLeaveAdjust;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.sys.notify.interfaces.ISysNotifyMainCoreService;
import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.sys.metadata.interfaces.ExtendDataServiceImp;
import com.landray.kmss.util.UserUtil;
import com.landray.kmss.common.forms.IExtendForm;

public class GeesunLeaveAdjustServiceImp extends ExtendDataServiceImp implements IGeesunLeaveAdjustService {

	private ISysNotifyMainCoreService sysNotifyMainCoreService;

	public IBaseModel convertBizFormToModel(IExtendForm form, IBaseModel model, ConvertorContext context)
			throws Exception {
		model = super.convertBizFormToModel(form, model, context);
		if (model instanceof GeesunLeaveAdjust) {
			GeesunLeaveAdjust geesunLeaveAdjust = (GeesunLeaveAdjust) model;
		}
		return model;
	}

	public IBaseModel initBizModelSetting(RequestContext requestContext) throws Exception {
		GeesunLeaveAdjust geesunLeaveAdjust = new GeesunLeaveAdjust();
		geesunLeaveAdjust.setDocCreateTime(new Date());
		geesunLeaveAdjust.setDocCreator(UserUtil.getUser());
		geesunLeaveAdjust.setDocDept(UserUtil.getUser().getFdParent());
		GeesunLeaveUtil.initModelFromRequest(geesunLeaveAdjust, requestContext);
		return geesunLeaveAdjust;
	}

	public void initCoreServiceFormSetting(IExtendForm form, IBaseModel model, RequestContext requestContext)
			throws Exception {
		GeesunLeaveAdjust geesunLeaveAdjust = (GeesunLeaveAdjust) model;
	}

	public ISysNotifyMainCoreService getSysNotifyMainCoreService() {
		if (sysNotifyMainCoreService == null) {
			sysNotifyMainCoreService = (ISysNotifyMainCoreService) SpringBeanUtil.getBean("sysNotifyMainCoreService");
		}
		return sysNotifyMainCoreService;
	}
}
