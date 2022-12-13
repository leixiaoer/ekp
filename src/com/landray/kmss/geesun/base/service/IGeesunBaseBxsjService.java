package com.landray.kmss.geesun.base.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.landray.kmss.geesun.base.util.StatisticsPageInfo;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataService;
import com.sunbor.web.tag.Page;

public interface IGeesunBaseBxsjService extends IExtendDataService {
	
	/**
	 * 财务总表查询
	 */
	public Page getExpenseReportList(StatisticsPageInfo statisticsPageInfo, 
			HttpServletRequest request) throws Exception;
	
	/**
	 * 导出财务总表
	 * @param ids
	 * @param response
	 * @throws Exception
	 */
	public void exportReportListInfos(String subject, String number, String status, String type, String beginDate, String endDate,
			HttpServletResponse response) throws Exception;
	
}
