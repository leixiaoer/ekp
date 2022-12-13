package com.landray.kmss.geesun.oitems.service.spring;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.geesun.oitems.model.GeesunOitemsTemplet;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsTempletService;
import com.landray.kmss.sys.authentication.intercept.IAuthenticationValidator;
import com.landray.kmss.sys.authentication.intercept.ValidatorRequestContext;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.UserUtil;

public class GeesunOitemsBudgerApplicationValidator implements IAuthenticationValidator {

	private Log logger = LogFactory.getLog(GeesunOitemsBudgerApplicationValidator.class);

	private IGeesunOitemsTempletService geesunOitemsTempletService;

	public IGeesunOitemsTempletService getGeesunOitemsTempletService() {
		if (geesunOitemsTempletService == null) {
			geesunOitemsTempletService = (IGeesunOitemsTempletService) SpringBeanUtil.getBean("geesunOitemsTempletService");
		}
		return geesunOitemsTempletService;
	}

	public boolean validate(ValidatorRequestContext validatorContext) throws Exception {
		String fdTemplateId = validatorContext.getParameter("fdTemplateId");
		GeesunOitemsTemplet templet = (GeesunOitemsTemplet) getGeesunOitemsTempletService().findByPrimaryKey(fdTemplateId);
		if (null != templet) {
			if (templet.getFdTempletType() == 1) {
				return UserUtil.checkRole("ROLE_GEESUNOITEMS_BUDGER_CREATE_DEPT");
			} else {
				return UserUtil.checkRole("ROLE_GEESUNOITEMS_BUDGER_CREATE_PERSON");
			}
		}
		return false;
	}
}
