package com.landray.kmss.geesun.leave.dao;

import java.util.Map;

import net.sf.json.JSONArray;

public interface IGeesunLeaveKaoQinRecordDao {
	// 获取指定工号指定日期的打卡记录
	JSONArray getKaoQin(Map<String, String> hashMap);

}
