package com.landray.kmss.geesun.oitems.actions;

import javax.servlet.http.HttpServletRequest;

import com.landray.kmss.common.actions.ExtendAction;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.oitems.service.IGeesunOitemsReportListingService;


/**
 * 统计领用明细表 Action
 * 
 * @author 
 * @version 1.0 2011-11-23
 */
public class GeesunOitemsReportListingAction extends ExtendAction {
	protected IGeesunOitemsReportListingService geesunOitemsReportListingService;

	protected IBaseService getServiceImp(HttpServletRequest request) {
		if(geesunOitemsReportListingService == null)
			geesunOitemsReportListingService = (IGeesunOitemsReportListingService)getBean("geesunOitemsReportListingService");
		return geesunOitemsReportListingService;
	}
}

