package com.landray.kmss.geesun.org.service.spring;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.alibaba.fastjson.JSONArray;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.service.BaseServiceImp;
import com.landray.kmss.geesun.org.dao.IGeesunOrgEkpDao;
import com.landray.kmss.geesun.org.model.GeesunOrgBaseElementModel;
import com.landray.kmss.geesun.org.model.GeesunOrgDetailElementModel;
import com.landray.kmss.geesun.org.service.IGeesunOrgEkpService;
import com.landray.kmss.geesun.org.service.IGeesunOrgOrganService;
import com.landray.kmss.geesun.org.service.IGeesunOrgPersonService;
import com.landray.kmss.geesun.org.service.IGeesunOrgPostService;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.SpringBeanUtil;
/**
 * HR同步日志业务接口实现
 * 
 * @author 
 * @version 1.0 2019-06-19
 */
public class GeesunOrgEkpServiceImp extends BaseServiceImp implements IGeesunOrgEkpService {

	public void addOrganizationMiddle(DataSource dataSource, JSONArray organArray, 
			JSONArray personArray, JSONArray postArray) throws Exception {
		//调用Dao层写入将HR数据中间表
		((IGeesunOrgEkpDao) getBaseDao()).addOrganizationMiddle(dataSource, organArray, personArray, postArray);
	}
	
	public void clean(DataSource dataSource) throws Exception {
		//调用Dao层写入将HR数据中间表
		((IGeesunOrgEkpDao) getBaseDao()).clean(dataSource);
	}
	
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
			List<String> filterOrganList, List<String> filterPersonList, List<String> filterPostList) throws Exception {
		//调用Dao层获取中间表数据
		((IGeesunOrgEkpDao) getBaseDao()).getBaseElementList(dataSource, baseList, detailList, filterOrganList, filterPersonList, filterPostList);
	}
	
	private IGeesunOrgOrganService geesunOrgOrganService;
	
	private IGeesunOrgPersonService geesunOrgPersonService;
	
	private IGeesunOrgPostService geesunOrgPostService;
	
	public IGeesunOrgOrganService getGeesunOrgOrganService() {
		if (null == geesunOrgOrganService) {
			geesunOrgOrganService = (IGeesunOrgOrganService) SpringBeanUtil.getBean("geesunOrgOrganService");
		}
		return geesunOrgOrganService;
	}
	
	public IGeesunOrgPersonService getGeesunOrgPersonService() {
		if (null == geesunOrgPersonService) {
			geesunOrgPersonService = (IGeesunOrgPersonService) SpringBeanUtil.getBean("geesunOrgPersonService");
		}
		return geesunOrgPersonService;
	}
	
	public IGeesunOrgPostService getGeesunOrgPostService() {
		if (null == geesunOrgPostService) {
			geesunOrgPostService = (IGeesunOrgPostService) SpringBeanUtil.getBean("geesunOrgPostService");
		}
		return geesunOrgPostService;
	}
	
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
			String tableName, String fieldName, String whereFieldName, List<String> filterParentList) throws Exception {
		List<String> childIdList = new ArrayList<String>();
		if (ArrayUtil.isEmpty(parentList)) {
			return childIdList;
		}
		if ("geesunOrgOrgan".equals(tableName)) {
			boolean flag = true;
			while (flag) {
				HQLInfo hql = new HQLInfo();
				hql.setSelectBlock(tableName + "." + fieldName);
				hql.setWhereBlock(HQLUtil.buildLogicIN(tableName + "." + whereFieldName, parentList));
				childIdList.addAll(parentList);
				List result = getGeesunOrgOrganService().findList(hql);
				if (!ArrayUtil.isEmpty(result)) {
					parentList.clear();
					parentList.addAll(result);
					childIdList.addAll(result);
				} else {
					flag = false;
				}
			}
		} else if ("geesunOrgPerson".equals(tableName)) {
			HQLInfo hql = new HQLInfo();
			hql.setSelectBlock(tableName + "." + fieldName);
			hql.setWhereBlock(HQLUtil.buildLogicIN(tableName + "." + whereFieldName, filterParentList));
			List result = getGeesunOrgPersonService().findList(hql);
			if (!ArrayUtil.isEmpty(result)) {
				childIdList.addAll(result);
			} 
		} else {
			HQLInfo hql = new HQLInfo();
			hql.setSelectBlock(tableName + "." + fieldName);
			hql.setWhereBlock(HQLUtil.buildLogicIN(tableName + "." + whereFieldName, filterParentList));
			List result = getGeesunOrgPostService().findList(hql);
			if (!ArrayUtil.isEmpty(result)) {
				childIdList.addAll(result);
			}
		}
		//去重
		ArrayUtil.unique(childIdList);
		return childIdList;
	}
	
}
