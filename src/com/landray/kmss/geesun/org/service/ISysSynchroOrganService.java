package com.landray.kmss.geesun.org.service;

import java.util.List;

import com.landray.kmss.geesun.org.model.GeesunOrgBaseElementModel;
import com.landray.kmss.sys.organization.webservice.in.SysSynchroSetOrgContext;
import com.landray.kmss.sys.organization.webservice.in.SysSynchroSetResult;
import com.landray.kmss.sys.quartz.interfaces.SysQuartzJobContext;

public interface ISysSynchroOrganService {

	/**
	 * 同步所有组织信息,删除没有组织的机构
	 */
	public void syncOrgElementsBaseInfo(SysQuartzJobContext jobContext, 
			List<GeesunOrgBaseElementModel> baseList, SysSynchroSetOrgContext setOrgContext) throws Exception;

	public SysSynchroSetResult updateOrgStaffingLevels(
			SysSynchroSetOrgContext setOrgContext) throws Exception;

	public SysSynchroSetResult delOrgStaffingLevels(
			SysSynchroSetOrgContext setOrgContext) throws Exception;
	
	public SysSynchroSetResult updateOrgElement(
			SysSynchroSetOrgContext setOrgContext) throws Exception;

}
