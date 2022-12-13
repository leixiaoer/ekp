package com.landray.kmss.geesun.org.actions;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.org.model.GeesunOrgEkp;
import com.landray.kmss.geesun.org.service.IGeesunOrgEkpService;
import com.landray.kmss.util.CriteriaUtil;
import com.landray.kmss.util.CriteriaValue;
import com.landray.kmss.util.StringUtil;

 
/**
 * HR同步日志 Action
 * 
 * @author 
 * @version 1.0 2019-06-19
 */
public class GeesunOrgEkpAction extends ExtendAction {
	protected IGeesunOrgEkpService geesunOrgEkpService;

	protected IBaseService getServiceImp(HttpServletRequest request) {
		if(geesunOrgEkpService == null)
			geesunOrgEkpService = (IGeesunOrgEkpService)getBean("geesunOrgEkpService");
		return geesunOrgEkpService;
	}

	protected void changeFindPageHQLInfo(HttpServletRequest request,
			HQLInfo hqlInfo) throws Exception {
		super.changeFindPageHQLInfo(request, hqlInfo);		

		CriteriaValue cv = new CriteriaValue(request);
		
		String where = hqlInfo.getWhereBlock();
		if(StringUtil.isNull(where)){
			where = " 1=1 ";
		}
		
		CriteriaUtil.buildHql(cv, hqlInfo, GeesunOrgEkp.class);
	}
}

