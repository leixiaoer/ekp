package com.landray.kmss.geesun.base.service;

import com.landray.kmss.geesun.base.model.GeesunBaseAccount;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataService;
import com.landray.kmss.sys.organization.model.SysOrgPerson;

public interface IGeesunBaseAccountService extends IExtendDataService {
	
	/**
	 * 根据指定人员获取对应的账号信息
	 * @param person
	 * @return
	 * @throws Exception
	 */
	public GeesunBaseAccount getAccountByUser(SysOrgPerson 
			person) throws Exception;
	
}
