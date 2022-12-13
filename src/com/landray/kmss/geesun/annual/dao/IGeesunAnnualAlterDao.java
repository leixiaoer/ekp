package com.landray.kmss.geesun.annual.dao;

import com.landray.kmss.common.dao.IBaseDao;

public interface IGeesunAnnualAlterDao extends IBaseDao {
	
	/**
	 * 根据对应模型ID和模型名称获取对应数量
	 * @param modelId
	 * @param modelName
	 * @return
	 */
	public int getAlterRecordInfoCount(String modelId, String modelName);
	
}
