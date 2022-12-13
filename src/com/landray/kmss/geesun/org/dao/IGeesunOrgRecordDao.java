package com.landray.kmss.geesun.org.dao;

import javax.sql.DataSource;

import com.alibaba.fastjson.JSONArray;
import com.landray.kmss.common.dao.IBaseDao;

public interface IGeesunOrgRecordDao extends IBaseDao {
	
	public void addRecordMiddle(DataSource dataSource, JSONArray organArray, 
			JSONArray personArray, JSONArray postArray) throws Exception;
	
}
