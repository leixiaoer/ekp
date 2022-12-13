package com.landray.kmss.geesun.leave.dao;

import java.util.Map;

import net.sf.json.JSONArray;

/**
 * 映射表的信息
 * 
 * @author 渣渣辉
 *
 */
public interface IGeesunLeaveMappingFormDao {
	// 修改表单的状态(state:【审批中】改为30【废弃】或者20【成功】)
	void upMessage(Map<String, String> map);

	// 查询表单信息
	Double getFreezeHour(String userId);

	// 删除表单信息
	void deleteMessage(String fdId);

	// 查询表单指定信息月份的已使用调休小时数
	JSONArray getFreezeDate(Map<String, String> map);
}