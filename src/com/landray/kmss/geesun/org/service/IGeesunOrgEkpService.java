package com.landray.kmss.geesun.org.service;

import java.util.List;

import javax.sql.DataSource;

import com.alibaba.fastjson.JSONArray;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.org.model.GeesunOrgBaseElementModel;
import com.landray.kmss.geesun.org.model.GeesunOrgDetailElementModel;
/**
 * HR同步日志业务对象接口
 * 
 * @author 
 * @version 1.0 2019-06-19
 */
public interface IGeesunOrgEkpService extends IBaseService {

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
	 * 根据父节点ID获取到所有子节点
	 * @param parentList
	 * @param dataSource
	 * @param tableName
	 * @param fieldName
	 * @param whereFieldName
	 * @param filterParentList
	 * @return
	 * @throws Exception
	 */
	public List<String> getChildIdList(List<String> parentList, DataSource dataSource,
			String tableName, String fieldName, String whereFieldName, List<String> filterParentList) throws Exception;
	
}
