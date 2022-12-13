package com.landray.kmss.geesun.leave.service;

/**
 * @author 渣渣辉
 */

public interface IClockingInDateService {
	/**
	 * 判断是否为休息日
	 */
	long isRestDay(String startTime, String endTime, String userId);
}
