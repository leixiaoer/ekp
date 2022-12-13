package com.landray.kmss.geesun.leave.dao;

import java.util.Map;

import net.sf.json.JSONArray;

import com.landray.kmss.common.dao.IBaseDao;

public interface IGeesunLeaveAdjustDao extends IBaseDao {
	// 查询指定用户的所有请假信息
	JSONArray getDateMessage(String userId);

	// 增加geesun_leave_adjust_areader信息
	void addAreader(Map<String, String> map);

	// 修改被冻结的请假申请时间状态
	void upAdjustState(Map<String, String> map);

	// 查询指定用户的请假冻结信息
	JSONArray getFreezeMessage(String userId, JSONArray json);
}
