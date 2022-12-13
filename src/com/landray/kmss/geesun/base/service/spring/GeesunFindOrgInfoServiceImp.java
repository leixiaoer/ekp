package com.landray.kmss.geesun.base.service.spring;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.geesun.base.service.IGeesunFindOrgInfoService;
import com.landray.kmss.sys.organization.model.SysOrgElement;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.sys.organization.service.ISysOrgElementService;
import com.landray.kmss.sys.organization.service.ISysOrgPersonService;
import com.landray.kmss.util.StringUtil;

/**
 * 获取组织架构信息
 * 
 * @author guoyp
 *
 */
public class GeesunFindOrgInfoServiceImp implements IGeesunFindOrgInfoService {
	
	private static final Log logger = LogFactory.getLog(GeesunFindOrgInfoServiceImp.class);

	public ISysOrgElementService sysOrgElementService;

	public void setSysOrgElementService(
			ISysOrgElementService sysOrgElementService) {
		this.sysOrgElementService = sysOrgElementService;
	}
	
	/**
	 * 组织架构bean
	 */
	protected ISysOrgPersonService sysOrgPersonService;
	
	public void setSysOrgPersonService(ISysOrgPersonService sysOrgPersonService) {
		this.sysOrgPersonService = sysOrgPersonService;
	}

	public String findOrgNo(Map orgMap) throws Exception {
		if (orgMap == null || orgMap.size() <= 0) {
			return "";
		}
		SysOrgElement org = (SysOrgElement) sysOrgElementService
				.findByPrimaryKey(orgMap.get("id").toString(), null, true);
		return org == null ? "" : org.getFdNo();
	}

	public String findOrgLoginName(Map orgMap) throws Exception {
		if (orgMap == null || orgMap.size() <= 0) {
			return "";
		}
		SysOrgPerson org = (SysOrgPerson) sysOrgElementService
				.findByPrimaryKey(orgMap.get("id").toString(),
						SysOrgPerson.class, true);
		return org == null ? "" : org.getFdLoginName();
	}
	
	public SysOrgPerson findOrg(Map orgMap) throws Exception {
		if (orgMap == null || orgMap.size() <= 0) {
			return null;
		}
		SysOrgPerson org = (SysOrgPerson) sysOrgElementService
				.findByPrimaryKey(orgMap.get("id").toString(),
						SysOrgPerson.class, true);
		return org;
	}
	
	public String findOrgNo(String personId) throws Exception {
		if (StringUtil.isNull(personId)) {
			return "";
		}
		SysOrgElement org = (SysOrgElement) sysOrgElementService
				.findByPrimaryKey(personId, null, true);
		return org == null ? "" : org.getFdNo();
	}
	
}
