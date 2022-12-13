package com.landray.kmss.geesun.org.dao;

import java.util.List;

import javax.sql.DataSource;

import com.alibaba.fastjson.JSONArray;
import com.landray.kmss.common.dao.IBaseDao;
import com.landray.kmss.geesun.org.model.GeesunOrgBaseElementModel;
import com.landray.kmss.geesun.org.model.GeesunOrgDetailElementModel;

/**
 * HR同步日志数据访问接口
 * 
 * @author 
 * @version 1.0 2019-06-19
 */
public interface IGeesunOrgEkpDao extends IBaseDao {
	
	/**
	 * 从中间表获取组织架构数据
	 * @param dataSource
	 * @param baseList
	 * @param detailList
	 * @param filterOrganList
	 * @param filterPersonList
	 * @param filterPostList
	 * @return
	 * @throws Exception
	 */
	public void getBaseElementList(DataSource dataSource, 
			List<GeesunOrgBaseElementModel> baseList, List<GeesunOrgDetailElementModel> detailList,
			List<String> filterOrganList, List<String> filterPersonList, List<String> filterPostList) throws Exception;

	/**
	 * 每次同步之前先清除组织架构中间表数据
	 * @param dataSource
	 * @throws Exception
	 */
	public void clean(DataSource dataSource) throws Exception;
	
	/**
	 * 将HR同步过来的组织架构信息插入中间表
	 * @param dataSource
	 * @param organArray
	 * @param personArray
	 * @param postArray
	 * @throws Exception
	 */
	public void addOrganizationMiddle(DataSource dataSource, JSONArray organArray, 
			JSONArray personArray, JSONArray postArray) throws Exception;
	
}
