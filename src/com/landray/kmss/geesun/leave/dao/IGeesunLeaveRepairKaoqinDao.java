package com.landray.kmss.geesun.leave.dao;

public interface IGeesunLeaveRepairKaoqinDao {
	// 查询获取指定用户ID,补卡时间当月的补卡的次数
	Integer getTime(String userId, String date);

	// 修改指定fdID的流程状态
	void upState(String fdId, String state);
}
