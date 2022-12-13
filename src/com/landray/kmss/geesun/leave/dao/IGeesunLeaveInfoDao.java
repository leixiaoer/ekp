package com.landray.kmss.geesun.leave.dao;

import java.util.Map;

public interface IGeesunLeaveInfoDao {
	// 获取指定用户年份的调休信息
	Map<String, String> getUserLeave(String userId, String year);

	// 增加调休额度信息
	void AddLeaveInfo(Map<String, String> map);

	// 修改调休信息
	void updateLeaveInfo(Map<String, String> map);
}
