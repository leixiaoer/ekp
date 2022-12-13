package com.landray.kmss.geesun.oitems.service;

import java.util.List;
import java.util.Map;

import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.oitems.model.GeesunOitemsReportListing;

/**
 * 月统计表业务对象接口
 * 
 * @author
 * @version 1.0 2011-11-23
 */
public interface IGeesunOitemsMonthReportService extends IBaseService {
	/***
	 * 将list按人员ID分组Map 以人员ID为key
	 * 
	 * @param geesunOitemsReportListing
	 * @return
	 */
	public Map<String, List<GeesunOitemsReportListing>> groupListByPerson(
			List<GeesunOitemsReportListing> geesunOitemsReportListing);
}
