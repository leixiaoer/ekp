package com.landray.kmss.geesun.org.service;

import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface IGeesunSynOrganizationQuarzeService {
	
	/**
	 * 同步HR组织架构数据到中间表定时任务
	 */
	public void SynchOrganizationToMiddleQuartz(SysQuartzJobContext 
			context) throws Exception;

	/**
	 * 同步组织架构（系统定时任务）
	 */
	public void SynchOrganizationQuartz(SysQuartzJobContext context) throws Exception;
	
}
