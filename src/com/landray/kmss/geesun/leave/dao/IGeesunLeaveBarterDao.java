package com.landray.kmss.geesun.leave.dao;

import java.util.Map;

import com.landray.kmss.common.dao.IBaseDao;

public interface IGeesunLeaveBarterDao extends IBaseDao {

	// 增加geesun_leave_barter_areader表单信息
	void addAreader(Map<String, String> hashMap);
}
