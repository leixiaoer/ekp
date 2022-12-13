package com.landray.kmss.geesun.org.service;

import javax.sql.DataSource;

import com.alibaba.fastjson.JSONArray;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface IGeesunOrgRecordService extends IBaseService {
	
	/**
	 * 将HR同步过来的组织架构信息插入记录表
	 * @param dataSource
	 * @param organArray
	 * @param personArray
	 * @param postArray
	 * @throws Exception
	 */
	public void addRecordMiddle(DataSource dataSource, JSONArray organArray, 
			JSONArray personArray, JSONArray postArray) throws Exception;
	
	/**
	 * 定时清除一周前HR记录表日志
	 * @param context
	 * @throws Exception
	 */
	public void deleteWeekBeforeLogQuartz(SysQuartzJobContext context) throws Exception;
	
}
