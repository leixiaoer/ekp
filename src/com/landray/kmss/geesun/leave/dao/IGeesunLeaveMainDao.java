package com.landray.kmss.geesun.leave.dao;

import java.util.Map;

import com.landray.kmss.common.dao.IBaseDao;

public interface IGeesunLeaveMainDao extends IBaseDao {
	// 增加geesun_leave_main_areader
	void addAreader(Map<String, String> map);
}
