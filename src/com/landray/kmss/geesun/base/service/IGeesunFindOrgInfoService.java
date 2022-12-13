package com.landray.kmss.geesun.base.service;

import java.util.Map;

import com.landray.kmss.sys.organization.model.SysOrgPerson;

/**
 * 获取组织架构信息接口
 * 
 * @author guoyp
 *
 */
public interface IGeesunFindOrgInfoService {

	/**
	 * 根据地址本控件查找编码
	 */
	public String findOrgNo(Map orgMap) throws Exception;

	/**
	 * 根据地址本控件查找登陆名
	 */
	public String findOrgLoginName(Map orgMap) throws Exception;
	
	/**
	 * 根据组织ID查找编码
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public String findOrgNo(String personId) throws Exception;
	
	/**
	 * 根据地址本控件查找对象
	 * @param orgMap
	 * @return
	 * @throws Exception
	 */
	public SysOrgPerson findOrg(Map orgMap) throws Exception;
	
}
